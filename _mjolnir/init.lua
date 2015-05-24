local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local tiling = require "mjolnir.tiling"
local hints = require "mjolnir.th.hints"

local mash = {"alt", "shift"}

hotkey.bind(mash, "space", function() tiling.cyclelayout() end)
hotkey.bind(mash, "j", function() tiling.cycle(1) end)
hotkey.bind(mash, "k", function() tiling.cycle(-1) end)
hotkey.bind(mash, "return", function() tiling.promote() end)
hotkey.bind(mash, "u", function() tiling.retile() end)
hotkey.bind(mash, "e",hints.windowHints)

-- If you want to set the layouts that are enabled
tiling.set('layouts', {
  'main-vertical',
  'main-horizontal',
  'gp-vertical',
  'fullscreen',
  'columns',
  'rows'
})

