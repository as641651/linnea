function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([100,100], Shape.Symmetric(), Properties.SPD());
    out{ 2 } = generate([100,100], Shape.UpperTriangular(), Properties.Random([10, 11]));
    out{ 3 } = generate([100,100], Shape.LowerTriangular(), Properties.Random([10, 11]));
    out{ 4 } = generate([100,250], Shape.General(), Properties.Random([-1, 1]));
    out{ 5 } = generate([250,100], Shape.General(), Properties.Random([-1, 1]));
end