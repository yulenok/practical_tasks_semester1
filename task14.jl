using HorizonSideRobots

mutable struct ChessRobot
    robot::Robot
    n::Int
end

function chessrobot!(robot::Robot)
    x0, y0 = tocorner!(robot)
    x = moves!(robot, Ost)
    moves!(robot, West)
    n = (x0 + y0 + 1) % 2
    robot = ChessRobot(robot, n)
    snake!(robot, x, Nord, Ost)
    fromcorner!(robot, x0, y0)
end

function HorizonSideRobots.move!(robot::ChessRobot, side::HorizonSide)
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

function moves!(robot, side::HorizonSide)
    k = 0
    while !isborder(robot, side)
        move!(robot, side)
        k += 1
    end
    return k
end

function snake!(robot, x, next_row_side, move_side)    
    while !isborder(robot, next_row_side) || !isborder(robot, move_side)
        count_x = 0
        while count_x < x
            count_y = 0
            while !isborder(robot, move_side)
                move!(robot, move_side)
                count_x += 1
            end
            if count_x < x
                while isborder(robot, move_side)
                    move!(robot, Sud)
                    count_y += 1
                end
                move!(robot, move_side)
                count_x += 1
                while isborder(robot, Nord)
                    move!(robot, move_side)
                    count_x += 1
                end
                for _ in 1:count_y
                    move!(robot, Nord)
                end
            end
        end
        if trymove!(robot, next_row_side)
            move_side = inverse(move_side)
        end
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)

function trymove!(robot, side)
        if !isborder(robot, side)
        move!(robot, side)
        return true
    end
    false
end

function tocorner!(robot) # робот идет в угол и запоминает координаты 
    x0 = 0
    y0 = 0
    while !isborder(robot, Sud) || !isborder(robot, West)
        while !isborder(robot, Sud)
            move!(robot, Sud)
            x0 = x0 + 1
        end
        while !isborder(robot, West)
            move!(robot, West)
            y0 = y0 + 1
        end
    end
    return x0, y0
end

function fromcorner!(robot, x0, y0) # возвращает робота в определенные координаты
    tocorner!(robot)
    for _ in 1:x0
        move!(robot, Nord)
    end
    for _ in 1:y0
        move!(robot, Ost)
    end
end