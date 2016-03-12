"use strict";
define ["Phaser"], (Phaser) -> 
  exports = {}
  exports.LoadState = class LoadState extends Phaser.State
    preload: ->
      @game = game
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
      @game.load.json "l10n", "assets/l10n.json"
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
      @setupL10n()
      @game.state.start "menu"
      return
    setupL10n: ->
      @game.l10n = @game.cache.getJSON "l10n"
      @loadL10nDefault()
      @game.getL10nString = (name, type) =>
        try
          @game.l10n[@game.lang][type][name]
        catch 
          undefined
      @game.menuL10n = (name) =>
        @game.getL10nString name, "menu"
      @game.levelL10n = (number) =>
        text = @game.getL10nString number, "level"
        console.log text
        return "" unless text?
        return text
    loadL10nDefault: ->
      # retrieve from local storage (to view in Chrome, Ctrl+Shift+J -> Resources -> Local Storage)
      str = window.localStorage.getItem "lang"
      # error checking, localstorage might not exist yet at first time start up
      if str and str.length is 2
        @game.lang = str
      else
        @game.lang = "en"
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
