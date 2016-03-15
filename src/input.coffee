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
        fill: "#00CC00"
      @inputText = @game.add.text x, y, "", textStyle
      @inputText.anchor.set 0, 0.5
      @inputText.standardX = x
      @nextWord()
      #Caret
      @game.input.keyboard.addCallbacks this, null, @whenBS, @whenPress
    setLabelText: (word) ->
      @wordLabel.text = word
      @inputText.reset @inputText.standardX - @wordLabel.width/2, @inputText.y
      @inputText.text = ""
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
      word = ""
      if @game.level.wordList.randomise #random
        i = @game.rand.between 0, @game.level.wordList.length-1
        console.log i
        word = @game.level.wordList[i]
        console.log word
      else # Ordered
        @game.level.wordsUsed += 1
        unless @game.level.wordList[@game.level.wordsUsed]?
          @game.level.wordsUsed = 0
        word = @game.level.wordList[@game.level.wordsUsed]
      @setLabelText word
    nextChar: ->
      inputLength = @inputText.text.length
      @wordLabel.text.substr inputLength, 1
    updateCaretPosition: ->
      @caret.offsetPositionBy @inputText.width/2 if @caret