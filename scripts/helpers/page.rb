# encoding: utf-8

##########################
# page helpers


def render_country( country, opts={} )
  tmpl       = File.read_utf8( 'templates/country.md' )
  render_erb_template( tmpl, binding )
end

def render_toc( opts={} )
  tmpl = File.read_utf8( 'templates/toc.md' )
  render_erb_template( tmpl, binding )
end


def render_cities_idx( opts={} )
  tmpl = File.read_utf8( 'templates/cities-idx.md' )
  render_erb_template( tmpl, binding )
end

