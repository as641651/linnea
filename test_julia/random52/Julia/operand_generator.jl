using MatrixGenerator

function operand_generator()
    M288::Diagonal{Float64,Array{Float64,1}} = generate((100,100), [Shape.Symmetric, Shape.Diagonal, Shape.LowerTriangular, Shape.UpperTriangular, Properties.Random(10, 11)])
    M289::Array{Float64,2} = generate((100,1500), [Shape.General, Properties.Random(-1, 1)])
    M292::Array{Float64,2} = generate((200,100), [Shape.General, Properties.Random(-1, 1)])
    M293::Array{Float64,2} = generate((200,1500), [Shape.General, Properties.Random(-1, 1)])
    M290::Array{Float64,2} = generate((1500,100), [Shape.General, Properties.Random(-1, 1)])
    M291::Array{Float64,2} = generate((1500,100), [Shape.General, Properties.Random(-1, 1)])
    M294::Array{Float64,2} = generate((1500,100), [Shape.General, Properties.Random(-1, 1)])
    return (M288, M289, M292, M293, M290, M291, M294,)
end