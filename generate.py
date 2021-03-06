#!/usr/bin/env python3

import os, sys, subprocess, configparser

try:
    import jinja2 as jinja
except ImportError:
    print("To compile this website, you must install jinja")
    os.exit(1)

cp = configparser.ConfigParser(
    interpolation = configparser.ExtendedInterpolation()
    )
cp.optionxform = str # be case sensitive in keys
cp.read(sys.argv[1])
conf = cp['main']
pages = cp['pages']
cp['autogen'] = {}


# Get the Git version and populate 'Version' with it.
try:
    cp['autogen']['FullVersion'] = subprocess.check_output(
            ["git", "rev-parse", "HEAD"],
            universal_newlines=True)
    cp['autogen']['VersionSummary'] = subprocess.check_output(
            ["git", "describe", "--always", "--dirty=+"],
            universal_newlines=True)
    cp['autogen']['LastChanged'] = subprocess.check_output(
            ["git", "log", "-1", "--pretty=format:%ad", "--date=short"],
            universal_newlines=True)
except (subprocess.CalledProcessError, FileNotFoundError) as e:
    print("Could not get Git version: %s" % e)
    print("Continuing...")

env = jinja.Environment(loader=jinja.FileSystemLoader(conf.get('TemplatePath')))

for pagename, page in pages.items():
    # Handle the root page in a sensible way.
    if page == "/" or page == "":
        page = "index.html"

    # Get the filename of the page.
    pagepath = os.path.join(conf.get('PagePath'), page)
    outputpath = os.path.join(conf.get('OutputPath'), page)

    print("%s... " % page, end='')

    if pagename in cp:
        data = cp[pagename]
    else:
        data = {}

    try:
        with open(pagepath, 'r') as fi:
            paget = env.from_string(fi.read())
        with open(outputpath, 'w') as fo:
            fo.write( paget.render(
                root = conf.get('RootURL'),
                pages = pages,
                links = cp['links'],
                info = cp['info'],
                repository = conf.get('Repository'),
                versionlink = conf.get('RepositoryVersion'),
                GA_ID = conf.get('GA_ID'),
                versionsum = cp['autogen'].get('VersionSummary'),
                lastchanged = cp['autogen'].get('LastChanged'),
                data = data,
                ))

        print("OK")
    except IOError as e:
        print("Failed!")
        print("    %s" % e)
