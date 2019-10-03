using MatrixGenerator

function operand_generator()
    M237::LowerTriangular{Float64,Array{Float64,2}} = generate((400,400), [Shape.LowerTriangular, Properties.Random(10, 11)])
    M238::UpperTriangular{Float64,Array{Float64,2}} = generate((400,400), [Shape.UpperTriangular, Properties.Random(10, 11)])
    M239::Symmetric{Float64,Array{Float64,2}} = generate((400,400), [Shape.Symmetric, Properties.SPD])
    M240::Array{Float64,2} = generate((150,400), [Shape.General, Properties.Random(-1, 1)])
    M241::UpperTriangular{Float64,Array{Float64,2}} = generate((150,150), [Shape.UpperTriangular, Properties.Random(10, 11)])
    M242::Array{Float64,2} = generate((150,50), [Shape.General, Properties.Random(-1, 1)])
    M243::Array{Float64,2} = generate((50,1300), [Shape.General, Properties.Random(-1, 1)])
    return (M237, M238, M239, M240, M241, M242, M243,)
end