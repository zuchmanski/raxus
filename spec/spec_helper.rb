$:.unshift File.join(File.dirname(__FILE__), '../lib')
require "raxus"
require "rspec"
require "rack/test"

def data_path
  File.join(File.dirname(__FILE__), "data")
end
