class Options

  #read access for all the parsed options
  attr_reader :files, :link_cols, :cols, :output_file

  def initialize
    #initial data for options that we are going to parse
    @files = []
    @link_cols = []
    @cols = []
    
    #parse cmd arguments
    parse_args
  end

  def get_info(args, index)
    fileinfo = args.split(',')
    #get file name
    @files[index] = fileinfo[0]
    #get column to join with
    @link_cols[index] = fileinfo[1].to_i
    @cols[index] = [];
    fileinfo.shift(2)
    cols_str = fileinfo.join(',')
    #check whether we have not required option for specific cols
    return if cols_str.length < 3
    #get an array with nums of cols to copy when join 
    cols_str[1..-2].split(',').each do |col|
      if col.include?('-')
        range = col.split('-')
        (range[0]..range[1]).each{|i| @cols[index] << i.to_i}
      else
        @cols[index] << col.to_i
      end
    end
  end
  
  private
  
  #parse cmd arguments
  def parse_args
    OptionParser.new do |opts|
      #file one and his options
      opts.on('', '--i1 FILE1,COL1,[COL_1,COL_2..COL_N]', String, 'Specify input file' ) do |args|
        get_info(args, 1)
      end
      #file two and his options
      opts.on('', '--i2 FILE2,COL2,[COL_1,COL_2..COL_N]', String, 'Specify input file2' ) do |args|
        get_info(args, 2)
      end
      #specify output file
      opts.on('', '--o FILE', String, 'Specify output file' ) do |file|
        @output_file = file
      end
    end.parse!
  end

end