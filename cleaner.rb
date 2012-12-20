#!/usr/bin/env ruby

#for parsing command line arguments
require 'optparse'
#for working with CSV format
require 'csv'
#cleaner class that does all the work
require_relative 'lib/cleaner'

#create an instance of a Cleaner class and run the cleaning command
Cleaner.new.clean_file
