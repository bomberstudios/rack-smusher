require "rack"
require "smusher"
require 'digest/md5'

class Rack::Smusher

  VERSION = "0.0.1"

  def initialize(app, options = {}, &block)
    @app = app
    @options = {
      :cache => true,
      :cache_path => "cache",
      :image_path => "public"
    }.merge(options)
    instance_eval(&block) if block_given?
  end

  def call(env)
    status, headers, body = @app.call(env)

    type = headers['Content-Type']

    if type == 'image/png'
      file = @options[:image_path] + env['PATH_INFO']
      file_hash = Digest::MD5.hexdigest(File.read(file))

      target = @options[:cache_path] + '/' + file_hash + '_' + File.basename(file)
      if !File.exist? target
        cp_r file, target, { :verbose => false }
        %x(smusher #{target})
      end

      body = File.read(target)
    end

    @response = Rack::Response.new(body, status, headers)
    @response.to_a
  end

end
