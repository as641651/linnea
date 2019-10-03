function [out] = operand_generator()
    import MatrixGenerator.*;
    out{ 1 } = generate([1500,1300], Shape.General(), Properties.Random([-1, 1]));
    out{ 2 } = generate([1300,1500], Shape.General(), Properties.Random([-1, 1]));
    out{ 3 } = generate([1600,1300], Shape.General(), Properties.Random([-1, 1]));
    out{ 4 } = generate([1600,1500], Shape.General(), Properties.Random([-1, 1]));
    out{ 5 } = generate([1500,1600], Shape.General(), Properties.Random([-1, 1]));
    out{ 6 } = generate([1500,1600], Shape.General(), Properties.Random([-1, 1]));
end