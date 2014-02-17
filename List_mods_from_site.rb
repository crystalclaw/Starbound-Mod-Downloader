#!/usr/bin/env ruby
require 'rubygems'
#require_relative 'resources'
#load both required libraries
require 'nokogiri'
require 'open-uri'


#Wrap get_names in a pageable format
def get_names_page(pnum)
  #Make URL based on page number and remainder of url
  get_names("http://community.playstarbound.com/index.php?resources/&page=" + pnum.to_s)
end

#code to extract the names from the site
def get_names(site)
  #set starbound to the nokogiri document of the website, with error handling
  starbound = Nokogiri::HTML( begin open(site) rescue puts("Can't open website!") end)
  #starbound = Nokogiri::HTML(open(site))
  #Initalize @all and set the names variable
  @all = ""
  names = %w(h3)
  #traverse starbound website, looking for the 'h3' name; when found, put it and some formatting data into @all
  starbound.traverse {|node| (@all = @all + node + "$|$") if names.include? node.name}
  #make sure @all is a string
  @all = @all.to_s
  #get rid of tab and return characters
  @all.gsub!(/\t/, '')
  @all.gsub!(/\n/, '')
  #split into array based on '$|$' character set; hopefully no one uses that in a mod name...
  @all = @all.split("$|$")
  #Remove parts of the website that show up but are not mods. Might need changeing if starbound site changes.
  @all = @all - ["Log in or Sign up","Categories","Top Mods","Most Active Authors","Forums","Mods","Members","Useful Searches"]
  #clear and initilize outputs varible
  outputs = ''
  #convert array into string with return characters between them, for display.
  @all.each {|e| outputs += e
    outputs += "
   " }
  #return the resulting string
  return "   " + outputs + "\b\b\b"
end

#print out the output, in this case of page one.
print get_names_page 1