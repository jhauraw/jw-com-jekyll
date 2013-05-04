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

    # Using crc32 to return consistent numeric value of string.
    # input.hash sucks and returns diff value for same string.
    #
    # Using input value of string to match with same CDN Host
    # upon successive site regenerations.
    #
    # time.usec to get a nice short numeric Release id.
    #
    # Expects 4 CDN hosts in an array
    def to_cdnurl(input)

      require 'zlib'

      cdn_hosts = @context.registers[:site].config['cdn_hosts']

      cdn_num = cdn_hosts.length
      hash = Zlib::crc32(input)
      cdn_sub = hash % cdn_num
      cdn_host = cdn_hosts[cdn_sub]

      release = @context.registers[:site].time.usec

      # puts "\nInput: #{input}\nCDN Host: #{cdn_host}\nCDN Sub: #{cdn_sub}\nCDN Num: #{cdn_num}\nRelease: #{release}\nHash: #{hash}\n"

      input = "//#{cdn_host}#{get_baseurl}/assets-#{release}#{input}"
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
