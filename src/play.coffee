"use strict"
define ["Phaser", "loadLevel", "input", "capsLock"], (Phaser, levelLoader, InputBox, CapsLock) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @game = game
      @game.level = {}
      levelLoader @game, "level" + 0
      @game.level.inputBox = new InputBox game, 370, 175
      @capsLockWarning = @game.add.image 650, 160, "capsLockWarning"
      @capsLockWarning.visible = no
      @makeBackButton()
    update: ->
      @game.player.update() if @game.player
      if CapsLock.isOn()
        @capsLockWarning.visible = yes
      else
        @capsLockWarning.visible = no
    makeBackButton: ->
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @exit
      @backButton = @game.add.button 10, 10, "backButton", @exit 
    exit: =>
      @game.state.start "levelSelect"
  return exports
