# Todos


```
  country_title = country_title.gsub('-and-', '-n-')  ???

  ### quick hack: patch Asia & Australia to => Asia
  # fix: do NOT use sport.db.admin e.g. FIFA continents for beerdb
  elsif country.key == 'de'
    # use deutschland NOT germany (same as domain country code)
    path = "europe/de-deutschland"  # deutsch/german (de)
  elsif country.key == 'es'
    # use espana NOT spain (same as domain country code)
    path = "europe/es-espana"   # spanish/espanol (es)
  elsif country.key == 'ch'
    # use confoederatio helvetica NOT switzerland (same as domain country code)
    path = "europe/ch-confoederatio-helvetica" # latin
```
