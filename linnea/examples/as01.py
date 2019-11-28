from ..algebra.expression import Symbol, Scalar, Vector, Matrix, ConstantScalar, \
                                 Equal, Plus, Times, Transpose, Inverse, \
                                 InverseTranspose, InverseConjugate, \
                                 InverseConjugateTranspose, \
                                 ConjugateTranspose, Index, IdentityMatrix

from ..algebra.properties import Property as properties

from ..algebra.equations import Equations

from .. import derivation

class Example01():
    def __init__(self):


        n = 2500
        m = 2500
        k = 500

        X = Matrix("X", (n, m))
        X.set_property(properties.FULL_RANK)

        Y = Matrix("Y", (m, k))

        Z = Matrix("Z", (n, k))

        # Z = XY
        self.eqns = Equations(Equal(Z, Times(X,Y)))


class Example02():
    def __init__(self):


        n = 500
        m = 480

        X = Matrix("X", (n, m))
        X.set_property(properties.FULL_RANK)

        Y = Matrix("Y", (m, n))

        Z = Matrix("Z", (n, m))

        # Z = XY
        self.eqns = Equations(Equal(Z, Times(X,Y,X)))

class Example02I():
    def __init__(self):


        n = 1000
        m = 10
        k = 1000

        A = Matrix("A", (n, m))
        A.set_property(properties.FULL_RANK)

        B = Matrix("B", (m, k))

        C = Matrix("C", (k, k))
        C.set_property(properties.SPD)

        Z = Matrix("Z", (n, k))

        # Z = XY
        self.eqns = Equations(Equal(Z, Times(A,B,Inverse(C))))


class Example03():
    def __init__(self):

        # least squares

        n = 2000
        m = 500

        X = Matrix("X", (n, m))
        X.set_property(properties.FULL_RANK)

        y = Vector("y", (n, 1))

        b = Vector("b", (m, 1))

        # b = (X^T X)^-1 X^T y
        self.eqns = Equations(Equal(b, Times(Inverse(Times(Transpose(X), X)), Transpose(X), y)))


class Example04():
    def __init__(self):

        # generalized least squares

        n = 2500
        m = 500

        S = Matrix("S", (n, n))
        S.set_property(properties.SPD)

        X = Matrix("X", (n, m))
        X.set_property(properties.FULL_RANK)

        z = Vector("z", (m, 1))

        y = Vector("y", (n, 1))

        self.eqns = Equations(Equal(z, Times(Inverse(Times(Transpose(X), Inverse(S), X ) ), Transpose(X), Inverse(S), y)))


class Example05():
    def __init__(self):


        n = 200
        m = 200
        k = 1

        A = Matrix("A", (n, m))
        A.set_property(properties.FULL_RANK)

        B = Matrix("B", (m, n))
        C = Matrix("C", (m, k))

        Z = Matrix("Z", (n, k))

        # Z = XY
        self.eqns = Equations(Equal(Z, Times(A,B,A,C)))
