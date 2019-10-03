function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([400,400], Shape.LowerTriangular(), Properties.Random([10, 11]));
    out{ 2 } = generate([400,400], Shape.UpperTriangular(), Properties.Random([10, 11]));
    out{ 3 } = generate([400,400], Shape.Symmetric(), Properties.SPD());
    out{ 4 } = generate([150,400], Shape.General(), Properties.Random([-1, 1]));
    out{ 5 } = generate([150,150], Shape.UpperTriangular(), Properties.Random([10, 11]));
    out{ 6 } = generate([150,50], Shape.General(), Properties.Random([-1, 1]));
    out{ 7 } = generate([50,1300], Shape.General(), Properties.Random([-1, 1]));
end