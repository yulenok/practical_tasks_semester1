using HorizonSideRobots

sides = [Nord, Ost, Sud, West, Nord, Ost]

function halfmirrorwall!(robot::Robot, side) # робот перемещается через стенку на расстояние, в 2 раза меньшее исходного
    if !isborder(robot, side)
        move!(robot, side)
        if !isborder(robot, side)
            move!(robot,side)
        end
        halfmirrorwall!(robot, side)
        move!(robot, side)
    else
        onemove!(robot,side)
    end
end

function onemove!(robot::Robot, side) # робот идет на соседнюю клетку в заданном направлении через стенку
    x = 2
    while sides[x] != side
        x += 1
    end
    if isborder(robot, side)
        move!(robot, sides[x+1])
        onemove!(robot, side)
        move!(robot, sides[x-1])
    else
        move!(robot, side)
    end
end