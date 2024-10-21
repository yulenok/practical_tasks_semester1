using HorizonSideRobots

function towall!(robot::Robot, side) # робот идет до стенки рекурсивным способом в заданном направлении
    if !isborder(robot, side)
        move!(robot, side)
        towall!(robot, side)
    end
end