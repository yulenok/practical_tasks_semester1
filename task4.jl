using HorizonSideRobots

function diagonal_cross!(robot) 
    for side in (Nord, West, Sud, Ost)
        side_new = HorizonSide((Int(side) + 1) % 4)
        num_steps = mark_direct!(robot, side, side_new)
        side = HorizonSide((Int(side) + 2) % 4)
        robot_move!(robot, side, num_steps) 
    end
    putmarker!(robot)
end

function mark_direct!(robot, side, side_new)
    n = 0
    while isborder(robot, side) == false && isborder(robot, side_new) == false
        move!(robot, side) 
        move!(robot, side_new)
        putmarker!(robot)
        n += 1
    end
    return n
end

function robot_move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
        side_new = HorizonSide((Int(side) + 1) % 4) 
        move!(robot, side_new)
    end
end