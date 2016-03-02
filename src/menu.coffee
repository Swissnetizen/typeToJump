"use strict"
define ["Phaser", "gridSelector"], (Phaser, Grid) -> 
  exports = {}
  exports.MenuState = class MenuState extends Phaser.State
    create: ->
      # Name of the @game
      console.log "CREATED"
      @game.world.setBounds 0, 0, @game.globals.width, @game.globals.height
      nameLabel = @game.add.text(@game.world.centerX, 80, "Name",
        font: "50px Arial"
        fill: "#ffffff")
      nameLabel.anchor.setTo 0.5, 0.5
      # Add a mute button
      @muteButton = @game.add.button 20, 20, "mute", @toggleSound, this
      @muteButton.input.useHandCursor = true
      if @game.sound.mute
        @muteButton.frame = 1
      # Start the @game when the up arrow key is pressed
      @grid = new Grid(
        game, 
        @game.globals.width/2,
        @game.globals.height/2 + 50, 
          maxSprites:
            x: 1
            y: 3
          sprite:
            w: 134
            h: 50
          selector: on
      )
      @grid.makeGridItem = @makeButton
      @grid.pressEvent = @pressEvent
      @grid.render 0, 0
      return
    toggleSound: ->
      @game.sound.mute = !@game.sound.mute
      @muteButton.frame = if @game.sound.mute then 1 else 0
      return
    makeButton: (game, x, y, i) =>
      texts = [
        "Play"
        "eo en fr"
        "Credits"
      ]
      b = new Phaser.Button game, x, y, "bgNormal", @pressEvent
      b.onInputOver.add @whenOver
      b.onInputOut.add @whenOut
      b.anchor.set 0.5, 0.5
      b.number = i
      text = game.add.text 0, 0, texts[i], {
        font: "30px Futura"
      }
      text.anchor.set 0.5, 0.5
      b.addChild text
      b
    whenOver: (button) =>
      button.loadTexture "bgSelected"
    whenOut: (button) =>
      button.loadTexture "bgNormal"
    pressEvent: (info) =>
      switch info.number
        when 0
          @start()
        when 1
          console.log "langu"
        when 2
          @game.state.start "credits"
    start: ->
      @game.state.start "levelSelect"
      return
  return exports

