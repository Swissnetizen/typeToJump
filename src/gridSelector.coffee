define ["Phaser", "grid"], (Phaser, Grid) ->
  class GridSelector extends Grid
    constructor: (game, x, y, properties) ->
      @isSelector = properties.selector
      super game, x, y, properties
    render: (x=0, y=0, fn) ->
      super fn
      c = @coordStructure[x][y]
      @selector = @makeSelector c[0], c[1]
      @selector.anchor.set 0.5, 0.5
      @level = {x: x, y: y}
      @addChild @selector
      @game.input.keyboard.addCallbacks this, null, @whenPress
    whenPress: (keyInfo) ->
      code = keyInfo.keyCode
      newCoords = [@level.x, @level.y]
      m = Phaser.Keyboard
      if code is m.UP
        console.log "UP"
        newCoords[1] = @level.y - 1
      else if code is m.DOWN
        newCoords[1] = @level.y + 1
        console.log "DOWN"
      else if code is m.LEFT
        newCoords[0] = @level.x - 1
      else if code is m.RIGHT
        newCoords[0] = @level.x + 1
      else if code is m.ENTER or code is m.SPACEBAR
        @levelSelect()
      console.log newCoords
      if @coordExists newCoords[0], newCoords[1]
        @level.x = newCoords[0]
        @level.y = newCoords[1]
        @level.number = @structure[@level.y][@level.x].levelNumber
        s = @structure[@level.y][@level.x]
        @selector.reset s.x, s.y
    makeSelector: (x, y) ->
      @game.add.sprite x, y, "selector"
