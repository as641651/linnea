using MatrixGenerator

function operand_generator()
    M278::Symmetric{Float64,Array{Float64,2}} = generate((1800,1800), [Shape.Symmetric, Properties.Random(10, 11)])
    M279::Array{Float64,2} = generate((300,1800), [Shape.General, Properties.Random(-1, 1)])
    M280::Array{Float64,2} = generate((1950,300), [Shape.General, Properties.Random(-1, 1)])
    M281::Array{Float64,2} = generate((1950,200), [Shape.General, Properties.Random(-1, 1)])
    M282::Array{Float64,2} = generate((200,1950), [Shape.General, Properties.Random(-1, 1)])
    return (M278, M279, M280, M281, M282,)
end