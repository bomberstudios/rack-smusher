# rack-smusher

rack-smusher is a rack middleware to compress (smush) images by using the [smusher](https://github.com/grosser/smusher) gem.

It is intended to be used with [serve](http://github.com/jlong/serve), but it may work with other Rack-based frameworks (Sinatra, I'm looking at you)

**Your original images will never be touched**. rack-smusher works on copies of your files.

## Why?

I like to save Fireworks editable files inside my serve project, and store them in the git repository. Thus, collaborators have access to the source files and can make changes, history is preserved, and life is good.

That, and it seemed like a fun miniproject :)


## Usage

Put this in your config.ru:

    gem 'rack-smusher'
    require 'rack/smusher'
    
    use Rack::Smusher, {
      :source => "app/images",
      :target => "public/images",
      :base_url => "/images/"
    }

Now, you can save your editable files in `app/images`, and rack-smusher will compress and copy them to `public/images` when the browser requests them. Folder structure will be preserved, so a file saved in `app/images/foo/bar.png` will be saved to `public/images/foo/bar.png`.

If for some reason your app uses a different path for images (say, `/img/`) you can specify it in the `:base_url` option.