# Initialize Phaser
requirejs.config (
    baseUrl: "js"
    paths: 
      Phaser:   "../phaser"
)
require ["Phaser", "boot", "load", "menu", "play", "levelSelect", "credits"], (Phaser, boot, load, menu, play, LevelSelect, CreditsState) ->
  "use strict"
  window.game = new Phaser.Game(740, 260, Phaser.AUTO, "gameDiv")
  # Our "globals" variable
  game.globals = 
    score: 0
    width: 740
    height: 260
    debug: off
    deleteOptions:
      delOne: off
      delAll: on
      autoDelAll: off
      autoDelOne: off
      autoNext: off
  # Define states
  game.state.add "boot", new boot.BootState
  game.state.add "load", new load.LoadState
  game.state.add "menu", new menu.MenuState
  game.state.add "play", new play.PlayState
  game.state.add "levelSelect", new LevelSelect
  game.state.add "credits", new CreditsState
  # Start the "boot" state
  game.state.start "boot"
