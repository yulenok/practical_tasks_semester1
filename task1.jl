using HorizonSideRobots
#include("librob.jl")

function cross!(robot) 
    for side in (Nord, Ost, Sud, West)
        num_steps = mark_direct!(robot, side)
        side = HorizonSide((Int(side) + 2) % 4)
        robot_move!(robot, side, num_steps) 
    end
end

function mark_direct!(robot, side)
    n = 0
    while isborder(robot, side) == false 
        move!(robot, side)
        putmarker!(robot)
        n += 1
    end
    return n
end

function robot_move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

