define ["Phaser"], (Phaser) ->
  exports = class InputBox
    constructor: (game, x, y) ->
      @game = game
      textStyle =
        font: "40px Futura"
        fill: "#FFFFFF"
      @wordLabel = @game.add.text x, y, "HAI", textStyle
      @wordLabel.anchor.set 0.5, 0.5
      @inputText = @game.add.text x, y+45, "", textStyle
      @inputText.anchor.set 0.5, 0.5
      @setLabelText()
      @game.input.keyboard.addCallbacks this, null, @whenBS, @whenPress
    setLabelText: ->
      unless @game.level.wordList[@game.level.wordsUsed]?
        @game.level.wordsUsed = 0
      @wordLabel.text = @game.level.wordList[@game.level.wordsUsed]
    whenPress: (a, b, c, d, e) =>
      console.log b.key
      @inputText.text += b.key
      if @inputText.text == @wordLabel.text
        @game.player.jump()
        @nextWord()
    whenBS: (a) =>
      g = @game.globals.deleteOptions
      if a.keyCode == 8 and (g.delOne or g.delAll)
        if g.delOne
          @inputText.text = @inputText.text.substr 0, @inputText.text.length-1 
        else if g.delAll
          @inputText.text = ""
    nextWord: ->
      @game.level.wordsUsed += 1
      @setLabelText()
      @inputText.text = ""
