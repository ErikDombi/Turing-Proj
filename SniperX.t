setscreen ("graphics:1260;920,offscreenonly;nobuttonbar;nocursor")

% -- START VECTOR CLASS -- %
%Vector class was not created by me, found at http://compsci.ca/v3/viewtopic.php?t=13981
class Vector 
    export add, element_at, is_empty, set_element, size 

    var elements : flexible array 0 .. -1 of ^anyclass 
    var bound := -1 
    var no_elements := true 

    fcn bound_check (position : int) : int 
        if position <= 0 then 
            result 0 
        elsif position >= bound then 
            result bound 
        end if 
        result position 
    end bound_check 

    proc add (element : ^anyclass) 
        bound += 1 
        new elements, bound 
        elements (bound) := element 
        no_elements := false 
    end add 

    fcn element_at (position : int) : ^anyclass 
        if bound = -1 then 
            result nil 
        end if 
        result elements (bound_check (position)) 
    end element_at 

    fcn is_empty () : boolean 
        result no_elements 
    end is_empty 

    proc set_element (position : int, element : ^anyclass) 
        elements (position) := element 
    end set_element 

    fcn size () : int 
        result bound + 1 
    end size 
end Vector

% -- END VECTOR CLASS -- %

var chars : array char of boolean
var sniperX, sniperY, sniperWidth, sniperHeight, speed, recoil, cooldown, enemies, ammo, reloadCountdown : int
sniperX := 500
sniperY := 500
sniperWidth := 150
sniperHeight := 150
speed := 4
recoil := 80
cooldown := 0
enemies := 20
ammo := 5
reloadCountdown := 0

var vec : ^Vector 
new Vector, vec 

var ammoString : string := "Ammo: " + intstr (ammo)

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
            sniperY += recoil
            cooldown := recoil
            enemies -= 1
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
    drawfillbox (20, 100, 200, 500, darkgrey) %Building Background
    drawfillbox (25, 475, 195, 495, black) %Window1 (Very top)
    drawfillbox (25, 450, 195, 470, black) %Window2
    drawfillbox (25, 425, 195, 445, black) %Window3
    drawfillbox (25, 400, 195, 420, black) %Window4
    drawfillbox (25, 375, 195, 395, black) %Window5
    drawfillbox (25, 450, 195, 470, black) %Window6
    %24
    drawfillbox (44, 100, 54, 500, darkgrey) %WindowDivider1
    drawfillbox (78, 100, 88, 500, darkgrey) %WindowDivider2
    drawfillbox (112, 100, 122, 500, darkgrey) %WindowDivider4
    drawfillbox (146, 100, 156, 500, darkgrey) %WindowDivider5
    
    %Building2
    drawfillbox (201, 100, 400, 400, 17)
    % -- END DRAWING LANDSCAPE -- %
    
    % -- START DRAWING ENEMIES -- % (Oh god)
    
    drawfilloval(150, 505, 5, 5, red)
    
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
    var sniperWidthHalf : int := round (sniperWidth / 2)
    var sniperHeightHalf : int := round (sniperHeight / 2)
    drawfillbox (sniperX, sniperY - sniperHeightHalf + 1, sniperX + sniperWidth, sniperY - sniperHeightHalf - 1, black)
    drawfillbox (sniperX + sniperWidthHalf - 1, sniperY, sniperX + sniperWidthHalf + 1, sniperY - sniperHeight, black)
    drawfilloval (sniperX + sniperWidthHalf, sniperY - sniperHeightHalf, 3, 3, red)
    
    % -- END DRAWING SNIPER SCOPE -- %
    
    % -- START DRAW AMMO COUNT -- %
    
    ammoString := "Ammo: " + intstr (ammo)
    
    var font : int
    font := Font.New ("Agency FB:20")
    var width : int := Font.Width ("This is in a serif font", font)
    var height, ascent, descent, internalLeading : int
    Font.Sizes (font, height, ascent, descent, internalLeading)
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
        Draw.FillStar (sniperX + 60, sniperY - 60, sniperX + 90, sniperY - 90, yellow)
    end if
    
    % -- END DRAW BULLET STAR -- %
    
    %Print variables to top of screen
    
    colorback (black)
    color (white)
    put "Enemies: ", enemies, "  |  Score: null  |  otherVar: null"
    
    
    
    %Updates the program's graphics to the new canvas
    View.Update
    
    %Delay the next loop by 17ms so we can run the program at 60 fps.
    %Lowering this number may be required for better performance on slow computers
    delay (17)
    
end loop
