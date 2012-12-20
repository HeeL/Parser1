#!/usr/bin/env ruby

require 'optparse'
require 'csv'
require_relative 'lib/cleaner'

Cleaner.new.clean_file
