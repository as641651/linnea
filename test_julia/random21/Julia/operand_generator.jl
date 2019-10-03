using MatrixGenerator

function operand_generator()
    M109::Array{Float64,2} = generate((1150,1300), [Shape.General, Properties.Random(-1, 1)])
    M110::Diagonal{Float64,Array{Float64,1}} = generate((1150,1150), [Shape.Symmetric, Shape.Diagonal, Shape.LowerTriangular, Shape.UpperTriangular, Properties.Random(10, 11)])
    M111::Array{Float64,2} = generate((1150,150), [Shape.General, Properties.Random(-1, 1)])
    M112::Array{Float64,2} = generate((150,1150), [Shape.General, Properties.Random(-1, 1)])
    v113::Array{Float64,1} = generate((150,1), [Shape.General, Properties.Random(-1, 1)])
    return (M109, M110, M111, M112, v113,)
end