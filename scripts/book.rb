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



#####
# todo/fix: use constant to set  ./_pages   - output (root) folder for generated pages
# todo/fix: use constant to set layout  e.g. book


def build_book( opts={} )

### generate table of contents (toc)

  b = BookBuilder.new( PAGES_DIR, opts )

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

