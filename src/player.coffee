###
  "Type 2 Jump" a silly game
  Copyright (C) 2016 Swissnetizen

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
###
define ["Phaser", "actor"], (Phaser, Actor) ->
  exports = class Player extends Actor
    constructor: (game, x, y) ->
      @game = game
      super game, x, y, "player", 1
      @setup()
      @anchor.set 0.5, 0.5
      # Die emitter
      emitter = game.add.emitter 0, 0, 0, 25
      emitter.makeParticles ["player"]
      emitter.setXSpeed 200, -200
      emitter.setYSpeed 500, -500
      emitter.minParticleScale = 0.2
      emitter.maxParticleScale = 0.4
      emitter.minRotation = 0
      emitter.maxRotation = 100
      emitter.width = 40
      emitter.height = 40
      emitter.gravity = 0
      @emitter = emitter
    setup: ->
      @body.velocity.x = +@game.level.speed or 1000
      @body.gravity.y = 500
    update: =>
      @die() if @game.physics.arcade.collide this, @game.level.dangerLayer
      @game.physics.arcade.collide this, @game.level.floor
      # keys
      k = @game.input.keyboard
      m = Phaser.Keyboard
      if @body.onFloor() and @frame isnt 1 and @game.globals.slant
        @frame = 1
      else if not @body.onFloor() and @frame isnt 0 or not @game.globals.slant
        @frame = 0
      # @jump() if (k.isDown m.SPACEBAR) and @body.onFloor()
      @endLevel() if @game.physics.arcade.intersects this.body, @game.level.end.body
    die: ->
      @game.playSound "die"
      timeTaken = 300 #ms
      respawnFaster = 100 #ms
      @emitter.x = @x 
      @emitter.y = @y;
      @emitter.start true, timeTaken, null, 15
      @kill()
      @game.playerData.deaths= @game.playerData.deaths + 1
      setTimeout @reSpawn, timeTaken - respawnFaster
    reSpawn: =>
      x = @game.level.spawnPoint.x
      y = @game.level.spawnPoint.y
      @reset x, y
      @jumpAnimation.stop() if @jumpAnimation
      @rotation = 0
      @setup()
    jump: ->
      return unless @body.onFloor()
      t = @game.add.tween this
      t.to({
          angle: @angle + 180
        }, 1000)
      t.start()
      @jumpAnimation = t
      @body.velocity.y = -250
      #sound
      @game.playSound "jump"
    endLevel: ->
      console.log "bitch please"
      completed = @game.playerData.levelsComplete
      completed[@game.level.number] = true
      @game.playerData.levelsComplete= completed
      @game.levelNumber = @game.level.number + 1
      @game.state.start "play"


