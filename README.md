# osmosis-chef-cookbook

An Opscode Chef cookbook that automatically install OpenStreetMap's Osmosis tool on a Chef-managed node

- - -

## Description

This cookbook installs and configure [Osmosis](http://wiki.openstreetmap.org/wiki/Osmosis) on a [Chef](http://www.opscode.com/chef/)-managed node.

The cookbook downloads the Osmosis build from [build page](http://dev.openstreetmap.org/~bretth/osmosis-build/) and unzips it to the installation directory (default: `/opt/osmosis/`).

It adds the `$OSMOSIS_HOME/bin/osmosis` executable to the `$PATH` for all users. Thus, you can play with it as soon as your node is up and running!

Please note that as a Java application, Osmosis requires a working JRE on the target node.

## Requirements

This cookboock requires the [`ark`](https://github.com/opscode-cookbooks/ark) provider to run as expected.

## Attributes

See attributes/default.rb for default values.

* node["osmosis"]["version"] - The version of Osmosis build to install. See the dedicated [build page](http://dev.openstreetmap.org/~bretth/osmosis-build/) to find the latest version.
* node["osmosis"]["checksum"] - The sha256 checksum of the build file to download. You should compute it using something like <code>shasum -a 256</code>.
* node["osmosis"]["path"] - The Osmosis installation path.
* node["osmosis"]["java_opts"] - The Osmosis Java options. See the dedicated [tuning page](http://wiki.openstreetmap.org/wiki/Osmosis/Tuning).
* node["osmosis"]["plugins"] - An array of JSON object containing <code>jar_url</code>, <code>jar_checksum</code> and <code>plugin_loader</code> keys.

## Usage

Simply include the osmosis recipe wherever you would like Osmosis installed.

To install Osmosis plugins, override the node["osmosis"]["plugins"] attribute within role:

```ruby
name "osmosis"
description "Install Osmosis"
run_list(
  "recipe[osmosis]"
)
override_attributes(
  :osmosis => {
    :plugins => [
      {
        :jar_url => "https://github.com/downloads/ncolomer/elasticsearch-osmosis-plugin/elasticsearch-osmosis-plugin-1.2.0.jar",
        :jar_checksum => "59bf1d755846a10bc5bcf4230ace5d589e410da28fb142d0566e232ad7d18e25"
        :plugin_loader => "org.openstreetmap.osmosis.plugin.elasticsearch.ElasticSearchWriterPluginLoader"
      }
    ]
  }
)
```