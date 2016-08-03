# permutat.gi
#
# pure GAP implementation of permutation functions
#
# Permutations are stored as plain list

InstallGlobalFunction(PermutationConsNC,
                     function(img)
                         return Objectify(PermPlistType, [ img ]);
                     end);

InstallGlobalFunction(PermutationCons,
    function(img)
        return Objectify(PermPlistType, [ img ]);
    end);

InstallMethod(
    LargestMovedPoint,
    "for permutations in plist rep",
    [ IsPerm and IsPermPlistRep ],
    function(p)
        local i, max;

        max := Length(p![1]);

        for i in [max,max-1..1] do
            if p![1][max] <> i then
                return i;
            fi;
        od;
    end);

InstallMethod(
    \=,
    "for permutations in plist rep",
    [ IsPerm and IsPermPlistRep, IsPerm and IsPermPlistRep ],
    function(p,q)
        local i, ploc, qloc, pl, ql;

        ploc := p![1];
        pl := Length(ploc);

        qloc := q![1];
        ql := Length(qloc);

        for i in [1..Minimum(pl,ql)] do
            if ploc[i] <> qloc[i] then
                return false;
            fi;
        od;
        for i in [pl+1..ql] do
            if qloc[i] <> i then
                return false;
            fi;
        od;
        for i in [ql+1..pl] do
            if ploc[i] <> i then
                return false;
            fi;
        od;
        return true;
    end);

InstallMethod(
    \*,
    "for permutations in plist rep",
    [ IsPerm and IsPermPlistRep, IsPerm and IsPermPlistRep ],
    function(p,q)
        local i, degree, res, pl, ql, ploc, qloc;

        ploc := p![1];
        pl := Length(ploc);

        qloc := q![1];
        ql := Length(qloc);

        if pl < ql then
            for i in [pl + 1..ql] do
                ploc[i] := i;
            od;
            degree := ql;
        else
            for i in [ql + 1..pl] do
                qloc[i] := i;
            od;
            degree := pl;
        fi;

        res := ListWithIdenticalEntries(degree, -1);
        for i in [1..degree] do
            res[i] := qloc[ploc[i]];
        od;

        return PermutationCons(res);
    end);


InstallMethod(
    \^,
    "for a permutation in plist rep, and an integer",
    [ IsPerm and IsPermPlistRep, IsInt ],
    function(p,e)
        local i, j, degree, res, ploc;

        ploc := p![1];
        degree := Length(ploc);
        res := ListWithIdenticalEntries(degree, -1);

        if e = 0 then
            return PermutationCons([]);
        fi;

        for i in [1..degree] do
            res[i] := i;
            for j in [1..e] do
                res[i] := p[res[i]];
            od;
        od;
        return PermutationCons(res);
    end);

InstallMethod(
    \^,
    "for a positive integer, and a permutation in plist rep",
    [ IsPosInt, IsPerm and IsPermPlistRep ],
    function(e, p)
        if e <= Length(p![1]) then
            return p![1][e];
        else
            return e;
        fi;
    end);

# Pull out cycle computations
InstallMethod(
    Order,
    "for a permutation in plist rep",
    [ IsPerm and IsPermPlistRep ],
    function(p)
        local pt, cycnum, cycnums, cyclens;

        cycnums := ListWithIdenticalEntries(LargestMovedPoint(p), -1);
        cyclens := [];

        pt := 1;
        cycnum := 0;
        cyclens[1] := 0;
        repeat
            cycnum := cycnum + 1;
            cyclens[cycnum] := 0;
            repeat
                cycnums[pt] := cycnum;
                cyclens[cycnum] := cyclens[cycnum] + 1;
                pt := p![1][pt];
            until cycnums[pt] <> -1;
            pt := PositionProperty(cycnums, x -> x = -1);
        until pt = fail;

        return Lcm(cyclens);
    end);

#BindGlobal("IdentityPerm", )
