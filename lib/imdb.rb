$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'cgi'

require 'imdb/base'
require 'imdb/search'
require 'imdb/movie'
require 'imdb/tv_show'
require 'imdb/season'
require 'imdb/episode'
require 'imdb/version'
