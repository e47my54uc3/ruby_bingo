
# Pseudocode : 
=begin
check for bingo row success by determining if all elements of subarray are X's
check for bingo column success by transposing and determining if all elements of subarray are x's
check for diagonal success by checking iterating through each index, checking if bingo[x][y] is an X, and going to next index. Count the X's, if 5, bingo.
=end

# sample_board =[['X', 44, 71, 8, 88],
#                [22, 'X', 75, 65, 73],
#                [83, 85, 'X', 89, 57],
#                [25, 31, 96, 'X', 51],
#                [75, 70, 54, 80, 'X']]






# Refactored Solution

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
#end-of-game methods

  def winner
    until (row_confirm == yell_confirm) || (col_confirm == yell_confirm) || (diagonal_up == yell_confirm) || (diagonal_down == yell_confirm)
      sample
      confirm
    end
    puts "We have a winner!"
  end

private

    def row_confirm
      bingo_board.each do |row|
        if row == ['X','X','X','X','X']
          yell_confirm
        end
      end
    end

    def col_confirm
      columns = bingo_board.transpose
      columns.each do |col|
        if col == ['X','X','X','X','X']
          yell_confirm
        end
      end
    end

    def diagonal_down
      xcount = 0
      i = 0
      bingo_board.each_index do |row|
        if bingo_board[row][i] == "X"
          xcount += 1
          i += 1
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
        end
      end
      
      if xcount == 5
        yell_confirm
      end
    end

    def yell_confirm
      "BINGO!"
    end
end




# DRIVER TESTS GO BELOW THIS LINE


# b = BingoBoard.new

# # b.sample

# # until b.diagonal_down == b.yell_confirm
# #   b.sample
# #   b.confirm
# # end

# # until b.diagonal_up == b.yell_confirm
# #   b.sample
# #   b.confirm
# # end

# # until (b.row_confirm == b.yell_confirm) || (b.col_confirm == b.yell_confirm) || (b.diagonal_up == b.yell_confirm) || (b.diagonal_down == b.yell_confirm)
# #   b.sample
# #   b.confirm
# # end

# b.winner
# # until b.diagonal_down == "BINGO!"
# #   b.sample
# #   b.confirm
# # end

# # until b.diagonal_up == "BINGO!"
# #   b.sample
# #   b.confirm
# # end


# p b.display_board


# create driver test code to retrieve a value at a coordinate here: p (bingo_board[x][y] == 'X')
# implement tests for each of the methods here:

b = BingoBoard.new
b.winner
p b.display_board
