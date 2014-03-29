# encoding: utf-8

##########################
# page helpers


def render_country( country, opts={} )
  tmpl       = File.read_utf8( 'templates/country.md' )
  TextUtils::PageTemplate.new( tmpl ).render( binding )
end

def render_toc( opts={} )
  tmpl = File.read_utf8( 'templates/toc.md' )
  TextUtils::PageTemplate.new( tmpl ).render( binding )
end


def render_cities_idx( opts={} )
  tmpl = File.read_utf8( 'templates/cities-idx.md' )
  TextUtils::PageTemplate.new( tmpl ).render( binding )
end

