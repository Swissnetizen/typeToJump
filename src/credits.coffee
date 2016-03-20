define ["Phaser"], (Phaser) ->
  class CreditState extends Phaser.State
    create: ->
      credits = @game.menuL10n @game.mType + "Screen"
      @created = yes
      label = @game.add.text 30, 0, credits, {
          font: "20px " + @game.globals.fontFamily
          fill: "#FFFFFF"
          wordWrap: on
          wordWrapWidth: 720
        }
      returnText = @game.menuL10n @game.mType+"Press"
      returnLabel = @game.add.text @game.globals.width/2, @game.globals.height-20, returnText, {
          font: "20px " + @game.globals.fontFamily
          fill: "#00FF00"
          wordWrap: on
          wordWrapWidth: 720
        }
      returnLabel.anchor.set 0.5, 0.5
      @game.input.keyboard.addCallbacks this, (info) ->
        return unless @created
        @created = no
        @game.keyPressDisabled = yes
        setTimeout(=>
          @game.keyPressDisabled = no
        , 750)
        if info.keyCode is Phaser.KeyCode.G
          @game.mType = "lic"
          @game.state.start "credits"
        else
          @game.state.start "menu"