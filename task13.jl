# Решить задачу 9 с использованием обобщённой функции snake!(robot, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Ost,Nord))
using HorizonSideRobots

mutable struct ChessRobot
    robot::Robot
    n::Int
end

function chessrobot!(robot::Robot)
    x, y = tocorner!(robot)
    n = (x + y + 1) % 2
    robot = ChessRobot(robot, n)
    snake!(side->isborder(robot, side) && isborder(robot, Nord), robot, (Ost, Nord))
    fromcorner!(robot, x, y)
end

function HorizonSideRobots.move!(robot::ChessRobot, side)
    if robot.n == 1
        putmarker!(robot.robot)
        move!(robot.robot, side)
        robot.n = 0
    else
        move!(robot.robot, side)
        robot.n = 1
    end
end
HorizonSideRobots.isborder(robot::ChessRobot, side) = isborder(robot.robot, side)
HorizonSideRobots.ismarker(robot::ChessRobot) = ismarker(robot.robot)

function snake!(stop_condition::Function, robot, sides::NTuple{2,HorizonSide})
    side = sides[1]
    while !stop_condition(side)
        movetoend!(()->stop_condition(side) || isborder(robot, side), robot, side)
        if stop_condition(side)
            break
        end
        side = inverse(side)
        move!(robot, sides[2])
    end
end

function tocorner!(robot) # робот идет в угол и запоминает координаты 
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

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)

function movetoend!(stop_condition::Function, robot, side)
    n = 0
    while !stop_condition()
        move!(robot, side)
        n += 1
    end
    return n
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