class MathProc
  
  def initialize(file = false)
    if file
      #save filename if it was specify
      @file = file
    else
      #try to parse a name if it wasn't passed
      parse_args
    end
  end
  
  #do a calculation with the provided file
  def calc_file
    #check whether file exists
    return unless File.file?(@file.to_s)
    #result file
    calc_file = File.new("calc_#{@file}", 'w')
    #read given file line by line
    CSV.foreach(@file) do |row|
      #proccess the line
      row_str = row2str(row)
      #write into a result file
      calc_file.write(row_str)
      calc_file.flush
    end
    calc_file.close
  end
  
  private
  
  #convert an array row to a valid csv string
  def row2str(row)
    row_str = ''
    row.each do |s|
      s = s.to_s
      #proccess the value if its a Number but not a Boolean
      if s =~ /^[0-9]+$/ && s.to_i > 1
        s = calc(s.to_i)
      else
        #check whether we need to wrap string with quotes
        s = "\"#{s}\"" if s.index(',')
      end
      #concat a result row
      row_str += ",#{s}"
    end
    #get rid of first comma
    row_str[0] = ''
    #return a row as a string with the new line at the end
    row_str + "\n"
  end
  
  def calc(num)
    #х(i)=( a(i)-AVERAGE(a:a) )/STDEV (a:a)
    num + 1
  end
  
  #parse arguments
  def parse_args
    OptionParser.new do |opts|
      #get the filename that needs to be proccessed
      opts.on('', '--file FILE', String, 'Specify the file name for proccessing' ) do |file|
        @file = file
      end
    end.parse!
  end
  
end