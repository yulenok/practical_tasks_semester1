using HorizonSideRobots
#include("librob.jl")

function chess!(robot) # шахматная доска
    x, y = tocorner!(robot)
    if ((x + y) % 2 == 0)
        putmarker!(robot)
        mark!(robot)
    else
        mark!(robot)
    end
    fromcorner!(robot, x, y)
end

function tocorner!(robot::Robot) # робот идет в угол и запоминает координаты 
    x = 0
    y = 0
    while !isborder(robot, Sud) || !isborder(robot, West)
        while !isborder(robot, Sud)
            move!(robot, Sud)
            x = x + 1
        end
        while !isborder(robot, West)
            move!(robot, West)
            y = y + 1
        end
    end
    return x, y
end  

function mark_direct!(robot, side)
    while !isborder(robot, side)
        check_border!(robot, side)
    end
    if !isborder(robot, Ost)
        check_border!(robot, Ost)
    end
end

function check_border!(robot, side)
    if ismarker(robot)
        move!(robot, side)
    else
        move!(robot, side)
        putmarker!(robot)
    end
end

function mark!(robot)
    while !isborder(robot, Ost)
        for side in (Nord, Sud)
            mark_direct!(robot, side)
        end
    end
end

function fromcorner!(robot, x, y) # возвращает робота в определенные координаты
    tocorner!(robot)
    for _ in 1:x
        move!(robot, Nord)
    end
    for _ in 1:y
        move!(robot, Ost)
    end
end