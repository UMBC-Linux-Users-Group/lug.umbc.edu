#!/usr/bin/env python3

import os, configparser

try:
    import jinja2 as jinja
except ImportError:
    print("To compile this website, you must install jinja")
    os.exit(1)

cp = configparser.ConfigParser(
    interpolation = configparser.ExtendedInterpolation()
    )
cp.optionxform = str # be case sensitive in keys
cp.read('demo.conf')
conf_main = cp['main']

env = jinja.Environment(loader=jinja.FileSystemLoader(conf_main.get('TemplatePath')))

print(env.get_template('muipage-titlepanel.html').render(pages = cp['pages']))
