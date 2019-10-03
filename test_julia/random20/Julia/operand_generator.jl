using MatrixGenerator

function operand_generator()
    M105::LowerTriangular{Float64,Array{Float64,2}} = generate((1600,1600), [Shape.LowerTriangular, Properties.Random(10, 11)])
    M106::Array{Float64,2} = generate((400,1600), [Shape.General, Properties.Random(-1, 1)])
    M107::Symmetric{Float64,Array{Float64,2}} = generate((1600,1600), [Shape.Symmetric, Properties.SPD])
    M108::Array{Float64,2} = generate((400,1600), [Shape.General, Properties.Random(-1, 1)])
    M104::Array{Float64,2} = generate((400,1600), [Shape.General, Properties.Random(-1, 1)])
    return (M105, M106, M107, M108, M104,)
end