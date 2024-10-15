using HorizonSideRobots

function chessN!(robot::Robot, N) # шахматная доска клетками N на N
    x , y = tocorner!(robot)
    k = 1
    while true
        square!(robot,N)
        if moven!(robot, Ost, N*2) != N*2
            if moven!(robot, Sud, N) != N
                fromcorner!(robot, x, y)
                return
            else
                gotowall!(robot,West)
                if k == 1
                    moven!(robot, Ost, N)
                    k = 0
                else
                    k = 1
                end
            end
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

function square!(robot::Robot, N) # робот делает закращенный квадрат N на N
    k = 0
    for _ in 1:N
        num_steps = movemark!(robot, Ost, N-1)
        if !isborder(robot,Sud)
            move!(robot,Sud)
            k += 1
        end
        moven!(robot, West, num_steps)
    end
    moven!(robot, Nord, k)
end

function movemark!(robot::Robot, side, n) # робот передвигается на n клеток в заданом направлении и ставит маркеры
    putmarker!(robot)
    num_steps = 0
    for _ in 1:n
        if !isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
            num_steps += 1
        end
    end
    return num_steps
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

function fromcorner!(robot, x, y) # возвращает робота в определенные координаты
    tocorner!(robot)
    for _ in 1:x
        move!(robot, Sud)
    end
    for _ in 1:y
        move!(robot, Ost)
    end
end