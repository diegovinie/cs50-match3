--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety)

    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety
    self.shinny = math.random(100) <= 2
    self.alpha = 0

    if self.shinny then
        Timer.every(1, function() self:flick(0.25, 0, 0.6, 1.75) end)
    end
end

function Tile:flick(time, min, max, rest)
    return Timer.after(rest or 0, function()
        return Timer.tween(time, { [self] = { alpha = max } }):finish(function()
            return Timer.tween(time, { [self] = { alpha = min } })
        end)
    end)
end

function Tile:render(x, y)

    -- draw shadow
    love.graphics.setColor(34 / 255, 32 / 255, 52 / 255, 1)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)

    if self.shinny then
        love.graphics.setBlendMode('add')
        love.graphics.setColor(1, 1, 1, self.alpha)
        love.graphics.rectangle('fill', self.x + x + 1, self.y + y + 1, 30, 30, 6)
        love.graphics.setBlendMode('alpha')
    end
end