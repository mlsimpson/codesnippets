def rotate(matrix)
  rotated = Array.new

  0.upto(matrix.length - 1){|row|
    rotated << Array.new(matrix.length)
  }

  row = 0
  while row < matrix.length
    col = 0
    while col < matrix.length
      rotated[row][col] = matrix[matrix.length - 1 - col][row]
      col += 1
    end
    row += 1
  end
  rotated
end
