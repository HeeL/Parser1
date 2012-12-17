#!/usr/bin/env ruby

require 'optparse'
require_relative 'lib/parser'

parser = Parser.new

OptionParser.new do |opts|
  opts.on('', '--i1 FILE1,COL1,[COL_1,COL_2..COL_N]', String, 'Specify input file' ) do |args|
    parser.get_info(args, 1)
  end
  opts.on('', '--i2 FILE2,COL2,[COL_1,COL_2..COL_N]', String, 'Specify input file2' ) do |args|
    parser.get_info(args, 2)
  end
  opts.on('', '--o FILE', String, 'Specify output file' ) do |file|
    parser.output_file = file
  end
end.parse!
