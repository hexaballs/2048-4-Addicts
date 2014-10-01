buildBoard = ->
  board = []
  for row in [0..3]
    # console.log "i1: ", i1
    # row = []
    board[row] = []
    for column in [0..3]
      board[row][column] = 0
      # console.log "i2: ", i2
  # console.log "board: ", board
  console.log "build board"
  board

generateTile = ->
  console.log "generate tile"

printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log "-- End --"


$ ->
  board = buildBoard()
  printArray(board)
  generateTile()
  generateTile()