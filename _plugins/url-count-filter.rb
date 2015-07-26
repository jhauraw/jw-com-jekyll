#
# Version: 1.0.0
# Release Date: 2013-09-20
# License: MIT
# (c) Copyright Jhaura Wachsman, http://jhaurawachsman.com

# http://stackoverflow.com/questions/7178590/facebook-fql-query-with-ruby

require 'uri'
require 'open-uri'
require 'json'

module Jekyll
  module UrlCountFilter

    def get_stats_facebook(url)

      apistub = 'http://graph.facebook.com/?ids='
      apiurl = "#{apistub}#{URI.escape(url)}"

      begin
        raise 'Bad URL' if %w( http https ).include?(url)

        if @context.registers[:site].config['app']['mode'] == 'development'
          0
        else
          data = open(apiurl).read
          data = JSON.parse(data)

          data[url]['shares'] ||= 0
        end

      rescue Exception => e
        puts "get_stats_facebook -> #{e} : #{url}"
        data = 0
      end
    end

    def get_stats_twitter(url)

      apistub = 'http://urls.api.twitter.com/1/urls/count.json?url='
      apiurl = "#{apistub}#{URI.escape(url)}"

      begin
        raise 'Bad URL' if %w( http https ).include?(url)

        if @context.registers[:site].config['app']['mode'] == 'development'
          0
        else
          data = open(apiurl).read
          data = JSON.parse(data)

          data['count'] ||= 0
        end

      rescue Exception => e
        puts "get_stats_twitter -> #{e} : #{url}"
        data = 0
      end
    end

    def get_stats_pinterest(url)

      apistub = 'http://api.pinterest.com/v1/urls/count.json?url='
      apiurl = "#{apistub}#{URI.escape(url)}"

      begin
        raise 'Bad URL' if %w( http https ).include?(url)

        if @context.registers[:site].config['app']['mode'] == 'development'
          0
        else
          data = open(apiurl).read

          data.strip!
          data.sub! 'receiveCount(', ''
          data.chop!
          data = JSON.parse(data)

          data['count'] ||= 0
        end

      rescue Exception => e
        puts "get_stats_pinterest -> #{e} : #{url}"
        data = 0
      end
    end

    def get_stats_gplus(url)

      apistub = 'https://plusone.google.com/u/0/_/+1/fastbutton?url='
      apiurl = "#{apistub}#{URI.escape(url)}"

      begin
        raise 'Bad URL' if %w( http https ).include?(url)

        if @context.registers[:site].config['app']['mode'] == 'development'
          0
        else
          data = open(apiurl).read

          data = data.split('window.__SSR = {')[1]

          data = data.split('};')[0]

          # if no shares yet, 'c:' string is not present
          if data.include? 'c:'
            data = data.split('c:')[1].split(',')[0].strip.to_i
          else
            data = 0
          end
        end

      rescue Exception => e
        puts "get_stats_gplus -> #{e} : #{url}"
        data = 0
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::UrlCountFilter)
