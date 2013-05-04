module Jekyll
  module Filters

    # The get_ methods grab a value from _config.yml and
    # returns it.
    def get_url
      url = @context.registers[:site].config['url']
    end

    def get_baseurl
      baseurl = @context.registers[:site].config['baseurl']
    end

    def to_baseurl(input)

      # baseurl << input # wouldn't work, created a huge concat chain
      input = "#{get_baseurl}#{input}"
    end

    def to_absurl(input)

      # url + baseurl << input
      input = "#{get_url}#{get_baseurl}#{input}"
    end

    # Prepend a 'virtual versioned' CDN URL for any relative URL resource,
    #
    # Example input value for a relative image resource:
    # /images/dog.jpg
    #
    # Example return value for an Amazon Cloudfront CDN URL:
    # //xxx.cloudfront.net/BASE_URL/RELEASE/images/dog.jpg
    #
    # Using crc32 to return consistent cross-machine numeric value of string.
    # input.hash sucks and returns diff value for same string, even on same
    # machine.
    #
    # Using value of @input string to match with same CDN Host upon successive
    # site regenerations.
    #
    # Release id, f not set or null, the current day's date will be used with
    # two digit century; given 2025/01/15, release will equal 250115
    #
    # Prefix. Release id is prefixed with this value, for catching in
    # an .htaccess RewriteRule such as:
    #
    # RewriteRule ^/v\d+/(img|js|css|pdf|font)/(.*)$ /$1/$2 [L]
    #
    # or, more aggressive:
    # RewriteRule ^/v\d{6,6}/(.*)$ /$1 [L]
    def to_cdnurl(input)

      require 'zlib'

      cdn_hosts = @context.registers[:site].config['cdn_hosts']

      cdn_num = cdn_hosts.length
      hash = Zlib::crc32(input)
      cdn_sub = hash % cdn_num
      cdn_host = cdn_hosts[cdn_sub]

      release = @context.registers[:site].config['release']

      if !release
        release = @context.registers[:site].time.strftime('%y%m%d')
      end

      prefix = 'v-'

      #puts "\nInput: #{input}\nCDN Host: #{cdn_host}\nCDN Sub: #{cdn_sub}\nCDN Num: #{cdn_num}\nRelease: #{release}\nHash: #{hash}\n//#{cdn_host}#{get_baseurl}/#{prefix}#{release}#{input}\n"

      input = "//#{cdn_host}#{get_baseurl}/#{prefix}#{release}#{input}"
    end

    def sub_baseurl(input)

      # Append @baseurl to Root-Relative URLs in templates
      # to make a Root-Base-Relative URL. Looks for ="/ in
      # href or src tags
      #input.gsub(/(href|src)="\//, '\1="' + get_baseurl + '/')
      input
    end

    def sub_absurl(input)

      # Append @url and @baseurl to Root-Relative URLs in
      # templates to make an Absolute URL. Looks for ="/ in
      # href or src tags.
      #input.gsub(/(href|src)="\//, '\1="' + get_url + get_baseurl + '/')
      input
    end
  end
end

Liquid::Template.register_filter(Jekyll::Filters)
