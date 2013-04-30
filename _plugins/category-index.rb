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
        dir = ''
        site.categories.keys.each do |category|
          write_category_index(site, File.join(dir, category), category)
        end
      end
    end

    def write_category_index(site, dir, category)
      index = CategoryIndex.new(site, site.source, dir, category)

      #pages = Pager.calculate_pages(site.posts, site.config['paginate'].to_i)
      #(1..pages).each do |num_page|
      #  pager = Pager.new(site.config, num_page, site.posts, pages)
      #  if num_page > 1
      #    newpage = CategoryIndex.new(site, site.source, dir, category)
      #    newpage.pager = pager
      #    newpage.dir = File.join(category, "page/#{num_page}")
      #    site.pages << newpage
      #  else
      #    index.pager = pager
      #  end
      #end

      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
end