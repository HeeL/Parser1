class Cleaner
  
  def initialize(file = false)
    if file
      #save filename if it was specify
      @file = file
    else
      #try to parse a name if it wasn't passed
      parse_args
    end
  end
  
  #clean file according to rules
  def clean_file
    #check whether file exists
    return unless File.file?(@file.to_s)
    
    #file for result output
    clean_file = File.new("clean_#{@file}", 'w')
    #file for error output
    error_file = File.new("errors_#{@file}", 'w')
    
    #first iteration
    first = true
    head_cols_count = 0
    CSV.foreach(@file) do |row|
      if first
        first = false
        # save the number of cols
        head_cols_count = row.count
      end
      #cleanings and conversions of a row
      row_str = row2str(row)
      #if amount of cols doesn't match
      if head_cols_count != row.count
        #save the case to an error file
        error_msg = "Number of columns is #{row.count}, expected to be #{head_cols_count}: \n"
        error_file.write(error_msg + row_str)
        error_file.flush
        #skip the line
        next
      end
      #put the clean line to a file
      clean_file.write(row_str)
      clean_file.flush
    end
    #close files after finish working with them
    clean_file.close
    error_file.close
  end
  
  private
  
  def row2str(row)
    row_str = ''
    row.each do |s|
      #down case the string and clean it
      s = s.to_s.strip.downcase.gsub(/[^\x20-\x7E]/, '')
      s.gsub!(/['"]$/, '')
      s.gsub!(/^['"]/, '')
      #convert booleans
      s = '1' if ['true', 'y'].include?(s)
      s = '0' if ['false', 'n'].include?(s)
      #deal with strings that contain comma
      s = "\"#{s}\"" if s.index(',')
      row_str += ",#{s}"
    end
    row_str[0] = ''
    row_str + "\n"
  end
  
  #parse cmd line args
  def parse_args
    OptionParser.new do |opts|
      #parse the only argument - file name for cleaning
      opts.on('', '--file FILE', String, 'Specify the file name for cleaning' ) do |file|
        @file = file
      end
    end.parse!
  end
  
end