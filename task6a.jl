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