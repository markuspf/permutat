#
# permutat: Basic implementation of permutations in pure GAP
#
# Reading the declaration part of the package.
#
_PATH_SO:=Filename(DirectoriesPackagePrograms("permutat"), "permutat.so");
if _PATH_SO <> fail then
    LoadDynamicModule(_PATH_SO);
fi;
Unbind(_PATH_SO);

ReadPackage( "permutat", "gap/permutat.gd");
