"use strict"
define ["Phaser", "loadLevel"], (Phaser, levelLoader) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @game = game
      @game.level = {}
      levelLoader @game, "map"
    update: ->
      @game.player.update() if @game.player
  return exports
