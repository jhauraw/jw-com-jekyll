module Jekyll

  class YamlToLiquid < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super

      args = markup.split(' ')

      arg0 = args[0].to_s.strip # yaml_path
      arg1 = args[1].to_s.strip # template_path
      arg2 = args[2].to_s.strip # category_node

      if arg0.length == 0 || arg1.length == 0
        raise 'Please enter both a yaml file path and a template path.'
      else
        @yaml_path = arg0
        @template_path = arg1
      end

      @cat_node = nil

      if args.length > 2
        arg2 = args[2].to_s.strip

        @cat_node = arg2 unless arg2.length == 0
      end
    end

    def render(context)

      template = File.read(@template_path)
      parsed = Liquid::Template.parse(template)

      hash = YAML::load(File.read(@yaml_path))

      output = ''

      hash.each do |cats|
        cats.each do |cat, projects|
          if (@cat_node == nil || cat == @cat_node)
            projects.each do |p|

              output += '<li>'
              output += parsed.render('p' => p)
              output += '</li>'
            end
          end
        end
      end

      output
    end
  end
end

Liquid::Template.register_tag('yaml_to_liquid', Jekyll::YamlToLiquid)
