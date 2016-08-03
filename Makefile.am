#
# permutat: Basic implementation of permutations in pure GAP
#
# This file is part of the build system of a GAP kernel extension.
# Requires automake.
#
ACLOCAL_AMFLAGS = -I m4

BINARCHDIR = bin/$(GAPARCH)
GAPINSTALLLIB = $(BINARCHDIR)/permutat.so

lib_LTLIBRARIES = permutat.la

permutat_la_SOURCES = src/permutat.cc
permutat_la_CPPFLAGS = $(GAP_CPPFLAGS) -DCONFIG_H
permutat_la_LDFLAGS = -module -avoid-version
if SYS_IS_CYGWIN
permutat_la_LDFLAGS += -no-undefined -version-info 0:0:0 
permutat_la_LDFLAGS += -Wl,$(GAPROOT)/bin/$(GAPARCH)/gap.dll
endif

all-local: $(GAPINSTALLLIB)

$(GAPINSTALLLIB): permutat.la
	$(mkdir_p) $(BINARCHDIR)
if SYS_IS_CYGWIN
	cp .libs/permutat.dll $(GAPINSTALLLIB)
else
	cp .libs/permutat.so $(GAPINSTALLLIB)
endif

clean-local:
	rm -f $(GAPINSTALLLIB)

distclean-local:
	rm -rf bin/*

doc:
	($(GAPROOT)/bin/gap.sh -A makedoc.g)
