using MatrixGenerator

function operand_generator()
    M231::Array{Float64,2} = generate((1500,1300), [Shape.General, Properties.Random(-1, 1)])
    M232::Array{Float64,2} = generate((1300,1500), [Shape.General, Properties.Random(-1, 1)])
    M233::Array{Float64,2} = generate((1600,1300), [Shape.General, Properties.Random(-1, 1)])
    M235::Array{Float64,2} = generate((1600,1500), [Shape.General, Properties.Random(-1, 1)])
    M234::Array{Float64,2} = generate((1500,1600), [Shape.General, Properties.Random(-1, 1)])
    M236::Array{Float64,2} = generate((1500,1600), [Shape.General, Properties.Random(-1, 1)])
    return (M231, M232, M233, M235, M234, M236,)
end