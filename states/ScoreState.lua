
ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:init()
	self.bronze = love.graphics.newImage('Bronze.png')
	self.width = self.bronze:getWidth()
	self.height = self.bronze:getHeight()
	self.silver = love.graphics.newImage('Silver.png')
	self.width = self.silver:getWidth()
	self.height = self.silver:getHeight()
	self.gold = love.graphics.newImage('Gold.png')
	self.width = self.gold:getWidth()
	self.height = self.gold:getHeight()
	self.x = VIRTUAL_WIDTH / 2 - 12

end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! Your plane crashed!', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    if self.score > 5 and self.score < 11 then
    	love.graphics.draw(self.bronze, self.x, 180)
    	love.graphics.printf ('You got a Bronze Medal, Keep Practicing! :)', 0, 130, VIRTUAL_WIDTH, 'center')

    elseif self.score > 10 and self.score < 21 then
    	love.graphics.draw(self.silver, self.x, 180)
    	love.graphics.printf ('You got a Silver Medal, Keep Up the Good Work! :)', 0, 130, VIRTUAL_WIDTH, 'center')

    elseif self.score > 20 then
    	love.graphics.draw(self.gold, self.x, 180)
    	love.graphics.printf ('Congratulations! You got a Gold Medal! :)', 0, 130, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.printf('Press Enter to Play Again! Have a safe flight!', 0, 160, VIRTUAL_WIDTH, 'center')
end
