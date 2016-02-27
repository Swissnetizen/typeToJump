"use strict";
define ["Phaser"], (Phaser) -> 
  exports = {}
  exports.LoadState = class LoadState extends Phaser.State
    preload: ->
      # Add a loading label 
      loadingLabel = @game.add.text(game.world.centerX, 150, "loading...",
        font: "30px Arial"
        fill: "#ffffff")
      loadingLabel.anchor.setTo 0.5, 0.5
      # Add a progress bar
      progressBar = @game.add.sprite(game.world.centerX, 200, "progressBar")
      progressBar.anchor.setTo 0.5, 0.5
      @game.load.setPreloadSprite progressBar
      # Load all assets
      #graphics
      @game.load.spritesheet "mute", "assets/graphics/muteButton.png", 28, 22
      @game.load.image "tileset", "assets/graphics/tileset.png"
      @game.load.image "player", "assets/graphics/player.png"
      @game.load.image "tilemap", "assets/levels/minimap/tilemap.png"
      @game.load.tilemap "map", "assets/levels/tilemap.json", null, Phaser.Tilemap.TILED_JSON
      @game.load.image "bgNormal", "assets/graphics/bgNormal.png"
      @game.load.image "bgSelected", "assets/graphics/bgSelected.png"
      @game.load.image "textBlockNormal", "assets/graphics/textBlockNormal.png"
      @game.load.image "textBlockSelected", "assets/graphics/textBlockSelected.png"
      @game.load.image "selector", "assets/graphics/selector.png"
      @game.load.image "lockedLevel", "assets/graphics/lockedLevel.png"
      @game.load.image "backButton", "assets/graphics/backButton.png"
      @game.load.image "backButtonSelected", "assets/graphics/backButton.png"
      # ...
      return
    create: ->
      game.input.keyboard.addKeyCapture([
        Phaser.Keyboard.UP,
        Phaser.Keyboard.DOWN, 
        Phaser.Keyboard.LEFT, 
        Phaser.Keyboard.RIGHT,
        Phaser.Keyboard.SPACEBAR,
        Phaser.Keyboard.BACKSPACE
      ])
      @game.state.start "menu"
      return
  return exports
