# rack-smusher

rack-smusher is a rack middleware to compress (smush) images by using the [smusher](https://github.com/grosser/smusher) gem.

It is intended to be used with [serve](http://github.com/jlong/serve), but it may work with other Rack-based frameworks (Sinatra, I'm looking at you)

**Your original images will never be touched**. rack-smusher works on copies of your files.

## Why?

I like to save my Fireworks editable files in the public folder while designing / prototyping. 


## Usage

    gem 'rack-smusher'
    require 'rack/smusher'
    
    use Rack::Smusher, {
      :cache_path => "cache",
      :image_path => "public"
    }

