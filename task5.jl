using HorizonSideRobots


function perimetr!(robot::Robot)
    x, y = tocorner!(robot)
    for side in (Ost, Sud, West, Nord)
        in_perimeter!(robot, side)
    end
    n = seek_border!(robot)
    if (n == Nord)
        for side in (Nord, Ost, Sud, West)
            side_new = HorizonSide((Int(side) + 3) % 4)
            out_perimeter!(robot, side, side_new)
        end
    else
        for side in (Sud, Ost, Nord, West)
            side_new = HorizonSide((Int(side) + 1) % 4)
            out_perimeter!(robot, side, side_new)
        end
    end
    fromcorner(robot, x, y)
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

function in_perimeter!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
    end
end

function seek_border!(robot) # робот ищет внутреннюю перегородку
    side = Nord
    while !isborder(robot, Ost)
        flag = false
        while !isborder(robot, side)
            if !isborder(robot, Ost)
                move!(robot, side)
            else
                flag = true
                break
            end
        end
        if !isborder(robot, Ost)
            move!(robot, Ost)
        end  
        side = HorizonSide((Int(side) + 2) % 4)
        if flag break end
    end
    return HorizonSide((Int(side) + 2) % 4)
end

function out_perimeter!(robot, side, side_new)
    putmarker!(robot)
    move!(robot, side)
    putmarker!(robot)
    while isborder(robot, side_new)
        move!(robot, side)
        putmarker!(robot)
    end
end

function fromcorner!(robot, x, y) # возвращает робота в определенные координаты
    tocorner!(robot)
    for _ in 1:x
        move!(robot, Sud)
    end
    for _ in 1:y
        move!(robot, Ost)
    end
end