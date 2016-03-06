define ["Phaser", "caret"], (Phaser, Caret) ->
  exports = class InputBox
    constructor: (game, x, y) ->
      @game = game
      textStyle =
        font: "40px Futura"
        fill: "#FFFFFF"
      @wordLabel = @game.add.text x, y, "HAI", textStyle
      @wordLabel.anchor.set 0.5, 0.5
      #Input box
      textStyle =
        font: "40px Futura"
        fill: "#00FF00"
        text-decoration: "underline"
      @inputText = @game.add.text x, y, "", textStyle
      @inputText.anchor.set 0, 0.5
      @inputText.standardX = x
      @setLabelText()
      #Caret
      @caret = new Caret(game, x, y)
      @game.input.keyboard.addCallbacks this, null, @whenBS, @whenPress
    setLabelText: ->
      unless @game.level.wordList[@game.level.wordsUsed]?
        @game.level.wordsUsed = 0
      @wordLabel.text = @game.level.wordList[@game.level.wordsUsed]
      @inputText.reset @inputText.standardX - @wordLabel.width/2, @inputText.y
    whenPress: (a, b, c, d, e) =>
      key = b.key
      g = @game.globals.deleteOptions 
      return if key is "Enter" or key is "Tab"
      if key is @nextChar() and (g.autoDelAll or g.autoDelOne)
        @inputText.text += key
      else if key isnt @nextChar() and g.autoDelAll
        @inputText.text = ""
        @nextWord() if g.autoNext
      else if key isnt @nextChar() and g.autoDelOne
        return
      #So when delOne or all are active
      else unless g.autoDelAll and g.autoDellOne
        @inputText.text += key
      #Applies to all cases
      if @inputText.text == @wordLabel.text
        @game.player.jump()
        @nextWord()
      @updateCaretPosition()
    whenBS: (a) =>
      g = @game.globals.deleteOptions
      if a.keyCode == 8
        if g.delOne
          @inputText.text = @inputText.text.substr 0, @inputText.text.length-1 
        else if g.delAll
          @inputText.text = ""
        @updateCaretPosition()
    nextWord: ->
      @game.level.wordsUsed += 1
      @setLabelText()
      @inputText.text = ""
    nextChar: ->
      inputLength = @inputText.text.length
      @wordLabel.text.substr inputLength, 1
    updateCaretPosition: ->
      @caret.offsetPositionBy @inputText.width/2