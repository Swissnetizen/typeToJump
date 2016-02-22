###
  "Type 2 jump" a silly game
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
define ["Phaser", "player"], (Phaser, Player) ->
  "use strict"
  exports = {}
  exports = (game, mapName) ->
    # does level exist
    return no unless game.cache.checkTilemapKey mapName
    map = game.add.tilemap mapName
    map.addTilesetImage "tileset"
    layer = map.createLayer "layer"
#    layer.anchor.setTo 0.5, 0.5
    map.setCollisionBetween 1, 3
   # game.physics.arcade.convertTilemap map, layer
    game.map = map
    game.layer = layer
    makeObjects game, game.map, game.layer
    yes
  #loops through objects layer
  makeObjects = (game, map, layer) ->
    return unless map.objects.objects
    objects = map.objects.objects 
    for object in objects
      type = object.type
      switch (object.type)
        when "endMarker"
          makeEndMarker game, map, object
        when "spawn"
          game.level.spawnPoint = 
            x: object.x
            y: object.y
          game.player = new Player(game, object.x, object.y)
        else
          console.warn "Undefined object type: " + object.type
  makeEndMarker = (game, map, object) ->

  exports