"use strict"
define ["Phaser", "loadLevel", "input", "capsLock"], (Phaser, levelLoader, InputBox, CapsLock) -> 
  exports = {}
  exports.PlayState = class PlayState extends Phaser.State
    create: ->
      @game = game
      @game.end = no
      @game.input.keyboard.clearCaptures()
      @game.level = {} unless @game.level?
      @game.level.number = @game.levelNumber or 0
      success = levelLoader @game, "level" + @game.levelNumber
      unless success
        @game.end = yes
        if @game.level.number is 20
          @game.mType = "credit"
          @game.state.start "credits"
        else
          @game.add.text 620, 200, "ER 404" + @game.globals.levels,
            fill: "#FFFFFF"
            font: "25px " + @game.globals.fontFamily
          @game.state.start "levelSelect"
        return
      @game.level.inputBox = new InputBox game, 370, 175
      @capsLockWarning = @game.add.image 650, 160, "capsLockWarning"
      @capsLockWarning.visible = no
      @makeBackButton()
      @game.add.text 620, 200, @game.level.number+1 + "/" + @game.globals.levels,
        fill: "#FFFFFF"
        font: "25px " + @game.globals.fontFamily
      @deaths = @game.add.text 100, 200, "0",
        fill: "#FFFFFF"
        font: "25px " + @game.globals.fontFamily
    update: ->
      return if @game.end
      @game.player.update() if @game.player
      if CapsLock.isOn()
        @capsLockWarning.visible = yes
      else
        @capsLockWarning.visible = no
      @deaths.text = @game.playerData.deaths
    makeBackButton: ->
      @game.input.keyboard.addKey(Phaser.Keyboard.ESC).onDown.add @exit
      @backButton = @game.add.button 10, 10, "backButton", @exit 
    exit: =>
      @game.state.start "levelSelect"
  return exports
