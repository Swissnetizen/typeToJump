"use strict";
define ["Phaser"], (Phaser) -> 
  exports = {}
  exports.LoadState = class LoadState extends Phaser.State
    preload: ->
      # Add a loading label 
      loadingLabel = @game.add.text(game.world.centerX, 150, "loading...",
        font: "30px Arial"
        fill: "#ffffff")
      loadingLabel = @game.add.text(game.world.centerX, 75, "swissnetizen.ch",
        font: "50px Arial"
        fill: "#ffffff")
      loadingLabel.anchor.setTo 0.5, 0.5
      # Add a progress bar
      progressBar = @game.add.sprite(game.world.centerX, 200, "progressBar")
      progressBar.anchor.setTo 0.5, 0.5
      @game.load.setPreloadSprite progressBar
      # Load all assets
      #graphics
      @game.load.spritesheet "mute", "assets/graphics/muteButton.png", 28, 22
      @game.load.image "tilemap", "assets/levels/minimap/tilemap.png"
      @game.load.tilemap "map", "assets/levels/tilemap.json", null, Phaser.Tilemap.TILED_JSON
      @loadImages()
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
    loader: (type, baseDir, prefix, extension, assets) ->
      for asset in assets
        @game.load[type] prefix + asset, baseDir + asset + extension
    loadImages: () ->
      @loader "image", "assets/graphics/", "", ".png", [
        "bgNormal",
        "bgSelected",
        "textBlockNormal",
        "textBlockSelected",
        "selector",
        "lockedLevel",
        "backButton",
        "backButtonSelected",
        "player",
        "tileset"
        "caret"
      ]

  return exports
