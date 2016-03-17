define ["Phaser", "caret"], (Phaser, Caret) ->
  exports = class InputBox extends Phaser.Sprite
    constructor: (game, x, y) ->
      super game, x, y
      @anchor.set 0.5, 0.5
      @game = game
      @game.add.existing this
      @originalCoords = 
        x: x
        y: y
      textStyle =
        font: "40px Futura"
        fill: "#FFFFFF"
      @wordLabel = @game.add.text 0, 0, "HAI", textStyle
      @wordLabel.anchor.set 0.5, 0.5
      @addChild @wordLabel
      #Input box
      textStyle =
        font: "40px Futura"
        fill: "#00CC00"
      @inputText = @game.add.text 0, 0, "", textStyle
      @inputText.anchor.set 0, 0.5
      @inputText.standardX = 0
      @addChild @inputText
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
        return @shakeAnimation()
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
      oldWord = @wordLabel.text
      word = ""
      if @game.level.wordList.randomise #random
        i = @game.rand.between 0, @game.level.wordList.length-1
        word = @game.level.wordList[i]
        return @nextWord() if word is oldWord
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
    shakeAnimation: (shakiness=10, autoStart=yes) =>
      x = @originalCoords.x
      t = @game.add.tween this
      t.to({
          x: x + shakiness
        }, 40)
      t.to({
          x: x - shakiness
        }, 40)
      t.to({
          x: x
        }, 40)
      t.start() if autoStart
      t