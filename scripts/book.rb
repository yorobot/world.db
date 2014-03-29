# encoding: utf-8


# -- custom code

require_relative 'helpers/link'
require_relative 'helpers/markdown'
require_relative 'helpers/navbar'
require_relative 'helpers/part'
require_relative 'helpers/misc'
require_relative 'helpers/city'
require_relative 'helpers/page'



puts '[book]  Welcome'
puts "[book]    Dir.pwd: #{Dir.pwd}"
puts "[book]    PAGES_DIR: #{PAGES_DIR}"


### model shortcuts

Continent = WorldDb::Model::Continent
Country   = WorldDb::Model::Country
Region    = WorldDb::Model::Region
City      = WorldDb::Model::City



######
# fix/todo: add to textutils or hybook ?? for reuse


class JekyllBuilder

  def initialize( pages_dir, opts={} )
    @pages_dir = pages_dir

    @inline    = opts[:inline ] == true ? true : false

    ### @layout    = opts[:layout] || 'book'

    ## if @inline create all-in-one book(.html) page
    if @inline
      path = "#{@pages_dir}/book.md"      
      puts "[book] create all-in-one book page (#{path})"

      ## add frontmatter

      ## todo: get title from opts!!!

      page_opts = { frontmatter: {
                       layout: 'book',
                       title: 'Book Title Here',
                       permalink: '/book.html' } }

      TextUtils::Page.create( path, page_opts ) do |page|
        ## do nothing for now
      end
    end
  end


  def page( name, frontmatter={} )

    if @inline
      path = "#{@pages_dir}/book.md"
      puts "[book] update all-in-one book page -- #{name} (#{path})"

      ## note: ignore title and permalink (frontmatter opts for now; not needed for all-in-one)
      TextUtils::Page.update( path ) do |page|
        yield( page )
      end
    else
      path = "#{@pages_dir}/#{name}.md"
      puts "[book] create page #{name} (#{path})"

      page_opts = { frontmatter: {
                       layout: 'book' } }
      ## merge all frontmatter opts for now into frontmatter
      #  e.g. expects title and permalink for now
      page_opts[ :frontmatter] = page_opts[ :frontmatter ].merge( frontmatter )

      TextUtils::Page.create( path, page_opts ) do |page|
        yield( page )
      end
    end
  end

end  # class JekyllBuilder



#####
# todo/fix: use constant to set  ./_pages   - output (root) folder for generated pages
# todo/fix: use constant to set layout  e.g. book


def build_book( opts={} )

### generate table of contents (toc)

  b = JekyllBuilder.new( PAGES_DIR, opts )

  b.page('index',  title:     'Contents',
                   permalink: '/index.html' ) do |page|
      page.write render_toc( opts )
  end


### generate pages for countries
# note: use same order as table of contents

Continent.all.each do |continent|
  continent.countries.order(:name).each do |country|

    puts "build country page #{country.key}..."
    path = country.to_path
    puts "path=#{path}"
    
    b.page( path,  title:    "#{country.name} (#{country.code})",
                   permalink: "/#{country.key}.html" ) do |page|
      page.write render_country( country, opts )
    end
  end
end

end # method build_book

