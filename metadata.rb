maintainer        "Nicolas Colomer"
maintainer_email  "ncolomer@ymail.com"
license           "Apache v2.0"
description       "Installs and configures OpenStreetMap Osmosis tool"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.1"

depends           "ark"

recommends        "java"

recipe            "osmosis", "Installs Osmosis"