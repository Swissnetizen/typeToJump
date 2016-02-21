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
"use strict"
define ["Phaser"], (Phaser) ->
  exports = class TextButton extends Phaser.Button
      constructor: (@game, x, y, text, style, callback, context) ->
        #Setup text
        @text = new Phaser.Text(@game, 0, 0, text, style)
        #Set up button
        super @game, x, y, @text.texture, callback, context
        @input.useHandCursor = true
        @anchor.set .5, .5
        @game.add.existing this
      reloadText: ->
        @loadTexture @text.texture
