function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([1800,1800], Shape.Symmetric(), Properties.Random([10, 11]));
    out{ 2 } = generate([300,1800], Shape.General(), Properties.Random([-1, 1]));
    out{ 3 } = generate([1950,300], Shape.General(), Properties.Random([-1, 1]));
    out{ 4 } = generate([1950,200], Shape.General(), Properties.Random([-1, 1]));
    out{ 5 } = generate([200,1950], Shape.General(), Properties.Random([-1, 1]));
end