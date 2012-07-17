#
# Cookbook Name:: osmosis
# Recipe:: default
#

OSMOSIS_HOME = "#{node[:osmosis][:path]}/osmosis"

# Install Osmosis
ark "osmosis" do
  url "#{node[:osmosis][:url]}"
  checksum "#{node[:osmosis][:checksum]}"
  version "#{node[:osmosis][:version]}"
  append_env_path true
  prefix_root "#{node[:osmosis][:path]}"
  prefix_home "#{node[:osmosis][:path]}"
  has_binaries [ 'bin/osmosis' ]
  action :install
end

# Create the Osmosis Java option file
file "/etc/osmosis" do
  owner "root"
  group "root"
  mode 0755
  action :create
  content "JAVACMD_OPTIONS=\"#{node[:osmosis][:java_opts]}\""
end

# Create the plugin configuration file
file "#{OSMOSIS_HOME}/config/osmosis-plugins.conf" do
  owner "root"
  group "root"
  mode 0755
  action :create
  content node[:osmosis][:plugins].collect{|plugin| "#{plugin["class_name"]}"}.join("\n")
end

# Put all plugin jars in the $OSMOSIS_HOME/lib/default/ directory
for plugin in node[:osmosis][:plugins]
  remote_file "#{OSMOSIS_HOME}/lib/default/#{plugin["jar_name"]}" do
    source "#{plugin["jar_url"]}"
    owner "root"
    group "root"
    mode 0755
  end
end
