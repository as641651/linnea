function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([1,1], Shape.Diagonal(), Properties.Random([10, 11]));
    out{ 2 } = generate([1700,1700], Shape.LowerTriangular(), Properties.Random([10, 11]));
    out{ 3 } = generate([1700,1700], Shape.Symmetric(), Properties.Random([10, 11]));
    out{ 4 } = generate([1700,1], Shape.General(), Properties.Random([-1, 1]));
    out{ 5 } = generate([100,1], Shape.General(), Properties.Random([-1, 1]));
    out{ 6 } = generate([100,50], Shape.General(), Properties.Random([-1, 1]));
    out{ 7 } = generate([500,50], Shape.General(), Properties.Random([-1, 1]));
end