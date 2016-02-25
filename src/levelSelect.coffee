define ["Phaser", "grid"], (Phaser, Grid) ->
  class LevelSelect extends Phaser.State
    preload: ->
      @grid =  new Grid(
        game, 
        @game.globals.width/2,
        @game.globals.height/2, 
          maxW: 620
          maxH: 100
          sprite:
            w: 129
            h: 50
      )
      @grid.makeGridItem = (game, x, y, i) ->
        container = @game.add.sprite x, y, "bgNormal"
        container.anchor.set 0.5, 0.5
        sprite = @game.add.button 0, 0, "tilemap", ->
          console.log i+1
          game.state.start "play"
        sprite.input.useHandCursor = on
        sprite.anchor.set 0.5, 0.5
        container.addChild sprite
        
        rect = game.make.bitmapData 32, 32
        rect.ctx.fillStyle = "#FFFFFF"
        rect.ctx.fillRect 0, 0, 32, 32
        box = game.add.sprite 30, 0, rect
        box.anchor.set 0.5, 0.5
        sprite.addChild box

        label = @game.add.text 30, 0, i + 1 + "", {
          font: "30px Futura"
          fill: "#000000"
        }
        label.anchor.set 0.5, 0.5
        sprite.addChild label

        container
      @grid.render()
    create: ->
     # game.state.start "play"