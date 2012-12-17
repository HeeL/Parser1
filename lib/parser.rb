class Parser

  attr_reader :file, :link_col, :cols
  attr_accessor :output_file

  def initialize
    @file = []
    @link_col = []
    @cols = []
  end

  def get_info(args, index)
    fileinfo = args.split(',')
    @file[index] = fileinfo[0]
    @link_col[index] = fileinfo[1]
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

end