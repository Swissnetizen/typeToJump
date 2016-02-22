# Initialize Phaser
requirejs.config (
    baseUrl: "js"
    paths: 
      Phaser:   "../phaser"
)
require ["Phaser", "boot", "load", "menu", "play"], (Phaser, boot, load, menu, play) ->
  "use strict"
  window.game = new Phaser.Game(740, 260, Phaser.AUTO, "gameDiv")
  # Our "globals" variable
  game.globals = 
    score: 0
    width: 740
    height: 260
  # Define states
  game.state.add "boot", new boot.BootState
  game.state.add "load", new load.LoadState
  game.state.add "menu", new menu.MenuState
  game.state.add "play", new play.PlayState
  # Start the "boot" state
  game.state.start "boot"
