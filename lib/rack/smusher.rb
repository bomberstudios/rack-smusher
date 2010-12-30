require "rack"
require "smusher"
require 'digest/md5'

class String
  def - arg
    copy = self.dup
    copy[arg] = ""
    return copy
  end
end

class Rack::Smusher

  VERSION = "0.0.3"

  def initialize(app, options = {}, &block)
    @app = app
    @options = {
      :source => "public/images/source",
      :target => "public/images",
      :base_url => "/images/"
    }.merge(options)
    instance_eval(&block) if block_given?
  end

  def call(env)
    status, headers, body = @app.call(env)

    if env['PATH_INFO'][/png/]
      should_compress = false
      source_path = @options[:source] + '/' + (env['PATH_INFO'] - @options[:base_url])
      target_path = @options[:target] + '/' + (env['PATH_INFO'] - @options[:base_url])

      there_is_a_source_file = File.exist?(source_path)
      there_is_a_target_file = File.exist?(target_path)

      if there_is_a_source_file && there_is_a_target_file
        if File.mtime(source_path) > File.mtime(target_path)
          should_compress = true
        end
      end

      if !there_is_a_target_file && there_is_a_source_file
        should_compress = true
      end

      if should_compress
        status, body = compress source_path, target_path
      end
    end

    @response = Rack::Response.new(body, status, headers)
    @response.to_a
  end

  def compress source, target
    puts "compressing #{source}"
    mkdir_p File.dirname(target), { :verbose => false }
    cp_r source, target, { :verbose => false }
    %x(smusher #{target})
    [200, File.read(target)]
  end

end
