module Jekyll

  class YamlToLiquid < Liquid::Tag
    def initialize(tag_name, args, tokens)
      super

      args = args.split(' ')

      arg0 = args[0].to_s.strip # yml_path
      arg1 = args[1].to_s.strip # yml_path_1
      arg2 = args[2].to_s.strip # yml_path_2

      if arg0.length == 0
        raise 'Please enter at least one yaml file path'
      else
        @yml_path = arg0
      end

      @yml_path_1 = arg1 unless arg1.length == 0
      @yml_path_2 = arg2 unless arg2.length == 0
    end

    def render(context)

      yml = YAML::load(File.read(@yml_path))
      context.registers[:page]['yml'] = yml

      unless @yml_path_1 == nil
        yml1 = YAML::load(File.read(@yml_path_1))
        context.registers[:page]['yml1'] = yml1
      end

      unless @yml_path_2 == nil
        yml2 = YAML::load(File.read(@yml_path_2))
        context.registers[:page]['yml2'] = yml2
      end
    end
  end
end

Liquid::Template.register_tag('yaml_to_liquid', Jekyll::YamlToLiquid)
