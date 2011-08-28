require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'matchy'
require 'fakeweb'
begin require 'redgreen'; rescue LoadError; end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'gowalla'

FakeWeb.allow_net_connect = false

def gowalla_basic_client
  Gowalla::Client.new(:username => 'pengwynn', :password => '0U812', :api_key => 'gowallawallabingbang')
end

def gowalla_oauth_client
  Gowalla::Client.new(:access_token => '0U812', :api_key => 'gowallawallabingbang')
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def gowalla_url(url)
  url =~ /^http/ ? url : "http://api.gowalla.com#{url}"
end

def stub_request(url, filename, options={})
  opts = {
    :body => fixture_file(filename),
    :content_type => 'application/json; charset=utf-8'
  }.merge(options)
  FakeWeb.register_uri(:any, gowalla_url(url), opts)
end
