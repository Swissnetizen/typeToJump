define ["Phaser", "grid"], (Phaser, Grid) ->
  class LevelSelect extends Phaser.State
    preload: ->
      @game = game
      @grid =  new Grid(
        game, 
        @game.globals.width/2,
        @game.globals.height/2, 
          maxW: 620
          maxH: 100
          sprite:
            w: 134
            h: 50
      )
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
    levelSelect: (button) =>
      game.state.start "play"
    whenOver: (button) =>
      button.children[0].loadTexture "textBlockSelected"
      button.parent.loadTexture "bgSelected"
    whenOut: (button) =>
      button.children[0].loadTexture "textBlockNormal"
      button.parent.loadTexture "bgNormal"
    create: ->
      @makeSelector()
      @game.input.keyboard.addCallbacks this, null, @whenPress
    makeSelector: ->
      x = @grid.structure[0][0].worldPosition.x
      y = @grid.structure[0][0].worldPosition.y
      @selector = game.add.image x, y, "selector"
      @selector.anchor.set 0.5, 0.5
      @level = {x: 0, y: 0}
    update: ->
      @selector.x = @grid.structure[@level.y][@level.x].worldPosition.x
      @selector.y = @grid.structure[@level.y][@level.x].worldPosition.y
    whenPress: (keyInfo) ->
      console.log "PRESS"
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
      console.log newCoords
      if @grid.coordExists newCoords[0], newCoords[1]
        @level.x = newCoords[0]
        @level.y = newCoords[1]