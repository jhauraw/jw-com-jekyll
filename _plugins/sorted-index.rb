# mimic this one:
# https://github.com/realjenius/realjenius.com/blob/master/_plugins/cat_and_tag_generator.rb

# REQUIRES plugin url-helper-filter.rb
# So we can use url-helper-filter.rb method sanitize_str to clean up
# any non-standard category names.
include Jekyll::Filters

module Jekyll
  class SortedIndex < Page
    def initialize(site, base, dir, group)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'sorted-index.html')
      self.data['group'] = group
      self.data['title'] = group.split(' ').map(&:capitalize).join(' ')
      self.data['excerpt'] = "Indexed list of all articles in &#39;"+group+"&#39;."
    end
  end

  class SortedGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'sorted-index'
        site.categories.each do |posts|
          write_sorted_index(site, posts)
        end
      end
    end

    def write_sorted_index(site, posts)

      posts[1] = posts[1].sort_by { |p| -p.date.to_f }

      pages = Pager.calculate_pages(posts[1], site.config['paginate'].to_i)
      (1..pages).each do |num_page|
        pager = Pager.new(site.config, num_page, posts[1], pages)

        category = sanitize_str(posts[0])

        path = "/#{category}"

        if num_page > 1
          path = path + "/page/#{num_page}"
        end

        newpage = SortedIndex.new(site, site.source, path, posts[0])
        newpage.pager = pager
        site.pages << newpage
      end
    end
  end
end