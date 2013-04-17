module Jekyll
  module Filters

    def sub_baseurl(input)

      # Use the value of @site.baseurl from _config.yml
      # to_s() in case null or non-string to prevent errors
      baseurl = @context.registers[:site].config['baseurl'].to_s

      # Append @baseurl to Root-Relative URLs in templates
      # to make a Root-Base-Relative URL. Looks for ="/ in
      # href or src tags
      input.gsub(/(href|src)="\//, '\1="' + baseurl + '/')
    end

    def sub_absurl(input)

      # Use the value of @site.url from _config.yml
      # to_s() in case null or non-string to prevent errors
      url = @context.registers[:site].config['url'].to_s

      baseurl = @context.registers[:site].config['baseurl'].to_s

      # Append @url and @baseurl to Root-Relative URLs in
      # templates to make an Absolute URL. Looks for ="/ in
      # href or src tags.
      input.gsub(/(href|src)="\//, '\1="' + url + baseurl + '/')
    end

    def to_absurl(input)

      url = @context.registers[:site].config['url'].to_s
      baseurl = @context.registers[:site].config['baseurl'].to_s

      url + baseurl << input
    end
  end
end

Liquid::Template.register_filter(Jekyll::Filters)
