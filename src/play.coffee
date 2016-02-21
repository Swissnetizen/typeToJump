"use strict"
define ["Phaser", "loadLevel"], (Phaser, levelLoader) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @game = game
      levelLoader @game, "tilemap"
    update: ->
  return exports
