using Memoize

function fibonacciA(n)
    a = 1
    b = 1
    c = 0
    if n == 0
        return 0
    elseif n == 1 || n == 2
        return 1
    else
        for _ in 1:(n-2)
            c = a + b
            a = b
            b = c
        end
    end
    return b
end

function fibonacciB(n)
    if n == 0
        return 0
    elseif n == 1 || n == 2
        return 1
    else
        return fibonacciB(n-1) + fibonacciB(n-2)
    end
end

@memoize function fibonacciC(n)
    if n == 0
        return 0
    elseif n == 1 || n == 2
        return 1
    else
        return fibonacciC(n-1) + fibonacciC(n-2)
    end
end

println(fibonacciA(50))
println(fibonacciA(50))
println(fibonacciA(50))