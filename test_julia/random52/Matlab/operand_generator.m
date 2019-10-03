function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([100,100], Shape.Symmetric(), Shape.Diagonal(), Shape.LowerTriangular(), Shape.UpperTriangular(), Properties.Random([10, 11]));
    out{ 2 } = generate([100,1500], Shape.General(), Properties.Random([-1, 1]));
    out{ 3 } = generate([200,100], Shape.General(), Properties.Random([-1, 1]));
    out{ 4 } = generate([200,1500], Shape.General(), Properties.Random([-1, 1]));
    out{ 5 } = generate([1500,100], Shape.General(), Properties.Random([-1, 1]));
    out{ 6 } = generate([1500,100], Shape.General(), Properties.Random([-1, 1]));
    out{ 7 } = generate([1500,100], Shape.General(), Properties.Random([-1, 1]));
end