# mimic this one:
# https://github.com/realjenius/realjenius.com/blob/master/_plugins/cat_and_tag_generator.rb

module Jekyll

  class CategoryIndex < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category-index.html')
      self.data['category'] = category
      self.data['title'] = "Posts categorized &ldquo;"+category+"&rdquo;"
      self.data['excerpt'] = "Indexed list of all Posts in category &#39;"+category+"&#39;."
    end
  end

  class CategoryGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'category-index'
        site.categories.each do |category|
          write_category_index(site, category)
        end
      end
    end

    def write_category_index(site, posts)
      posts[1] = posts[1].sort_by { |p| -p.date.to_f }

      pages = Pager.calculate_pages(posts[1], site.config['paginate'].to_i)
      (1..pages).each do |num_page|
        pager = Pager.new(site.config, num_page, posts[1], pages)

        path = "/#{posts[0]}"

        if num_page > 1
          path = path + "/page/#{num_page}"
        end

        newpage = CategoryIndex.new(site, site.source, path, posts[0])
        newpage.pager = pager
        site.pages << newpage
      end
    end
  end
end