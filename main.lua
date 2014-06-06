
-- main.lua
-- Hide the iPhone status bar
display.setStatusBar( display.HiddenStatusBar)

local bg = display.newRect( display.screenOriginX,
                            display.screenOriginY, 
                            display.contentWidth, 
                            display.contentHeight)
 
bg.x = display.contentCenterX
bg.y = display.contentCenterY
bg:setFillColor( 192/255, 192/255, 192/255 )

-- create a group to contain character and healthbar
characterGroup = display.newGroup( )
characterGroup.x = display.contentCenterX
characterGroup.y = display.contentCenterY

-- set maxHealth and currentHealth values
maxHealth = 100
currentHealth = 100

-- draw a character to the screen
dwarf = display.newImage("dwarf.png" )
characterGroup:insert( dwarf )

-- create green health bar
healthBar = display.newRect(0,
                        -45, 
                        maxHealth, 
                       10)

healthBar:setFillColor( 000/255, 255/255, 0/255 )
healthBar.strokeWidth = 1
healthBar:setStrokeColor( 255, 255, 255, .5 )
characterGroup:insert(healthBar)

-- create red damage bar (-create it second so it lays on top)
damageBar = display.newRect(0,
						-45,
                        0, 
                       10)

damageBar:setFillColor( 255/255, 0/255, 0/255 )
characterGroup:insert(damageBar)

-- update the damage bar
function updateDamageBar()
	damageBar.x = currentHealth / 2
	damageBar.width = maxHealth - currentHealth
end

-- lower the character's currentHealth
function damageCharacter(damageTaken)
	currentHealth = currentHealth - damageTaken
	updateDamageBar()
end

-- move the character to the right and apply 25 damage
function moveRight()
	if(currentHealth > 0) then damageCharacter(25) end
	transition.to( characterGroup, { time=1500, x=(characterGroup.x+100), onComplete = moveLeft} )
end

-- move the character to the left
function moveLeft()
	transition.to( characterGroup, { time=1500, x=(characterGroup.x-100), onComplete = moveRight} )
end

moveLeft()
