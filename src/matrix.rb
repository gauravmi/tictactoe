module Matrix
  def left_diagonal
    (0..@matrix.length-1).collect{|i| @matrix[i][i] }
  end

  def right_diagonal
    offset = @matrix.length
    (0..@matrix.length-1).collect{|i| offset=offset-1; @matrix[i][offset] }
  end

  def same_values_in_a_seq(sequence)
    sequence if (sequence.uniq.count == 1)
  end

  def each_row(&block)
    @matrix.each(&block)
  end

  def each_column(&block)
    @matrix.transpose.each(&block)
  end

  def each_diagonal(&block) 
    [left_diagonal, right_diagonal].each(&block)
  end
end