define ["Phaser"], (Phaser) ->
  class GridButton extends Phaser.Button
    constructor: (game, x, y, clickEvent) ->
      @game = game
      super game, x, y, "bgNormal", clickEvent
      @game.add.existing this
      @anchor.set 0.5, 0.5
      @onInputOver.add @whenOver
      @onInputOut.add @whenOut
      @input.useHandCursor = on
      @originalCoords = 
        x: x
        y: y
    shakeAnimation: (shakiness=10, autoStart=yes) =>
      x = @originalCoords.x
      t = @game.add.tween this
      t.to({
          x: x + shakiness
        }, 40)
      t.to({
          x: x - shakiness
        }, 40)
      t.to({
          x: x
        }, 40)
      t.start() if autoStart
      t
    whenOver: =>
      @loadTexture "bgSelected"
    whenOut: (button) =>
      @loadTexture "bgNormal"
