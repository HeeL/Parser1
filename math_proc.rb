#!/usr/bin/env ruby

require 'optparse'
require 'csv'
require_relative 'lib/math_proc'

MathProc.new.calc_file
