"use strict"
define ["Phaser", "loadLevel", "input"], (Phaser, levelLoader, InputBox) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @game = game
      @game.level = {}
      levelLoader @game, "map"
      @game.level.inputBox = new InputBox game, 370, 175
    update: ->
      @game.player.update() if @game.player
  return exports
