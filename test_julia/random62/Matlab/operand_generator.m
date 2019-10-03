function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([1650,1650], Shape.Symmetric(), Properties.SPD());
    out{ 2 } = generate([1650,1700], Shape.General(), Properties.Random([-1, 1]));
    out{ 3 } = generate([1700,1650], Shape.General(), Properties.Random([-1, 1]));
    out{ 4 } = generate([1650,1650], Shape.UpperTriangular(), Properties.Random([10, 11]));
end