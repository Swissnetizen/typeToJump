define ["Phaser"], (Phaser) ->
  class Grid extends Phaser.Sprite
    constructor: (game, x, y, w, h, sW, sH) ->
      super game, x, y, "mute"
      @game = game
      @game.add.existing this
      @anchor.set 0.5, 0.5
      @maxSpritesX = Math.floor (w / sW)
      @maxSpritesY = Math.floor (h / sH)
      @w = w
      @h = h
      @sprite =
        w: sW
        h: sH
    topLeftCoords: =>
        x: @x - @x/2
        y: @y - @h/2
    makeGridItem: (game, x, y, i) ->
      new Phaser.Sprite(game, x, y, "player")
    render: =>
      y = 0
      i = 0
      while y < @maxSpritesY
        x = 0
        while x < @maxSpritesX
          sX = x * @sprite.w + @sprite.w/2 - @x/2
          sY = y * @sprite.h + @sprite.h/2 - @y/2
          sprite = @makeGridItem game, sX, sY
          sprite.anchor.set 0.5, 0.5
          @addChild sprite
          x += 1
          i += 1
        y += 1


