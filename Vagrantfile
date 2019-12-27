# -*- mode: ruby -*-

require 'yaml'
require File.dirname(__FILE__)+"/dependency"
check_plugins ["vagrant-vultr"]
servers = YAML.load_file('srv_name.yml')
API_VERSION = "2"

Vagrant.configure(API_VERSION) do |config|
  servers.each do | servers |
    config.vm.define servers["name"] do |machine|
      machine.vm.provider :vultr do |vultr|
        #vultr.name = servers["name"]
        #vultr.memory = servers["memory"]
        #vultr.cpus = servers["cpu"]
        vultr.token = servers ["token"] #'YOUR_TOKEN'  # You can also use VULTR_TOKEN environment variable
        vultr.region = servers ["region"] #'Seattle'
        vultr.os = servers ["os"] #'Ubuntu 14.04 x64'
        vultr.snapshot = servers ["snapshot"] # example '524557af2439b'
        vultr.label    = servers ["label"]
        vultr.tag      = servers ["tag"]
        vultr.hostname = servers ["hostname"]
     end
    end
  end
end
