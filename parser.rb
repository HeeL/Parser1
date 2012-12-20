#!/usr/bin/env ruby

#for parsing command line arguments
require 'optparse'
#for working with CSV format
require 'csv'
#include all the classes we are working with
require_relative 'lib/options'
require_relative 'lib/cleaner'
require_relative 'lib/math_proc'
require_relative 'lib/joiner'

#Options class for parsing multiple args and options from command line
options = Options.new

#run each module one by one: Clean, Calculate...
options.files.each do |file|
  Cleaner.new(file).clean_file
  MathProc.new("clean_#{file}").calc_file
end

#join files
Joiner.new(options).join_files

