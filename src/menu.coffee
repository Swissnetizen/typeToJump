"use strict"
define ["Phaser", "gridSelector"], (Phaser, Grid) -> 
  exports = {}
  exports.MenuState = class MenuState extends Phaser.State
    create: ->
      # Name of the @game
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
      @grid =  new Grid(
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
      @grid.render 0, 0
      @grid.pressEvent = (info) =>
        switch info.number
          when 0
            @start()
          when 1
            console.log "langu"
          when 2
            console.log "credits"
      return
    toggleSound: ->
      @game.sound.mute = !@game.sound.mute
      @muteButton.frame = if @game.sound.mute then 1 else 0
      return
    makeButton: (game, x, y, i) ->
      texts = [
        "Play"
        "💬🗺🌍"
        "Credits"
      ]
      rect = game.make.bitmapData 124, 40
      rect.ctx.fillStyle = '#ffFFFF'
      rect.ctx.fillRect 0, 0, 124, 40
      b = new Phaser.Button game, x, y, rect
      b.anchor.set 0.5, 0.5
      text = game.add.text 0, 0, texts[i], {
        font: "30px Futura"
      }
      text.anchor.set 0.5, 0.5
      b.addChild text
      b
    start: ->
      @game.state.start "levelSelect"
      return
  return exports

