using HorizonSideRobots

function seekmarker!(robot::Robot) # робот двигается по спирали и останавливается в клетке с маркером
    spiral!(ismarker, robot)
end

function spiral!(stop_condition::Function, robot::Robot) # робот двигается по спирали
    side = [Ost, Sud, West, Nord]
    s = 1
    n = 1
    while !stop_condition(robot)
        if moves!(stop_condition, robot, side[s], n)
            return
        end
        s = (s + 1) % 5 + (div(s + 1,5))
        if s % 2 == 1
            n = n + 1
        end
    end
end

function moves!(stop_condition::Function, robot::Robot, side, n) # робот проходит в определеную сторону определенное количество клеток
    for _ in 1:n
        move!(robot, side)
        if stop_condition(robot)
            return true
        end
    end
    return false
end