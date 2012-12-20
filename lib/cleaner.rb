class Cleaner
  
  def initialize(file = false)
    if file
      @file = file
    else
      parse_args
    end
  end
  
  def clean_file
    return unless File.file?(@file.to_s)
    
    clean_file = File.new("clean_#{@file}", 'w')
    error_file = File.new("errors_#{@file}", 'w')
    
    first = true
    head_cols_count = 0
    CSV.foreach(@file) do |row|
      if first
        first = false
        head_cols_count = row.count
      end
      row_str = row2str(row)
      if head_cols_count != row.count
        error_msg = "Number of columns is #{row.count}, expected to be #{head_cols_count}: \n"
        error_file.write(error_msg + row_str)
        next
      end
      clean_file.write(row_str)
    end
    clean_file.close
    error_file.close
  end
  
  private
  
  def row2str(row)
    row_str = ''
    row.each do |s|
      s = s.to_s.strip.downcase.gsub(/[^\x20-\x7E]/, '')
      s = '1' if ['true', 'y'].include?(s)
      s = '0' if ['false', 'n'].include?(s)
      s = "\"#{s}\"" if s.index(',')
      row_str += ",#{s}"
    end
    row_str[0] = ''
    row_str + "\n"
  end
  
  def parse_args
    OptionParser.new do |opts|
      opts.on('', '--file FILE', String, 'Specify the file name for cleaning' ) do |file|
        @file = file
      end
    end.parse!
  end
  
end