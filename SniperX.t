setscreen ("graphics:1260;920,offscreenonly;nobuttonbar;nocursor")

var chars : array char of boolean
var sniperX, sniperY, sniperWidth, sniperHeight, speed, recoil, cooldown, timeLeft, enemies, ammo, reloadCountdown, starSize : int
sniperX := 500
sniperY := 500
sniperWidth := 175
sniperHeight := 175
speed := 4
recoil := 80
cooldown := 0
enemies := 20
ammo := 5
starSize := 15
reloadCountdown := 0
timeLeft := 50000
var sniperWidthHalf : int := round (sniperWidth / 2)
var sniperHeightHalf : int := round (sniperHeight / 2)

var ammoString : string := "Ammo: " + intstr (ammo)

var font : int
font := Font.New ("Agency FB:40")
var width : int := Font.Width ("Press [R] to reload!", font)
var height, ascent, descent, internalLeading : int
Font.Sizes (font, height, ascent, descent, internalLeading)

type coordinates: 
record 
    x : int 
    y: int 
end record 

var hostiles : array 1 .. 4 of coordinates

hostiles(1).x := 100
hostiles(1).y := 506
hostiles(2).x := 350
hostiles(2).y := 406
hostiles(3).x := 600
hostiles(3).y := 600
hostiles(4).x := 600
hostiles(4).y := 600

% -- START INTRO -- %

