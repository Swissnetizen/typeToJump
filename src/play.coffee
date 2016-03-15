"use strict"
define ["Phaser", "loadLevel", "input"], (Phaser, levelLoader, InputBox) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @game = game
      @game.level = {}
      levelLoader @game, "map"
      @game.level.inputBox = new InputBox game, 370, 200
      @makeBackButton()
    update: ->
      @game.player.update() if @game.player
    makeBackButton: ->
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @exit
      @backButton = @game.add.button 10, 10, "backButton", @exit 
    exit: =>
      @game.state.start "levelSelect"
  return exports
