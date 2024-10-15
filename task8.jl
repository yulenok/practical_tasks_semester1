using HorizonSideRobots

function seek_mark!(robot) 
    n = 1
    while !ismarker(robot)
        for side in (Nord, Sud)
            move_spiral!(robot, side, n)
            side = HorizonSide((Int(side) + 1) % 4)
            move_spiral!(robot, side, n)
            n += 1
        end
    end
end

function move_spiral!(robot, side, n) # передвижение робота по спирали
    for _ in 1:n
        if !ismarker(robot)
            move!(robot, side)
        end
    end
end