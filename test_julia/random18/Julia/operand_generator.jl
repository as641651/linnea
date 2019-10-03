using MatrixGenerator

function operand_generator()
    M99::Symmetric{Float64,Array{Float64,2}} = generate((100,100), [Shape.Symmetric, Properties.SPD])
    M96::UpperTriangular{Float64,Array{Float64,2}} = generate((100,100), [Shape.UpperTriangular, Properties.Random(10, 11)])
    M95::LowerTriangular{Float64,Array{Float64,2}} = generate((100,100), [Shape.LowerTriangular, Properties.Random(10, 11)])
    M97::Array{Float64,2} = generate((100,250), [Shape.General, Properties.Random(-1, 1)])
    M98::Array{Float64,2} = generate((250,100), [Shape.General, Properties.Random(-1, 1)])
    return (M99, M96, M95, M97, M98,)
end