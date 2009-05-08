require 'rake'
$:.unshift(File.dirname(__FILE__) + "/lib")
require 'hoe'
require 'dropio/xmpp/client'

Hoe.new('dropio_xmpp_client', Dropio::XMPP::VERSION) do |p|
  p.name = "dropio_xmpp_client"
  #p.author = "Sergio Rubio"
  p.description = %q{drop.io XMPP Client}
  p.email = 'sergio@rubio.name'
  p.summary = "drop.io XMPP Client Library"
  p.url = "http://github.com/rubiojr/dropio_xmpp_client"
  p.remote_rdoc_dir = '' # Release to root
  p.extra_deps << [ "dropio",">= 0.9" ]
  p.extra_deps << [ "xmpp4r",">= 0.4" ]
  p.extra_deps << [ "term-ansicolor",">= 1.0" ]
  p.developer('Sergio Rubio', 'sergio@rubio.name')
end

task :publish_dev_gem do
end
task :publish_gem do
end
