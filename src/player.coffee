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
      super game, x, y, "player"
      @setup()
    setup: ->
      @body.velocity.x = 100
      @body.gravity.y = 50
    update: =>
      @reSpawn() if @game.physics.arcade.collide this, @game.dangerLayer
      @game.physics.arcade.collide this, @game.floor
    reSpawn: ->
      console.log "DANGER"
      x = @game.level.spawnPoint.x
      y = @game.level.spawnPoint.y
      @reset x, y
      @setup()

