function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([1600,1600], Shape.LowerTriangular(), Properties.Random([10, 11]));
    out{ 2 } = generate([400,1600], Shape.General(), Properties.Random([-1, 1]));
    out{ 3 } = generate([1600,1600], Shape.Symmetric(), Properties.SPD());
    out{ 4 } = generate([400,1600], Shape.General(), Properties.Random([-1, 1]));
    out{ 5 } = generate([400,1600], Shape.General(), Properties.Random([-1, 1]));
end