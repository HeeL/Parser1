class Options

  attr_reader :files, :link_cols, :cols, :output_file

  def initialize
    @files = []
    @link_cols = []
    @cols = []
    
    parse_args
  end

  def get_info(args, index)
    fileinfo = args.split(',')
    @files[index] = fileinfo[0]
    @link_cols[index] = fileinfo[1]
    @cols[index] = [];
    fileinfo.shift(2)
    cols_str = fileinfo.join(',')
    return if cols_str.length < 3
    cols_str[1..-2].split(',').each do |col|
      if col.include?('-')
        range = col.split('-')
        (range[0]..range[1]).each{|i| @cols[index] << i}
      else
        @cols[index] << col
      end
    end
  end
  
  private
  
  def parse_args
    OptionParser.new do |opts|
      opts.on('', '--i1 FILE1,COL1,[COL_1,COL_2..COL_N]', String, 'Specify input file' ) do |args|
        get_info(args, 1)
      end
      opts.on('', '--i2 FILE2,COL2,[COL_1,COL_2..COL_N]', String, 'Specify input file2' ) do |args|
        get_info(args, 2)
      end
      opts.on('', '--o FILE', String, 'Specify output file' ) do |file|
        @output_file = file
      end
    end.parse!
  end

end