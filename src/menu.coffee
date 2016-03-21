"use strict"
define ["Phaser", "gridSelector", "gridButton"], (Phaser, Grid, GridButton) -> 
  exports = {}
  exports.MenuState = class MenuState extends Phaser.State
    preload: ->
    create: ->
      # Name of the @game
      console.log "CREATED"
      @game.world.setBounds 0, 0, @game.globals.width, @game.globals.height
      nameLabel = @game.add.text(@game.world.centerX, 80, "Gidsuck",
        font: "50px " + @game.globals.fontFamily
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
      # SUISSE!
      swissmade = @game.add.text(20, @game.world.height - 20, "swissmade",
        font: "16px " + @game.globals.fontFamily
        fill: "#ffffff")
      swissflag = @game.add.sprite 100, @game.world.height - 20, "swiss"
      @game.addCredit @game
      # SUISSE !
      @grid.makeGridItem = @makeButton
      @grid.pressEvent.add @pressEvent
      @grid.render 0, 0
      return
    toggleSound: ->
      @game.sound.mute = !@game.sound.mute
      @muteButton.frame = if @game.sound.mute then 1 else 0
      return
    makeButton: (game, x, y, i) =>
      texts = [
        @game.menuL10n "play"
        @game.menuL10n "lang"
        @game.menuL10n "credits"
      ]
      b = new GridButton(game, x, y, @pressEvent)
      b.number = i
      text = game.add.text 0, 0, texts[i], {
        font: "30px " + @game.globals.fontFamily
      }
      text.anchor.set 0.5, 0.5
      b.addChild text
      b
    pressEvent: (info) =>
      switch info.number
        when 0
          @start()
        when 1
          @game.state.start "langSelect"
        when 2
          @game.mType = "credit"
          @game.state.start "credits"
    start: ->
      @game.state.start "levelSelect"
      return
  return exports

