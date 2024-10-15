using HorizonSideRobots

function seekpassage!(robot::Robot) # робот ищет проход в перегородке и останавливается под ним
    shuttle!(isborder, robot, Ost)
end

function shuttle!(stop_condition::Function, robot, start_side)
    s = start_side
    n = 1
    while stop_condition(robot, Nord)
        moves!(robot, s, n)
        s = inverse(s)
        n += 1
    end
end

function moves!(robot, side, n)
    for _ in 1:n
        move!(robot, side)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)