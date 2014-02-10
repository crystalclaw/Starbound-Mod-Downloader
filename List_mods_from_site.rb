#!/usr/bin/env ruby
require 'rubygems'
#require_relative 'resources'
require 'nokogiri'
require 'open-uri'
def get_names_page(pnum)
  get_names("http://community.playstarbound.com/index.php?resources/&page=" + pnum.to_s)
end
def get_names(site)
  starbound = Nokogiri::HTML( begin open(site) rescue puts("Can't open website!") end)
  #starbound = Nokogiri::HTML(open(site))
  @all = ""
  names = %w(h3)
  starbound.traverse {|node| (@all = @all + node + "$|$") if names.include? node.name}
  @all = @all.to_s
  @all.gsub!(/\t/, '')
  @all.gsub!(/\n/, '')
  @all = @all.split("$|$")
  @all = @all - ["Log in or Sign up","Categories","Top Mods","Most Active Authors","Forums","Mods","Members","Useful Searches"]
  outputs = ''
  @all.each {|e| outputs += e
    outputs += "
   " }
  return "   " + outputs + "\b\b\b"
end
print get_names_page 1