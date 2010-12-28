require "rack"
require "smusher"

class Rack::Smusher

  VERSION = "0.0.1"

  def initialize(app, options = {}, &block)
    @app = app
    @options = {
      :notes_path => 'notes',
      :css => "position: fixed; bottom: 0; left: 0; width: 100%; padding: 1em; background-color: rgba(245,242,137,0.6); margin: 0 auto;",
      :extra_css => ""
    }.merge(options)
    instance_eval(&block) if block_given?
  end

  def call(env)
    status, headers, body = @app.call(env)

    route = env['PATH_INFO']
    file = Dir.pwd + "/#{@options[:notes_path]}" + route.gsub(/\/$/,'') + '.txt'
    if File.exists?(file)
      note = File.readlines(file).to_s
      body.body.gsub!("</body>","<div id='racknotes'>#{note}</div><style>#racknotes { #{@options[:css]} #{@options[:extra_css]} }</style></body>")
    end

    @response = Rack::Response.new(body, status, headers)
    @response.to_a
  end

end
