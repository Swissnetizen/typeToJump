define ["Phaser"], (Phaser) ->
  exports = class InputBox
    constructor: (game, x, y) ->
      @game = game
      @wordLabel = @game.add.text x, y, "HAI",
        font: "40px Futura"
        fill: "#FFFFFF"
      @wordLabel.anchor.set 0.5, 0.5
      @setLabelText()
    setLabelText: ->
      @wordLabel.text = @game.level.wordList[@game.level.wordsUsed]