for i : 16 .. 31
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("SniperX", sniperX + 60, sniperY - 60, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    
delay(3000)

for decreasing i : 31 .. 16
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("SniperX", sniperX + 60, sniperY - 60, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    
delay(1000)

for i : 16 .. 31
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("Created by Erik Dombi", sniperX - 50, sniperY - 60, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    
delay(3000)

for decreasing i : 31 .. 16
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("Created by Erik Dombi", sniperX - 50, sniperY - 60, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    
delay(1000)

for i : 16 .. 31
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("A group of terrorist have taken a hostage", sniperX - 200, sniperY - 60, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    

delay(3000)

for i : 16 .. 31
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("A group of terrorist have taken a hostage", sniperX - 200, sniperY - 60, font, 31)   
    Draw.Text ("Your object is to eliminate the enemies", sniperX - 190, sniperY - 150, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    
delay(3000)

for decreasing i : 31 .. 16
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("A group of terrorist have taken a hostage", sniperX - 200, sniperY - 60, font, i)   
    Draw.Text ("Your object is to eliminate the enemies", sniperX - 190, sniperY - 150, font, i)   
    View.Update
    
    delay (80)
    
end for
    

delay(1000)

for i : 16 .. 31
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("Recon reports indicate there are 20 hostiles on site", sniperX - 300, sniperY - 60, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    
delay(3000)

for decreasing i : 31 .. 16
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("Recon reports indicate there are 20 hostiles on site", sniperX - 300, sniperY - 60, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    
delay(1000)

for i : 16 .. 31
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("W/A/S/D To Move, Space to Shoot, Shift to steady aim,", sniperX - 280, sniperY - 60, font, i)   
    Draw.Text ("and CTRL to Steady Aim Pro", sniperX - 100, sniperY - 120, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    
delay(3000)

for decreasing i : 31 .. 16
    cls
    
    drawfillbox(0, 0, 2000, 2000, black)
    Draw.Text ("W/A/S/D To Move, Space to Shoot, Shift to steady aim,", sniperX - 280, sniperY - 60, font, i)   
    Draw.Text ("and CTRL to Steady Aim Pro", sniperX - 100, sniperY - 120, font, i)   
    
    View.Update
    
    delay (80)
    
end for
    
delay(2000)

% -- END INTRO -- %

font := Font.New ("Agency FB:20")

loop
    
    % Clear the canvas
    cls
    
    % -- START INPUT HANDLING -- %
    
    if cooldown > 0 then
        cooldown -= 1
        sniperY -= 1
    end if
    
    if reloadCountdown > 0 then
        reloadCountdown -= 1
        if reloadCountdown = 1 then
            ammo := 5
        end if
    end if
    
    if timeLeft > 0 then
        timeLeft -= 3
    end if
    
    if enemies = 0 & cooldown = 0 then
        %PUT ENDGAME HERE (WIN)
    end if
    
    if timeLeft = 0 then
        %PUT ENDGAME HERE (LOSE)
    end if
    
    Input.KeyDown (chars)
    
    if chars ('w') then
        sniperY += speed
    end if
    if chars ('s') then
        sniperY -= speed
    end if
    if chars ('a') then
        sniperX -= speed
    end if
    if chars ('d') then
        sniperX += speed
    end if
    if chars ('r') & reloadCountdown = 0 & ammo < 5 & cooldown = 0 then
        reloadCountdown := 100
    end if
    if chars (' ') & cooldown = 0 & reloadCountdown = 0 then
        if ammo > 0 then
            
            for i : 1 .. upper(hostiles)
                if hostiles(i).x - (sniperX + sniperWidthHalf) >= -4 & hostiles(i).x - (sniperX + sniperWidthHalf) <= 4 then
                    if hostiles(i).y - (sniperY - sniperHeightHalf) >= -4 & hostiles(i).y - (sniperY - sniperHeightHalf) <= 4 then
                        
                        enemies -= 1
                        hostiles(i).x := -999
                        hostiles(i).y := -999
                        
                    end if
                end if
            end for
                
            sniperY += recoil
            cooldown := recoil
            ammo -= 1
        end if
    end if
    if chars (KEY_SHIFT) then
        speed := 2
    else
        if not chars (KEY_CTRL) then
            speed := 4
        end if
    end if
    if chars (KEY_CTRL) then
        speed := 1
    else
        if not chars (KEY_SHIFT) then
            speed := 4
        end if
    end if
    
    % -- END INPUT HANDLING -- %
    
    % -- START DRAWING LANDSCAPE -- %
    
    %Sky
    drawfillbox (0, 0, 1260, 1260, 104)
    
    %Ground
    drawfillbox (0, 0, 1260, 99, 19)
    
    %Building1
    drawfillbox (0, 100, 200, 500, darkgrey)
    
    %Building2
    drawfillbox (201, 100, 400, 400, 17)
    
    %Building3
    drawfillbox(400, 100, 600, 600, 18)
    
    %Building4
    drawfillbox(600, 100, 900, 400, 15)
    
    %Building5
    drawfillbox(900, 100, 1100, 500, 23)
    
    %Building6
    drawfillbox(1100, 100, 1260, 700, 20)
    
    % -- END DRAWING LANDSCAPE -- %
    
    % -- START DRAWING ENEMIES -- % (Oh god)
    
    for i : 1 .. upper(hostiles)
        drawfilloval(hostiles(i).x, hostiles(i).y, 5, 5, 12)
    end for
        
    % -- END DRAWING ENEMIES -- %
    
    % -- START DRAWING SNIPER SCOPE -- %
    
    %Draws box to the left of the sniper
    drawfillbox (0, 0, sniperX, 1260, black)
    
    %Draws box to the top of the sniper
    drawfillbox (0, 1260, 1260, sniperY, black)
    
    %Draws box to the right of the sniper
    drawfillbox (1260, 0, sniperX + sniperWidth, 1260, black)
    
    %Draws box to the bottom of the sniper
    drawfillbox (0, 0, 1260, sniperY - sniperHeight, black)
    
    %Makes top left of scope rounded
    drawfillbox (0, 1260, sniperX + 30, sniperY - 30, black)
    drawfillbox (0, 1260, sniperX + 10, sniperY - 50, black)
    drawfillbox (0, 1260, sniperX + 50, sniperY - 10, black)
    
    %Makes bottom left of scope rounded
    drawfillbox (0, 0, sniperX + 30, sniperY - sniperHeight + 30, black)
    drawfillbox (0, 0, sniperX + 10, sniperY - sniperHeight + 50, black)
    drawfillbox (0, 0, sniperX + 50, sniperY - sniperHeight + 10, black)
    
    %Makes bottom right of scope rounded
    drawfillbox (1260, 0, sniperX + sniperWidth - 30, sniperY - sniperHeight + 30, black)
    drawfillbox (1260, 0, sniperX + sniperWidth - 10, sniperY - sniperHeight + 50, black)
    drawfillbox (1260, 0, sniperX + sniperWidth - 50, sniperY - sniperHeight + 10, black)
    
    %Makes top right of scope rounded
    drawfillbox (1260, 1260, sniperX + sniperWidth - 30, sniperY - 30, black)
    drawfillbox (1260, 1260, sniperX + sniperWidth - 10, sniperY - 50, black)
    drawfillbox (1260, 1260, sniperX + sniperWidth - 50, sniperY - 10, black)
    
    %Draws the lines through the middle of the scope
    drawfillbox (sniperX, sniperY - sniperHeightHalf + 1, sniperX + sniperWidth, sniperY - sniperHeightHalf - 1, black)
    drawfillbox (sniperX + sniperWidthHalf - 1, sniperY, sniperX + sniperWidthHalf + 1, sniperY - sniperHeight, black)
    drawfilloval (sniperX + sniperWidthHalf, sniperY - sniperHeightHalf, 3, 3, red)
    
    % -- END DRAWING SNIPER SCOPE -- %
    
    % -- START DRAW AMMO COUNT -- %
    
    ammoString := "Ammo: " + intstr (ammo)
    
    Draw.Text (ammoString, sniperX + sniperWidth + 10, sniperY - sniperHeightHalf - 10, font, white)
    if ammo = 0 & cooldown = 0 & reloadCountdown = 0 then
        Draw.Text ("Press [R] to reload!", sniperX + sniperWidth + 10, sniperY - sniperHeight + 36, font, white)
    end if
    if reloadCountdown > 0 then
        drawfillbox(sniperX + sniperWidth + 10, sniperY - sniperHeight + 58, sniperX + sniperWidth + 114, sniperY - sniperHeight + 47, white)
        drawfillbox(sniperX + sniperWidth + 12, sniperY - sniperHeight + 56, sniperX + sniperWidth + 112 - reloadCountdown, sniperY - sniperHeight + 49, black)
    end if
    
    % -- END DRAW AMMO COUNT -- %
    
    % -- START DRAW BULLET STAR -- %
    
    if cooldown = recoil then
        Draw.FillStar (sniperX + sniperWidthHalf - starSize, sniperY - sniperHeightHalf - starSize, sniperX + sniperWidthHalf + starSize, sniperY - sniperHeightHalf + starSize, yellow)
    end if
    
    % -- END DRAW BULLET STAR -- %
    
    %Print variables to top of screen
    
    colorback (black)
    color (white)
    put "Enemies: ", enemies, "  |  Time Remaining:", intstr (timeLeft) (1 .. 3)
    
    
    
    %Updates the program's graphics to the new canvas
    View.Update
    
    %Delay the next loop by 17ms so we can run the program at 60 fps.
    %Lowering this number may be required for better performance on slow computers
    delay (17)
    
end loop
