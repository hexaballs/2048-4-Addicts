buildBoard = ->
  [0..3].map (-> [0..3].map (-> 0))

# can also be written as:
  # board = []
  # for row in [0..3]
  #   board[row] = []
  #   for column in [0..3]
  #     board[row][column] = 0
  # board

generateTile = ->
  value = 2

  console.log "generate tile"

printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log "-- End --"

$ ->
  newBoard = buildBoard()
  printArray(newBoard)
  generateTile()
  generateTile()