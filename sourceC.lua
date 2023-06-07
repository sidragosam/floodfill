local xMax, yMax = guiGetScreenSize()
local red = 255
local green = 0
local blue = 255
local color = tocolor(red, green, blue, 255)
texture = dxCreateTexture (xMax, yMax)
local pixels = dxGetTexturePixels (texture)

function floodFillCMD ( commandName, x, y )
	if not x or not y then return outputChatBox("/" .. commandName .. " [x], [y]") end
	if tonumber(x) and tonumber(y) then
		x = tonumber(x)
		y = tonumber(y)
		
		if (x >= 0 and x <= xMax) and (y >= 0 and y <= yMax) then
			floodFill(x, y)
			outputChatBox("FloodFill Started at X: " .. x .. ", Y: " .. y .. ".")
		else
			outputChatBox("X and Y must be greater than 0, but lesser than " .. xMax .." and " .. yMax .."!")
		end
	else
		outputChatBox("X and Y must be number!")
	end
end    
addCommandHandler ( "ff", floodFillCMD )

function floodFill(x, y)
	if (x >= 0 and x <= xMax) and (y >= 0 and y <= yMax) then
	local r,g,b,a = dxGetPixelColor(pixels,x,y)
		if r ~= red or g ~= green and b ~= blue then
			dxSetPixelColor (pixels, x, y, red, green, blue, 255)
			dxSetTexturePixels (texture, pixels)
			setTimer ( function()
				floodFill(x + 1, y)
				floodFill(x - 1, y)
				floodFill(x, y + 1)
				floodFill(x, y - 1)
			end, 100, 1 )

		end
	end
end

addEventHandler ("onClientRender", root,
    function ()
         dxDrawImage (0, 0, xMax, yMax, texture)
    end)