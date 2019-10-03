using MatrixGenerator

function operand_generator()
    M90::Array{Float64,2} = generate((1000,50), [Shape.General, Properties.Random(-1, 1)])
    M92::LowerTriangular{Float64,Array{Float64,2}} = generate((1000,1000), [Shape.LowerTriangular, Properties.Random(10, 11)])
    M91::Symmetric{Float64,Array{Float64,2}} = generate((1000,1000), [Shape.Symmetric, Properties.SPD])
    M93::Symmetric{Float64,Array{Float64,2}} = generate((1000,1000), [Shape.Symmetric, Properties.Random(10, 11)])
    M94::Array{Float64,2} = generate((50,1000), [Shape.General, Properties.Random(-1, 1)])
    return (M90, M92, M91, M93, M94,)
end