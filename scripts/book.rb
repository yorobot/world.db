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

  def inline?()   @inline;    end
  def title()     @title;     end
  def layout()    @layout;    end
  def pages_dir() @pages_dir; end


  def initialize( user_pages_dir, opts={} )
    @pages_dir = user_pages_dir   # add user_ to avoid conflict w/ attrib

    @inline    = opts[:inline ] == true ? true : false   # all-in-one page version or multi-page?

    @title     = opts[:title]  || 'Book Title Here'
    @layout    = opts[:layout] || 'book'


    ## if @inline create all-in-one book(.html) page
    if inline?
      path = "#{pages_dir}/book.md"      
      puts "[book] create all-in-one book page (#{path})"

      ## add frontmatter

      page_opts = { frontmatter: {
                       layout: layout,
                       title:  title,
                       permalink: '/book.html' } }

      TextUtils::Page.create( path, page_opts ) do |page|
        ## do nothing for now
      end
    end
  end



  def page( name, opts={} )

    # add fallbacks/defaults
    opts[:title] ||= 'Page Title Here'
    opts[:id]    ||= TextUtils.slugify( @title )   ## add page/section counter to generated fallback id/anchor

    if inline?
      path = "#{pages_dir}/book.md"
      puts "[book] update all-in-one book page -- #{name} (#{path})"

      page_opts = {}.merge( opts )  ## for now pass along all opts; no built-in/auto-added opts -- in the future add page/section counter or similar, for example?
      TextUtils::Page.update( path, page_opts ) do |page|
        yield( page )
      end
    else
      path = "#{pages_dir}/#{name}.md"
      puts "[book] create page #{name} (#{path})"

      page_opts = { frontmatter: {
                       layout:    layout,                 # e.g. 'book'
                       title:     opts[:title],            # e.g. 'The Free Beer Book'
                       permalink: "/#{opts[:id]}.html"      # e.g. '/index.html'
                  }}
      page_opts = page_opts.merge( opts )   ## pass along all opts

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
                   id:        'index' ) do |page|
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
                   id:       country.key ) do |page|
      page.write render_country( country, opts )
    end
  end
end

end # method build_book

