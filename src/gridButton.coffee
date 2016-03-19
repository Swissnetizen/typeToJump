define ["Phaser"], (Phaser) ->
  class GridButton extends Phaser.Button
    constructor: (game, x, y, clickEvent) ->
      @game = game
      super game, x, y, "bgNormal", clickEvent
      @game.add.existing this
      @anchor.set 0.5, 0.5
      @onInputOver.add @whenOver
      @onInputOut.add @whenOut
      @onInputDown.add @whenDown
      @input.useHandCursor = on
      @originalCoords = 
        x: x
        y: y
      #@onInputDown.add @downAnimation 
      #@onInputUp.add @upAnimation
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
    whenDown: =>
      @game.playSound "select"
    downAnimation: () =>
      t = @game.add.tween this
      t.to({
          scale:
            x: 0.8
            y: 0.8
        }, 40)
      t.start()
    upAnimation: () =>
      t = @game.add.tween this
      t.to({
          scale:
            x: 1
            y: 1
        }, 40)
      t.start()
