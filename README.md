# build

Note: The recommended and easiest way to build yourself
your own database copies (e.g. world.db, austria.db, etc.)
is using Datafiles.
See the [`openmundi/datafile`](https://github.com/openmundi/datafile)
repo for details.


## Intro

Build scripts for world.db, austria.db, etc.


## Usage

To list all available build tasks try:

~~~
$ rake -T
~~~

Will print something like:

~~~
rake build     # clean world.db build from folder '../world.db'
rake create    # create world.db schema
rake update    # update world.db from folder '../world.db'

rake about     # print versions of gems
rake stats     # print stats for world.db tables/records
~~~

## Examples

Build the database for all countries (from scratch):

~~~
rake build SETUP=countries
~~~

Build the database for all all countries (incl. all states, cities, etc.):

~~~
rake build SETUP=all
~~~



## More (Extra) Tasks

~~~
rake factbook  # generate json for factbook.json repo
~~~


## License

The build scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [Open World Database (world.db) and Friends Forum/Mailing List](http://groups.google.com/group/openmundi). 
Thanks!
