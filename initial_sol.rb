

Initial Solution

class BingoBoard
  attr_reader :bingo_board

  def initialize
    @bingo_board = Array.new(5) {Array(5.times.map{rand(1..100)})}
    @bingo_board[2][2] = 'X'
    @bingo = [' B ',' I ',' N ',' G ',' O ']
  end

  def sample
    @letter = @bingo.sample
    @number = (1..100).to_a.sample
    puts "Next is #{@letter}#{@number}"
  end

  def confirm
    bingo_board.map! {|row| (@bingo.index(@letter) == row.index(@number))  ? (row[row.index(@number)] = 'X';  row) : row }
  end


  def display_column
    bingo_board.transpose.each.with_index{|col, i| puts "Column #{@bingo[i]}: #{col}"}
  end

  def yell_confirm
    "BINGO!"
  end

  def col_confirm
    columns = bingo_board.transpose
    columns.each do |col|
      if col == ['X','X','X','X','X']
        yell_confirm
      end
    end
  end

  def row_confirm
    bingo_board.each do |row|
      if row == ['X','X','X','X','X']
        yell_confirm
      end
    end
  end

  # def diagonal_down
  #   xcount = 0

  #   x = 0
  #   y = 0

  #   while x < 5
  #     if bingo_board[x][y] == 'X'
  #       xcount += 1
  #       y += 1
  #       next
  #     end
  #   x += 1
  #   end

  #   if xcount == 5
  #     yell_confirm
  #   end
  # end
# def diagonal_up
  #   xcount = 0

  #   x = 4
  #   y = 0

  #   while x > -1
  #     if bingo_board[x][y] == 'X'
  #       xcount += 1
  #       y += 1
  #       next
  #     end
  #     x -= 1
  #   end

  #   if xcount == 5
  #     yell_confirm
  #   end
  # end
    def diagonal_down
      xcount = 0
      i = 0
      bingo_board.each_index do |row|
        if bingo_board[row][i] == "X"
          xcount += 1
          i += 1
          next
        end
      end

      if xcount == 5
        yell_confirm
      end
    end

    def diagonal_up
      xcount = 0
      i = 4
      bingo_board.each_index do |row|
        if bingo_board[row][i] == "X"
          xcount += 1
          i -= 1
          next
        end
      end
      
      if xcount == 5
        yell_confirm
      end
    end

    def winner
      until (row_confirm == yell_confirm) || (col_confirm == yell_confirm) || (diagonal_up == yell_confirm) || (diagonal_down == yell_confirm)
        sample
        confirm
      end
    end
  

  def display_board
    puts
    bingo_board.unshift(@bingo).each do|row| 
      row.map! do |char| 
        if char.to_s.length < 2 && char.is_a?(Fixnum)
          char = " " + char.to_s + " "
        elsif char.to_s.length < 3 && char.is_a?(Fixnum)
          char = " " + char.to_s
        elsif char == "X"
          char = " " + char + " "
        else
          char.to_s
        end
      end
      p row
      p "---------------------------------"
    end
    puts
  end
end