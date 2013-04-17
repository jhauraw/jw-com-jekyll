module Jekyll
  module AbsoluteURLFilter
    def to_absolute_url(content)
      url = @context.registers[:site].config['url'].to_s
      content.gsub(/(href|src)="\//, '\1="' + url + '/')
    end
  end
end

Liquid::Template.register_filter(Jekyll::AbsoluteURLFilter)
