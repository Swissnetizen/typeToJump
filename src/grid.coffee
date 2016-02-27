define ["Phaser"], (Phaser) ->
  class Grid extends Phaser.Sprite
    ###
      Properties =
        maxW
        maxH
        sprite:
          w
          h
        maxSprites
          x
          y
          total
        selector: (bool)
    ###
    constructor: (game, x, y, properties) ->
      super game, x, y
      @game = game
      @game.add.existing this
      @anchor.set 0.5, 0.5
      @computeValues properties
    computeValues: (p) ->
      @maxSprites = p.maxSprites or {}
      if p.maxW and p.maxH
        @maxSprites.x = Math.floor (p.maxW / p.sprite.w) unless @maxSprites.x?
        @maxSprites.y = Math.floor (p.maxH / p.sprite.h) unless @maxSprites.y?
        @maxW = p.maxW
        @maxH = p.maxH
      else if p.maxSprites.x and p.maxSprites.y
        @maxSprites = p.maxSprites
        @maxW = @maxSprites.x * p.sprite.w
        @maxH = @maxSprites.y * p.sprite.h
      @sprite = p.sprite
      @sprite.padding = {x: 0, y: 0} unless @sprite.padding?
      @isSelector = p.selector
    topLeftCoords: =>
        x: @x - @x/2
        y: @y - @h/2
    makeGridItem: (game, x, y, i) ->
      new Phaser.Sprite(game, x, y, "player")
    render: (fn) ->
      @structure = []
      y = 0
      i = 0
      while y < @maxSprites.y
        @structure.push []
        x = 0
        while x < @maxSprites.x
          sX = x * @sprite.w + @sprite.w/2 - @maxW/2
          sY = y * @sprite.h + @sprite.h/2 - @maxH/2 
          if i is 0
            selectorCoords = [sX, sY]
          sprite = @makeGridItem game, sX, sY, i
          sprite.anchor.set 0.5, 0.5
          sprite.i = i
          @addChild sprite
          @structure[y].push sprite
          x += 1
          i += 1
        y += 1
      fn() if fn
      if @isSelector
        @makeSelector selectorCoords
    coordExists: (x, y) ->
      try
        @structure[y][x]?
      catch
        no
    makeSelector: (coords) ->
      @selector = game.add.sprite coords[0], coords[1], "selector"
      @selector.anchor.set 0.5, 0.5
      @level = {x: 0, y: 0}
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

