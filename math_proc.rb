#!/usr/bin/env ruby

#for parsing command line arguments
require 'optparse'
#for working with CSV format
require 'csv'
#MathProc class that does all the work
require_relative 'lib/math_proc'

#create an instance of a MathProc class and run the command for calculations
MathProc.new.calc_file
