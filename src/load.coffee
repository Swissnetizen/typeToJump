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
      loadingLabel.anchor.setTo 0.5, 0.5
      loadingLabel = @game.add.text(game.world.centerX, 75, "swissnetizen.ch",
        font: "50px Arial"
        fill: "#ffffff")
      loadingLabel.anchor.setTo 0.5, 0.5
      # Add a progress bar
      progressBar = @game.add.sprite(game.world.centerX, game.world.centerY + 50, "progressBar")
      progressBar.anchor.setTo 0.5, 0.5
      @game.load.setPreloadSprite progressBar
      # Load all assets
      #graphics
      @game.load.spritesheet "mute", "assets/graphics/muteButton.png", 28, 22
      @game.load.spritesheet "player", "assets/graphics/player.png", 24, 20, 2
      @game.load.json "l10n", "assets/l10n.json"
      @loadImages()
      @loadAudio()
      @loadLevels()
      # ...
      return
    create: ->
      k = Phaser.KeyCode
      game.input.keyboard.addKeyCapture([
        k.UP
        k.DOWN 
        k.LEFT 
        k.RIGHT
        k.SPACEBAR
        k.BACKSPACE
      ])
      @setupL10n()
      @game.state.start "menu"
      return
    setupL10n: ->
      @game.l10n = @game.cache.getJSON "l10n"
      @loadL10nDefault()
      @game.getL10nString = (name, type, wantArray=no) =>
        try
          value = @game.l10n[@game.lang][type][name]
          if typeof value is "string" or wantArray
            value
          else
            paragraph = ""
            for line in value
              paragraph += line + "\n "
            paragraph

        catch 
          try
            @game.l10n["en"][type][name]
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
        try 
          console.log asset
          @game.load[type] prefix + asset, baseDir + asset + extension
        catch e
          console.warn "Couldn't load *" + asset "* because *" + e + "*."
    loadImages: () ->
      @loader "image", "assets/graphics/", "", ".png", [
        "bgNormal"
        "bgSelected"
        "textBlockNormal"
        "textBlockSelected"
        "selector"
        "lockedLevel"
        "backButton"
        "backButtonSelected"
        "tileset"
        "caret"
        "capsLockWarning"
        "slab"
        "plate"
        "swiss"
      ]
    generateNames: (prefix, number) ->
      names = []
      for v, i in @range number
        names.push prefix + i
      names
    loadAudio: () ->
      soundList = @game.globals.sounds
      sounds = []
      for key of soundList
        newSounds = @generateNames key, soundList[key]
        sounds = sounds.concat newSounds
      @loader "audio", "assets/sounds/", "", ".wav", sounds
      @game.playSound = (name) =>
        number = @game.rand.between 0, @game.globals.sounds[name] - 1
        @game.sound.play  name + number
    range: (number) ->
      x = []
      for v, i in new Array(number)
        x.push i
      x
    loadLevels: ->
      numbers = @range @game.globals.levels
      for i in numbers
        @game.load.tilemap "level" + i, "assets/levels/" + i + ".json", null, Phaser.Tilemap.TILED_JSON
        @game.load.image "levelMinimap" + i, "assets/levels/minimap/" + i + ".png" 
      # @game.load.image "tilemap", "assets/levels/minimap/tilemap.png"
      # @game.load.tilemap "map", "assets/levels/tilemap.json", null, Phaser.Tilemap.TILED_JSON
  return exports
