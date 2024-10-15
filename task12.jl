using HorizonSideRobots

sides = [Ost, West]

function seekwall!(robot::Robot) # робот ищет все перегородки на поле
    x, y = tocorner!(robot)
    move!(robot, Sud)
    side = 0
    count_walls = 0
    while !isborder(robot, Sud)
        while true
            flag = gotowall!(robot, sides[(side % 2) + 1])
            if flag == false break end
            count_walls = gotonowall!(robot, sides[(side % 2) + 1], count_walls)
        end
        side = side + 1
        move!(robot, Sud)
    end
    while true
        flag = gotowall!(robot, sides[(side % 2) + 1])
        if flag == false break end
        count_walls = gotonowall!(robot, sides[(side % 2) + 1], count_walls)
    end
    fromcorner!(robot, x, y)
    return count_walls
end

function tocorner!(robot::Robot) # робот идет в верхний левый угол и запоминает координаты 
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

function gotowall!(robot::Robot, side) # робот идет вправо или влево пока не увидит стенку сверху
    flag = true
    while !isborder(robot, Nord) && !isborder(robot, side)
        move!(robot, side)
        if isborder(robot, side) break end
    end
    if isborder(robot, side)
        flag = false
    end
    return flag
end

function gotonowall!(robot::Robot, side, count_walls) # робот идет вправо или влево пока есть стенка сверху
    flag = true
    while isborder(robot, Nord)
        move!(robot, side)
    end
    while true
        if !isborder(robot, side)
            move!(robot, side)
            if isborder(robot, Nord)
                while isborder(robot, Nord)
                    move!(robot, side)
                end
            else
                move!(robot, inverse(side))
                flag = false
            end 
        else
            flag = false
        end
        if flag == false break end
    end  
    count_walls += 1
    return count_walls
end

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)

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