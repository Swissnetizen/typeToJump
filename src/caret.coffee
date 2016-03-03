define ["Phaser"], (Phaser) ->
  class Caret extends Phaser.Sprite
    constructor: (game, x, y) ->
      @game = game
      super @game, x, y, "caret"
      @game.add.existing this
      @anchor.set 0.5, 0.5
      @standardX = x
      @timer = @game.time.create off
      @timer.loop 1000, @updateVisibility
      @timer.start()
    offsetPositionBy: (w) ->
      @x = @standardX + w
    updateVisibility: =>
      @visible = not @visible