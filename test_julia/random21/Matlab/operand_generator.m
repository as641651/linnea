function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([1150,1300], Shape.General(), Properties.Random([-1, 1]));
    out{ 2 } = generate([1150,1150], Shape.Symmetric(), Shape.Diagonal(), Shape.LowerTriangular(), Shape.UpperTriangular(), Properties.Random([10, 11]));
    out{ 3 } = generate([1150,150], Shape.General(), Properties.Random([-1, 1]));
    out{ 4 } = generate([150,1150], Shape.General(), Properties.Random([-1, 1]));
    out{ 5 } = generate([150,1], Shape.General(), Properties.Random([-1, 1]));
end