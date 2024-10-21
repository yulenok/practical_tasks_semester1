using HorizonSideRobots

function towallandback!(robot::Robot, side) # робот идет до стенки, ставит маркет у стены и идет обратно рекурсивным способом в заданном направлении
    if !isborder(robot, side)
        move!(robot, side)
        towallandback!(robot, side)
        move!(robot, inverse(side))
    else
        putmarker!(robot)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
