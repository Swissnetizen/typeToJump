define ["Phaser", "gridSelector", "gridButton"], (Phaser, Grid, GridButton) ->
  class LevelSelect extends Phaser.State
    preload: ->
      @game = game
      @game.input.keyboard.clearCaptures()
      @grid = new Grid(
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
      @setupCheatCode()
      @grid.makeGridItem = (game, x, y, i) =>
        button = new GridButton game, x, y, @levelSelect
        ## Button
        unlocked = @game.playerData.levelsComplete[i-1]
        graphicName = "levelMinimap" + i
        graphicName = "lockedLevel" unless unlocked or i is 0
        graphic = @game.add.sprite -62, 0, graphicName
        button.levelNumber = i
        graphic.anchor.set 0, 0.5
        button.addChild graphic
        ## Bg 4 text
        box = game.add.sprite 62, 0, "textBlockNormal"
        box.anchor.set 1, 0.5
        button.addChild box
        button.onInputOver.add @whenOver
        button.onInputOut.add @whenOut
        ## Actual text
        label = @game.add.text 30, 0, i + 1 + "", {
          font: "30px Futura"
          fill: "#000000"
        }
        label.anchor.set 0.5, 0.5
        button.addChild label
        button
    levelSelect: (button) =>
      n = button.levelNumber
      unless @game.playerData.levelsComplete[n-1] or n is 0
        button.shakeAnimation()
        return
      @game.levelNumber = button.levelNumber
      game.state.start "play"
    whenOver: (button) =>
      button.children[1].loadTexture "textBlockSelected"
    whenOut: (button) =>
      button.children[1].loadTexture "textBlockNormal"
    create: ->
      @game.world.setBounds 0, 0, @grid.maxW/2, @grid.maxH/2 
      @grid.render()
      @grid.pressEvent.add @levelSelect
      @makeBackButton()
    makeBackButton: ->
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @exit
      @backButton = @game.add.button 10, 10, "backButton", @exit 
    exit: =>
      @game.state.start "menu"
    setupCheatCode: ->
      upKey = game.input.keyboard.addKey(Phaser.Keyboard.UP)
      downKey = game.input.keyboard.addKey(Phaser.Keyboard.DOWN)
      leftKey = game.input.keyboard.addKey(Phaser.Keyboard.LEFT)
      rightKey = game.input.keyboard.addKey(Phaser.Keyboard.RIGHT)
      aKey = game.input.keyboard.addKey(Phaser.Keyboard.A)
      bKey = game.input.keyboard.addKey(Phaser.Keyboard.B)
      upKey.onUp.addOnce ->
        upKey.onUp.addOnce ->
          downKey.onUp.addOnce ->
            downKey.onUp.addOnce ->
              leftKey.onUp.addOnce ->
                rightKey.onUp.addOnce ->
                  leftKey.onUp.addOnce ->
                    rightKey.onUp.addOnce ->
                      bKey.onUp.addOnce ->
                        aKey.onUp.addOnce ->
                          console.log "CHEATER"
                          complete = []
                          for v in new Array(@game.globals.levels)
                            complete.push yes
                          console.log complete
                          @game.playerData.levelsComplete = complete
                          @game.state.start "levelSelect"