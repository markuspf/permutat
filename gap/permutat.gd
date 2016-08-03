#
# permutat: Basic implementation of permutations in pure GAP
#
# Declarations
#
# DeclareConstructor with filter?
DeclareGlobalFunction("PermutationCons");
DeclareGlobalFunction("PermutationConsNC");

DeclareRepresentation( "IsPermPlistRep", IsPerm and IsPositionalObjectRep, [] );
BindGlobal( "PermPlistType",
            NewType(PermutationsFamily, IsPerm and IsPermPlistRep));
