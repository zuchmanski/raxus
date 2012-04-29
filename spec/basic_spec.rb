# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe Raxus do
  include Rack::Test::Methods

  def prepare_browser(options)
    browser = Rack::Test::Session.new(Rack::MockSession.new(Raxus.app(options)))
    browser.get '/'
    browser
  end

  it "should be able to share one file" do
    browser = prepare_browser(:files => ["#{data_path}/avatar.jpg"])
    browser.last_response.body.should == File.read("#{data_path}/avatar.jpg")
    browser.last_response.header["Content-Disposition"].should include(%{filename="avatar.jpg"})
  end

  it "should be able to share one folder" do
    browser = prepare_browser(:files => ["#{data_path}/GPL"])
    browser.last_response.body.should == File.read("/tmp/GPL.zip")
    browser.last_response.header["Content-Disposition"].should include(%{filename="GPL.zip"})
  end

  it "should be able to share files/folders many times" do
    browser = prepare_browser(:files => ["#{data_path}/GPL", "#{data_path}/avatar.jpg"])
    10.times do
      browser.get '/'
      browser.last_response.body.should == File.read("/tmp/download.zip")
      browser.last_response.header["Content-Disposition"].should include(%{filename="download.zip"})
    end
  end

  it "should be able to set download limit" do
    browser = prepare_browser(:files => ["#{data_path}/avatar.jpg"], :limit => 5)
    browser.last_response.body.should == File.read("#{data_path}/avatar.jpg")
    browser.last_response.header["Content-Disposition"].should include(%{filename="avatar.jpg"})

    4.times do # one get already done in prepare_browser
      browser.get '/'
      browser.last_response.body.should == File.read("#{data_path}/avatar.jpg")
      browser.last_response.header["Content-Disposition"].should include(%{filename="avatar.jpg"})
    end

    browser.get '/'
    browser.last_response.body.should include("limit exceeded")
  end
end
