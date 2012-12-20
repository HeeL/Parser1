class Joiner

  def initialize(options)
    #save the options that were parsed before from args
    @options = options
  end

  #join given files
  def join_files
    #output file
    output_file = File.new(@options.output_file, 'w')
    #files that will be joined
    file1 = "calc_clean_#{@options.files[1]}"
    file2 = "calc_clean_#{@options.files[2]}"
    first = true
    num_cols2 = 0
    #iterate through the first file
    CSV.foreach(file1) do |row1|
      #get the specified cols or all of them
      selected_cols1 = get_selected_cols(row1, 1)
      selected_cols2 = false
      #iterate through the second file
      CSV.foreach(file2) do |row2|
        #get the line if its first iteration or linked field matches
        if first || row1[@options.link_cols[1] - 1] == row2[@options.link_cols[2] - 1]
          #get the specified cols for the second file or all of them
          selected_cols2 = get_selected_cols(row2, 2)
          first = false
          #number of cols for the second file
          num_cols2 = row2.count
          #finish the search when match was found
          next
        end
      end
      #selected columns for the second file can be all, none or specific 
      selected_cols2 = Array.new(@options.cols[2] == [] ? @options.cols[2].count : num_cols2) unless selected_cols2
      #output the result (joined line)
      output_file.write(row2str(selected_cols1 + selected_cols2))
      output_file.flush
    end
    #close the output file when we are done
    output_file.close
  end
  
  private

  #get the specified cols options
  def get_selected_cols(row, index)
    if @options.cols[index] == []
      #give all the cols if wasn't specified
      selected_cols = row
    else
      selected_cols = []
      #get only those fields that were specified in options of a command line
      row.each_with_index{|val, key| selected_cols << val if @options.cols[index].include?(key - 1) }
    end
    #return the col nums
    selected_cols
  end
  
  #convert array row into a string to write to csv
  def row2str(row)
    row_str = ''
    row.each do |s|
      s = s.to_s
      s = "\"#{s}\"" if s.index(',')
      row_str += ",#{s}"
    end
    row_str[0] = ''
    row_str + "\n"
  end
  
end