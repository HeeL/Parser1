class MathProc
  
  def initialize(file = false)
    if file
      @file = file
    else
      parse_args
    end
  end
  
  def calc_file
    return unless File.file?(@file.to_s)
    
    calc_file = File.new("calc_#{@file}", 'w')
    
    first = true
    CSV.foreach(@file) do |row|
      if first
        first = false
      end
      row_str = row2str(row)
      calc_file.write(row_str)
    end
    calc_file.close
  end
  
  private
  
  def row2str(row)
    row_str = ''
    row.each do |s|
      s = s.to_s
      if s =~ /^[0-9]+$/ && s.to_i > 1
        s = calc(s.to_i)
      else
        s = "\"#{s}\"" if s.index(',')
      end
      row_str += ",#{s}"
    end
    row_str[0] = ''
    row_str + "\n"
  end
  
  def calc(num)
    num + 1
  end
  
  def parse_args
    OptionParser.new do |opts|
      opts.on('', '--file FILE', String, 'Specify the file name for proccessing' ) do |file|
        @file = file
      end
    end.parse!
  end
  
end