using HorizonSideRobots

function marks_opposite_robot!(robot::Robot)
    x, y = tocorner!(robot)
    for side in (Ost, Sud, West, Nord)  
        if (side == Ost) || (side == Sud)
            if side == Ost
                moven!(robot, side, y)
            else
                moven!(robot, side, x)
            end
            putmarker!(robot)
            gotowall!(robot,side)
        else
            gotowall!(robot, side)
            if side == West
                moven!(robot, Ost, y)
            else
                moven!(robot, Sud, x)
            end
            putmarker!(robot)
            gotowall!(robot, side)
        end
    end
    fromcorner!(robot, x, y)
end

function tocorner!(robot::Robot) # робот идет в угол и запоминает координаты 
    x = 0
    y = 0
    while !isborder(robot, Nord) || !isborder(robot, West)
        while !isborder(robot, Nord)
            move!(robot, Nord)
            x = x + 1
        end
        while !isborder(robot, West)
            move!(robot, West)
            y = y + 1
        end
    end
    return x, y
end

function gotowall!(robot::Robot,side) # робот идет до стенки
    while !isborder(robot, side)
        move!(robot, side)
    end
end

function moven!(robot::Robot, side, n) # робот передвигается на n клеток в заданом направлении
    num_steps = 0
    for _ in 1:n
        if !isborder(robot, side)
            move!(robot, side)
            num_steps += 1
        end
    end
    return num_steps
end

function fromcorner!(robot::Robot,x,y) # возвращaет робота в определенные координаты относительно верхнего левого угла 
    tocorner!(robot)
    while (x != 0) || (y != 0)

        if !isborder(robot, Sud) && x > 0
            move!(robot, Sud)
            x -= 1
        elseif isborder(robot, Sud) && x > 0
            while isborder(robot, Sud) 
                move!(robot, Ost)
                y -= 1
            end
            move!(robot, Sud)
            x -= 1
        elseif !isborder(robot, Nord) && x < 0
            move!(robot, Nord)
            x += 1
        end

        if !isborder(robot, Ost) && y > 0 
            move!(robot, Ost)
            y -= 1
        elseif isborder(robot, Ost) && y > 0
            while isborder(robot, Ost) 
                move!(robot, Sud)
                x -= 1
            end
            move!(robot, Ost)
            y -= 1
        elseif !isborder(robot, West) && y < 0
            move!(robot, West)
            y += 1
        end
    end
end