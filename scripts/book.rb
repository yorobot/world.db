# encoding: utf-8


# -- custom code

require_relative 'helpers/link'
require_relative 'helpers/markdown'
require_relative 'helpers/navbar'
require_relative 'helpers/part'
require_relative 'helpers/misc'
require_relative 'helpers/city'
require_relative 'helpers/page'

require_relative 'utils'



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

Page.create( 'index', frontmatter: {
                        layout: 'book',
                        title: 'Contents',
                        permalink: '/index.html' }) do |page|
  file.write render_toc( opts )
end



### generate pages for countries

# Country.where( "key in ('at','mx','hr', 'de', 'be', 'nl', 'cz')" ).each do |country|
Country.all.each do |country|
  puts "build country page #{country.key}..."

  path = country_to_path( country )
  puts "path=#{path}"
  Page.create( path, frontmatter: {
                       layout:  'book',
                       title:   "#{country.title} (#{country.code})",
                       permalink: "/#{country.key}.html" })  do |page|
    file.write render_country( country, opts )
  end
end

end # method build_book



####################################
# fix:
#  - use the country order same as in table of contents
##

def build_book_all_in_one_remove_remove

book_text = <<EOS
---
layout: book
title: Contents
permalink: /book.html
---

EOS

book_text += render_toc( inline: true )


### generate pages for countries
# note: use same order as table of contents

Continent.all.each do |continent|
  continent.countries.order(:title).each do |country|

    puts "build country page #{country.key}..."
    country_text = render_country( country )

    book_text += <<EOS

---------------------------------------

EOS

    book_text += country_text
  end
end
