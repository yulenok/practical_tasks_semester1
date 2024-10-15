using HorizonSideRobots

sides = [Ost, West]

function all_red!(robot::Robot) # закрашивает все поле красным
    x, y = tocorner!(robot)
    side = 0
    while !isborder(robot, Sud)
        gotowallmark!(robot, sides[(side % 2) + 1])
        side = side + 1
        move!(robot, Sud)
    end
    gotowallmark!(robot, sides[(side % 2) + 1])
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

function gotowallmark!(robot::Robot, side) # робот идет до стенки ставя маркеры
    putmarker!(robot)
    while !isborder(robot, side)
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