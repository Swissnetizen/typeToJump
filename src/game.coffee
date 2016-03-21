# Initialize Phaser
requirejs.config (
    baseUrl: "js"
    paths: 
      Phaser:   "../phaser"
)
require ["Phaser", "boot", "load", "menu", "play", "levelSelect", "credits", "langSelect"], (Phaser, boot, load, menu, play, LevelSelect, CreditsState, langSelect) ->
  "use strict"
  window.game = new Phaser.Game(740, 260, Phaser.AUTO, "gameDiv")
  # Our "globals" variable
  game.globals = 
    score: 0
    width: 740
    height: 260
    debug: off
    slant: off
    deleteOptions:
      delOne: off
      delAll: off
      autoDelAll: off
      autoDelOne: on
      autoNext: off
    sounds:
      jump: 6
      select: 4
      die: 5
      wrong: 4
      right: 4
    levels: 20
    unlockAll: on
    fontFamily: "Futura, ment"
  # Define states
  game.state.add "boot", new boot.BootState
  game.state.add "load", new load.LoadState
  game.state.add "menu", new menu.MenuState
  game.state.add "play", new play.PlayState
  game.state.add "levelSelect", new LevelSelect
  game.state.add "credits", new CreditsState
  game.state.add "langSelect", new langSelect
  # Start the "boot" state
  game.state.start "boot"
  game.playerData = (JSON.parse window.localStorage.getItem "playerData") or {
    levelsComplete: new Array(game.globals.levels)
    deaths: 0
  }
  game.playerData.write = ->
    window.localStorage.setItem "playerData", JSON.stringify this
  game.playerData.write()
  game.playerData.write.bind game.playerData
  game.addCredit = (game) ->
    game.add.text(game.globals.width-20, game.globals.height, "swissnetizen.ch",
      font: "20px " + game.globals.fontFamily
      fill: "#ffffff").anchor.set 1, 1


