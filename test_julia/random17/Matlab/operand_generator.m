function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([1000,50], Shape.General(), Properties.Random([-1, 1]));
    out{ 2 } = generate([1000,1000], Shape.LowerTriangular(), Properties.Random([10, 11]));
    out{ 3 } = generate([1000,1000], Shape.Symmetric(), Properties.SPD());
    out{ 4 } = generate([1000,1000], Shape.Symmetric(), Properties.Random([10, 11]));
    out{ 5 } = generate([50,1000], Shape.General(), Properties.Random([-1, 1]));
end