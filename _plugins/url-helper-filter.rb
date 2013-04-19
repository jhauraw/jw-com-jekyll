module Jekyll
  module Filters
    def get_url

      # Use the value of @site.url from _config.yml
      # to_s() in case null or non-string to prevent errors
      url = @context.registers[:site].config['url'].to_s
    end

    def get_baseurl

      # Use the value of @site.baseurl from _config.yml
      # to_s() in case null or non-string to prevent errors
      baseurl = @context.registers[:site].config['baseurl'].to_s
    end

    def to_baseurl(input)

      # baseurl << input # wouldn't work, created a huge concat chain
      input = get_baseurl + input
    end

    def to_absurl(input)

      # url + baseurl << input
      input = get_url + get_baseurl + input
    end

    def sub_baseurl(input)

      # Append @baseurl to Root-Relative URLs in templates
      # to make a Root-Base-Relative URL. Looks for ="/ in
      # href or src tags
      input.gsub(/(href|src)="\//, '\1="' + get_baseurl + '/')
    end

    def sub_absurl(input)

      # Append @url and @baseurl to Root-Relative URLs in
      # templates to make an Absolute URL. Looks for ="/ in
      # href or src tags.
      input.gsub(/(href|src)="\//, '\1="' + get_url + get_baseurl + '/')
    end
  end
end

Liquid::Template.register_filter(Jekyll::Filters)
