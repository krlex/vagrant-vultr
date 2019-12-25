# -*- mode: ruby -*-

require 'yaml'
require File.dirname(__FILE__)+"/dependency"
check_plugins ["vagrant-vultr"]
servers = YAML.load_file('srv_name.yml')
API_VERSION = "2"
Vagrant.configure(API_VERSION) do |config|
  servers.each do | servers |
    config.vm.define servers["name"] do |machine|
      machine.vm.box = servers["box"]
      machine.vm.provider :virtualbox do |vb|
      machine.vm.provider :vultr do |vultr, override|
        vb.name = servers["name"]
        vb.memory = servers["memory"]
        vb.cpus = servers["cpu"]
      end
    end
  end
end
end
