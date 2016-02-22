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
    game.map = map
    makeLayers game, map
    makeObjects game, map
    makeWordList game, map
    yes
  makeLayers = (game, map) ->
    floor = map.createLayer "floor"
    dangerLayer = map.createLayer "dangerLayer"
    # set debug
    floor.debug = game.globals.debug
    dangerLayer.debug = game.globals.debug
    #set collisions
    map.setCollision 3, yes, floor
    map.setCollisionBetween 1, 4, yes, dangerLayer
    game.physics.arcade.enable [dangerLayer, floor]
    # set var
    game.level.dangerLayer = dangerLayer
    game.level.floor = floor
  makeWordList = (game, map) ->
    mapWordList = map.properties.wordList
    game.level.wordList = []
    wordList = JSON.parse mapWordList if mapWordList
    game.level.wordList = wordList
  #loops through objects layer
  makeObjects = (game, map) ->
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