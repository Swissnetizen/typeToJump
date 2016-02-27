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
      topLeftCoords: =>
          x: @x - @x/2
          y: @y - @h/2
      makeGridItem: (game, x, y, i) ->
        new Phaser.Sprite(game, x, y)
      render: (fn) ->
        @structure = []
        @coordStructure = []
        y = 0
        i = 0
        while y < @maxSprites.y
          @structure.push []
          @coordStructure.push []
          x = 0
          while x < @maxSprites.x
            sX = x * @sprite.w + @sprite.w/2 - @maxW/2
            sY = y * @sprite.h + @sprite.h/2 - @maxH/2 
            sprite = @makeGridItem game, sX, sY, i
            sprite.anchor.set 0.5, 0.5
            sprite.gridNumber = i
            @addChild sprite
            @structure[y].push sprite
            @coordStructure[y].push [sX, sY, i]
            x += 1
            i += 1
          y += 1
      coordExists: (x, y) ->
        try
          @structure[y][x]?
        catch
          no