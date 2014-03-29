## {{ country.name }}   ++
   ({{ country.code }})  ++
   -                     ++
   {{ country.regions.count }} Regions, ++
   {{ country.cities.count }} Cities
   {: #{{ country.key }} }

 .. <!-- add intra-page links for regions here -->
 <!-- change to navbar_regions_for_country ?? -->
 {{ regions_navbar_for_country( country ) }}


  .. <!-- list breweries w/o (missing) region -->
  .. <!-- todo/fix: change name to uncategorized_breweries -->
{% cities_missing_regions = country.cities.where( 'region_id is null' )
   if cities_missing_regions.count > 0
 %}

### Uncategorized _({{ cities_missing_regions.count }})_{:.count}

  {{ render_cities( cities_missing_regions ) }}
{% end %}


  .. <!-- list regions w/ breweries -->
{% country.regions.each do |region| %}

### _({{region.key}})_{:.key} {{ region.all_names }}  ++
    _({{ region.cities.count }})_{:.count}    {{ region.area }} km2  {{ region.pop }} pop
{: #{{ country.key }}-{{ region.key }} }

 {{ render_cities( region.cities.order(:name) ) }}

{% end %} <!-- each region -->
