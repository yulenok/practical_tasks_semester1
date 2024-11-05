using HorizonSideRobots

function doublemove!(robot::Robot, side) # робот вдвое увеличивает расстояние от стенки с заданного направления
    x = true

    if !isborder(robot, side)
        move!(robot, side)
        doublemove!(robot, side)
        if !isborder(robot, inverse(side))
            move!(robot, inverse(side))
        end

        if !isborder(robot, inverse(side))
            move!(robot, inverse(side))
        else
            x = false
        end

    end

    return x
end

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
