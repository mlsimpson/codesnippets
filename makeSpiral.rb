def makeSpiral(dimensions=5)

  spiral = Array.new(dimensions)
  spiral.map!{|col|
    col = Array.new(dimensions)
  }

  start = spiral.size / 2

  val = 0

  x = 0
  y = 0

  row = start
  col = start

  0.upto(start - 1){|iter|
    #Right:  Stay on same row, increment col by 1 until no further from start than iter+1 cells.
    while col <= start + (iter + 1)
      spiral[row][col] = (val += 1)
      col += 1
    end
    col -= 1
    row += 1
    #Down:  Stay on same col, increment row by 1 until no further from start than iter+1 cells.
    while row <= start + (iter + 1)
      spiral[row][col] = (val += 1)
      row += 1
    end
    row -= 1
    col -= 1
    #Left:  Stay on same row, decrement col by 1 until no further from start than iter+1 cells.
    while col >= start - (iter + 1)
      spiral[row][col] = (val += 1)
      col -= 1
    end
    row -= 1
    col += 1
    #Up:  Stay on same col, decrement row by 1 until no further from start than iter+1 cells.
    while row >= start - (iter + 1)
      spiral[row][col] = (val += 1)
      row -= 1
    end
    row += 1
    col += 1
    #Right:  Stay on same row, increment col by 1 until no further from start than iter+1 cells.
    while col <= start + (iter + 1)
      spiral[row][col] = (val += 1)
      col += 1
    end
  }

  spiral
end
