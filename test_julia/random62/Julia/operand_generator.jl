using MatrixGenerator

function operand_generator()
    M345::Symmetric{Float64,Array{Float64,2}} = generate((1650,1650), [Shape.Symmetric, Properties.SPD])
    M343::Array{Float64,2} = generate((1650,1700), [Shape.General, Properties.Random(-1, 1)])
    M344::Array{Float64,2} = generate((1700,1650), [Shape.General, Properties.Random(-1, 1)])
    M342::UpperTriangular{Float64,Array{Float64,2}} = generate((1650,1650), [Shape.UpperTriangular, Properties.Random(10, 11)])
    return (M345, M343, M344, M342,)
end