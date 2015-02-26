#!/usr/bin/env python3

import os, sys, configparser

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

env = jinja.Environment(loader=jinja.FileSystemLoader(conf.get('TemplatePath')))

for page in pages.values():
    # Handle the root page in a sensible way.
    if page == "/" or page == "":
        page = "index.html"

    # Get the filename of the page.
    pagepath = os.path.join(conf.get('PagePath'), page)
    outputpath = os.path.join(conf.get('OutputPath'), page)

    print("%s... " % page, end='')

    try:
        with open(pagepath, 'r') as fi:
            paget = env.from_string(fi.read())
        with open(outputpath, 'w') as fo:
            fo.write( paget.render(
                root = conf.get('RootURL'),
                pages = pages,
                links = cp['links']))

        print("OK")
    except IOError as e:
        print("Failed!")
        print("    %s" % e)
