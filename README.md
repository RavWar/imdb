# imdb [![Build Status](https://travis-ci.org/ariejan/imdb.png?branch=master)](https://travis-ci.org/ariejan/imdb)

* [Sources](https://github.com/ariejan/imdb)
* [Issues](https://github.com/ariejan/imdb/issues)

## Description

This gem allows you to easy access publicly available data from IMDB.

## Features

IMDB currently features the following:

* Querying details movie info
* Searching for movies
* Command-line utility included.

## Synopsis

### Movies:

    i = Imdb::Movie.new("0095016")

    i.title
    #=> "Die Hard"

    i.cast_members.first
    #=> "Bruce Willis"

### Searching:

    i = Imdb::Movie.search("Star Trek")

    i.size
    #=> 97

### Using the command line utility is quite easy:

    $ imdb Star Trek

or get movie info

    $ imdb 0095016

## Installation

    gem install imdb

## Running Tests

    $ bundle install
    $ bundle exec rake spec

## Disclaimer

I, or any developer who contributed to this project, accepts any kind of
liabilty for your use of this library.

IMDB does not permit use of its data by third parties without their consent.

Using this library for anything other than limited personal use may result
in an IP ban to the IMDB website.

## License

See [MIT-LICENSE](https://github.com/ariejan/imdb/blob/master/MIT-LICENSE)
