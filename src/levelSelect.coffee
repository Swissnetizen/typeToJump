define ["Phaser", "gridSelector"], (Phaser, Grid) ->
  class LevelSelect extends Phaser.State
    preload: ->
      @game = game
      @grid =  new Grid(
        game, 
        @game.globals.width/2,
        @game.globals.height/2, 
          maxSprites:
            x: 5
            y: 4
          sprite:
            w: 134
            h: 50
          selector: on
      )
      @grid.makeGridItem = (game, x, y, i) =>
        container = @game.add.sprite x, y, "bgNormal"
        container.anchor.set 0.5, 0.5
        container.levelNumber = i+1
        ## Button
        graphic = "lockedLevel"
        graphic = "tilemap" if i is 0
        button = @game.add.button 0, 0, graphic, @levelSelect 
        button.onInputOver.add @whenOver
        button.onInputOut.add @whenOut
        button.levelNumber = i+1
        button.input.useHandCursor = on
        button.anchor.set 0.5, 0.5
        container.addChild button
        ## Bg 4 text
        box = game.add.sprite 30, 0, "textBlockNormal"
        box.anchor.set 0.5, 0.5
        button.addChild box
        ## Actual text
        label = @game.add.text 30, 0, i + 1 + "", {
          font: "30px Futura"
          fill: "#000000"
        }
        label.anchor.set 0.5, 0.5
        button.addChild label
        container
    levelSelect: (button) =>
      game.state.start "play"
    whenOver: (button) =>
      button.children[0].loadTexture "textBlockSelected"
      button.parent.loadTexture "bgSelected"
    whenOut: (button) =>
      button.children[0].loadTexture "textBlockNormal"
      button.parent.loadTexture "bgNormal"
    create: ->
      @game.world.setBounds 0, 0, @grid.maxW/2, @grid.maxH/2 
      @grid.render()
      @makeBackButton()
    makeBackButton: ->
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @exit
      @backButton = @game.add.button 10, 10, "backButton", @exit 
    exit: =>
      @game.state.start "menu"