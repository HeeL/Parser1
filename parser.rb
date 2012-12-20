#!/usr/bin/env ruby

require 'optparse'
require 'csv'
require_relative 'lib/options'
require_relative 'lib/cleaner'
require_relative 'lib/math_proc'
require_relative 'lib/joiner'

options = Options.new

options.files.each do |file|
  Cleaner.new(file).clean_file
  MathProc.new("clean_#{file}").calc_file
  Joiner.new("calc_clean_#{file}").join_file
end
