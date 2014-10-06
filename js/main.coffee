randomInt = (x) ->
  Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]
  # row = randomInt(4)
  # col = randomInt(4)
  # cellIndices = [row, col]

randomValue = ->
  values = [2, 2, 2, 4]
  values[randomInt(4)]

buildBoard = ->
  [0..3].map (-> [0..3].map (-> 0))

# can also be written as:
  # board = []
  # for row in [0..3]
  #   board[row] = []
  #   for column in [0..3]
  #     board[row][column] = 0
  # board

generateTile = (board) ->
  value = randomValue()
  # console.log "randomInt: #{randomCellIndices()}"
  [row, column] = randomCellIndices()
  console.log [row, column]

  if board[row][column] is 0
    board[row][column] = value
  else
    generateTile(board)

  # console.log "generate tile"

move = (board, direction) ->
  newBoard = buildBoard()
  for i in [0..3]
    if direction in ['right', 'left']
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)

    else if direction in ['down', 'up']
      col = getCol(i, board)
      col = mergeCells(col, direction)
      col = collapseCells(col, direction)
      setCol(col, i, newBoard)

  newBoard

getRow = (r, board) ->
  [board[r][0], board[r][1], board[r][2], board[r][3]]

getCol = (c, board) ->
  [board[0][c], board[1][c], board[2][c], board[3][c]]

setRow = (row, index, board) ->
  board[index] = row

setCol = (col, index, board) ->
  for i in [0..3]
    board[i][index] = col[i]

mergeCells = (cells, direction) ->

  merge = (cells) ->
    for a in [3...0]
      for b in [a-1..0]
        if cells[a] is 0 then break
        else if cells[a] == cells[b]
          cells[a] *= 2
          cells[b] = 0
          break
        else if cells[b] isnt 0 then break
    cells

  if direction in ['right', 'down']
    cells = merge(cells)
  else if direction in ['left', 'up']
    cells = merge(cells.reverse()).reverse()

  cells

  # cabwa if direction == 'left'
  #   row = row.reverse()

  # if direction == 'right' or 'left'
  #   for a in [3...0]
  #     for b in [a-1..0]
  #       if row[a] is 0 then break
  #       else if row[a] == row[b]
  #         row[a] *= 2 #cabwa row[a] = row[a] * 2
  #         row[b] = 0
  #         break
  #       else if row[b] isnt 0 then break

  # if direction is 'left'
  #   row.reverse()
  # row

collapseCells = (cells, direction) ->
  # Remove '0'
  cells = cells.filter (x) -> x isnt 0
  #  Adding '0'

  while cells.length < 4
    if direction in ['right', 'down']
      cells.unshift 0
    else if direction in ['left', 'up']
      cells.push 0
  cells

moveIsValid = (originalBoard, newBoard) ->
  for row in [0..3]
    for col in [0..3]
      if originalBoard[row][col] isnt newBoard[row][col]
        return true
  false

isGameOver = (board) ->
  boardIsFull(board) and noValidMoves(board)


boardIsFull = (board) ->
  for row in board
    if 0 in row
        return false
  true

noValidMoves = (board) ->
  directions = ['right', 'left', 'up', 'down']
  for direction in directions
    newBoard = move(board, direction)
    if moveIsValid(board, newBoard)
      return false
  true

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      for power in [1..11]
        $(".r#{row}.c#{col}").removeClass('value-' + Math.pow(2, power))
      if board[row][col] == 0
        $(".r#{row}.c#{col} > div").html(" ")
      else
        $(".r#{row}.c#{col} > div").html(board[row][col])
        $(".r#{row}.c#{col}").addClass('value-' + board[row][col])
        # if board[row][col] is 2
        #   $(".r#{row}.c#{col}").css('background', '#eee4da')
        # else if board[row][col] is 4
        #   $(".r#{row}.c#{col}").css('background', '#faf8ef')
        # else if board[row][col] is 8
        #   $(".r#{row}.c#{col}").css('background', '#f2b179')
        # else if board[row][col] is 16
        #   $(".r#{row}.c#{col}").css('background', '#f59563')

printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log "-- End --"

score = (board) ->
  counter = 0
  for row in board
    for col in row
      counter += col
  counter

$ ->
  $('.board').hide()
  $('.board').fadeIn(1000)
  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  # printArray(@board)
  showBoard(@board)

  gameStarted = false
  timePlayedSec = 12
  timePlayedMin = 0


  $('.newGame').click =>
    $('.board').hide()
    $('.board').fadeIn(1000)
    @board = buildBoard()
    generateTile(@board)
    generateTile(@board)
    showBoard(@board)

  setInterval( =>
    if (timePlayedSec is 1) && (timePlayedMin is 0)
      $('.timer').addClass('stopPlaying').html('STOP!')
      $('h1 p > span').addClass('addicts').html('ADDICT!')
      $('.board').fadeIn().addClass('stopPlayingBoard2').html('Go back to coding!!!')
      $('.newGame').click =>
        alert('Don\'t even think about it!')

    else if (timePlayedSec is 11) && (timePlayedMin is 0)
      $('.board').addClass('stopPlayingBoard').fadeOut(800).fadeIn(800).fadeOut(700).fadeIn(700).fadeOut(600).fadeIn(600).fadeOut(500).fadeIn(500).fadeOut(400).fadeIn(400).fadeOut(350).fadeIn(350).fadeOut(300).fadeIn(300).fadeOut(250).fadeIn(250).fadeOut(200).fadeIn(200).fadeOut(150).fadeIn(150).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(50).fadeOut()
      timePlayedSec -= 1
      if timePlayedSec is -1
        timePlayedSec = 59
        timePlayedMin -= 1
      $('.timer > p').html("#{timePlayedMin}:#{timePlayedSec}")

    else if gameStarted
      timePlayedSec -= 1
      if timePlayedSec is -1
        timePlayedSec = 59
        timePlayedMin -= 1
      $('.timer > p').html("#{timePlayedMin}:#{timePlayedSec}")
  ,
  1000)

  $('body').keydown (e) =>

    key = e.which
    keys = [37..40]

    if key in keys   # cabwa keys.indexOf(key) > -1
      gameStarted = true
      e.preventDefault()
      # continue the game
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'
      console.log direction

      # try moving
      newBoard = move(@board, direction)
      printArray newBoard
      # check the move validity, by comparing the original and new board
      if moveIsValid(@board, newBoard)
        console.log "valid"
        @board = newBoard
        $('.score > p').html(score(@board))
        # generate tile
        generateTile(@board)
        # show board
        showBoard(@board)
        # check game lost
        if isGameOver(@board)
          alert("You LOSE!")
        else

      else
        console.log "invalid"








