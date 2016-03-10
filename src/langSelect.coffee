"use strict"
define ["Phaser", "gridSelector"], (Phaser, Grid) -> 
  class LangSelect extends Phaser.State
    create: ->
      # Name of the @game
      @game.world.setBounds 0, 0, @game.globals.width, @game.globals.height
      # Add a mute button
      @muteButton = @game.add.button 20, 20, "mute", @toggleSound, this
      @muteButton.input.useHandCursor = true
      if @game.sound.mute
        @muteButton.frame = 1
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
        "English"
        "Esperanto"
        "Français"
      ]
      b = new Phaser.Button game, x, y, "bgNormal", @pressEvent
      b.onInputOver.add @whenOver
      b.onInputOut.add @whenOut
      b.anchor.set 0.5, 0.5
      b.number = i
      text = game.add.text 0, 0, texts[i], {
        font: "25px Futura"
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
          @game.lang = "en"
        when 1
          @game.lang = "eo"
        when 2
          @game.lang = "fr"
      window.localStorage.setItem "lang", @game.lang
      @start()
    start: ->
      @game.state.start "menu"

