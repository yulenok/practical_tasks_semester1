using HorizonSideRobots

function seek_passage!(robot) # робот ищет проход 
    while !isborder(robot, Nord)
        move!(robot, Nord)
    end
    num_steps = 1
    side = West
    while isborder(robot, Nord)
        for _ in 1:num_steps
            move!(robot, side)
        end
        side = HorizonSide((Int(side) + 2) % 4)
        num_steps += 1
    end
end