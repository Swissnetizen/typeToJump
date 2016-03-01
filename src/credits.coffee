define ["Phaser"], (Phaser) ->
  class CreditState extends Phaser.State
    create: ->
      credits = """
* This program uses the Phaser.io framework written by Richard Davey underthe MIT license. 
* All code in the src/ folder is under the GPL≥3; Copyright swissnetizen 2016.
* All assets in assets/ **except music.ogg** are under CC-BY-SA; Copyright swissnetizen 2016.
* There are two extra terms for the GPL
=> This whole program is licensed under the GPL≥3
      """
      label = @game.add.text 30, 0, credits, {
          font: "20px Futura"
          fill: "#FFFFFF"
          wordWrap: on
          wordWrapWidth: 720
        }
      returnText = "Press any key to return"
      returnLabel = @game.add.text @game.globals.width/2, @game.globals.height-20, returnText, {
          font: "20px Futura"
          fill: "#00FF00"
          wordWrap: on
          wordWrapWidth: 720
        }
      returnLabel.anchor.set 0.5, 0.5
      console.log "HI"
      @game.input.keyboard.addCallbacks this, ->
        @game.state.start "menu"