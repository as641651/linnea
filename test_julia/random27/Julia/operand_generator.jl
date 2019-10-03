using MatrixGenerator

function operand_generator()
    s144::Float64 = generate((1,1), [Shape.Diagonal, Properties.Random(10, 11)])
    M141::LowerTriangular{Float64,Array{Float64,2}} = generate((1700,1700), [Shape.LowerTriangular, Properties.Random(10, 11)])
    M142::Symmetric{Float64,Array{Float64,2}} = generate((1700,1700), [Shape.Symmetric, Properties.Random(10, 11)])
    v143::Array{Float64,1} = generate((1700,1), [Shape.General, Properties.Random(-1, 1)])
    v145::Array{Float64,1} = generate((100,1), [Shape.General, Properties.Random(-1, 1)])
    M146::Array{Float64,2} = generate((100,50), [Shape.General, Properties.Random(-1, 1)])
    M147::Array{Float64,2} = generate((500,50), [Shape.General, Properties.Random(-1, 1)])
    return (s144, M141, M142, v143, v145, M146, M147,)
end