using HorizonSideRobots

sides = [Ost, Sud, West, Nord]

function perimetr!(robot::Robot) # робот идет по периметру и ставит маркеры
    x, y = tocorner!(robot)
    for i in sides
        while !isborder(robot, i) && !ismarker(robot)
            putmarker!(robot)
            move!(robot, i)
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
            x= x + 1
        end
        while !isborder(robot, West)
            move!(robot, West)
            y = y + 1
        end
    end
    return x, y
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