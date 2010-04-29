$:.unshift File.dirname(__FILE__)

require "lib/compress"

class Raxus

  class << self

    def app(options = {})
      Raxus::Application.new(options)
    end

  end

  class Application

    attr_accessor :options, :headers, :body, :request_counter

    def initialize(options)
      @options = options
      @headers = {}
      @request_counter = 0

      @options[:files].map! { |file| File.expand_path(file) }

      if @options[:files].size > 1 || File.directory?(@options[:files][0])
        @options[:newfile] = compress(@options[:files])
      else
        @options[:newfile] = @options[:files][0]
      end

      @body = File.read(@options[:newfile])

      @headers["Content-Type"] = "binary/octet-stream"
      @headers["Content-Disposition"] = "attachment; filename=\"#{@options[:newfile]}\""
      @headers["Content-Length"] = @body.size.to_s
    end

    def call(env)
      unless @options[:limit] && (@request_counter += 1) > @options[:limit]
        [200, @headers, [@body]]
      else
        [404, {}, ["Download limit exceeded."]]
      end
    end

  end

end
