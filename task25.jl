using HorizonSideRobots

function towallchessmark!(robot::Robot, side, f) # робот идет до упора в заданную сторону, расставляя маркеры в шахматном порядке
    if !isborder(robot, side)
        if f == 1 
            putmarker!(robot)
            move!(robot, side)
            f = 0
            towallchessmark!(robot, side, f)
        else
            move!(robot, side)
            putmarker!(robot)
            f = 1
            towallchessmark!(robot, side, f)
        end
    else
        return f
    end
end

# 1 если начинать с маркера
# 0 если на первой клетки не отмечать маркер