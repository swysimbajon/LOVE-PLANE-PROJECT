
PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0

    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)

	if scrolling == true and love.keyboard.wasPressed('p') then
		sounds['pause']:play()
		scrolling = false

	elseif scrolling == false and love.keyboard.wasPressed('p') then
		scrolling = true
	end

    self.timer = self.timer + dt

    if scrolling then
    	while self.timer > math.random(100) do
        	local y = math.max(-PIPE_HEIGHT + 10, 
            	math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
       		self.lastY = y

        	table.insert(self.pipePairs, PipePair(y))

        	self.timer = 0
        end
    end

	if scrolling then
    	for k, pair in pairs(self.pipePairs) do
        	if not pair.scored then
            	if pair.x + PIPE_WIDTH < self.bird.x then
                	self.score = self.score + 1
                	pair.scored = true
                	sounds['score']:play()
            	end
        	end

        	pair:update(dt)
    	end
	end


    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

	if scrolling then
    	for k, pair in pairs(self.pipePairs) do
        	for l, pipe in pairs(pair.pipes) do
            	if self.bird:collides(pipe) then
                	sounds['explosion']:play()
                	sounds['hurt']:play()

                	gStateMachine:change('score', {
                    	score = self.score
                	})
            	end
        	end
    	end

    	self.bird:update(dt)
	end

    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        sounds['explosion']:play()
        sounds['hurt']:play()

        gStateMachine:change('score', {
            score = self.score
        })
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()
    if scrolling == false then
    	love.graphics.printf('PAUSED', 0, 115, VIRTUAL_WIDTH, 'center')
    	love.graphics.printf('Press P to resume', 0, 150, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:enter()
    scrolling = true
end

function PlayState:exit()
    scrolling = false
end
