define ["Phaser", "grid"], (Phaser, Grid) ->
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
      @game.input.keyboard.addCallbacks this, null, @whenPress
      @game.world.setBounds 0, 0, @grid.maxW/2, @grid.maxH/2 
      @grid.render() 
      @makeSelector() 
      @game.camera.focusOnXY 300, 100
      @game.camera.follow @selector
      @makeBackButton()
    makeBackButton: ->
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @exit
      @backButton = @game.add.button 10, 10, "backButton", @exit 
    makeSelector: ->
      x = @grid.structure[0][0].worldPosition.x
      y = @grid.structure[0][0].worldPosition.y
      @selector = game.add.sprite x, y, "selector"
      @selector.anchor.set 0.5, 0.5
      @level = {x: 0, y: 0}
     # @grid.addChild @selector
    update: ->
      @selector.x = @grid.structure[@level.y][@level.x].worldPosition.x
      @selector.y = @grid.structure[@level.y][@level.x].worldPosition.y
    exit: =>
      @game.state.start "menu"
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
      if @grid.coordExists newCoords[0], newCoords[1]
        @level.x = newCoords[0]
        @level.y = newCoords[1]
        @level.number = @grid.structure[@level.y][@level.x].levelNumber