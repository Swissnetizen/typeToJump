define ["Phaser", "grid"], (Phaser, Grid) ->
  class LevelSelect extends Phaser.State
    preload: ->
      @grid =  new Grid(
        game, 
        @game.globals.width/2,
        @game.globals.height/2, 
          maxW: 620
          maxH: 100
          sprite:
            w: 129
            h: 50
      )
    levelSelect: (button) =>
      game.state.start "play"
    whenOver: (button) =>
      console.log "OVER"
      button.children[0].loadTexture "textBlockSelected"
      button.parent.loadTexture "bgSelected"
    whenOut: (button) =>
      console.log  "OUT !!"
      button.children[0].loadTexture "textBlockNormal"
      button.parent.loadTexture "bgNormal"
    create: ->
      @grid.makeGridItem = (game, x, y, i) =>
        container = @game.add.sprite x, y, "bgNormal"
        container.anchor.set 0.5, 0.5
        button = @game.add.button 0, 0, "tilemap", @levelSelect 
        button.onInputOver.add @whenOver
        button.onInputOut.add @whenOut
        button.input.useHandCursor = on
        button.levelNumber = i+1
        button.anchor.set 0.5, 0.5
        container.addChild button

        box = game.add.sprite 30, 0, "textBlockNormal"
        box.anchor.set 0.5, 0.5
        button.addChild box

        label = @game.add.text 30, 0, i + 1 + "", {
          font: "30px Futura"
          fill: "#000000"
        }
        label.anchor.set 0.5, 0.5
        button.addChild label

        container
      @grid.render()
     # game.state.start "play"