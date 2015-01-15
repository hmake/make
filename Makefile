#!/usr/bin/make -f
# All-in-One Makefile

########################################################################
# Copyright 2014 RCF                                                   #
#                                                                      #
# Licensed under the Apache License, Version 2.0 (the "License");      #
# you may not use this file except in compliance with the License.     #
# You may obtain a copy of the License at                              #
#                                                                      #
#     http://www.apache.org/licenses/LICENSE-2.0                       #
#                                                                      #
# Unless required by applicable law or agreed to in writing, software  #
# distributed under the License is distributed on an "AS IS" BASIS,    #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or      #
# implied.                                                             #
# See the License for the specific language governing permissions and  #
# limitations under the License.                                       #
########################################################################

# Default target
all:

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                          USER DEFINITIONS                            #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

########################################################################
##                             PROGRAM                                ##
########################################################################

# Project setting
PROJECT         := Default
VERSION         := 1.0.0

# Package info
AUXFILES        :=
MAINTEINER_NAME := Your Name
MAINTEINER_MAIL := your_mail@mail.com
COPYRIGHT       := $(MAINTEINER_NAME)
SYNOPSIS        := default short synopsis
DESCRIPTION     := default long description

# Debian package
DEB_VERSION     := 1
DEB_PROJECT     := Default
DEB_PRIORITY    := optional

# Program settings
BIN             :=
SBIN            :=
LIBEXEC         :=
TESTBIN         :=
ARLIB           :=
SHRLIB          :=

# Documentation settings
LICENSE         := LICENSE
NOTICE          := NOTICE
CONTRIBUTORS    := CONTRIBUTORS
DOXYFILE        := Doxyfile

# Dependencies
GIT_DEPENDENCY  :=
WEB_DEPENDENCY  :=

########################################################################
##                              FLAGS                                 ##
########################################################################

# Preprocessor options
CPPFLAGS   :=

# Assembly/C/C++/Fortran options
ASFLAGS    := -f elf32
CFLAGS     :=
CXXFLAGS   := -std=c++11
FFLAGS     := -cpp

# Coverage options
CPPCOV     :=
CCOV       := --coverage
FCOV       :=
CXXCOV     := --coverage
LDCOV      := --coverage

# Linker options
LDFLAGS    :=
LDC        :=
LDF        := -lgfortran
LDCXX      :=
LDLEX      := -lfl
LDYACC     :=
LDESQL     := -lecpg

# Library options
ARFLAGS    := -rcv
SOFLAGS    := -shared

# Assembly/C/C++/Fortran paths for include dirs
ASLIBS     :=
CLIBS      :=
CXXLIBS    :=
FLIBS      :=

# Linker paths for library dirs
LDLIBS     :=

########################################################################
##                            DIRECTORIES                             ##
########################################################################

# Local directories
ifndef SINGLE_DIR
SRCDIR    := src
DEPDIR    := dep
INCDIR    := include
DOCDIR    := doc
DEBDIR    := debian
OBJDIR    := build
COVDIR    := cov
LIBDIR    := lib
EXTDIR    := external
SRPDIR    := script
BINDIR    := bin
SBINDIR   := sbin
EXECDIR   := libexec
DISTDIR   := dist
CONFDIR   := conf
TESTDIR   := test
DATADIR   := data
MAKEDIR   := make
DESTDIR   :=
LOCALEDIR := locale
else
$(foreach var,\
    SRCDIR DEPDIR INCDIR OBJDIR COVDIR LIBDIR EXTDIR SRPDIR \
    BINDIR SBINDIR DISTDIR CONFDIR TESTDIR DATADIR MAKEDIR LOCALEDIR,\
    $(eval $(var) := .)\
)
endif

# System directories
SYSINCDIR  := /include /usr/include /usr/local/include
SYSLIBDIR  := /lib     /usr/lib     /usr/local/lib      \
              /lib32   /usr/lib32   /usr/local/lib32    \
              /lib64   /usr/lib64   /usr/local/lib64
SYSBINDIR  := /bin     /usr/bin     /usr/local/bin
SYSSBINDIR := /sbin    /usr/sbin    /usr/local/sbin
SYSEXECDIR := /libexec /usr/libexec /usr/local/libexec

# Include configuration file if exists
-include .version.mk
-include .config.mk config.mk Config.mk

## INSTALLATION ########################################################

### PREFIXES
# * prefix:        Default prefix for variables below
# * exec_prefix:   Prefix for machine-specific files (bins and libs)
prefix         := /usr/local
exec_prefix    := $(prefix)

### EXECUTABLES AND LIBRARIES
# * bindir:        Programs that user can run
# * sbindir:       Runnable by shell, useful by sysadmins
# * libexecdir:    Executables for being run only by other programs
# * libdir         Object and libraries of object code
install_dirs   := bindir sbindir libexecdir libdir
bindir         := $(exec_prefix)/bin
sbindir        := $(exec_prefix)/sbin
libexecdir     := $(exec_prefix)/libexec
libdir         := $(exec_prefix)/lib

### DATA PREFIXES
# * datarootdir:   Read-only machine-independent files (docs and data)
# * datadir:       Read-only machine-independent files (data, no docs)
# * sysconfdir:    Read-only single-machine files (as server configs)
# * localstatedir: Exec-modifiable single-machine single-exec files
# * runstatedir:   Exec-modifiable single-machine run-persistent files
install_dirs   += datarootdir datadir sysconfdir
install_dirs   += sharedstatedir localstatedir runstatedir
datarootdir    := $(prefix)/share
datadir        := $(datarootdir)
sysconfdir     := $(prefix)/etc
sharedstatedir := $(prefix)/com
localstatedir  := $(prefix)/var
runstatedir    := $(localstatedir)/run

### HEADER FILES
# * includedir:    Includable (header) files for use by GCC
# * oldincludedir: Includable (header) files for GCC and othe compilers
install_dirs   += includedir oldincludedir
includedir     := $(prefix)/include
oldincludedir  := /usr/include

### DOCUMENTATION FILES
# * infodir:       Doc directory for info files
# * docdir:        Doc directory for files other than info
# * htmldir:       Doc directory for HTML files (with subdir for locale)
# * dvidir:        Doc directory for DVI files (with subdir for locale)
# * pdfdir:        Doc directory for PDF files (with subdir for locale)
# * psdir:         Doc directory for PS files (with subdir for locale)
install_dirs   += docdir infodir htmldir dvidir pdfdir psdir
docdir         := $(datarootdir)/doc/$(PROJECT)/$(VERSION)
infodir        := $(datarootdir)/info
htmldir        := $(docdir)
dvidir         := $(docdir)
pdfdir         := $(docdir)
psdir          := $(docdir)

### MAN FILES
# * mandir:       Manual main directory
# * manXdir:      Manual section X (X from 1 to 7)
install_dirs   += mandir man1dir man2dir man3dir
install_dirs   += man4dir man5dir man6dir man7dir
mandir         := $(datarootdir)/man
man1dir        := $(mandir)/man1
man2dir        := $(mandir)/man2
man3dir        := $(mandir)/man3
man4dir        := $(mandir)/man4
man5dir        := $(mandir)/man5
man6dir        := $(mandir)/man6
man7dir        := $(mandir)/man7

### OTHERS
# * lispdir:      Emacs Lisp files in this package
# * localedir:    Locale-specific message catalogs for the package
install_dirs   += lispdir localedir
lispdir        := $(datarootdir)/emacs/site-lisp
localedir      := $(datarootdir)/locale

########################################################################
##                            EXTENSIONS                              ##
########################################################################

# Assembly extensions
ASMEXT  := .asm .S

# Header extensions
HEXT    := .h
HFEXT   := .mod .MOD
HXXEXT  := .H .hh .hpp .HPP .hxx .h++ .ih

# Source extensions
CEXT    := .c
FEXT    := .f .FOR .for .f77 .f90 .f95 .F .fpp .FPP
CXXEXT  := .C .cc .cpp .CPP .cxx .c++
TLEXT   := .tcc .icc

# Library extensions
LIBEXT  := .a .so .dll

# Parser/Lexer extensions
LEXEXT  := .l
LEXXEXT := .ll .lpp
YACCEXT := .y
YAXXEXT := .yy .ypp

# Embedded SQL extensions
ESQLEXT := .pgc .pc

# Dependence extensions
DEPEXT  := .d
EXTEXT  := .dy
SYSEXT  := .dep

# Coverage extensions
COVEXT  := .gcov

# Binary extensions
OBJEXT  := .o
BINEXT  :=

# Documentation extensions
TEXIEXT := .texi
INFOEXT := .info
HTMLEXT := .html
DVIEXT  := .dvi
PDFEXT  := .pdf
PSEXT   := .ps

# Script extensions
SRPEXT  := .ahk .applescript .bat .bash .cmd .coffee .erb .hta \
           .itcl .js .lua .m .php .pl .pm .py .pyc .pyo .r .rb \
           .scpt .scptd .sh .tcl .vbs

# Data extensions
DATAEXT := .asc .bak .bin .bk .cfg .conf .cnf .css .csv .dat \
           .diff .dsk .htm .html .json .log .ltsv .raw .sql \
           .temp .tmp .tsv .txt .xml .yaml .yml

# I18n extensions
POTEXT  := .pot
POEXT   := .po
MOEXT   := .mo

# Test suffix
TESTSUF := Test

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                           OS DEFINITIONS                             #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

########################################################################
##                             PROGRAMS                               ##
########################################################################

# Compilation
AR              := ar
AS              := nasm
CC              := gcc
FC              := gfortran
CXX             := g++
RANLIB          := ranlib

# Include configuration file for compiler if exists
-include .compiler.mk compiler.mk Compiler.mk

# Installation
INSTALL         := install
INSTALL_DATA    := $(INSTALL)
INSTALL_PROGRAM := $(INSTALL) -m 644

# File manipulation
CP              := cp -rap
MV              := mv
RM              := rm -f
TAR             := tar -cvf
ZIP             := zip
GZIP            := gzip
BZIP2           := bzip2
MKDIR           := mkdir -p
RMDIR           := rm -rf
FIND            := find
FINDFLAGS       := -type d -print 2> /dev/null

# Parser and Lexer
LEX             := flex
LEXCXX          := flexc++
LEXLIBS         :=
LEXFLAGS        :=
YACC            := bison
YACCCXX         := bisonc++
YACCLIBS        :=
YACCFLAGS       :=

# Coverage
COV             := gcov
COVFLAGS        := -abc

# Embedded SQL
ESQL            := ecpg
ESQLLIBS        := $(if $(strip $(shell which pg_config)),\
                       $(shell pg_config --includedir))
ESQLFLAGS       :=

# Tags
CTAGS           := ctags
CTAGSFLAGS      :=
ETAGS           := etags
ETAGSFLAGS      :=

# Documentation
DOXYGEN         := doxygen
MAKEINFO        := makeinfo
INSTALL_INFO    := install-info
TEXI2HTML       := makeinfo --no-split --html
TEXI2DVI        := texi2dvi
TEXI2PDF        := texi2pdf
TEXI2PS         := texi2dvi --ps

# Native Language Support
XGETTEXT        := xgettext
MSGINIT         := msginit --no-translator
MSGMERGE        := msgmerge
MSGFMT          := msgfmt -c
NLSREQINC       := libintl.h

# Packages (Debian)
DEBUILD         := debuild -us -uc
DCH             := dch --create -v $(VERSION)-$(DEB_VERSION) \
                       --package $(DEB_PROJECT)

# Remote
CURL            := curl -o
GIT             := git

# Make
MAKEFLAGS       := --no-print-directory
MAKE            += -f $(firstword $(MAKEFILE_LIST)) $(MAKEFLAGS)

# Include configuration file for programs if exists
-include .config_os.mk config_os.mk Config_os.mk

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                        DEVELOPER DEFINITIONS                         #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

########################################################################
##                  MAKEFILE BASIC CONFIGURATIONS                     ##
########################################################################

# Remote path
MAKERAWREMOTE := \
    https://raw.githubusercontent.com/renatocf/make/master/Makefile

# Git remote path
MAKEGITREMOTE := \
    git@github.com:renatocf/make.git

# Make current directory
MAKECURRENTDIR := \
    $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

# Define the shell to be used
SHELL = /bin/sh

########################################################################
##                         USEFUL DEFINITIONS                         ##
########################################################################

comma := ,
empty :=
space := $(empty) $(empty)
tab   := $(empty)	$(empty)
define quote
"
endef
define newline


endef
lparentheses := (
rparentheses := )

########################################################################
##                             FUNCTIONS                              ##
########################################################################

# Basic variable functions
# ==========================
# 1) is-empty:  Returns not empty if a variable is empty
# 2) not-empty: Returns not empty if a variable is not empty

define is-empty
$(strip $(if $(strip $1),,1))
endef

define not-empty
$(strip $(if $(strip $1),1))
endef

# Logic functions
# =================
# 1) not: Returns empty if arg is not empty, and not empty otherwise
# 2) eq:  Returns not empty if $1 == $2, and empty otherwise
# 3) ne:  Returns not empty if $1 != $2, and empty otherwise
define not
$(strip $(if $1,,1))
endef

define eq
$(strip $(if $(strip $(filter $(strip $1),$(strip $2))),1))
endef

define ne
$(strip $(call not,$(call eq,$1,$2)))
endef

# List manipulation functions
# =============================
# 1) car:    Gets first element of a list
# 2) cdr:    Gets all but firs element of a list
# 3) rcar:   Gets last element of a list
# 4) rcdr:   Gets all but last element of a list
# 5) invert: Inverts a list
define car
$(strip $(firstword $(strip $1)))
endef

define cdr
$(strip $(wordlist 2,$(words $(strip $1)),$(strip $1)))
endef

define rcar
$(strip $(lastword $(strip $1)))
endef

define rcdr
$(strip $(patsubst %.word,%,\
    $(patsubst %.word.last,,$(strip $(addsuffix .word,$1)).last)))
endef

define invert
$(if $(strip $1),\
    $(call invert,$(wordlist 2,$(words $1),$1))) $(firstword $1)
endef

# Numeric comparison functions
# ==============================
# 1) gt:         Returns not empty if $1 is greater than $2
# 2) lt:         Returns not empty if $1 is less than $2
# 3) ge:         Returns not empty if $1 is greater or equal than $2
# 4) le:         Returns not empty if $1 is less or equal than $2
# 5) is-numeric: Returns not empty if $1 matches [0-9]*
# 5) is-integer: Returns not empty if $1 matches [+-]?[0-9]*
# 5) is-decimal: Returns not empty if $1 matches [+-]?[1-9]?[0-9]*

define cmp-factory
lt_$(word 1,$(subst -, ,$1))_$(word 2,$(subst -, ,$1)) := 1
gt_$(word 2,$(subst -, ,$1))_$(word 1,$(subst -, ,$1)) := 1
endef
$(foreach p,\
    0-1 0-2 0-3 0-4 0-5 0-6 0-7 0-8 0-9 1-2 1-3 1-4 1-5 1-6 1-7 1-8   \
    1-9 2-3 2-4 2-5 2-6 2-7 2-8 2-9 3-4 3-5 3-6 3-7 3-8 3-9 4-5 4-6   \
    4-7 4-8 4-9 5-6 5-7 5-8 5-9 6-7 6-8 6-9 7-8 7-9 8-9,              \
    $(eval $(call cmp-factory,$p)))

define expand
$(subst 0,0 ,$(subst 1,1 ,$(subst 2,2 ,$(subst 3,3 ,$(subst 4,4 ,\
    $(subst 5,5 ,$(subst 6,6 ,$(subst 7,7 ,$(subst 8,8 ,$(subst 9,9 ,$1)\
)))))))))
endef

define gt_impl
$(if $(strip $1),$(if $(strip $2),\
    $(if $(gt_$(call car,$1)_$(call car,$2)),1,\
        $(call gt_impl,$(call cdr,$1),$(call cdr,$2))),1))
endef

define gt
$(strip $(if \
    $(call eq,$(words $(call expand,$1)),$(words $(call expand,$2))),\
    $(call gt_impl,\
        $(call invert,$(call expand,$1)),  \
        $(call invert,$(call expand,$2))), \
    $(call gt_impl,\
        $(call invert,$(call expand,$(words $1))), \
        $(call invert,$(call expand,$(words $2)))) \
))
endef

define ge
$(or $(call eq,$1,$2),$(call gt,$1,$2))
endef

define lt
$(if $(call eq,$(call ge,$1,$2),1),,1)
endef

define le
$(or $(call eq,$1,$2),$(call lt,$1,$2))
endef

define rm-number
$(strip $(subst 0,,$(subst 1,,$(subst 2,,$(subst 3,,$(subst 4,,\
        $(subst 5,,$(subst 6,,$(subst 7,,$(subst 8,,$(subst 9,,\
        $(strip $1))))))))))))
endef

define is-numeric
$(if $(call rm-number,$1),,1)
endef

define is-negative_impl
$(if $(filter -%,$1))
endef

define is-positive_impl
$(call not,$(call is-negative,$1))
endef

define is-integer
$(if $(and $(call is-numeric,$1),$(strip \
           $(or $(call is-positive_impl,$1),$(call is-negative_impl,$1))\
)),1)
endef

define is-decimal
$(if $(and $(call not,$(filter 0%,$1)),$(call is-integer,$1)),1)
endef

# Lexical comparison functions
# ==============================
# 1) lexical-eq: Returns not empty if $1 is equal to $2
# 2) lexical-ne: Returns not empty if $1 is not equal to $2
# 3) lexical-gt: Returns not empty if $1 is greater than $2
# 4) lexical-lt: Returns not empty if $1 is less than $2
# 5) lexical-ge: Returns not empty if $1 is greater or equal than $2
# 6) lexical-le: Returns not empty if $1 is less or equal than $2

define lexical-eq
$(call eq,$1,$2)
endef

define lexical-ne
$(call ne,$1,$2)
endef

define lexical-gt
$(strip $(if $(strip $1),$(if $(strip $2),\
    $(if $(call lexical-ne,\
             $(firstword $(sort $(call car,$1) $(call car,$2))),\
             $(call car,$1)),\
        1,$(call lexical-gt,$(call cdr,$1),$(call cdr,$2))\
    ),1\
)))
endef

define lexical-ge
$(or $(call lexical-eq,$1,$2),$(call lexical-gt,$1,$2))
endef

define lexical-lt
$(if $(call lexical-eq,$(call lexical-ge,$1,$2),1),,1)
endef

define lexical-le
$(or $(call lexical-eq,$1,$2),$(call lexical-lt,$1,$2))
endef

define rm-lower
$(strip $(subst a,,$(subst b,,$(subst c,,$(subst d,,$(subst e,,\
        $(subst f,,$(subst g,,$(subst h,,$(subst i,,$(subst j,,\
        $(subst k,,$(subst l,,$(subst m,,$(subst n,,$(subst o,,\
        $(subst p,,$(subst q,,$(subst r,,$(subst s,,$(subst t,,\
        $(subst u,,$(subst v,,$(subst w,,$(subst x,,$(subst y,,\
        $(subst z,,$(strip $1))))))))))))))))))))))))))))
endef

define rm-upper
$(strip $(subst A,,$(subst B,,$(subst C,,$(subst D,,$(subst E,,\
        $(subst F,,$(subst G,,$(subst H,,$(subst I,,$(subst J,,\
        $(subst K,,$(subst L,,$(subst M,,$(subst N,,$(subst O,,\
        $(subst P,,$(subst Q,,$(subst R,,$(subst S,,$(subst T,,\
        $(subst U,,$(subst V,,$(subst W,,$(subst X,,$(subst Y,,\
        $(subst Z,,$(strip $1))))))))))))))))))))))))))))
endef

define is-alpha
$(if $(call is-empty,$(call rm-upper,$(call rm-lower,$1))),1)
endef

define is-alphanumeric
$(if $(call is-empty,$(strip \
    $(call rm-number,$(call rm-upper,$(call rm-lower,$1))))),1)
endef

# Version comparison functions
# ==============================
# 1) version-eq: Returns not empty if $1 is equal to $2
# 2) version-ne: Returns not empty if $1 is not equal to $2
# 3) version-gt: Returns not empty if $1 is greater than $2
# 4) version-lt: Returns not empty if $1 is less than $2
# 5) version-ge: Returns not empty if $1 is greater or equal than $2
# 6) version-le: Returns not empty if $1 is less or equal than $2

define version-eq
$(call eq,$(firstword $(subst +, ,$1)),$(firstword $(subst +, ,$2)))
endef

define version-ne
$(call ne,$(firstword $(subst +, ,$1)),$(firstword $(subst +, ,$2)))
endef

define version-gt_impl
$(strip $(if $(strip $1),$(if $(strip $2),\
    $(if $(and $(call is-numeric,$1),$(call is-numeric,$2)),\
        $(if $(call gt,$(call car,$1),$(call car,$2)),1,\
            $(if $(call eq,$(call car,$1),$(call car,$2)),\
                $(call version-gt_impl,$(call cdr,$1),$(call cdr,$2)))),\
        $(if $(call lexical-gt,$(call car,$1),$(call car,$2)),1,\
            $(if $(call lexical-eq,$(call car,$1),$(call car,$2)),\
                $(call version-gt_impl,$(call cdr,$1),$(call cdr,$2))))\
    ),1\
)))
endef

define version-gt
$(strip $(if \
    $(strip $(call version-gt_impl,\
        $(subst ., ,$(call car,$(subst -, ,$(word 1,$(subst +, ,$1))))),\
        $(subst ., ,$(call car,$(subst -, ,$(word 1,$(subst +, ,$2)))))\
    )),\
    1,$(strip $(call version-gt_impl,\
        $(subst ., ,$(call cdr,$(subst -, ,$(word 1,$(subst +, ,$1))))),\
        $(subst ., ,$(call cdr,$(subst -, ,$(word 1,$(subst +, ,$2)))))\
    ))\
))
endef

define version-ge
$(or $(call version-eq,$1,$2),$(call version-gt,$1,$2))
endef

define version-lt
$(if $(call version-eq,$(call version-ge,$1,$2),1),,1)
endef

define version-le
$(or $(call version-eq,$1,$2),$(call version-lt,$1,$2))
endef

# Semantic versioning
# =====================
# 1) version-data:        Returns version without metadata
# 2) version-release:     Returns release numbers (X.Y.Z)
# 3) version-major:       Returns major version (X)
# 4) version-minor:       Returns minor version (Y)
# 5) version-patch:       Returns patch version (Z)
# 6) version-pre-release: Returns pre-release strings
# 7) version-metadata:    Returns metadata
# 8) version-check:       Verifies if $1 follows semantic versioning

define version-data
$(strip $(firstword $(subst +, ,$(strip $1))))
endef

define version-release
$(strip $(firstword $(subst -, ,$(call version-data,$1))))
endef

define version-major
$(strip $(word 1,$(subst ., ,$(call version-release,$(strip $1)))))
endef

define version-minor
$(strip $(word 2,$(subst ., ,$(call version-release,$(strip $1)))))
endef

define version-patch
$(strip $(word 3,$(subst ., ,$(call version-release,$(strip $1)))))
endef

define version-pre-release
$(strip $(patsubst -%,%,$(patsubst $(call version-release,$1)%,%,\
    $(call version-data,$1))))
endef

define version-metadata
$(strip $(patsubst +%,%,$(patsubst $(call version-data,$1)%,%,\
    $(strip $1))))
endef

define version-check
$(if $(call is-empty,$(strip $1)),\
    $(error "Version MUST NOT be empty"))\
$(if $(call ne,1,$(words $(strip $1))),\
    $(error "Version MUST NOT have spaces"))\
$(if $(call lt,2,$(words $(subst +, ,$1))),\
    $(error "Version MUST have just one + separating version/metadata"))\
$(if $(call ne,3,$(words $(subst ., ,$(call version-release,$1)))),\
    $(error "Version MUST be on the form X.Y.Z"))\
$(if $(call is-numeric,$(call version-major,$1)),,\
    $(error "Major version (X.y.z) MUST be a non-negative number"))\
$(if $(call is-numeric,$(call version-minor,$1)),,\
    $(error "Minor version (x.Y.z) MUST be a non-negative number"))\
$(if $(call is-numeric,$(call version-patch,$1)),,\
    $(error "Patch version (x.y.Z) MUST be a non-negative number"))\
$(if $(call eq,-,$(subst $(call version-release,$1),,$1)),\
    $(error "Version MUST NOT have an empty pre-release after -"))\
$(foreach p,$(subst ., ,$(call version-pre-release,$1)),\
    $(if $(call is-alphanumeric,$(subst -,,$p)),,\
        $(error "Pre-release '$p' MUST be ASCII alphanumeric and -")))\
$(if $(call eq,+,$(subst $(call version-data,$1),,$1)),\
    $(error "Version MUST NOT have an empty metadata after +"))\
$(if $(call is-alphanumeric,$(subst -,,$(call version-metadata,$1))),,\
    $(error "Metadata MUST be ASCII alphanumeric and hyphen"))
endef

# Path manipulation functions
# =============================
# 1) root: Gets the root directory (first in the path) of a path or file
# 2) not-root: Given a path or file, take out the root directory of it
# 3) rm-trailing-bar: Removes the last / of a directory-only name

define root
$(strip $(foreach s,$1,\
    $(if $(findstring /,$s),\
        $(call root,$(patsubst %/,%,$(dir $s))),$(strip $s))))
endef

define not-root
$(strip $(foreach s,$1,\
    $(patsubst $(strip $(call root,$s))/%,%,$s)))
endef

define rm-trailing-bar
$(strip $(foreach s,$1,\
    $(if $(or $(call not,$(dir $s)),$(suffix $s),$(notdir $(basename $s))),$s,$(patsubst %/,%,$s))))
endef

# Suffix manipulation functions
# ===============================
# 1) abs-basename: Extracts all but all suffixes from file names in $1
# 2) all-suffix: Extracts all suffixes from file names in $1
# 3) extra-suffix: Extracts all but basename with first suffix
# 4) not-extra-suffix: Extracts basename with first suffix

define abs-basename_impl
$(strip $(if $(call is-empty,$(basename $1)),,\
    $(if $(call eq,$(basename $1),$1),\
        $1,$(call abs-basename_impl,$(basename $1)))))
endef

define abs-basename
$(strip $(foreach w,$1,$(call abs-basename_impl,$w)))
endef

define all-suffix_impl
$(if $(call abs-basename_impl,$1),\
    $(foreach p,$(call abs-basename_impl,$1),$(patsubst $p%,%,$1)),$1)
endef

define all-suffix
$(strip $(foreach w,$1,$(call all-suffix_impl,$1)))
endef

define suffix-list
$(strip $(subst ., ,$(call all-suffix,$1)))
endef

define extra-suffix
$(strip .$(call all-suffix,$(patsubst .%,%,$(call all-suffix,$1))))
endef

define not-extra-suffix
$(strip $(foreach w,$1,\
    $(call abs-basename,$w).$(firstword $(call suffix-list,$w))))
endef

# File identification functions
# ===============================
# 1) is-f:    Figures out if all files in a list are Fortran files
# 2) has-cxx: Figures out if there is a C++ file in a list
# 3) is-cxx:  Figures out if all files in a list are C++ files

define is_c
$(if $(strip $(foreach s,$(sort $(suffix $1)),\
    $(if $(strip $(findstring $s,$(cext))),$s))),is_c)
endef

define is_f
$(if $(strip $(foreach s,$(sort $(suffix $1)),\
    $(if $(strip $(findstring $s,$(fext))),$s))),is_f)
endef

define is_cxx
$(if $(strip $(foreach s,$(sort $(suffix $1)),\
    $(if $(strip $(findstring $s,$(cxxext))),$s))),is_cxx)
endef

# Auxiliar recursive functions
# ==============================
# 1) rsubdir:     For listing all subdirectories of a given dir
# 2) rwildcard:   For wildcard deep-search in the directory tree
# 3) rfilter:     For filtering a list of text from another list
# 3) rfilter-out: For filtering out a list of text from another list
rsubdir     = $(strip $(foreach d,$1,$(shell $(FIND) $d $(FINDFLAGS))))
rwildcard   = $(strip $(if $(strip $(wildcard $1/*)),\
                  $(foreach d,$(wildcard $1/*),$(call rwildcard,$d,$2)),\
                  $(if $(wildcard $1*),$(filter $(subst *,%,$2),$1))))
rfilter     = $(strip $(if $(strip $1),\
                 $(call rfilter,$(call cdr,$1),$2)\
                 $(filter $(call car,$1),$2)))
rfilter-out = $(strip $(if $(strip $1),\
                 $(call rfilter-out,\
                     $(call cdr,$1),\
                     $(filter-out $(call car,$1),$2)),\
                 $(sort $2)))

########################################################################
##                           DATA STRUCTURES                          ##
########################################################################

# Hash Table
# ============
# 1) hash-table.new:      Creates a hash table with elements accessible
#                         by hash-table.key and a list of keys
#                         hash-table.keys
# 2) hash-table.new_impl: Implements recursion for hash-table.new
# 3) hash-table.keys:     Returns the list of keys of hash-table $1
# 4) hash-table.values:   Returns the list of values of hash-table $1

define hash-table.new
$(call hash-table.new_impl,$(strip $1),$($(strip $1)))
endef

define hash-table.new_impl
$(if $(strip $2),$(or\
  $(if $(strip $(subst =>,,$(strip $(wordlist 2,2,$2)))),\
    $(error "Hash separator must be a => at variable '$1'")\
  ),\
  $(eval $1.__keys += $(firstword $2)),\
  $(eval $1.$(firstword $2) := 0),\
  $(strip $(foreach w,$(wordlist 3,$(words $2),$2),\
    $(if $(strip $(filter 0,$(firstword $($1.$(firstword $2))))),\
      $(if $(call eq,=>,$w),\
        $(eval $1.$(firstword $2) := \
          $(call rcdr,$($1.$(firstword $2))))\
        $(eval $1.$(firstword $2) := \
          $(words $(call cdr,$($1.$(firstword $2))))\
          $(call cdr,$($1.$(firstword $2)))\
        ),\
        $(eval $1.$(firstword $2) += $w)\
        $(if $(strip $(filter %$(comma),$w)),\
          $(eval $1.$(firstword $2) := \
            $(words $(call cdr,$($1.$(firstword $2))))\
            $(call cdr,$($1.$(firstword $2)))\
          )\
        )\
      )\
    )\
  )),\
  $(eval $1.$(firstword $2) := \
    $(call cdr,$($1.$(strip $(firstword $2)))))\
  $(call hash-table.new_impl,$1,\
    $(wordlist $(words a a a $($1.$(firstword $2))),$(words $2),$2)\
    $(eval $1.$(firstword $2) := \
        $(patsubst %$(comma),%,$($1.$(firstword $2))))\
  )\
))
endef

define hash-table.keys
$(strip $($(strip $1).__keys))
endef

define hash-table.values
$(strip $(foreach k,$(call hash-table.keys,$1),$($1.$k)))
endef

########################################################################
##                       USER INPUT VALIDATION                        ##
########################################################################

# Version
# =========
$(call version-check,$(VERSION))

# Native Language Support
# =========================
ENABLE_NLS ?= $(strip $(and $(foreach s,$(sysincdir),\
                  $(foreach i,$(NLSREQINC),$(wildcard $s$i))),$(strip \
                  $(or $(strip $(filter translation,$(MAKECMDGOALS))),\
                       $(sort $(patsubst %,1,$(strip $(call rwildcard,\
                           $(localedir),$(addprefix *,$(potext))))))\
                  ))\
              ))

# Documentation
# ===============
license      := $(strip $(firstword $(wildcard $(LICENSE))))
notice       := $(strip $(firstword $(wildcard $(NOTICE))))
contributors := $(strip $(firstword $(wildcard $(CONTRIBUTORS))))
doxyfile     := $(strip $(firstword $(DOXYFILE)))

# Flags
# =======
# Redefine flags to avoid conflict with user's local definitions
cppflags  := $(CPPFLAGS)
asflags   := $(ASFLAGS)
cflags    := $(CFLAGS)
fflags    := $(FFLAGS)
cxxflags  := $(CXXFLAGS)
cxxlexer  := $(CXXLEXER)
cxxparser := $(CXXPARSER)
ldlibs    := $(LDLIBS)
ldflags   := $(LDFLAGS)
arflags   := $(ARFLAGS)
soflags   := $(SOFLAGS)
lexflags  := $(LEXFLAGS)
yaccflags := $(YACCFLAGS)
esqlflags := $(ESQLFLAGS)

ldas      := $(LDAS)
ldc       := $(LDC)
ldf       := $(LDF)
ldcxx     := $(LDCXX)
ldlex     := $(LDLEX)
ldyacc    := $(LDYACC)
ldesql    := $(LDESQL)

ccov      := $(CCOV)
fcov      := $(FCOV)
cxxcov    := $(CXXCOV)
ldcov     := $(LDCOV)
cppcov    := $(CPPCOV)

# Installation directories
# ==========================
# Add prefix $(destdir)/ and transforms names in i_
destdir := $(strip $(foreach d,$(DESTDIR),$(patsubst %/,%,$d)))

$(foreach b,$(install_dirs),\
    $(if $(strip $(firstword $($b))),\
        $(eval i_$b := $(destdir)$(strip $(patsubst %/,%,$($b)))),\
        $(error "$b" must not be empty))\
)

# Directories
# =============
# No directories must end with a '/' (slash)
override srcdir    := $(call rm-trailing-bar,$(SRCDIR))
override depdir    := $(call rm-trailing-bar,$(DEPDIR))
override incdir    := $(call rm-trailing-bar,$(INCDIR))
override docdir    := $(call rm-trailing-bar,$(DOCDIR))
override debdir    := $(call rm-trailing-bar,$(DEBDIR))
override objdir    := $(call rm-trailing-bar,$(OBJDIR))
override covdir    := $(call rm-trailing-bar,$(COVDIR))
override libdir    := $(call rm-trailing-bar,$(LIBDIR))
override extdir    := $(call rm-trailing-bar,$(EXTDIR))
override srpdir    := $(call rm-trailing-bar,$(SRPDIR))
override bindir    := $(call rm-trailing-bar,$(BINDIR))
override sbindir   := $(call rm-trailing-bar,$(SBINDIR))
override execdir   := $(call rm-trailing-bar,$(EXECDIR))
override distdir   := $(call rm-trailing-bar,$(DISTDIR))
override confdir   := $(call rm-trailing-bar,$(CONFDIR))
override testdir   := $(call rm-trailing-bar,$(TESTDIR))
override datadir   := $(call rm-trailing-bar,$(DATADIR))
override makedir   := $(call rm-trailing-bar,$(MAKEDIR))
override localedir := $(call rm-trailing-bar,$(LOCALEDIR))

# All directories
alldir := $(strip\
    $(srcdir) $(depdir) $(incdir) $(docdir) $(debdir) $(objdir)         \
    $(libdir) $(extdir) $(srpdir) $(bindir) $(sbindir) $(execdir)       \
    $(distdir) $(confdir) $(testdir) $(datadir) $(makedir) $(localedir) \
)

# Check if directory variable is non-empty
$(foreach p,src inc doc deb lib srp bin sbin exec conf data,\
    $(if $(call ge,$(words $($pdir)),1),,\
        $(error There must be at least one dir in '$pdir'.)))

# Check if directory variable has only one directory
$(foreach p,dep obj ext dist test make locale,\
    $(if $(call eq,$(words $($pdir)),1),,\
        $(error There must be only one dir in '$pdir'.)))

# System Directories
# ====================
# No directories must end with a '/' (slash)
override sysincdir  := $(call rm-trailing-bar,$(wildcard $(SYSINCDIR)))
override syslibdir  := $(call rm-trailing-bar,$(wildcard $(SYSLIBDIR)))
override sysbindir  := $(call rm-trailing-bar,$(wildcard $(SYSBINDIR)))
override syssbindir := $(call rm-trailing-bar,$(wildcard $(SYSSBINDIR)))
override sysexecdir := $(call rm-trailing-bar,$(wildcard $(SYSEXECDIR)))

# Suffixes
# ==========
testsuf := $(strip $(sort $(TESTSUF)))
ifneq ($(words $(testsuf)),1)
    $(error Just one suffix allowed for test sources!)
endif

# Extensions
# ============
# Every extension must begin with a '.' (dot)
hext    := $(strip $(sort $(HEXT)))
hfext   := $(strip $(sort $(HFEXT)))
hxxext  := $(strip $(sort $(HXXEXT)))
cext    := $(strip $(sort $(CEXT)))
fext    := $(strip $(sort $(FEXT)))
cxxext  := $(strip $(sort $(CXXEXT)))
tlext   := $(strip $(sort $(TLEXT)))
asmext  := $(strip $(sort $(ASMEXT)))
libext  := $(strip $(sort $(LIBEXT)))
lexext  := $(strip $(sort $(LEXEXT)))
lexxext := $(strip $(sort $(LEXXEXT)))
yaccext := $(strip $(sort $(YACCEXT)))
yaxxext := $(strip $(sort $(YAXXEXT)))
esqlext := $(strip $(sort $(ESQLEXT)))
depext  := $(strip $(sort $(DEPEXT)))
extext  := $(strip $(sort $(EXTEXT)))
sysext  := $(strip $(sort $(SYSEXT)))
covext  := $(strip $(sort $(COVEXT)))
objext  := $(strip $(sort $(OBJEXT)))
binext  := $(strip $(sort $(BINEXT)))

srpext  := $(strip $(sort $(SRPEXT)))
dataext := $(strip $(sort $(DATAEXT)))

potext  := $(strip $(sort $(POTEXT)))
poext   := $(strip $(sort $(POEXT)))
moext   := $(strip $(sort $(MOEXT)))

texiext := $(strip $(sort $(TEXIEXT)))
infoext := $(strip $(sort $(INFOEXT)))
htmlext := $(strip $(sort $(HTMLEXT)))
dviext  := $(strip $(sort $(DVIEXT)))
pdfext  := $(strip $(sort $(PDFEXT)))
psext   := $(strip $(sort $(PSEXT)))

incext := $(hext) $(hxxext) $(tlext) $(hfext)
srcext := $(cext) $(cxxext) $(fext)
docext := $(texiext) $(infoext) $(htmlext) $(dviext) $(pdfext) $(psext)

# Check all extensions
allext := $(incext) $(srcext) $(asmext) $(libext)
allext += $(lexext) $(lexxext) $(yaccext) $(yaxxext) $(esqlext)
allext += $(depext) $(extext) $(sysext) $(covext) $(objext) $(binext)
allext += $(srpext) $(dataext) $(potext) $(poext) $(moext) $(docext)
allext := $(strip $(allext))
$(foreach ext,$(allext),\
    $(if $(filter .%,$(ext)),,\
        $(error "$(ext)" is not a valid extension)))

ifneq ($(words $(objext)),1)
    $(error Just one object extension allowed!)
endif

ifneq ($(words $(depext)),1)
    $(error Just one dependency extension allowed!)
endif

ifneq ($(words $(extext)),1)
    $(error Just one external dependency extension allowed!)
endif

ifneq ($(words $(sysext)),1)
    $(error Just one system dependency extension allowed!)
endif

ifneq ($(words $(binext)),1)
    $(if $(binext),\
        $(error Just one or none binary extensions allowed!))
endif

# Define extensions as the only valid ones
.SUFFIXES:
.SUFFIXES: $(allext)

# Get all existent programs
programs := \
    AR AS CC FC CXX RANLIB INSTALL INSTALL_DATA INSTALL_PROGRAM CP MV \
    RM TAR ZIP GZIP BZIP2 MKDIR RMDIR FIND LEX LEXCXX YACC YACCCXX    \
    COV ESQL CTAGS ETAGS DOXYGEN MAKEINFO INSTALL_INFO TEXI2HTML      \
    TEXI2DVI TEXI2PDF TEXI2PS XGETTEXT MSGINIT MSGMERGE MSGFMT DCH    \
    DEBUILD CURL GIT

########################################################################
##                     COMPILATION POST PROCESSMENT                   ##
########################################################################

# Coverage
# ==========
# Changes needed to deal with coverage compilation.
# 1) Preprocess flags to add coverage compiler options and remove
#    automatic optimizations (flags -On, n > 0)
# 2) Adds prefix $(COVDIR) as prefix for some directories
ifdef COVERAGE
#------------------------------------------------------------------[ 1 ]
$(foreach p,cpp as c f cxx ld,\
    $(eval override $pflags := $($pcov) $(patsubst -O%,,$($pflags))))
#------------------------------------------------------------------[ 2 ]
$(foreach p,obj bin lib,\
    $(eval override $pdir := $(addprefix $(covdir)/,$($pdir))))
endif

########################################################################
##                              PATHS                                 ##
########################################################################

# Paths
# ======
$(foreach e,.zip .tar .tgz .tbz2 .tar.gz .tar.bz2,\
    $(eval vpath %.$e $(distdir)))

# Binaries, libraries and source extensions
$(foreach e,$(libext),$(eval vpath lib%$e $(libdir)))
$(foreach s,$(srcdir),$(foreach e,$(srcext),$(eval vpath %$e $s)))
$(foreach s,$(testdir),$(foreach e,$(srcext),$(eval vpath %$e $s)))

########################################################################
##                              FILES                                 ##
########################################################################

# Default variable names
# ========================
# fooall: complete path WITH root directories
# foosrc: complete path WITHOUT root directories
# foopat: incomplete paths WITH root directories
# foolib: library names WITHOUT root directories

# Configuration Files
# =====================
make_configs := $(AUXFILES) $(license) $(notice) $(contributors)
make_configs += $(filter $(confdir)/%,$(MAKEFILE_LIST))
make_configs += Config.mk config.mk Config_os.mk config_os.mk
make_configs := $(sort $(foreach f,$(make_configs),$(wildcard $f)))

# Ignored Files
# ===============
# 1) Find complete paths for the ignored files
# 2) Define a function for filtering out the ignored files
#------------------------------------------------------------------[ 1 ]
ignored := $(sort $(IGNORED))
ignored := $(sort $(foreach f,$(ignored),\
               $(foreach r,$(alldir) $(bin) $(sbin) $(libexec),\
                   $(foreach d,$(call rsubdir,$r),\
                       $(wildcard $d/$f*)\
           ))))
#------------------------------------------------------------------[ 2 ]
define filter-ignored
$(call rfilter-out,$(ignored),$1)
endef

# External dependency files
# ===========================
# 1) git/web_dependency: Internally defined vars for dependencies
# 2) Make variables above hash tables
# 3) Create variable for all dependencies
# 4) Create variable with complete dependency paths
# 5) Paths (in first extdir) to store new dependencies
#------------------------------------------------------------------[ 1 ]
git_dependency := $(strip $(GIT_DEPENDENCY))
web_dependency := $(strip $(WEB_DEPENDENCY))
#------------------------------------------------------------------[ 2 ]
$(call hash-table.new,git_dependency)
$(call hash-table.new,web_dependency)
#------------------------------------------------------------------[ 3 ]
ext_dependency := $(call hash-table.keys,git_dependency)
ext_dependency += $(call hash-table.keys,web_dependency)
#------------------------------------------------------------------[ 4 ]
externdep := $(addsuffix $(sysext),$(ext_dependency))
externdep := $(addprefix $(depdir)/$(firstword $(extdir))/,$(externdep))
externdep := $(call invert,$(externdep))
#------------------------------------------------------------------[ 5 ]
externreq := $(addprefix $(extdir)/,$(ext_dependency))

# Program dependency files
# ==========================
# 1) Add dependency suffix and directory
#------------------------------------------------------------------[ 1 ]
progdep := $(addprefix $(depdir)/$(bindir)/,$(programs))
progdep := $(addsuffix $(sysext),$(progdep))

# Library files
# ===============
# .---.-----.------.-----.--------.---------------------------------.
# | # | dir | base | ext | STATUS |             ACTION              |
# |===|=====|======|=====|========|=================================|
# | 0 |     |      |     | Ok     | None                            |
# | 1 |  X  |      |     | Warn   | Correct to fall in case #4      |
# | 2 |     |  X   |     | Ok     | Matches all bases with this dir |
# | 3 |     |      |  X  | Error  | Extension only not allowed      |
# | 4 |  X  |  X   |     | Ok     | Find base in this dir           |
# | 5 |  X  |      |  X  | Error  | Extension only not allowed      |
# | 6 |     |  X   |  X  | Ok     | Find all bases with this ext    |
# | 7 |  X  |  X   |  X  | Ok     | Find the specific file          |
# '---'-----'------'-----'--------'---------------------------------'
# Examples: 1: test1/  2: test2 .c      4: test4/test4       5: test5/.c
#           6: test6.c 7: test7/test7.c 8: src/test8/test8.c
# 1) ar_in/shr_in: Remove the last / if there is a path only
# 2) lib_in      : Store libraries as being shared and static libs.
#                  If there is only a suffix, throw an error.
#------------------------------------------------------------------[ 1 ]
ar_in     := $(call rm-trailing-bar,$(ARLIB))
shr_in    := $(call rm-trailing-bar,$(SHRLIB))
#------------------------------------------------------------------[ 2 ]
lib_in    := $(ar_in) $(shr_in)
lib_in    := \
$(foreach s,$(lib_in),                                                 \
  $(if $(and                                                           \
      $(strip $(suffix $s)),$(if $(strip $(notdir $(basename $s))),,T) \
  ),                                                                   \
  $(error "Invalid argument $s in library variable"),$s)               \
)

# Assembly files
# ================
# 1) Find all assembly files in the source directory
# 2) Filter out ignored files from above
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(asmext),\
        $(eval asmall += $(call rwildcard,$(root),*$E))))
#------------------------------------------------------------------[ 2 ]
asmall := $(call filter-ignored,$(asmall))

# Lexical analyzers
# ===================
# 1) Find in a directory tree all the lex files (with dir names)
# 2) Filter out ignored files from above
# 3) Split C++ and C lexers (to be compiled appropriately)
# 4) Change lex extension to .yy.c or .yy.cc (for C/C++ lexers)
#    and join all the C and C++ lexer source names
# 5) Create lex scanners default directories for headers
# 6) Add default header directories for lexer compilation
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(lexext) $(lexxext),\
        $(eval alllexer += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
alllexer := $(call filter-ignored,$(alllexer))
#------------------------------------------------------------------[ 3 ]
cxxlexer := $(foreach e,$(lexxext),$(filter %$e,$(alllexer)))
clexer   := $(filter-out $(cxxlexer),$(alllexer))
#------------------------------------------------------------------[ 4 ]
lexall   += $(foreach E,$(lexext) $(lexxext),\
                $(patsubst %$E,%.yy.cc,$(filter %$E,$(cxxlexer))))
lexall   += $(foreach E,$(lexext) $(lexxext),\
                $(patsubst %$E,%.yy.c,$(filter %$E,$(clexer))))
lexall   := $(strip $(lexall))
#------------------------------------------------------------------[ 5 ]
lexinc   := $(call not-root,$(basename $(basename $(lexall))))
lexinc   := $(addprefix $(firstword $(incdir))/,$(lexinc))
lexinc   := $(addsuffix -yy/,$(lexinc))
#------------------------------------------------------------------[ 6 ]
lexinc   += $(if $(strip $(lexall)),$(strip $(LEXLIBS)))

# Syntatic analyzers
# ====================
# 1) Find in a directory tree all the yacc files (with dir names)
# 2) Filter out ignored files from above
# 3) Split C++ and C parsers (to be compiled appropriately)
# 4) Change yacc extension to .tab.c or .tab.cc (for C/C++ parsers)
#    and join all the C and C++ parser source names
# 5) Create yacc parsers default header files
# 6) Add default header directories for parser compilation
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(yaccext) $(yaxxext),\
        $(eval allparser += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
allparser := $(call filter-ignored,$(allparser))
#------------------------------------------------------------------[ 3 ]
cxxparser := $(foreach e,$(yaxxext),$(filter %$e,$(allparser)))
cparser   := $(filter-out $(cxxparser),$(allparser))
#------------------------------------------------------------------[ 4 ]
yaccall   += $(foreach E,$(yaccext) $(yaxxext),\
                $(patsubst %$E,%.tab.cc,$(filter %$E,$(cxxparser))))
yaccall   += $(foreach E,$(yaccext) $(yaxxext),\
                $(patsubst %$E,%.tab.c,$(filter %$E,$(cparser))))
yaccall   := $(strip $(yaccall))
#------------------------------------------------------------------[ 5 ]
yaccinc   := $(call not-root,$(basename $(basename $(yaccall))))
yaccinc   := $(addprefix $(firstword $(incdir))/,$(yaccinc))
yaccinc   := $(addsuffix -tab/,$(yaccinc))
#------------------------------------------------------------------[ 6 ]
yaccinc   += $(if $(strip $(yaccall)),$(strip $(YACCLIBS)))

# Embedded SQL preprocessors
# ============================
# 1) Find in a directory tree all the esql files (with dir names)
# 2) Filter out ignored files from above
# 3) Change esql extension to .c
# 4) Add default header directories for embedded SQL compilation
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(esqlext),\
        $(eval cesql += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
cesql     := $(call filter-ignored,$(cesql))
#------------------------------------------------------------------[ 3 ]
esqlall   += $(foreach E,$(esqlext),\
                $(patsubst %$E,%.c,$(filter %$E,$(cesql))))
esqlall   := $(strip $(esqlall))
#------------------------------------------------------------------[ 4 ]
esqlinc   := $(if $(strip $(esqlall)),$(strip $(ESQLLIBS)))

# Automatically generated files
# ===============================
autoall := $(yaccall) $(lexall) $(esqlall)
autoinc := $(yaccinc) $(lexinc) $(esqlinc)

# Header files
# ==============
# 1) Get all files able to be included
# 2) Filter out ignored files from above
# 3) Get all subdirectories of the included dirs
# 4) Add them as paths to be searched for headers
#------------------------------------------------------------------[ 1 ]
incall  := $(foreach i,$(incdir),$(foreach e,$(incext),\
                $(call rwildcard,$i,*$e)))
#------------------------------------------------------------------[ 2 ]
incall  := $(call filter-ignored,$(incall))
#------------------------------------------------------------------[ 3 ]
incsub  := $(sort $(call rm-trailing-bar,$(dir $(incall))))
incsub  += $(autoinc)
#------------------------------------------------------------------[ 4 ]
aslibs  := $(ASLIBS)  $(patsubst %,-I%,$(incsub))
clibs   := $(CLIBS)   $(patsubst %,-I%,$(incsub))
flibs   := $(FLIBS)   $(patsubst %,-I%,$(incsub))
cxxlibs := $(CXXLIBS) $(patsubst %,-I%,$(incsub))

# Source files
# ==============
# 1) srcall  : Find in the dir trees all source files (with dir names)
# 2) srcall  : Filter out ignored files from above
# 3) srcall  : Remove automatically generated source files from srcall
# 4) liball  : Save complete paths for libraries (wildcard-expanded)
# 5) libpat  : Save complete paths for libraries (non-wildcard-expanded)
# 6) srccln  : Remove library src from normal src
# 6) asmcln  : Remove library src from assembly src
# 6) autocln : Remove library src from normal auto generated src
# 7) src     : Remove root directory names from dir paths
# 7) asmsrc  : Remove root directory names from dir paths
# 7) autosrc : Remove root directory names from dir paths
# 8) c_all   : C files from srcall
# 8) f_all   : Fortran files from srcall
# 8) cxx_all : C++ files from srcall
#------------------------------------------------------------------[ 1 ]
ifneq ($(srcdir),.)
srcall := $(sort\
    $(foreach root,$(srcdir),\
        $(foreach E,$(srcext),\
            $(call rwildcard,$(root),*$E)\
)))
else
$(warning Source directory is '.'. Deep search for source disabled.)
srcall := $(sort\
    $(foreach E,$(srcext),\
        $(wildcard *$E)\
))
endif
#------------------------------------------------------------------[ 2 ]
srcall := $(call filter-ignored,$(srcall))
#------------------------------------------------------------------[ 3 ]
srcall := $(call rfilter-out,$(lexall) $(yaccall) $(esqlall),$(srcall))
#------------------------------------------------------------------[ 4 ]
liball := $(sort \
    $(foreach r,$(autoall) $(srcall) $(asmall),\
        $(foreach l,$(lib_in),\
            $(strip $(foreach s,$r,\
                $(if $(findstring $l,$s),$s)))\
)))
# Give error if there is no match with the lib name
$(foreach l,$(lib_in),\
    $(if $(or $(findstring $l,$(liball)),$(call rfilter,\
                init standard nothing config gitignore,\
                $(MAKECMDGOALS))),,\
        $(error Library file/directory "$l" not found)\
))
#------------------------------------------------------------------[ 5 ]
# Search-for-complete-path steps:
# * Cases #6 (path witout root) and #7 (all path);
# * Case  #2 (path without file);
# * Case  #4 (path with file without extension);
libpat := $(sort \
    $(foreach l,$(lib_in),$(or\
        $(strip $(foreach s,$(srcall),\
            $(if $(findstring $l,$s),\
                $(filter %$l,$s))\
        )),\
        $(strip $(foreach root,$(srcdir),\
            $(firstword $(sort \
                $(foreach s,$(call rsubdir,$(root)),\
                    $(if $(findstring $l,$s),$s)\
                )\
        )))),\
        $(strip $(foreach s,$(srcall) $(autoall) $(asmall),\
            $(if $(findstring $l,$s),$s)\
        ))\
    ))\
)
#------------------------------------------------------------------[ 6 ]
srccln  := $(srcall)
srccln  := $(call rfilter-out,$(liball),$(srccln))

asmcln  := $(asmall)
asmcln  := $(call rfilter-out,$(liball),$(asmcln))

autocln := $(autoall)
autocln := $(call rfilter-out,$(liball),$(autocln))
#------------------------------------------------------------------[ 7 ]
src     := $(call not-root,$(srccln))
asmsrc  := $(call not-root,$(asmcln))
autosrc := $(call not-root,$(autocln))
#------------------------------------------------------------------[ 8 ]
c_all   := $(call rfilter,$(addprefix %,$(cext)),$(srcall))
f_all   := $(call rfilter,$(addprefix %,$(fext)),$(srcall))
cxx_all := $(call rfilter,$(addprefix %,$(cxxext)),$(srcall))

# Type-specific library flags
# =============================
# 1) Add asm, c, f, cxx, lex, yacc and esql only flags in linker flags
$(if $(strip $(asmall)), $(eval ldflags += $(ldas)   ))
$(if $(strip $(c_all)),  $(eval ldflags += $(ldc)    ))
$(if $(strip $(f_all)),  $(eval ldflags += $(ldf)    ))
$(if $(strip $(cxx_all)),$(eval ldflags += $(ldcxx)  ))
$(if $(strip $(lexall)), $(eval ldflags += $(ldlex)  ))
$(if $(strip $(yaccall)),$(eval ldflags += $(ldyacc) ))
$(if $(strip $(esqlall)),$(eval ldflags += $(ldesql) ))

# Static libraries
# ==================
# 1) Get complete static library paths from all libraries
# 2) Store static library paths without root directory
# 3) Create one var with the object dependencies for each lib above
# 4) Create variables for all static library objects
# 5) Create library simple names, without directories or extension
# 6) Create library names, with directories, from the source
#------------------------------------------------------------------[ 1 ]
arpat   := \
$(foreach ar,$(ar_in),\
    $(foreach l,$(libpat),\
        $(if $(findstring $(ar),$l),$l)\
))
#------------------------------------------------------------------[ 2 ]
arpatsrc  := $(call not-root,$(arpat))
#------------------------------------------------------------------[ 3 ]
$(foreach ar,$(arpat),\
    $(eval arobj_$(call not-root,$(ar)) := \
        $(foreach l,$(liball),\
            $(if $(strip $(findstring $(ar),$l)),\
                $(addprefix $(objdir)/,\
                    $(addsuffix $(firstword $(objext)),\
                         $(call not-root,$(basename $l)\
)))))))
#------------------------------------------------------------------[ 4 ]
arobj     := $(foreach ar,$(arpatsrc),$(arobj_$(ar)))
#------------------------------------------------------------------[ 5 ]
arlibname := $(notdir $(basename $(arpatsrc)))
#------------------------------------------------------------------[ 6 ]
arlib     := $(foreach s,$(arpatsrc),\
                 $(patsubst $(subst ./,,$(dir $s))%,\
                 $(subst ./,,$(dir $s))lib%,$s)\
             )
arlib     := $(patsubst %,$(firstword $(libdir))/%.a,\
                 $(basename $(arlib)))

# Dynamic libraries
# ===================
# 1) Get all source files that may be compiled to create the shared lib
# 2) Get complete dynamic library paths from all libraries
# 3) Store dynamic library paths without root directory
# 4) Create one var with the object dependencies for each lib above
# 5) Create variables for all dynamic library objects
# 6) Create library simple names, without directories or extension
# 7) Create library complete names, with directories, from the source
# 8) Set directories for locally searching for the libraries
#------------------------------------------------------------------[ 1 ]
shrall    := \
$(foreach so,$(shr_in),\
    $(foreach l,$(liball),\
        $(if $(findstring $(so),$l),$l)\
))
#------------------------------------------------------------------[ 2 ]
shrpat    := \
$(foreach so,$(shr_in),\
    $(foreach l,$(libpat),\
        $(if $(findstring $(so),$l),$l)\
))
#------------------------------------------------------------------[ 3 ]
shrpatsrc := $(call not-root,$(shrpat))
#------------------------------------------------------------------[ 4 ]
$(foreach shr,$(shrpat),\
    $(eval shrobj_$(call not-root,$(shr)) := \
        $(foreach l,$(liball),\
            $(if $(strip $(findstring $(shr),$l)),\
                $(addprefix $(objdir)/,\
                    $(addsuffix $(firstword $(objext)),\
                         $(call not-root,$(basename $l)\
)))))))
#------------------------------------------------------------------[ 5 ]
shrobj     := $(foreach shr,$(shrpatsrc),$(shrobj_$(shr)))
#------------------------------------------------------------------[ 6 ]
shrlibname := $(notdir $(basename $(shrpatsrc)))
#------------------------------------------------------------------[ 7 ]
shrlib     := $(foreach s,$(shrpatsrc),\
                   $(patsubst $(subst ./,,$(dir $s))%,\
                   $(subst ./,,$(dir $s))lib%,$s)\
               )
shrlib     := $(patsubst %,$(firstword $(libdir))/%.so,\
                  $(basename $(shrlib)))

# System libraries
# ==================
# 1) System libraries used by the user
# 2) System library names, deduced from above
#------------------------------------------------------------------[ 1 ]
syslib     := \
$(foreach l,$(filter -l%,$(ldflags)),\
    $(foreach d,$(syslibdir) \
                $(foreach s,$(syslibdir),\
                    $(filter $s%,$(patsubst -L%,%,$(ldlibs)))),\
        $(lastword $(foreach e,$(libext),\
            $(wildcard $d/lib$(patsubst -l%,%,$l)$e)))\
))
#------------------------------------------------------------------[ 2 ]
syslibname := $(patsubst lib%,%,$(notdir $(basename $(syslib))))
#------------------------------------------------------------------[ 3 ]
syslibdep  := $(addprefix $(depdir)/$(firstword $(libdir)),\
                  $(addsuffix $(sysext),$(syslibname)))

# Local libraries
# =================
# 1) Local libraries used by the user
# 2) Local library names, deduced from above
#------------------------------------------------------------------[ 1 ]
loclib     := \
$(foreach l,$(filter -l%,$(ldflags)),\
    $(foreach d,$(call rsubdir,$(call cdr,$(libdir))),\
        $(lastword $(foreach e,$(libext),\
            $(wildcard $d/lib$(patsubst -l%,%,$l)$e)))))
#------------------------------------------------------------------[ 2 ]
loclibname := $(patsubst lib%,%,$(notdir $(basename $(loclib))))

# Dependency libraries
# ==================
# 1) Dependency library names, deduced from above
#------------------------------------------------------------------[ 1 ]
deplibname := \
$(call rfilter-out,$(libname) $(syslibname) $(loclibname),\
    $(patsubst -l%,%,$(filter -l%,$(ldflags))))

# General libraries
# ===================
# 1) lib: all complete library names (path/libname.ext)
# 2) libname: all library names (name)
# 3) Get all subdirectories of the library dirs and
#    add them as paths to be searched for libraries
lib     := $(arlib) $(shrlib) $(syslib) $(loclib) $(deplib)
libname := $(arlibname) $(shrlibname)
libname += $(syslibname) $(loclibname) $(deplibname)
libsub   = $(if $(strip $(lib)),\
               $(foreach d,$(libdir),$(call rsubdir,$d)))
ldlibs   = $(LDLIBS) $(sort $(addprefix -L$(space),$(libsub)))
ldlibs  += $(sort $(patsubst -L%,-Wl$(comma)-rpath$(comma)%, \
               $(subst -L$(space),-L,$(LDLIBS))              \
               $(addprefix -L,$(libsub))                     \
           ))

# Object files
# ==============
# 1) Add obj suffix for each 'naked' assembly source file name (basename)
# 2) Add obj suffix for each 'naked' source file name (basename)
# 3) Prefix the build dir before each name
# 4) Join all object files (including auto-generated)
# 5) Repeat (1) and (3) for the automatically generated sources
#------------------------------------------------------------------[ 1 ]
obj := $(addsuffix $(firstword $(objext)),$(basename $(asmsrc)))
#------------------------------------------------------------------[ 2 ]
obj += $(addsuffix $(firstword $(objext)),$(basename $(src)))
#------------------------------------------------------------------[ 3 ]
obj := $(addprefix $(objdir)/,$(obj))
#------------------------------------------------------------------[ 4 ]
objall := $(obj) $(arobj) $(shrobj) #$(autoobj)
#------------------------------------------------------------------[ 5 ]
autoobj := $(addsuffix $(firstword $(objext)),$(basename $(autosrc)))
autoobj := $(addprefix $(objdir)/,$(autoobj))

# Source dependency files
# =========================
# 1) Get tests and not-root source/auto-source for dependencies
# 2) Create dependency names
# 3) Add dependency suffix and directory
depall := $(testall) $(call not-root,$(srcall) $(autoall))
depall := $(strip $(basename $(depall)))
depall := $(addprefix $(depdir)/,$(addsuffix $(depext),$(depall)))

# Internationalization
# ======================
# 1) intlall: Get all portable object files (based on their locale)
# 2) intlall: Filter out ignored files from above
# 3) intlobj: Names of corresponding machine object files
ifneq (,$(strip $(ENABLE_NLS)))
#------------------------------------------------------------------[ 1 ]
ifneq ($(srcdir),.)
intlall := $(sort\
    $(foreach E,$(poext),\
        $(call rwildcard,$(localedir),*$E)\
))
else
$(warning Locale directory is '.'. Deep search for translations disabled.)
intlall := $(sort\
    $(foreach E,$(poext),\
        $(wildcard *$E)\
))
endif
#------------------------------------------------------------------[ 2 ]
intlall := $(strip $(call filter-ignored,$(intlall)))
#------------------------------------------------------------------[ 3 ]
intlobj := \
$(foreach p,$(intlall),\
    $(dir $p)LC_MESSAGES/$(notdir $(basename $p))$(firstword $(moext)))
intlobj := $(strip $(intlobj))
endif

# Binaries
# ==========
# 1) Define all binary names (with extensions if avaiable)
# 2) Store binary-specific files from source, objects and libs
# 3) Store common source, objects and libs filtering the above ones
# 4) Create variables:
#    4.1) binary-name_src, for binary's specific sources;
#    4.2) binary-name_obj, for binary's specific objects;
#    4.3) binary-name_lib, for binary's specific libraries;
#    4.4) binary-name_link, for binary's specific linker flags;
#    4.5) binary-name_aobj, for binary's specific auto-generated objects;
#    4.6) binary-name_asrc, for binary's specific auto-generated sources;
#    4.7) binary-name_is_cxx, to test if the binary may be C's or C++'s
#------------------------------------------------------------------[ 1 ]
define binary-name
$1 := $$(call rm-trailing-bar,$2)
$1 := $$(foreach b,$$($1),$$(or $$(strip $$(wildcard $$b/*)),\
          $$(strip $$(foreach d,$$(srcdir),$$(wildcard $$d/$$b/*))),$$b))
$1 := $$(addprefix $$(strip $3)/,$$(basename $$(call not-root,$$($1))))
$1 := $$(if $$(strip $$(binext)),$$(addsuffix $$(binext),$$($1)),$$($1))
$1 := $$(call filter-ignored,$$($1))
endef
$(eval $(call binary-name,bin,$(BIN),$(bindir)))
$(eval $(call binary-name,sbin,$(SBIN),$(sbindir)))
$(eval $(call binary-name,libexec,$(LIBEXEC),$(execdir)))

$(if $(strip $(bin) $(sbin) $(libexec)),\
    $(eval binall := $(bin) $(sbin) $(libexec)),\
    $(if $(strip $(srccln)),$(eval binall := $(bindir)/a.out))\
)
#------------------------------------------------------------------[ 2 ]
$(foreach sep,/ .,$(foreach b,$(notdir $(binall)),$(or\
    $(eval $b_src  += $(filter $b$(sep)%,$(src))),\
    $(eval $b_all  += $(sort $(call rfilter,\
                          $(addprefix %,$($b_src)),$(srcall))))\
    $(eval $b_obj  += $(filter $(objdir)/$b$(sep)%,$(objall))),\
    $(eval $b_aobj += $(filter $(objdir)/$b$(sep)%,$(autoobj))),\
    $(eval $b_lib  += $(foreach d,$(libdir),\
                          $(filter $d/$b$(sep)%,$(lib)))),\
    $(eval $b_link += $(foreach n,$(libname),$(if $(strip \
                          $(filter %$n,$(basename $($b_lib)))),$n))),\
    $(eval $b_aall += $(foreach d,$(srcdir),\
                          $(filter $d/$b$(sep)%,$(autosrc)))),\
)))
#------------------------------------------------------------------[ 3 ]
define common-factory
$(call rfilter-out,$(foreach b,$(notdir $(binall)),$($b_$1)),$2)
endef
comsrc  := $(call common-factory,src,$(src))
comall  := $(call common-factory,all,$(srcall))
comobj  := $(call common-factory,obj,$(objall))
comlib  := $(call common-factory,lib,$(lib))
comlink := $(call common-factory,link,$(libname))
comaobj := $(call common-factory,aobj,$(autoobj))
comaall := $(call common-factory,aall,$(autoall))
#------------------------------------------------------------------[ 4 ]
$(foreach b,$(notdir $(binall)),$(or\
    $(eval $b_src    := $(comsrc)  $($b_src)  ),\
    $(eval $b_all    := $(comall)  $($b_all)  ),\
    $(eval $b_obj    := $(comobj)  $($b_obj)  ),\
    $(eval $b_lib    := $(comlib)  $($b_lib)  ),\
    $(eval $b_aobj   := $(comaobj) $($b_aobj) ),\
    $(eval $b_aall   := $(comasrc) $($b_aall) ),\
    $(eval $b_link   := $(sort $(addprefix -l,$($b_link) $(comlink)))),\
    $(eval $b_is_c   := $(strip $(call is_c,$($b_src)))),\
    $(eval $b_is_f   := $(strip $(call is_f,$($b_src)))),\
    $(eval $b_is_cxx := $(strip $(call is_cxx,$($b_src)))),\
))

# Binary installation
# =====================
i_lib     := $(addprefix $(i_libdir)/,$(call not-root,$(lib)))
i_bin     := $(addprefix $(i_bindir)/,$(call not-root,$(bin)))
i_sbin    := $(addprefix $(i_sbindir)/,$(call not-root,$(sbin)))
i_libexec := $(addprefix $(i_libexecdir)/,$(call not-root,$(libexec)))

# Internationalization templates
# ================================
# 1) intltl:   Template files for executables
# 2) cppflags: Add definitions for internationalization
ifneq (,$(strip $(ENABLE_NLS)))
#------------------------------------------------------------------[ 1 ]
intltl    := \
$(foreach b,$(binall),\
    $(localedir)/$(call not-root,$b)$(firstword $(potext)))
intltl    := $(strip $(intltl))
#------------------------------------------------------------------[ 2 ]
cppflags  += -D ENABLE_NLS -D PACKAGE=\"$(PROJECT)\" \
             -D LOCALEDIR=\"$(i_localedir)\"
endif

# Automated tests
# =================
# 1) testall: Get all source files in the test directory
# 2) testall: Filter out ignored files from above
# 3) testdep: Basenames without test suffix, root dirs and extensions
# 4) testrun: Alias to execute tests, prefixing run_ and
#             substituting / for _ in $(testdep)
#------------------------------------------------------------------[ 1 ]
$(foreach e,$(srcext),\
    $(eval testall += $(call rwildcard,$(testdir),*$e)))
#------------------------------------------------------------------[ 2 ]
testall := $(call filter-ignored,$(testall))
#------------------------------------------------------------------[ 4 ]
testsrc := $(call not-root,$(testall))
#------------------------------------------------------------------[ 5 ]
testobj := $(addsuffix $(firstword $(objext)),$(basename $(testsrc)))
testobj := $(addprefix $(objdir)/$(testdir)/,$(testobj))
#------------------------------------------------------------------[ 6 ]
testbin := $(call rm-trailing-bar,$(TESTBIN))
testbin := $(foreach b,$(testbin),$(or $(strip \
               $(foreach d,$(testdir),$(wildcard $d/$b/*))),$b))
testbin := $(call not-root,$(basename $(testbin)))
testbin := $(addprefix $(strip $(bindir)/$(testdir))/,$(testbin))
testbin := $(if $(strip $(binext)),\
               $(addsuffix $(binext),$(testbin)),$(testbin))
testbin := $(call filter-ignored,$(testbin))
#------------------------------------------------------------------[ 7 ]
$(foreach t,$(call not-root,$(testbin)),$(or\
    $(eval $t_src := $(filter $(call not-root,$t)%,$(testsrc))),\
    $(eval $t_obj := $(filter $(objdir)/$(testdir)/$t%,$(testobj)))\
))
#------------------------------------------------------------------[ 8 ]
define common-test-factory
$(call rfilter-out,$(foreach t,$(call not-root,$(testbin)),$($t_$1)),$2)
endef
comtestsrc := $(call common-test-factory,src,$(testsrc))
comtestobj := $(call common-test-factory,obj,$(testobj))
#------------------------------------------------------------------[ 9 ]
$(foreach t,$(call not-root,$(testbin)),$(or\
    $(eval $t_src := $(comtestsrc) $($t_src)),\
    $(eval $t_obj := $(comtestobj) $($t_obj)),\
))
#------------------------------------------------------------------[ 10 ]
$(foreach s,$(comtestsrc),\
    $(if $(and $(filter-out %$(testsuf),$(basename $s)),$(strip \
               $(call rfilter,check,$(MAKECMDGOALS)))),\
        $(error "Test $(testdir)/$s does not have suffix $(testsuf)")))
$(foreach s,$(comtestsrc),\
    $(if $(or $(filter $(subst $(testsuf).,.,$s),$(src)),$(strip \
              $(call not,$(call rfilter,check,$(MAKECMDGOALS))))),,\
        $(error "Test $(testdir)/$s has no corresponding source file")))
#------------------------------------------------------------------[ 11 ]
testrun := $(addprefix run_,$(subst /,_,$(testbin)))

# Coverage analysis
# ===================
# 1) Recompiled binaries for coverage test
# 2) Directories (with source file names) for coverage analysis files
covbin := $(addprefix $(covdir)/,$(binall))
covall := $(addprefix $(covdir)/,$(srcall))

# Texinfo files
# ===============
# 1) texiall: All TexInfo files with complete path
# 2) texiall: Filter out ignored files from above
# 3) texisrc: Take out root dir reference from above
# 4) Create variables:
#    4.1) texiinfo, for INFO's to be generated from TexInfo files
#    4.1) texihtml, for HTML's to be generated from TexInfo files
#    4.2) texidvi, for DVI's to be generated from TexInfo files
#    4.3) texipdf, for PDF's to be generated from TexInfo files
#    4.4) texips, for PS's to be generated from TexInfo files
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(docdir),\
    $(foreach E,$(texiext),\
        $(eval texiall += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
texiall := $(call filter-ignored,$(texiall))
#------------------------------------------------------------------[ 3 ]
texisrc := $(call not-root,$(texiall))
#------------------------------------------------------------------[ 4 ]
$(foreach doc,info html dvi pdf ps,\
    $(eval texi$(doc) := \
        $(addprefix $(firstword $(docdir))/$(doc)/,\
            $(addsuffix $(firstword $($(doc)ext)),\
                $(basename $(texisrc))\
))))

# Debian package files
# ======================
# 1) deball: debian packaging files in the default debian directory
deball := changelog compat control copyright
deball += rules source/format $(DEB_PROJECT).dirs
deball := $(sort $(strip $(addprefix $(debdir)/,$(deball))))

########################################################################
##                            VERSION                                 ##
########################################################################

# Version check
# ===============
# 1) program/library_version: Internally defined vars for versions
# 2) Make variables above hash tables
# 3) Check validity of keys
# 4) Remove parentheses around version
#------------------------------------------------------------------[ 1 ]
program_version := $(strip $(PROGRAM_VERSION))
library_version := $(strip $(LIBRARY_VERSION))
#------------------------------------------------------------------[ 2 ]
$(call hash-table.new,program_version)
$(call hash-table.new,library_version)
#------------------------------------------------------------------[ 3 ]
$(foreach p,$(call hash-table.keys,program_version),\
    $(if $(call not,$(findstring $p,$(programs))),\
        $(error "$p key of PROGRAM_VERSION is not a program var name")))
#------------------------------------------------------------------[ 4 ]
$(foreach n,program library,\
    $(foreach p,$(call hash-table.keys,$n_version),\
        $(eval $n_version.$p := \
            $(patsubst $(lparentheses)%,%,\
                $(call car,$($n_version.$p)))\
            $(call cdr,$($n_version.$p)))\
        $(eval $n_version.$p := \
            $(call rcdr,$($n_version.$p))\
            $(patsubst %$(rparentheses),%,\
                $(call rcar,$($n_version.$p))))\
))

########################################################################
##                              BUILD                                 ##
########################################################################

build_dependency := \
    AR       => $(arlib),\
    AS       => $(asmall),\
    CC       => $(c_all),\
    FC       => $(f_all),\
    CXX      => $(cxx_all),\
    RANLIB   => $(arlib),\
    LEX      => $(clexer),\
    LEXCXX   => $(cxxlexer),\
    YACC     => $(cparser),\
    YACCCXX  => $(cxxparser),\
    ESQL     => $(cesql)

.PHONY: all
all: depend $(binall) $(lib)

.PHONY: depend
depend: builddep librarydep gitdep webdep

.PHONY: check
check: all $(testrun)
	$(if $(strip $^),$(call phony-ok,$(MSG_TEST_SUCCESS)))

.PHONY: nothing
nothing:

########################################################################
##                       EXTERNAL REPOSITORIES                        ##
########################################################################

external_dependency := \
    GIT      => $(or $(filter-out undefined,$(origin NO_GIT)),1)

.PHONY: sync
sync: externaldep
	$(call git-pull,$(REMOTE),$(BRANCH))

.PHONY: deploy
deploy: externaldep
	$(call git-push,$(REMOTE),$(BRANCH))

########################################################################
##                              UPGRADE                               ##
########################################################################

upgrade_dependency := \
    CURL     => $(firstword $(MAKEFILE_LIST)),\
    GIT      => $(or $(filter-out undefined,$(origin NO_GIT)),1)

.PHONY: upgrade
upgrade: upgradedep
ifneq ($(wildcard $(makedir)/*),)
	$(call git-pull,origin,master,$(makedir))
	$(call git-add-commit,$(makedir),"Upgrade submodule $(makedir)")
else
	$(call web-clone,$(MAKERAWREMOTE),$(firstword $(MAKEFILE_LIST)))
	$(call git-add-commit,$(firstword $(MAKEFILE_LIST)),\
                          "Upgrade $(firstword $(MAKEFILE_LIST))")
endif

########################################################################
##                          INITIALIZATION                            ##
########################################################################

init_dependency := \
    GIT      => $(or $(filter-out undefined,$(origin NO_GIT)),1)

.PHONY: init
init: initdep
	$(call git-init)
	$(call git-remote-add,origin,$(GIT_REMOTE_PATH))
	
	$(if $(wildcard $(makedir)/*),\
	    $(if $(wildcard $(depdir)/make.mk),,\
	        $(call touch,$(depdir)/make.mk)$(newline)\
	        $(call git-submodule-add,$(MAKEGITREMOTE),$(makedir))))
	
	$(call mkdir,$(srcdir))
	$(call mkdir,$(incdir))
	$(call mkdir,$(docdir))
	
	$(call make-create,config,Config.mk)
	$(call make-create,version,.version.mk)
	$(call make-create,gitignore,.gitignore)
	
	$(call git-tag,"v$(strip $(VERSION))")
	
	$(call git-add-commit,Makefile Config.mk,\
	       "Add Makefile and Config.mk")
	$(call git-add-commit,.git[a-z]*,\
	       "Add git configuration files")
	$(call git-add-commit,.version.mk,\
	       "Add versioning control file .version.mk")

.PHONY: standard
standard: init
	$(call mv,$(objext), $(objdir),   "object")
	$(call mv,$(libext), $(libdir),   "library")
	$(call mv,$(docext), $(docdir),   "document")
	$(call mv,$(srpext), $(srpdir),   "script")
	$(call mv,$(dataext),$(datadir),  "data")
	$(call mv,$(potext), $(localedir),"portable object template")
	$(call mv,$(poext),  $(localedir),"portable object")
	$(call mv,$(moext),  $(localedir),"machine object")
	$(call mv,$(incext), $(incdir),   "header")
	$(call mv,$(asmext), $(srcdir),   "assembly")
	$(call mv,$(srcext), $(srcdir),   "source")
	$(call mv,$(esqlext),$(srcdir),   "embedded SQL")
	$(call mv,$(lexext)  $(lexxext),$(srcdir),"lexer")
	$(call mv,$(yaccext) $(yaxxext),$(srcdir),"parser")

########################################################################
##                               TAGS                                 ##
########################################################################

tags_dependency := \
    CTAGS => ctags,\
    ETAGS => etags

.PHONY: TAGS
TAGS: tagsdep ctags etags

ctags: $(incall) $(srcall)
	$(call phony-status,$(MSG_CTAGS))
	$(quiet) $(CTAGS) $(CTAGSFLAGS) $^ -o $@ $(ERROR)
	$(call phony-ok,$(MSG_CTAGS))

etags: $(incall) $(srcall)
	$(call phony-status,$(MSG_ETAGS))
	$(quiet) $(ETAGS) $(ETAGSFLAGS) $^ -o $@ $(ERROR)
	$(call phony-ok,$(MSG_ETAGS))

########################################################################
##                              COVERAGE                              ##
########################################################################

coverage_dependency := \
    COV => $(patsubst %,$(covdir)/%/,$(srcall))

ifndef COVERAGE
$(covbin):
	$(call phony-vstatus,$(MSG_COV_COMPILE))
	$(quiet) $(MAKE) COVERAGE=1 $@
	$(call phony-ok,$(MSG_COV_COMPILE))
endif

.PHONY: coverage
coverage: coveragedep $(covbin) $(covall)

########################################################################
##                             STATISTICS                             ##
########################################################################

define statistic-count
$(words $1) $(if $(call ne,$(words $1),0),$(strip \
    $(foreach n,$(call rcar,$(call rcdr,$(shell wc -l $1))),$(strip \
        $(if $(call eq,1,$n),($n line),($n lines))\
))))
endef

.PHONY: statistics
statistics:
	@echo "                                                            "
	@echo "$(PROJECT)-$(VERSION)                                       "
	@echo "=============================                               "
	@echo "                                                            "
	@echo "C            : $(call statistic-count,$(c_all))             "
	@echo "C++          : $(call statistic-count,$(cxx_all))           "
	@echo "Fortran      : $(call statistic-count,$(f_all))             "
	@echo "Assembly     : $(call statistic-count,$(asmall))            "
	@echo "Headers      : $(call statistic-count,$(incall))            "
	@echo "Lexers       : $(call statistic-count,$(alllexer))          "
	@echo "Parsers      : $(call statistic-count,$(allparser))         "
	@echo "Embedded SQL : $(call statistic-count,$(cesql))             "
	@echo "Tests        : $(call statistic-count,$(testall))           "
	@echo "-----------------------------------                         "
	@echo "Total        :"\
          "$(call statistic-count,$(srcall) $(asmall) $(incall)        \
           $(alllexer) $(allparser) $(cesql) $(testall))               "
	@echo "                                                            "

########################################################################
##                        INTERNATIONALIZATION                        ##
########################################################################

translation_dependency := \
    XGETTEXT => $(intltl),\
    MSGINIT  => $(intlall),\
    MSGMERGE => $(intlall),\
    MSGFMT   => $(intlobj)

.PHONY: translation
translation: translationdep $(intltl) $(intlobj)

########################################################################
##                          DOCUMENTATION                             ##
########################################################################

docs_dependency := \
    DOXYGEN   => $(doxyfile),\
    MAKEINFO  => $(texiinfo),\
    TEXI2HTML => $(texihtml),\
    TEXI2DVI  => $(texidvi),\
    TEXI2PDF  => $(texipdf),\
    TEXI2PS   => $(texips)

.PHONY: docs
docs: docsdep $(if $(strip $(doxyfile)),doxy)
docs: $(if $(strip $(texiall)),info html dvi pdf ps)

ifneq ($(strip $(doxyfile)),) ####

.PHONY: doxy
doxy: docsdep $(docdir)/$(doxyfile).mk
	$(call phony-status,$(MSG_DOXY_DOCS))
	$(quiet) $(DOXYGEN) $(word 2,2,$^) $(NO_OUTPUT) $(NO_ERROR)
	$(call phony-ok,$(MSG_DOXY_DOCS))

$(docdir)/$(doxyfile).mk: | $(docdir) $(docdir)/doxygen
$(docdir)/$(doxyfile).mk: $(doxyfile) $(srcall) $(incall)
	$(call status,$(MSG_DOXY_MAKE))
	$(quiet) $(CP) $< $@
	
	@echo "                                                      " >> $@
	@echo "######################################################" >> $@
	@echo "##                 MAKEFILE CONFIGS                 ##" >> $@
	@echo "######################################################" >> $@
	@echo "                                                      " >> $@
	@echo "# Project info                                        " >> $@
	@echo "PROJECT_NAME     = $(PROJECT)                         " >> $@
	@echo "PROJECT_NUMBER   = $(VERSION)                         " >> $@
	@echo "PROJECT_BRIEF    = $(SYNOPSIS)                        " >> $@
	@echo "                                                      " >> $@
	@echo "# Source info                                         " >> $@
	@echo "INPUT            = $(call rsubdir,$(srcdir) $(incdir))" >> $@
	@echo "FILE_PATTERNS    = $(addprefix *,$(srcext) $(incext)) " >> $@
	@echo "                                                      " >> $@
	@echo "OUTPUT_DIRECTORY = $(firstword $(docdir)/doxygen)     " >> $@
	
	$(call ok,$(MSG_DOXY_MAKE),$@)

$(doxyfile):
	$(call status,$(MSG_DOXY_FILE))
	$(quiet) $(DOXYGEN) -g $@ $(NO_OUTPUT)
	$(call ok,$(MSG_DOXY_FILE),$@)

$(docdir)/doxygen:
	$(call mkdir,$(docdir)/doxygen)

endif # ifneq($(strip $(doxyfile)),) ####

########################################################################
##                            DISTRIBUTION                            ##
########################################################################

dist_dependency := \
    ZIP   => $(call rfilter,%-zip,$(MAKECMDGOALS)),\
    TAR   => $(call rfilter,package dist tar,$(MAKECMDGOALS))\
             $(call rfilter,dist-tar% package-tar%,$(MAKECMDGOALS)),\
    GZIP  => $(call rfilter,dist-%gz package-tar%gz, $(MAKECMDGOALS)),\
    BZIP2 => $(call rfilter,dist-%bz2 package-tar%bz2, $(MAKECMDGOALS))

.PHONY: package
package: package-tar.gz

.PHONY: dist
dist: dist-tar.gz

.PHONY: tar
tar: dist-tar

########################################################################
##                          DEBIAN PACKAGE                            ##
########################################################################

dpkg_dependency := \
    DEBUILD => $(deball),\
    DCH     => $(debdir)/changelog,

.PHONY: dpkg
dpkg: dpkgdep package-tar.gz $(deball)
	
	@# Step 1: Rename the upstream tarball
	$(call phony-status,$(MSG_DEB_STEP1))
	$(quiet) $(MV) $(distdir)/$(PROJECT)-$(VERSION)_src.tar.gz \
	         $(distdir)/$(DEB_PROJECT)_$(VERSION).orig.tar.gz $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP1))
	
	@# Step 2: Unpack the upstream tarball
	$(call phony-status,$(MSG_DEB_STEP2))
	$(quiet) cd $(distdir) \
	         && tar xf $(DEB_PROJECT)_$(VERSION).orig.tar.gz $(ERROR)
	$(call srmdir,$(distdir)/$(DEB_PROJECT)-$(VERSION))
	$(quiet) $(MV) $(distdir)/$(PROJECT)-$(VERSION)_src \
	         $(distdir)/$(DEB_PROJECT)-$(VERSION) $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP2))
	
	@# Step 3: Add the Debian packaging files
	$(call phony-status,$(MSG_DEB_STEP3))
	$(quiet) $(CP) $(debdir) \
	         $(distdir)/$(DEB_PROJECT)-$(VERSION) $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP3))
	
	@# Step 4: Install the package
	$(call phony-status,$(MSG_DEB_STEP4))
	$(quiet) cd $(distdir)/$(DEB_PROJECT)-$(VERSION) \
	         && $(DEBUILD) $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP4))

# Executes iff one of the make goals is 'dpkg'
ifneq (,$(foreach g,$(MAKECMDGOALS),$(filter $g,dpkg)))

$(debdir)/changelog: | $(debdir)
	$(quiet) $(DCH)

$(debdir)/compat: | $(debdir)
	$(call touch,$@)
	$(quiet) echo 9 >> $@

$(debdir)/control: | $(debdir)
	$(call touch,$@)
	$(call select,$@)
	@echo " "                                                 >> $@
	@echo "Source: $(DEB_PROJECT)"                            >> $@
	@echo "Maintainer: $(MAINTEINER_NAME) $(MAINTEINER_MAIL)" >> $@
	@echo "Section: misc"                                     >> $@
	@echo "Priority: $(DEB_PRIORITY)"                         >> $@
	@echo "Standards-Version: $(VERSION)"                     >> $@
	@echo "Build-Depends: debhelper (>= 9)"                   >> $@
	@echo " "                                                 >> $@
	@echo "Package: $(DEB_PROJECT)"                           >> $@
	@echo "Architecture: any"                                 >> $@
	@echo "Depends: "$$"{shlibs:Depends}, "$$"{misc:Depends}" >> $@
	@echo "Description: $(SYNOPSIS)"                          >> $@
	@echo " $(DESCRIPTION)"                                   >> $@
	$(call select,stdout)

$(debdir)/copyright: | $(debdir)
	$(call touch,$@,$(notice))

$(debdir)/rules: | $(debdir)
	$(call touch,$@)
	$(call select,$@)
	$(call cat,"#!/usr/bin/make -f                                    ")
	$(call cat,"                                                      ")
	$(call cat,"%:                                                    ")
	$(call cat,"\tdh "$$"@                                            ")
	$(call cat,"                                                      ")
	$(call cat,"override_dh_auto_install:                             ")
	$(call cat,"\t"$$"(MAKE) \\"                                       )
	$(call cat,"    DESTDIR="$$""$$"(pwd)/debian/$(DEB_PROJECT) \\"    )
	$(call cat,"    prefix=/usr install"                               )
	$(call select,stdout)

$(debdir)/source/format: | $(debdir)
	$(call mksubdir,$(debdir),$@)
	$(call touch,$@)
	$(quiet) echo "3.0 (quilt)" >> $@

$(debdir)/$(DEB_PROJECT).dirs: | $(debdir)
	$(call touch,$@)
	$(call select,$@)
	$(if $(strip $(bin)),     $(call cat,'$(i_bindir)                '))
	$(if $(strip $(sbin)),    $(call cat,'$(i_sbindir)               '))
	$(if $(strip $(libexec)), $(call cat,'$(i_libexecdir)            '))
	$(if $(strip $(lib)),     $(call cat,'$(i_libdir)                '))
	$(if $(strip $(texiinfo)),$(call cat,'$(i_docdir)/info           '))
	$(call select,stdout)
endif

########################################################################
##                           INSTALLATION                             ##
########################################################################

install_dependency := \
    INSTALL         => $(i_lib) $(i_bin) $(i_sbin) $(i_libexec),\
    INSTALL_DATA    => $(i_lib),\
    INSTALL_PROGRAM => $(i_bin) $(i_sbin) $(i_libexec)

.PHONY: install-strip
install-strip: installdep
	$(MAKE) INSTALL_PROGRAM='$(INSTALL_PROGRAM) -s' install

.PHONY: install
install: installdep $(i_lib) $(i_bin) $(i_sbin) $(i_libexec) \
         install-docs

.PHONY: install-docs
install-docs: installdep install-info install-html install-dvi
install-docs: install-pdf install-ps

.PHONY: install-info
install-info:
	$(if $(strip $(texiinfo)),$(foreach f,$(texiinfo),\
        $(INSTALL_DATA) $f $(i_infodir)/$(notdir $f);\
        if $(SHELL) -c '$(INSTALL_INFO) --version' $(NO_OUTPUT) 2>&1; \
        then \
            $(INSTALL_INFO) --dir-file="$(i_infodir)/dir" \
            "$(i_infodir)/$(notdir $f)"; \
        else true; fi;\
    ))

.PHONY: installcheck
installcheck:
	$(call phony-ok,"No installation test avaiable")

########################################################################
##                          UNINSTALLATION                            ##
########################################################################

# Remove subdirectories of this directory
# Remove files if no subdir was identified
define uninstall
$(if $(strip $(i_$1)),\
    $(if $(sort $(foreach d,\
        $(call root,$(call not-root,$($1))),\
        $(call rsubdir,$(i_$1dir)/$d)\
    )),
        $(call rm-if-empty,\
            $(call invert,$(sort $(foreach d,\
                $(call root,$(call not-root,$($1))),\
                $(call rsubdir,$(i_$1dir)/$d)\
            ))),\
            $(i_$1)\
        ),\
        $(if $(strip $(foreach f,$(i_$1),$(wildcard $f))),\
            $(call rm,$(i_$1)))\
))
endef

.PHONY: mainteiner-uninstall
mainteiner-uninstall:
	@$(MAKE) uninstall DESTDIR=$(destdir) MAINTEINER_CLEAN=1

.PHONY: uninstall
uninstall:
	$(call uninstall,lib)
	$(call uninstall,bin)
	$(call uninstall,sbin)
	$(call uninstall,libexec)

.PHONY: uninstall-docs
uninstall-docs: uninstall-info uninstall-html uninstall-dvi
uninstall-docs: uninstall-pdf uninstall-ps

.PHONY: uninstall-info
uninstall-info:
	$(if $(strip $(texiinfo)),$(call rm-if-empty,$(i_infodir),\
	    $(addprefix $(i_infodir)/,$(notdir $(texiinfo)))\
	))

########################################################################
##                              RULES                                 ##
########################################################################

# Include dependencies for each src extension, unless cleaning files
ifneq ($(patsubst %clean,clean,$(MAKECMDGOALS)),clean)
-include $(wildcard $(depall))
-include $(wildcard $(progdep))
-include $(wildcard $(externdep))
-include $(wildcard $(syslibdep))
endif

#======================================================================#
# Function: program-dependency-target                                  #
# @param  $1 Dependency name (for targets)                             #
# @param  $2 Dependency nick (hash key)                                #
# @return Target to check a set of dependencies defined in $2          #
#======================================================================#
define program-dependency-target
# Creates hash from hash-key
$$(call hash-table.new,$2)

# Verifies if programs of $1dep are the same. If they changed, deletes 
# old program dependency file and checks if the new is avaiable.
.PHONY: $1dep
$1dep: \
    $$(foreach k,$$(call hash-table.keys,$2),$$(if \
        $$(and $$(strip $$(OLD_$$k)),$$(call ne,$$(OLD_$$k),$$($$k))),\
            $$(shell $$(RM) \
                $$(addprefix $$(depdir)/$$(firstword $$(bindir))/,\
                    $$(addsuffix $$(sysext),$$k) \
            )) \
    )) \
    $$(if $$(strip $$(call hash-table.values,$2)),\
        $$(depdir)/$1$$(sysext))
endef
$(foreach d,build external upgrade init tags coverage \
            translation docs doxy dist dpkg install,\
    $(eval $(call program-dependency-target,$d,$d_dependency)))

#======================================================================#
# Function: program-dependency                                         #
# @param  $1 Complete library path                                     #
# @param  $2 Library name                                              #
# @return Target to check if program exists                            #
#======================================================================#
define program-dependency
$$(depdir)/$$(firstword $$(bindir))/$1$$(sysext): d=$1
$$(depdir)/$$(firstword $$(bindir))/$1$$(sysext): | $$(depdir)
	$$(if $$(strip $$($1)),,$$(call phony-error,$$(MSG_PRG_UNDEFINED)))
	$$(call phony-status,$$(MSG_PRG_SEARCH))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) which $$(firstword $$($1)) $$(NO_OUTPUT) $$(NO_ERROR) \
	          || $$(call model-error,$$(MSG_PRG_NOT_FOUND))
	
	$$(if $$(strip $$(program_version.$1)),\
	    $$(if $$(call version-ge,\
	             $$(lastword $$(shell $$(firstword $$($1)) --version \
	                 | grep "\([0-9a-zA-Z]\+[-.]\)\+[0-9a-zA-Z]$$$$")),\
	             $$(lastword $$(program_version.$1))\
	        ),,\
	        $$(call phony-error,$$(MSG_PRG_BAD_VER))\
	))
	
	$$(call select,$$@)
	$$(call cat,'override OLD_$1 := $$($1)')
	
	$$(call phony-ok,$$(MSG_PRG_SEARCH))
endef
$(foreach p,$(programs),$(eval $(call program-dependency,$p)))

#======================================================================#
# Function: library-dependency-target                                  #
# @param  $1 Dependency name (for targets)                             #
# @param  $3 Dependency nick (hash key)                                #
# @return Target to check a set of dependencies defined in $2          #
#======================================================================#
define library-dependency-target
.PHONY: $1dep
$1dep: \
    $$(foreach l,$$(old_syslib),\
        $$(if $$(findstring $$l,$$(syslib)),,\
            $$(shell $$(RM) \
                $$(addprefix $$(depdir)/$$(firstword $$(libdir))/,\
                    $$(addsuffix $$(sysext),\
                        $$(patsubst lib%,%,$$(notdir $$(basename $$l)))\
            ))) \
    )) \
    $$(if $$(strip $$(call hash-table.values,$2)),\
        $$(depdir)/$1$$(sysext))
endef
$(foreach d,library,\
    $(eval $(call library-dependency-target,$d,$d_version)))

#======================================================================#
# Function: library-dependency                                         #
# @param  $1 Program name                                              #
# @return Target to check if program exists                            #
#======================================================================#
define library-dependency
$$(depdir)/$$(firstword $$(libdir))/$1$$(sysext): d=$1
$$(depdir)/$$(firstword $$(libdir))/$1$$(sysext): | $$(depdir)
	$$(call phony-status,$$(MSG_LIB_SEARCH))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) ls $2* $$(NO_OUTPUT) $$(NO_ERROR) \
	          || $$(call model-error,$$(MSG_LIB_NOT_FOUND))
	
	$$(if $$(strip $$(library_version.$1)),\
	    $$(if $$(lastword $$(shell ls $2* \
	              | sed 's/[^ ]\+$$(suffix $2).//')),,\
	        $$(call prony-error,$$(MSG_LIB_NO_VERSION))\
	))
	
	$$(if $$(strip $$(library_version.$1)),\
	    $$(if $$(call version-ge,\
	             $$(lastword $$(shell ls $2* \
	                 | sed 's/[^ ]\+$$(suffix $3).//')),\
	             $$(lastword $$(library_version.$1))\
	        ),,\
	        $$(call phony-error,$$(MSG_LIB_BAD_VER))\
	))
	
	$$(call select,$$@)
	$$(call cat,'override old_syslib := $$(syslib)')
	
	$$(call phony-ok,$$(MSG_LIB_SEARCH))
endef
$(foreach p,$(syslib),$(strip \
    $(eval $(call library-dependency,$(patsubst lib%,%,\
               $(notdir $(basename $(call not-extra-suffix,$p)))),$p,\
               $(call not-extra-suffix,$p)))))

#======================================================================#
# Function: extern-dependency-target                                   #
# @param  $1 Dependency name (for targets)                             #
# @param  $3 Dependency nick (hash key)                                #
# @return Target to check a set of dependencies defined in $2          #
#======================================================================#
define extern-dependency-target
.PHONY: $1dep
$1dep: \
    $$(foreach d,$$(old_externdep),\
        $$(if $$(findstring $$l,$$(externdep)),,\
            $$(shell $$(RM) \
                $$(addprefix $$(depdir)/$$(firstword $$(extdir))/,\
                    $$(addsuffix $$(extext),$$l)\
            ))\
    )) \
    $$(if $$(strip $$(call hash-table.values,$2)),\
        $$(depdir)/$1$$(sysext))
endef
$(foreach d,git web,\
    $(eval $(call extern-dependency-target,$d,$d_dependency)))

#======================================================================#
# Function: extern-dependency                                          #
# @param  $1 Dependency nick (hash key)                                #
# @param  $2 Dependency path (hash value)                              #
# @return Target to download git dependencies for building             #
#======================================================================#
define extern-dependency
$$(extdir)/$1: | $$(extdir)
	$$(call $2,$$(call car,$3),$$@)

$$(depdir)/$$(firstword $$(extdir))/$1$$(sysext): d=$$(extdir)/$1
$$(depdir)/$$(firstword $$(extdir))/$1$$(sysext): $$(externreq)
	$$(call status,$$(MSG_EXT_BUILD))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(if $$(call cdr,$3),$$(strip \
	              (cd $$d && $$(call cdr,$3)) $$(ERROR) \
	              || $$(call model-error,$$(MSG_EXT_BUILD_ERR)) \
	          ),$$(strip \
	              if [ -f $$d/[Mm]akefile ]; then \
	                  cd $$d && $$(MAKE) -f [Mm]akefile $$(ERROR) \
	                  || $$(call model-error,$$(MSG_EXT_BUILD_ERR)); \
	              elif [ -f $$d/$$(makedir)/[Mm]akefile ]; then \
	                  cd $$d/$$(makedir) \
	                  && $$(MAKE) -f [Mm]akefile $$(ERROR) \
	                  || $$(call model-error,$$(MSG_EXT_BUILD_ERR)); \
	              else \
	                  echo "$$(MSG_EXT_NO_MAKE)" $$(ERROR); \
	              fi \
	          ))
	
	$$(call select,$$@)
	$$(call cat,'override old_externdep := $$(externdep)')
	
	$$(call ok,$$(MSG_EXT_BUILD))
endef
$(foreach d,$(call hash-table.keys,git_dependency),$(eval\
    $(call extern-dependency,$d,git-submodule-add,$(git_dependency.$d))))
$(foreach d,$(call hash-table.keys,web_dependency),$(eval\
    $(call extern-dependency,$d,web-clone,$(web_dependency.$d))))

#======================================================================#
# Function: phony-target-dependency                                    #
# @param  $1 Dependency name (for targets)                             #
# @param  $2 Dependency nick (hash key)                                #
# @return Target to check a set of dependencies defined in $2          #
#======================================================================#
define phony-target-dependency
$$(depdir)/$$(strip $1)$$(sysext): n=$1
$$(depdir)/$$(strip $1)$$(sysext): \
    $$(foreach k,$3,$$(if $$(strip $$($2.$$k)),$4/$$k$$(sysext))) \
    | $$(depdir)
	
	$$(quiet) touch $$@
	$$(call phony-ok,$$(MSG_PRG_ALL))
endef
$(foreach d,build external upgrade init tags coverage \
            translation docs doxy dist dpkg install,\
    $(eval $(call phony-target-dependency,$d,$d_dependency,\
               $(call hash-table.keys,$d_dependency),\
               $(depdir)/$(firstword $(bindir)))))
$(foreach d,library,\
    $(eval $(call phony-target-dependency,$d,$d_version,\
               $(call hash-table.keys,$d_version),\
               $(depdir)/$(firstword $(libdir)))))
$(foreach d,git web,\
    $(eval $(call phony-target-dependency,$d,$d_dependency,\
               $(call invert,$(call hash-table.keys,$d_dependency)),\
               $(depdir)/$(firstword $(extdir)))))

#======================================================================#
# Function: scanner-factory                                            #
# @param  $1 Basename of the lex file                                  #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files according to its type        #
#======================================================================#
define scanner-factory
# Recompile target iff the include directory not exists
$$(firstword $$(srcdir))/$1.yy.$2: \
    $$(if $$(wildcard $$(firstword $$(incdir))/$1-yy),,\
    $$(firstword $$(incdir))/$1-yy)

$$(firstword $$(srcdir))/$1.yy.$2: $3
	$$(call status,$$(MSG_LEX))
	
	$$(quiet) $$(MV) $$< $$(firstword $$(incdir))/$1-yy/
	$$(quiet) cd $$(firstword $$(incdir))/$1-yy/ \
	          && $4 $$(lexflags) $$(notdir $$<) $$(ERROR)
	$$(quiet) $$(MV) $$(firstword $$(incdir))/$1-yy/$$(notdir $$<) $$<
	$$(quiet) $$(MV) $$(firstword $$(incdir))/$1-yy/*.$2 $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_LEX),$$@)

ifeq ($$(wildcard $$(firstword $$(incdir))/$1-yy),)
$$(firstword $$(incdir))/$1-yy/:
	$$(call mkdir,$$@)
endif
endef
$(foreach s,$(clexer),$(eval\
    $(call scanner-factory,$(call not-root,$(basename $s)),c,$s,\
    $(LEX))\
))
$(foreach s,$(cxxlexer),$(eval\
    $(call scanner-factory,$(call not-root,$(basename $s)),cc,$s,\
    $(LEXCXX))\
))

#======================================================================#
# Function: parser-factory                                             #
# @param  $1 Basename of the yacc file                                 #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files accordingly to their types   #
#======================================================================#
define parser-factory
$$(firstword $$(srcdir))/$1.tab.$2: \
    $$(if $$(wildcard $$(firstword $$(incdir))/$1-tab),,\
    $$(firstword $$(incdir))/$1-tab)

$$(firstword $$(srcdir))/$1.tab.$2: $3 $$(lexall)
	$$(call status,$$(MSG_YACC))
	
	$$(quiet) $$(MV) $$< $$(firstword $$(incdir))/$1-tab/
	$$(quiet) cd $$(firstword $$(incdir))/$1-tab/ \
	          && $4 $$(yaccflags) $$(notdir $$<) $$(ERROR)
	$$(quiet) $$(MV) $$(firstword $$(incdir))/$1-tab/$$(notdir $$<) $$<
	$$(quiet) $$(MV) $$(firstword $$(incdir))/$1-tab/*.$2 $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_YACC),$$@)

ifeq ($$(wildcard $$(firstword $$(incdir))/$1-tab),)
$$(firstword $$(incdir))/$1-tab/:
	$$(call mkdir,$$@)
endif
endef
$(foreach s,$(cparser),$(eval\
    $(call parser-factory,$(call not-root,$(basename $s)),c,$s,\
    $(YACC))\
))
$(foreach s,$(cxxparser),$(eval\
    $(call parser-factory,$(call not-root,$(basename $s)),cc,$s,\
    $(YACCCXX))\
))

#======================================================================#
# Function: esql-factory                                               #
# @param  $1 Basename of the esql file                                 #
# @return Target to generate source files from embeddes SQL            #
#======================================================================#
define esql-factory
$$(firstword $$(srcdir))/$1.$2: $3
	$$(call status,$$(MSG_ESQL))
	$$(quiet) $$(ESQL) $$(esqlflags) -c $$< -o $$@ $$(ERROR)
	$$(call ok,$$(MSG_ESQL),$$@)
endef
$(foreach s,$(cesql),$(eval\
    $(call esql-factory,$(call not-root,$(basename $s)),c,$s)\
))

#======================================================================#
# Function: compile-asm                                                #
# @param  $1 Directory for object files                                #
# @param  $2 Root source directory                                     #
# @param  $3 Assembly extension                                        #
# @return Target to compile all Assembly files with the given          #
#         extension, looking in the right root directory               #
#======================================================================#
define compile-asm
$1/%$$(firstword $$(objext)): $2/%$3 | $$(depdir)
	$$(call status,$$(MSG_ASM_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call c-depend,$$<,$$@,$$(call not-root,$1/$$*))
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(AS) $$(cppflags) $$(asflags) $$(aslibs) \
	                 $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_ASM_COMPILE),$$@)
endef
$(foreach r,$(srcdir),\
    $(foreach e,$(asmext),\
        $(eval $(call compile-asm,$(objdir),$r,$e))))

#======================================================================#
# Function: compile-c                                                  #
# @param  $1 Directory for object files                                #
# @param  $2 Root source directory                                     #
# @param  $3 C extension                                               #
# @return Target to compile all C files with the given extension,      #
#         looking in the right root directory                          #
#======================================================================#
define compile-c
$1/%$$(firstword $$(objext)): $2/%$3 | $$(depdir)
	$$(call status,$$(MSG_C_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call c-depend,$$<,$$@,$$(call not-root,$1/$$*))
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CC) $$(cppflags) $$(cflags) $$(clibs) \
	                 -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_C_COMPILE),$$@)
endef
$(foreach r,$(srcdir),$(foreach e,$(cext),\
    $(eval $(call compile-c,$(objdir),$r,$e))))
$(foreach e,$(cext),\
    $(eval $(call compile-c,$(objdir)/$(testdir),$(testdir),$e)))

#======================================================================#
# Function: compile-cpp                                                #
# @param  $1 Directory for object files                                #
# @param  $2 Root source directory                                     #
# @param  $3 C++ extension                                             #
# @return Target to compile all C++ files with the given extension     #
#         looking in the right root directory                          #
#======================================================================#
define compile-cpp
$1/%$$(firstword $$(objext)): $2/%$3 | $$(depdir)
	$$(call status,$$(MSG_CXX_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call cpp-depend,$$<,$$@,$$(call not-root,$1/$$*))
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CXX) $$(cppflags) $$(cxxlibs) $$(cxxflags) \
	                  -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_CXX_COMPILE),$$@)
endef
$(foreach r,$(srcdir),$(foreach e,$(cxxext),\
    $(eval $(call compile-cpp,$(objdir),$r,$e))))
$(foreach e,$(cxxext),\
    $(eval $(call compile-cpp,$(objdir)/$(testdir),$(testdir),$e)))

#======================================================================#
# Function: compile-fortran                                            #
# @param  $1 Directory for object files                                #
# @param  $2 Root source directory                                     #
# @param  $3 Fortran extension                                         #
# @return Target to compile all Fortran files with the given           #
#         extension, looking in the right root directory               #
#======================================================================#
define compile-fortran
$1/%$$(firstword $$(objext)): $2/%$3 | $$(depdir)
	$$(call status,$$(MSG_F_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call fortran-depend,$$<,$$@,$$(call not-root,$3/$$*))
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(FC) $$(cppflags) $$(fflags) $$(flibs) \
	                 -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_F_COMPILE),$$@)
endef
$(foreach r,$(srcdir),$(foreach e,$(fext),\
    $(eval $(call compile-fortran,$(objdir),$r,$e))))
$(foreach e,$(fext),\
    $(eval $(call compile-fortran,$(objdir)/$(testdir),$(testdir),$e)))

#======================================================================#
# Function: compile-sharedlib-linux-c                                  #
# @param  $1 File root directory                                       #
# @param  $2 File basename without root dir                            #
# @param  $3 File extension                                            #
# @return Target to compile the C library file                         #
#======================================================================#
define compile-sharedlib-linux-c
$$(objdir)/$2$$(firstword $$(objext)): $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_C_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call c-depend,$$<,$$@,$2)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CC) -fPIC $$(cppflags) $$(clibs) $$(cflags) \
	                 -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_C_LIBCOMP),$$@)
endef
$(foreach s,$(foreach E,$(cext),$(filter %$E,$(shrall))),\
    $(eval $(call compile-sharedlib-linux-c,$(call root,$s)/,$(call not-root,$(basename $s)),$(suffix $s))))

#======================================================================#
# Function: compile-sharedlib-linux-cpp                                #
# @param  $1 File root directory                                       #
# @param  $2 File basename without root dir                            #
# @param  $3 File extension                                            #
# @return Target to compile the C++ library file                       #
#======================================================================#
define compile-sharedlib-linux-cpp
$$(objdir)/$2$$(firstword $$(objext)): $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_CXX_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call cpp-depend,$$<,$$@,$2)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CXX) -fPIC $$(cppflags) $$(cxxlibs) $$(cxxflags) \
	                  -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_CXX_LIBCOMP),$$@)
endef
$(foreach s,$(foreach E,$(cxxext),$(filter %$E,$(shrall))),\
    $(eval $(call compile-sharedlib-linux-cpp,$(call root,$s)/,$(call not-root,$(basename $s)),$(suffix $s))))

#======================================================================#
# Function: compile-sharedlib-linux-fortran                            #
# @param  $1 File root directory                                       #
# @param  $2 File basename without root dir                            #
# @param  $3 File extension                                            #
# @return Target to compile the Fortran library file                   #
#======================================================================#
define compile-sharedlib-linux-fortran
$$(objdir)/$2$$(firstword $$(objext)): $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_F_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call fortran-depend,$$<,$$@,$2)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(FC) -fPIC $$(cppflags) $$(flibs) $$(fflags) \
	                 -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_F_LIBCOMP),$$@)
endef
$(foreach s,$(foreach E,$(fext),$(filter %$E,$(shrall))),\
    $(eval $(call compile-sharedlib-linux-fortran,$(call root,$s)/,$(call not-root,$(basename $s)),$(suffix $s))))

#======================================================================#
# Function: link-sharedlib-linux                                       #
# @param  $1 Directory in which the lib may be put                     #
# @param  $2 Subdirectories in which the lib may be put                #
# @param  $3 File/dir basename that makes the name of the dir          #
# @param  $4 Object dependencies of this static library                #
# @return Target to create a shared library from objects               #
#======================================================================#
define link-sharedlib-linux
$1/$2lib$3.so: $4 | $1
	$$(call status,$$(MSG_CXX_SHRDLIB))
	$$(quiet) $$(call mksubdir,$1,$$(objdir)/$2)
	$$(quiet) $$(CXX) $$(soflags) -o $$@ $$^ $$(ERROR)
	$$(call ok,$$(MSG_CXX_SHRDLIB),$$@)
endef
$(foreach s,$(shrpatsrc),\
    $(eval $(call link-sharedlib-linux,$(firstword $(libdir)),$(patsubst ./%,%,$(dir $s)),$(notdir $(basename $s)),$(shrobj_$s))))

#======================================================================#
# Function: link-statlib-linux                                         #
# @param  $1 Directory in which the lib may be put                     #
# @param  $2 Subdirectories in which the lib may be put                #
# @param  $3 File/dir basename that makes the name of the dir          #
# @param  $4 Object dependencies of this static library                #
# @return Target to create a static library from objects               #
#======================================================================#
define link-statlib-linux
$1/$2lib$3.a: $4 | $1
	$$(call status,$$(MSG_STATLIB))
	$$(quiet) $$(call mksubdir,$1,$$(objdir)/$2)
	$$(quiet) $$(AR) $$(arflags) $$@ $$^ $$(NO_OUTPUT) $$(NO_ERROR)
	$$(quiet) $$(RANLIB) $$@
	$$(call ok,$$(MSG_STATLIB),$$@)
endef
$(foreach a,$(arpatsrc),\
    $(eval $(call link-statlib-linux,$(firstword $(libdir)),$(patsubst ./%,%,$(dir $a)),$(notdir $(basename $a)),$(arobj_$a))))

#======================================================================#
# Function: test-factory                                               #
# @param  $1 Unit test binary's directory name                         #
# @param  $1 Unit test binary's name without root directory            #
# @param  $3 Alias to execute tests, prefixing run_ and                #
#            substituting / for _ in $(testdep)                        #
# @return Target to generate binary file for the unit test             #
#======================================================================#
ifneq (,$(foreach g,$(MAKECMDGOALS),$(filter $g,check)))
define test-factory
$1/$2: $$($2_obj) | $1
	$$(call status,$$(MSG_TEST_COMPILE))
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(CXX) $$^ -o $$@ $$(ldflags) $$(ldlibs)
	$$(call ok,$$(MSG_TEST_COMPILE),$$@)

.PHONY: $3
$3: $1/$2
	$$(call phony-vstatus,$$(MSG_TEST))
	@./$$< || $$(call model-test-error,$$(MSG_TEST_FAILURE))
	$$(call ok,$$(MSG_TEST))
endef
$(foreach t,$(testbin),$(eval\
    $(call test-factory,$(call root,$t),$(call not-root,$t),\
    run_$(subst /,_,$t)\
)))
endif

#======================================================================#
# Function: binary-factory                                             #
# @param  $1 Binary root directory                                     #
# @param  $1 Binary name witout root dir                               #
# @param  $3 Comments to be used (C's, Fortran's or C++'s)             #
# @param  $4 Compiler to be used (C's, Fortran's or C++'s)             #
# @return Target to generate binaries and dependencies of its object   #
#         files (to create objdir and automatic source)                #
#======================================================================#
define binary-factory
$1/$2: $$($2_lib) $$($2_aobj) $$($2_obj) | $1
	$$(call status,$$(MSG_$$(strip $3)_LINKAGE))
	
	@# Check if executable has files
	$$(if $$(strip $$($2_all)),,\
	    $$(call phony-error,$$(MSG_$$(strip $3)_NO_FILE)))
	
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $4 $$($2_aobj) $$($2_obj) -o $$@ \
	          $$(ldflags) $$($2_link) $$(ldlibs) $$(ERROR)
	$$(call ok,$$(MSG_$$(strip $3)_LINKAGE),$$@)

$$($2_obj): | $$(objdir)

$$($2_aobj): $$($2_aall) | $$(objdir)
endef
$(foreach b,$(binall),$(eval \
    $(call binary-factory,$(bindir),$(notdir $b),\
    $(strip \
        $(if $($(notdir $b)_is_c),C,\
        $(if $($(notdir $b)_is_f),F,\
        $(if $($(notdir $b)_is_cxx),CXX,CXX\
    )))),\
    $(strip \
        $(if $($(notdir $b)_is_c),$(CC),\
        $(if $($(notdir $b)_is_f),$(FC),\
        $(if $($(notdir $b)_is_cxx),$(CXX),$(CXX)\
    )))),\
)))

#======================================================================#
# Function: coverage-factory                                           #
# @param  $1 Binary root directory                                     #
# @param  $1 Binary name witout root dir                               #
# @param  $3 Comments to be used (C's, Fortran's or C++'s)             #
# @param  $4 Compiler to be used (C's, Fortran's or C++'s)             #
# @return Target to generate binaries and dependencies of its object   #
#         files (to create objdir and automatic source)                #
#======================================================================#
define coverage-factory
$1/$2/%$3: $1/$$(objdir)/%$$(firstword $$(objext)) $1/$$(objdir)/%.* | $1
	$$(call phony-status,$$(MSG_COV))
	
	$$(call mksubdir,$1,$$@/)
	$$(quiet) $$(COV) $$(COVFLAFS) -o $1/$$(objdir) $2/$$*$3 \
	          1> $$(basename $$@/$$*).out $$(ERROR)
	$$(quiet) $$(foreach e,$$(covext),$$(strip \
	              for f in *$$e; do \
	                  [ ! -f "$$$$f" ] && break; \
	                  $$(MV) $$$$f $$@ $$(ERROR); \
	              done;\
	          ))
	
	$$(call phony-ok,$$(MSG_COV))
endef
$(foreach r,$(srcdir),$(foreach s,$(srcext),$(foreach c,$(covext),\
    $(eval $(call coverage-factory,$(covdir),$r,$s,$c)))))

#======================================================================#
# Function: intl-template-factory                                      #
# @param  $1 Locale root directory                                     #
# @param  $1 Binary name witout root dir                               #
# @return Target to generate template translations for translators     #
#======================================================================#
ifneq (,$(strip $(ENABLE_NLS)))
define intl-template-factory
$1/$2$$(firstword $$(potext)): $$($2_all) | $1
	$$(call status,$$(MSG_INTL_TEMPLATE))
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(XGETTEXT)\
	          --copyright-holder=$$(call shstring,$$(COPYRIGHT))\
	          --msgid-bugs-address=$$(call shstring,$$(MAINTEINER_MAIL))\
	          --package-name=$$(call shstring,$$(PROJECT))\
	          --package-version=$$(VERSION)\
	          -d $2 -k_ -kN_ -s $$^ -o $$@
	$$(call ok,$$(MSG_INTL_TEMPLATE),$$@)
endef
$(foreach b,$(binall),$(eval\
    $(call intl-template-factory,$(strip\
        $(localedir)),$(call not-root,$(basename $b)))))
endif

#======================================================================#
# Function: intl-translate-factory                                     #
# @param  $1 Locale root directory                                     #
# @param  $1 Binary name witout root dir                               #
# @return Target to generate machine objects to be used by binaries    #
#======================================================================#
ifneq (,$(strip $(ENABLE_NLS)))
define intl-translate-factory
$1/%/$2$$(firstword $$(poext)): $1/$2$$(firstword $$(potext))
	$$(call phony-status,$$(MSG_INTL_PORTABLE))
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(if $$(strip $$(wildcard $$@)),\
	              $$(MSGMERGE) $$@ $$< -o $$@ $$(ERROR),\
	              $$(MSGINIT)  -l $$* -i $$< -o $$@ $$(ERROR))
	$$(call phony-ok,$$(MSG_INTL_PORTABLE),$$@)

$1/%/LC_MESSAGES/$2$$(firstword $$(moext)): $1/%/$2$$(firstword $$(poext))
	$$(call status,$$(MSG_INTL_MACHINE))
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(MSGFMT) $$< -o $$@ $$(ERROR)
	$$(call ok,$$(MSG_INTL_MACHINE),$$@)
endef
$(foreach t,$(intltl),$(eval\
    $(call intl-translate-factory,$(strip \
        $(localedir)),$(call not-root,$(basename $t)))))
endif

#======================================================================#
# Function: texinfo-factory                                            #
# @param  $1 Type of doc to be generated                               #
# @param  $2 Extension that should be used for the doc file type       #
# @param  $3 Command to generate the doc file                          #
# @return Three targets: one to generate all files of a doc type; one  #
#         general target to create the files of this doc type; and a   #
#         target to generate the dir where the files should be put     #
#======================================================================#
define texinfo-factory
.PHONY: $1
$1: docsdep $$(texi$1)
	$$(call phony-ok,$$(MSG_TEXI_DOCS))

$$(docdir)/$1/%$2: $$(filter $$(docdir)/$$*%,$$(texiall)) | $$(docdir)/$1
	$$(call status,$$(MSG_TEXI_FILE))
	$$(call mksubdir,$$(docdir)/$1,$$<)
	$$(quiet) $3 $$< -o $$@ $$(ERROR)
	$$(call srm,$$(notdir $$(basename $$@)).*)
	$$(call ok,$$(MSG_TEXI_FILE),$$@)

$$(docdir)/$1:
	$$(quiet) $$(call mkdir,$$@)
endef
$(eval $(call texinfo-factory,info,$(firstword $(infoext)),$(MAKEINFO)))
$(eval $(call texinfo-factory,html,$(firstword $(htmlext)),$(TEXI2HTML)))
$(eval $(call texinfo-factory,dvi,$(firstword $(dviext)),$(TEXI2DVI)))
$(eval $(call texinfo-factory,pdf,$(firstword $(pdfext)),$(TEXI2PDF)))
$(eval $(call texinfo-factory,ps,$(firstword $(psext)),$(TEXI2PS)))

#======================================================================#
# Function: install-texinfo-factory                                    #
# @param  $1 Type of doc to be generated                               #
# @return Two targets: one to install the files of the specified doc   #
#         type (creating the directory as needed); and another one to  #
#         uninstall these files and delete the dir (if empty).         #
#======================================================================#
define install-texinfo-factory
.PHONY: install-$1
install-$1:
	$$(if $$(strip $$(texi$1)),$$(call mkdir,$$(i_$1dir)))
	$$(if $$(strip $$(texi$1)),$$(foreach f,$$(texi$1),\
	    $$(call phony-status,$$(MSG_INSTALL_DOC));\
	    $$(INSTALL_DATA) $$f $$(i_$1dir)/$$(notdir $$f);\
	    $$(call phony-ok,$$(MSG_INSTALL_DOC));\
	))

.PHONY: uninstall-$1
uninstall-$1:
	$$(if $$(strip $$(texi$1)),$$(call rm-if-empty,$$(i_$1dir),\
	    $$(addprefix $$(i_$1dir)/,$$(notdir $$(texi$1)))\
	))
endef
$(foreach type,html dvi pdf ps,\
    $(eval $(call install-texinfo-factory,$(type))))

#======================================================================#
# Function: installdirs                                                #
# @param  $1 Directory to be created for installation                  #
# @return Target to create directory for some installation             #
#======================================================================#
define installdirs
$1:
	$$(call mkdir,$$@)
endef
$(foreach d,$(i_libdir) $(i_bindir) $(i_sbindir) $(i_libexecdir),\
    $(eval $(call installdirs,$d)))

#======================================================================#
# Function: install-data                                               #
# @param  $1 Directory where the installation should be made           #
# @param  $2 Name of the data file to be installed                     #
# @return Target to install some data file                             #
#======================================================================#
define install-data
$1/$$(call not-root,$2): | $1
	$$(call phony-status,$$(MSG_INSTALL_DAT))
	$$(call mksubdir,$1,$2)
	$$(quiet) $$(INSTALL_DATA) $2 $$@
	$$(call phony-ok,$$(MSG_INSTALL_DAT))
endef
$(foreach t,lib,$(foreach b,$($t),\
    $(eval $(call install-data,$(i_$tdir),$b))))

#======================================================================#
# Function: install-program                                            #
# @param  $1 Directory where the installation should be made           #
# @param  $2 Name of the binary program to be installed                #
# @return Target to install some program                               #
#======================================================================#
define install-program
$1/$$(call not-root,$2): | $1
	$$(call phony-status,$$(MSG_INSTALL_BIN))
	$$(call mksubdir,$1,$2)
	$$(quiet) $$(INSTALL_PROGRAM) $2 $$@
	$$(call phony-ok,$$(MSG_INSTALL_BIN))
endef
$(foreach t,bin sbin libexec,$(foreach b,$($t),\
    $(eval $(call install-program,$(i_$tdir),$b))))

#======================================================================#
# Function: packsyst-factory                                           #
# @param  $1 Extension of the file package system                      #
# @param  $2 Part of the name of the var with text to be outputed      #
# @param  $3 Program to be used to generate the package                #
# @return Target to create a package with dirs specified by 'dirs' var #
#======================================================================#
define packsyst-factory
%.$1: clndirs = $$(foreach d,$$(dirs),$$(if $$(wildcard $$d*),$$d))
%.$1: packdir = $$(notdir $$*)
%.$1: packdep = $$(addprefix $$(packdir)/,\
        $$(strip $$(foreach f,$$(dirs),$$(or \
            $$(strip $$(call rwildcard,$$f,*)),\
            $$(strip $$(wildcard $$f*))) )))
%.$1: distdep $$(binall)
	$$(call mkdir,$$(dir $$@))
	$$(quiet) $$(MKDIR) $$(packdir)
	$$(quiet) $$(CP) $$(clndirs) $$(packdir)
	
	$$(call vstatus,$$(MSG_MAKE$2))
	$$(quiet) $3 $$@ $$(packdep)
	$$(call ok,$$(MSG_MAKE$2),$$@)
	
	$$(quiet) $$(RMDIR) $$(packdir)
endef
$(eval $(call packsyst-factory,tar,TAR,$(TAR)))
$(eval $(call packsyst-factory,zip,ZIP,$(ZIP)))

#======================================================================#
# Function: compression-factory                                        #
# @param  $1 Extension to be added in the compressed file              #
# @param  $2 Extension of the uncompressed file (for dependency)       #
# @param  $3 Part of the name of the var with text to be outputed      #
# @param  $4 Program to be used to generate the compressed package     #
# @return Target to create a compressed package from uncompressed one  #
#======================================================================#
define compression-factory
%.$1: %.$2
	$$(call status,$$(MSG_MAKE$3))
	$$(quiet) $4 $$< $$(ERROR)
	$$(call ok,$$(MSG_MAKE$3),$$@)
endef
$(eval $(call compression-factory,tar.gz,tar,TGZ,$(GZIP)))
$(eval $(call compression-factory,tar.bz2,tar,TBZ2,$(BZIP2)))

#======================================================================#
# Function: compression-shortcut                                       #
# @param  $1 Default extension generated by a compression tool         #
# @param  $2 Shortcut extension to be put in the file above            #
# @param  $3 Part of the name of the var with text to be outputed      #
# @return Target to create a compressed extension from another one     #
#======================================================================#
define compression-shortcut
%.$1: %.$2
	$$(call status,$$(MSG_MAKE$3))
	$$(quiet) $$(CP) $$< $$@ $$(ERROR)
	$$(call ok,$$(MSG_MAKE$3),$$@)
endef
$(eval $(call compression-shortcut,tgz,tar.gz,TGZ))
$(eval $(call compression-shortcut,tbz2,tar.bz2,TBZ2))

#======================================================================#
# Function: dist-factory                                               #
# @param  $1 Extension of the file package system                      #
# @return Phony targets to create a binary distribution and a source   #
#         distribution of the project                                  #
#======================================================================#
define dist-factory
.PHONY: package-$1
package-$1: dirs := Makefile $$(make_configs) $$(wildcard .git*)
package-$1: dirs += $$(srcdir) $$(incdir) $$(datadir) $$(docdir)
package-$1: dirs += $$(if $$(strip $$(lib)),$$(libdir)) $$(bindir)
package-$1: distdep $$(distdir)/$$(PROJECT)-$$(VERSION)_src.$1

.PHONY: dist-$1
dist-$1: dirs := Makefile $$(make_configs)
dist-$1: dirs += $$(if $$(strip $$(lib)),$$(libdir)) $$(bindir)
dist-$1: distdep $$(distdir)/$$(PROJECT)-$$(VERSION).$1
endef
$(foreach e,tar.gz tar.bz2 tar zip tgz tbz2,\
    $(eval $(call dist-factory,$e)))

########################################################################
##                              CLEAN                                 ##
########################################################################
.PHONY: mostlyclean
mostlyclean:
	$(call rm-if-empty,$(objdir),$(objall) $(autoobj) $(testobj))

.PHONY: clean
clean: mostlyclean
	$(call rm-if-empty,$(bindir),$(bin) $(testbin))
	$(call rm-if-empty,$(sbindir),$(sbin))
	$(call rm-if-empty,$(execdir),$(libexec))

.PHONY: distclean
distclean: clean
	$(call rm-if-empty,$(depdir),\
	    $(depall) $(progdep) $(externdep) $(syslibdep))
	$(call rm-if-empty,$(distdir))
	$(call rm-if-empty,$(firstword $(libdir)),\
	    $(filter $(firstword $(libdir))/%,$(lib)))

ifneq (,$(strip $(ENABLE_NLS)))
.PHONY: translationclean
translationclean:
	$(call rm-if-exists,$(intltl),$(MSG_INTLTL_NONE))
	$(call rm-if-exists,$(intlall),$(MSG_INTLALL_NONE))
	$(call rm-if-exists,$(intlobj),$(MSG_INTLOBJ_NONE))
	$(call rm-if-empty,$(localedir))
endif

.PHONY: docclean
docclean:
	$(call rm-if-empty,$(docdir)/doxygen)
	$(call rm-if-exists,$(docdir)/Doxyfile.mk,$(MSG_DOXY_NONE))
	$(call rm-if-empty,$(docdir)/info,$(texiinfo))
	$(call rm-if-empty,$(docdir)/html,$(texihtml))
	$(call rm-if-empty,$(docdir)/dvi,$(texidvi))
	$(call rm-if-empty,$(docdir)/pdf,$(texipdf))
	$(call rm-if-empty,$(docdir)/ps,$(texips))
	$(call rm-if-empty,$(docdir))

.PHONY: packageclean
packageclean:
	$(call rm-if-empty,$(distdir)/$(DEB_PROJECT)-$(VERSION))
	$(call rm-if-empty,$(debdir),$(deball))

.PHONY: coverageclean
coverageclean:
	$(call rm-if-empty,$(addprefix $(covdir)/,$(objdir)))
	$(call rm-if-empty,$(addprefix $(covdir)/,$(bindir)))
	$(call rm-if-empty,$(addprefix $(covdir)/,$(sbindir)))
	$(call rm-if-empty,$(addprefix $(covdir)/,$(execdir)))
	$(call rm-if-empty,$(addprefix $(covdir)/,$(firstword $(libdir))))
	$(call rm-if-empty,$(addprefix $(covdir)/,$(srcdir)))
	$(call rm-if-empty,$(covdir))

.PHONY: externalclean
externalclean:
	$(foreach d,$(call invert,$(call hash-table.keys,git_dependency)),\
	    $(if $(wildcard $(extdir)/$d),\
	        $(call git-submodule-rm,$(extdir)/$d)$(newline)))
	$(foreach d,$(call invert,$(call hash-table.keys,web_dependency)),\
	    $(if $(wildcard $(extdir)/$d),\
	        $(call rmdir,$(extdir)/$d)$(newline)))
	$(call rm-if-empty,$(extdir),$(externreq))

.PHONY: realclean
ifndef D
realclean:
	@echo $(MSG_WARNCLEAN_BEG)
	@echo $(MSG_WARNCLEAN_END)
	@echo $(MSG_WARNCLEAN_ALT)
else
realclean: distclean docclean packageclean coverageclean externalclean \
           $(if $(ENABLE_NLS),translationclean)
	$(call rm-if-exists,$(lexall),$(MSG_LEX_NONE))
	$(foreach d,$(lexinc),$(call rm-if-empty,$d)$(newline))
	$(call rm-if-exists,$(yaccall),$(MSG_YACC_NONE))
	$(foreach d,$(yaccinc),$(call rm-if-empty,$d)$(newline))
	$(call rm-if-exists,$(esqlall),$(MSG_ESQL_NONE))
	$(call rm-if-exists,ctags,$(MSG_CTAGS_NONE))
	$(call rm-if-exists,etags,$(MSG_ETAGS_NONE))
endif

.PHONY: mainteiner-clean
ifndef D
mainteiner-clean:
	@echo $(MSG_WARNCLEAN_BEG)
	@echo $(MSG_WARNCLEAN_END)
	@echo $(MSG_WARNCLEAN_ALT)
else
mainteiner-clean:
	@$(MAKE) realclean MAINTEINER_CLEAN=1 D=1
endif

.PHONY: uninitialize
ifndef U
uninitialize:
	@echo $(MSG_UNINIT_WARN)
	@echo $(MSG_UNINIT_ALT)
else
uninitialize:
	@$(MAKE) mainteiner-clean D=1
	$(call rm-if-empty,$(srcdir),$(srcall))
	$(call rm-if-empty,$(incdir),$(incall))
	$(call rm-if-empty,$(docdir),$(texiall))
	$(call rm-if-exists,Config.mk)
	$(call rm-if-exists,config.mk)
	$(call rm-if-exists,.config.mk)
	$(call rm-if-exists,Config_os.mk)
	$(call rm-if-exists,config_os.mk)
	$(call rm-if-exists,.config_os.mk)
	$(call rm-if-exists,.version.mk)
	$(call rm-if-exists,.gitignore)
	$(call rm-if-exists,.gitmodules)
	$(call rm-if-empty,.git)
endif

########################################################################
##                              OUTPUT                                ##
########################################################################

# Hide command execution details
V   ?= 0
Q_0 := @
quiet := $(Q_$V)

O_0 := 1> /dev/null
E_0 := 2> /dev/null
NO_OUTPUT    := $(O_$V)
NO_ERROR     := $(E_$V)
NO_OPERATION := :

# ANSII Escape Colors
ifndef NO_COLORS
DEF     := \033[0;38m
RED     := \033[1;31m
GREEN   := \033[1;32m
YELLOW  := \033[1;33m
BLUE    := \033[1;34m
PURPLE  := \033[1;35m
CYAN    := \033[1;36m
WHITE   := \033[1;37m
RES     := \033[0m
ERR     := \033[0;37m
endif

MSG_UNINIT_WARN   = "${RED}Are you sure you want to delete all"\
                    "sources, headers and configuration files?"
MSG_UNINIT_ALT    = "${DEF}Run ${BLUE}'make uninitialize U=1'${RES}"

MSG_MOVE          = "${YELLOW}Populating ${BLUE}$(firstword $2)"\
                    "${YELLOW}with $(strip $3) files${RES}"
MSG_NO_MOVE       = "${PURPLE}No $(strip $3) files to put in"\
                    "$(firstword $2)${RES}"

MSG_WEB_CLONE     = "${YELLOW}Downloading web dependency ${DEF}$2${RES}"

MSG_GIT_INIT      = "${YELLOW}[$(GIT)]"\
                    "${BLUE}Initializing empty repository${RES}"
MSG_GIT_TAG       = "${YELLOW}[$(GIT)]"\
                    "${BLUE}Creating new tag ${DEF}$(strip $1)${RES}"
MSG_GIT_CLONE     = "${YELLOW}[$(GIT)]"\
                    "${BLUE}Cloning repository ${DEF}$2${RES}"
MSG_GIT_ADD       = "${YELLOW}[$(GIT)]${BLUE} Adding"\
                    "$(if $(wordlist 2,2,$1),files,file)${DEF}"\
                    "$(subst $(space),$(comma)$(space),$(strip $1))"\
                    "${RES}"
MSG_GIT_COMMIT    = "${YELLOW}[$(GIT)]${BLUE}"\
                    "Commiting message ${DEF}\"$(strip $2)\"${RES}"
MSG_GIT_REM_ADD   = "${YELLOW}[$(GIT)]${BLUE} Setting ${DEF}$(strip $1)"\
                    "${BLUE}to remote ${DEF}$(strip $2)${RES}"
MSG_GIT_PULL      = "${YELLOW}[$(GIT)]${BLUE} Receiveing in${DEF}"\
                    "$(or $(strip $1),origin)${BLUE} from remote"\
                    "repository ${DEF}$(or $(strip $2),master)${RES}"
MSG_GIT_PUSH      = "${YELLOW}[$(GIT)]${BLUE} Sending from${DEF}"\
                    "$(or $(strip $1),origin)${BLUE} to remote"\
                    "repository ${DEF}$(or $(strip $2),master)${RES}"
MSG_GIT_SUB_ADD   = "${YELLOW}[$(GIT)]${BLUE} Adding git dependency"\
                    "${DEF}$(strip $2)${RES}"
MSG_GIT_SUB_RM    = "${YELLOW}[$(GIT)]${BLUE} Removing git dependency"\
                    "${DEF}$(strip $1)${RES}"

MSG_MAKE_CREATE   = "${PURPLE}Creating file ${DEF}$2"\
                    "${PURPLE}from target ${DEF}$1${RES}"

MSG_PRG_SEARCH    = "${DEF}Searching for $d dependency"\
                    "${GREEN}$($d)${RES}"
MSG_PRG_ALL       = "${YELLOW}All $n dependencies avaiable${RES}"
MSG_PRG_UNDEFINED = "${ERR}Undefined variable ${GREEN}$d${DEF}"
MSG_PRG_NOT_FOUND = "${ERR}Dependency ${GREEN}$($d)${DEF}"\
                    "not found${RES}"
MSG_PRG_BAD_VER   = "${ERR}$d dependency ${GREEN}$($d)${DEF}"\
                    "has not the required version"\
                    "($(program_version.$d)${RES})"

MSG_LIB_SEARCH    = "${DEF}Searching for system library"\
                    "${GREEN}$d${RES}"
MSG_LIB_NOT_FOUND = "${ERR}System library ${GREEN}$d${DEF}"\
                    "not found${RES}"
MSG_LIB_BAD_VER   = "${ERR}System library ${RED}$d${DEF}"\
                    "has not the required version"\
                    "($(library_version.$d)${RES})"

MSG_EXT_BUILD     = "${YELLOW}Building dependency ${DEF}$d${RES}"
MSG_EXT_NO_MAKE   = "${ERR}No Makefile found for compilation${RES}"
MSG_EXT_BUILD_ERR = "${ERR}Failed compiling ${DEF}$@${RES}"

MSG_TOUCH         = "${PURPLE}Creating new file ${DEF}$1${RES}"
MSG_UPDATE_NMSH   = "${YELLOW}Updating namespace${DEF}"\
                    "$(subst /,::,${NMS_HEADER})"
MSG_UPDATE_LIBH   = "${YELLOW}Updating library${DEF}"\
                    "$(subst /,::,${LIB_HEADER})"
MSG_NEW_EXT       = "${RED}Extension '$1' invalid${RES}"
MSG_DELETE_WARN   = "${RED}Are you sure you want to do deletes?${RES}"
MSG_DELETE_ALT    = "${DEF}Run ${BLUE}'make delete FLAGS D=1'${RES}"

MSG_WARNCLEAN_BEG = "${RED}This command is intended for maintainers"\
                    "to use; it${RES}"
MSG_WARNCLEAN_END = "${RED}deletes files that may need special tools"\
                    "to rebuild.${RES}"
MSG_WARNCLEAN_ALT = "${RED}Run ${BLUE}'make $@ D=1'${RED} to confirm."\
                    "${RES}"

MSG_MKDIR         = "${CYAN}Creating directory $1${RES}"
MSG_RM            = "${BLUE}Removing ${RES}$1${RES}"
MSG_RMDIR         = "${BLUE}Removing directory ${CYAN}$1${RES}"
MSG_RM_NOT_EMPTY  = "${PURPLE}Directory ${WHITE}$d${RES} not empty"
MSG_RM_EMPTY      = "${PURPLE}Nothing to remove in $d${RES}"

MSG_CTAGS         = "${BLUE}Creating tags for ${YELLOW}Vi${RES}"
MSG_CTAGS_NONE    = "${PURPLE}No auto-generated tags for Vi${RES}"
MSG_ETAGS         = "${BLUE}Creating tags for ${YELLOW}Emacs${RES}"
MSG_ETAGS_NONE    = "${PURPLE}No auto-generated tags for Emacs${RES}"

MSG_INTL_TEMPLATE = "${DEF}Generating template ${GREEN}$@${RES}"
MSG_INTL_PORTABLE = "${DEF}Generating file for ${BLUE}$*${DEF}"\
                    "translation from ${GREEN}$<${RES}"
MSG_INTL_MACHINE  = "${DEF}Generating machine translation for"\
                    "${GREEN}$(notdir $(basename $@))${RES}"
MSG_INTLTL_NONE   = "${PURPLE}No translation templates${RES}"
MSG_INTLALL_NONE  = "${PURPLE}No translation portable objects${RES}"
MSG_INTLOBJ_NONE  = "${PURPLE}No translation machine objects${RES}"

MSG_TEXI_FILE     = "${DEF}Generating $1 file ${WHITE}$@${RES}"
MSG_TEXI_DOCS     = "${BLUE}Generating docs in ${WHITE}$@${RES}"

MSG_DOXY_DOCS     = "${YELLOW}Generating Doxygen docs${RES}"
MSG_DOXY_FILE     = "${BLUE}Generating Doxygen file ${WHITE}$@${RES}"
MSG_DOXY_MAKE     = "${BLUE}Generating Doxygen config ${WHITE}$@${RES}"
MSG_DOXY_NONE     = "${PURPLE}No auto-generated Doxyfile.mk${RES}"

MSG_INSTALL_BIN   = "${DEF}Installing binary file ${GREEN}$@${RES}"
MSG_UNINSTALL_BIN = "${DEF}Uninstalling binary file ${GREEN}$@${RES}"
MSG_INSTALL_DAT   = "${DEF}Installing data file ${GREEN}$@${RES}"
MSG_UNINSTALL_DAT = "${DEF}Uninstalling data file ${GREEN}$@${RES}"
MSG_INSTALL_DOC   = "${DEF}Installing document file ${BLUE}$f${RES}"
MSG_UNINSTALL_DOC = "${DEF}Uninstalling document file ${BLUE}$f${RES}"

MSG_DEB_STEP1     = "${YELLOW}[STEP_1]${DEF} Rename upstream tarball to"\
                    "${BLUE}${DEB_PROJECT}_${VERSION}.orig.tar.gz${RES}"
MSG_DEB_STEP2     = "${YELLOW}[STEP_2]${DEF} Unpacking upstream tarball"\
                    "and renaming directory${RES}"
MSG_DEB_STEP3     = "${YELLOW}[STEP_3]${DEF} Adding directory${CYAN}"\
                    "${debdir}${DEF} with Debian packaging files${RES}"
MSG_DEB_STEP4     = "${YELLOW}[STEP_4]${DEF} Building the Debian"\
                    "package${RES}"

MSG_LEX           = "${PURPLE}Generating scanner ${BLUE}$@${RES}"
MSG_LEX_NONE      = "${PURPLE}No auto-generated lexers${RES}"
MSG_YACC          = "${PURPLE}Generating parser ${BLUE}$@${RES}"
MSG_YACC_NONE     = "${PURPLE}No auto-generated parsers${RES}"
MSG_ESQL          = "${PURPLE}Generating embedded SQL ${BLUE}$@${RES}"
MSG_ESQL_NONE     = "${PURPLE}No auto-generated embedded SQL${RES}"

MSG_TEST          = "${BLUE}Testing ${WHITE}$(notdir $<)${RES}"
MSG_TEST_COMPILE  = "${DEF}Generating test executable"\
                    "${GREEN}$(notdir $(strip $@))${RES}"
MSG_TEST_FAILURE  = "${CYAN}Test '$(notdir $<)' did not passed${RES}"
MSG_TEST_SUCCESS  = "${YELLOW}All tests passed successfully${RES}"

MSG_COV           = "${PURPLE}Generating coverage analysis for"\
                    "${DEF}$(call not-root,$@)${RES}"
MSG_COV_COMPILE   = "${DEF}Building ${GREEN}$@${DEF} to generate"\
                    "coverage files ${RES}"

MSG_MAKETAR       = "${RED}Generating tar file ${BLUE}$@${RES}"
MSG_MAKEZIP       = "${RED}Generating zip file ${BLUE}$@${RES}"
MSG_MAKETGZ       = "${YELLOW}Compressing file ${BLUE}$@"\
                    "${YELLOW}(gzip)${RES}"
MSG_MAKETBZ2      = "${YELLOW}Compressing file ${BLUE}$@"\
                    "${YELLOW}(bzip2)${RES}"

MSG_ASM_COMPILE   = "${DEF}Generating Assembly artifact ${WHITE}$@${RES}"
MSG_STATLIB       = "${RED}Generating static library $@${RES}"

MSG_C_COMPILE     = "${DEF}Generating C artifact ${WHITE}$@${RES}"
MSG_C_LINKAGE     = "${YELLOW}Generating C executable ${GREEN}$@${RES}"
MSG_C_SHRDLIB     = "${RED}Generating C shared library $@${RES}"
MSG_C_NO_FILE     = "${DEF}No files for C executable ${GREEN}$@${RES}"
MSG_C_LIBCOMP     = "${DEF}Generating C library artifact"\
                    "${YELLOW}$@${RES}"

MSG_F_COMPILE     = "${DEF}Generating Fortran artifact ${WHITE}$@${RES}"
MSG_F_LINKAGE     = "${YELLOW}Generating Fortran executable"\
                    "${GREEN}$@${RES}"
MSG_F_SHRDLIB     = "${RED}Generating Fortran shared library $@${RES}"
MSG_F_NO_FILE     = "${DEF}No files for Fortran executable"\
                    "${GREEN}$@${RES}"
MSG_F_LIBCOMP     = "${DEF}Generating Fortran library artifact"\
                    "${YELLOW}$@${RES}"

MSG_CXX_COMPILE   = "${DEF}Generating C++ artifact ${WHITE}$@${RES}"
MSG_CXX_LINKAGE   = "${YELLOW}Generating C++ executable ${GREEN}$@${RES}"
MSG_CXX_SHRDLIB   = "${RED}Generating C++ shared library $@${RES}"
MSG_CXX_NO_FILE   = "${DEF}No files for C++ executable ${GREEN}$@${RES}"
MSG_CXX_LIBCOMP   = "${DEF}Generating C++ library artifact"\
                    "${YELLOW}$@${RES}"

########################################################################
##                            FUNCTIONS                               ##
########################################################################

## TARGET FILES ########################################################
define make-create
$(if $(wildcard $2),,\
	$(call phony-status,$(MSG_MAKE_CREATE))$(newline)\
	$(quiet) $(MAKE) $1 $(if $(filter -k,$(MAKE)),,> $2)$(newline)\
	$(call phony-ok,$(MSG_MAKE_CREATE)))$(newline)
endef

## DEPENDENCIES ########################################################
# Functions: *-depend
# @param $1 Source name (with path)
# @param $2 Main target to be analised
# @param $3 Dependency file name

define c-depend
$(CC) -MM -MF $(depdir)/$3$(depext) -MP -MT $2 \
      $(cppflags) $(clibs) $(cflags) $1
endef

define cpp-depend
$(CXX) -MM -MF $(depdir)/$3$(depext) -MP -MT $2 \
       $(cppflags) $(cxxlibs) $(cxxflags) $1
endef

define fortran-depend
$(FC) -MM -MF $(depdir)/$3$(depext) -MP -MT $2 \
      $(cppflags) $(flibs) $(fflags) $1
endef

## DIRECTORIES #########################################################
$(sort $(srcdir) $(incdir) $(bindir) $(sbindir) $(execdir) ):
	$(call mkdir,$@)

$(sort $(objdir) $(covdir) $(depdir) $(libdir) $(extdir) ):
	$(call mkdir,$@)

$(sort $(docdir) $(debdir) $(srpdir) $(datadir) $(localedir) ):
	$(call mkdir,$@)

define mkdir
$(if $(shell if ! [ -d $(strip $(patsubst .,,$1)) ]; then echo 1; fi),\
	$(if $(strip $(patsubst .,,$1)), $(call phony-status,$(MSG_MKDIR)) )
	$(if $(strip $(patsubst .,,$1)), $(quiet) $(MKDIR) $1              )
	$(if $(strip $(patsubst .,,$1)), $(call phony-ok,$(MSG_MKDIR))     )
)
endef

# Create a subdirectory tree in the first element of a list of roots
define mksubdir
$(if $(strip $(patsubst .,,$1)),\
	$(quiet) $(MKDIR) $(firstword $1)/$(strip $(call not-root,$(dir $2))))
endef

define mv
$(if $(strip $(foreach e,$(strip $1),$(wildcard *$e))),\
    $(if $(strip $(wildcard $(firstword $2/*))),,\
        $(call mkdir,$(firstword $2))\
))
$(call phony-status,$(MSG_MOVE))
$(strip $(foreach e,$(strip $1),\
    $(if $(strip $(wildcard *$e)),\
        $(quiet) $(MV) $(wildcard *$e) $(firstword $2);\
    )\
))
$(if $(strip $(foreach e,$(strip $1),$(wildcard *$e))),\
    $(call phony-ok,$(MSG_MOVE)),\
    $(call phony-ok,$(MSG_NO_MOVE))\
)
$(if $(strip $(foreach e,$(strip $1),$(wildcard *$e))),\
    $(call git-add-commit,\
        $(addprefix $(firstword $2)/,\
            $(foreach e,$(strip $1),$(wildcard *$e))),\
        "Move $(subst $(quote),,$3) files to $(firstword $2)/")\
)
endef

## REMOTION ############################################################
define srm
	$(quiet) $(RM) $1 $(NO_ERROR);
endef

define srmdir
	$(if $(strip $(patsubst .,,$1)), $(quiet) $(RMDIR) $1;)
endef

define rm
$(if $(strip $(patsubst .,,$1)),\
	$(call phony-status,$(MSG_RM))
	$(quiet) $(RM) $1;
	$(call phony-ok,$(MSG_RM))
)
endef

define rmdir
	$(if $(strip $(patsubst .,,$1)), $(call phony-status,$(MSG_RMDIR)) )
	$(if $(strip $(patsubst .,,$1)), $(quiet) $(RMDIR) $1;             )
	$(if $(strip $(patsubst .,,$1)), $(call phony-ok,$(MSG_RMDIR))     )
endef

#======================================================================#
# Function: rm-if-empty                                                #
# If MAINTEINER_CLEAN is setted, or there is no $2 arg, the function   #
# does not test for extra files in the directory (see below)           #
# @param $1 Directory name                                             #
# @param $2 Files in $1 that should be removed from within $1          #
# .---------.-----.-------.-------.------------.                       #
# | Dir not | 2nd | Extra |  Dir  | Result     |                       #
# |  empty  | arg | files | exist |            |                       #
# |=========|=====|=======|=======|============|                       #
# |         |     |       |       | nothing    | }                     #
# |         |     |   X   |       | nothing    | } When dir is         #
# |         |  X  |       |       | nothing    | } empty               #
# |         |  X  |   X   |       | nothing    | }                     #
# |         |     |       |   X   | remove     | }                     #
# |    X    |     |       |   X   | remove     | - With or without     #
# |    X    |     |   X   |   X   | remove     | - rest., remove.      #
# |    X    |  X  |       |   X   | remove     | - ok? Remove!         #
# |    X    |  X  |   X   |   X   | not_remove | } Not remove,         #
# '---------'-----'-------'-------'------------'   otherwise           #
#======================================================================#
define rm-if-empty
	$(if $(strip $2),$(call srmdir,$2))
	$(foreach d,$(strip $1),\
	    $(if $(strip $(call rwildcard,$d,*)),\
	        $(if $(strip $2),
	            $(if $(strip $(MAINTEINER_CLEAN)),\
	                $(call rmdir,$d),\
	                $(if $(strip
	                  $(call rfilter-out,$(call rsubdir,$d)),\
	                  $(call rfilter-out,$2,$(call rwildcard,$d,*))),\
	                    $(call phony-ok,$(MSG_RM_NOT_EMPTY)),\
	                    $(call rmdir,$d)\
	            )),\
	            $(call rmdir,$d)\
	        ),\
	        $(if $(wildcard $d),\
	            $(call rmdir,$d),\
	            $(call phony-ok,$(MSG_RM_EMPTY))\
	        )\
	))
endef

#======================================================================#
# Function: rm-if-exists                                               #
# @param $1 File to be removed                                         #
# @param $1 Message to be outputed if the file was not found           #
#======================================================================#
define rm-if-exists
$(if $(wildcard $1),\
    $(call rm,$1),$(if $(strip $2),$(call phony-ok,$(strip $2))))
endef

## ERROR SHELL #########################################################
ifndef SILENT
ifndef MORE

define ERROR_SEPARATOR
########################################################################
endef

define ERROR
2>&1 | sed '1 s/^/\$(newline)$(ERROR_SEPARATOR)\$(newline)/' \
     | sed '$$ s/$$/\$(newline)$(ERROR_SEPARATOR)/'
endef
#| sed '1 s/^/> stderr:\n/'                 # '> stderr:' in 1st line
#| sed 's/^/> /'                            # Put '> ' before each line
#| sed ''/"> error"/s//`printf "${ERR}"`/'' # Gray color with above

else # ifndef MORE

define ERROR
2>&1 | more
endef

endif # ifndef MORE
endif # ifndef SILENT

## ERROR MAKEFILE ######################################################
ifndef SILENT

define model-error
(echo "\r${RED}[ERROR]${RES}" $1 "${RED}(STATUS: $$?)${RES}" && exit 42)
endef

define model-test-error
(echo "\r${RED}[FAILURE]${RES}" $1"."\
      "${RED}Aborting status: $$?${RES}" && exit 42)
endef

define phony-error
@$(call model-error,$1)
endef

else # ifndef SILENT

define model-error
$(NO_OPERATION)
endef

define model-test-error
$(NO_OPERATION)
endef

endif # ifndef SILENT

## STATUS ##############################################################
ifneq ($(and $(call is-empty,$(SILENT)),$(call not-empty,$(quiet))),)

define model-status
printf "%b " $1; printf "... "
endef

define model-vstatus
echo $1 "... "
endef

define phony-status
	@$(call model-status,$1)
endef

define phony-vstatus
	@$(call model-vstatus,$1)
endef

define status
	@$(RM) $@ && $(call model-status,$1)
endef

define vstatus
	@$(RM) $@ && $(call model-vstatus,$1)
endef

else # if empty $(SILENT) and not empty $(quiet)

define model-status
$(NO_OPERATION)
endef

define model-vstatus
$(NO_OPERATION)
endef

endif # if empty $(SILENT) and not empty $(quiet)

## ACKNOWLEDGMENT ######################################################
ifndef SILENT

define model-ok
echo "\r${GREEN}[OK]${RES}" $1 "     "
endef

define phony-ok
@if [ $$? ];\
    then $(call model-ok,$1);\
    else $(call model-error,$1);\
fi;
endef

define ok
@if [ -f $2 ];\
    then $(call model-ok,$1);\
    else $(call model-error,$1);\
fi
endef

else # ifndef SILENT

define model-ok
$(NO_OPERATION)
endef

endif # ifndef SILENT

## TEXT ################################################################
define uc
$(shell echo $1 | tr "a-z" "A-Z")
endef

define lc
$(shell echo $1 | tr "A-Z" "a-z")
endef

# Function: shstring
# Transforms a text valid inside make in a valid for shell
define shstring
$(strip $(subst $(space),\$(space),$(strip $1)))
endef

# Function: select
# Define which ostream should be used
define select
$(eval ostream = \
    $(strip $(if $(strip $(subst stdout,,$(strip $1))),$1,)))
endef

# Function: cat
# Add a text in the end of a ostream
define cat
$(if $(strip $(wildcard $(ostream)*)),,\
    $(quiet) echo $1 $(if $(strip $(ostream)),>> $(ostream)))
endef

# Function: touch
# Create a new file based on a model
# @param $1 File to be created
# @param $2 Model to be used in the creation (optional)
define touch
$(if $(wildcard $1*),,\
    $(call phony-status,$(MSG_TOUCH)))
$(if $(wildcard $1*),,\
    $(if $(strip $2),\
        $(quiet) cat $2 > $1,\
        $(quiet) touch $1))
$(if $(wildcard $1*),,\
    $(call phony-ok,$(MSG_TOUCH)))
endef

## VERSIONMENT #########################################################
ifndef NO_GIT

git_version          := $(subst git version,,$(shell git --version))

GIT_ADD              := $(GIT) add -f
GIT_CLONE            := $(GIT) clone -q --recursive
GIT_COMMIT           := $(GIT) commit -q -m
GIT_DIFF             := $(GIT) diff --quiet
GIT_INIT             := $(GIT) init -q  
GIT_LS_FILES         := $(GIT) ls-files --error-unmatch 2>/dev/null 1>&2
GIT_PULL             := $(GIT) pull -q  
GIT_PUSH             := $(GIT) push -q  
GIT_REMOTE           := $(GIT) remote
GIT_REMOTE_ADD       := $(GIT_REMOTE) add
GIT_RM               := $(GIT) rm -q
GIT_SUBMODULE        := $(GIT) submodule -q
GIT_SUBMODULE_ADD    := $(GIT_SUBMODULE) add -f
GIT_SUBMODULE_INIT   := $(GIT_SUBMODULE) init
GIT_TAG              := $(GIT) tag

ifneq ($(call version-gt,$(git_version),1.8.3),)
GIT_SUBMODULE_DEINIT := $(GIT_SUBMODULE) deinit -f
else
GIT_SUBMODULE_DEINIT := $(NO_OPERATION)
endif

define git-cmd-factory
model-git-$1 = \
    $(GIT_$2) $$1 $$(ERROR) || $$(call model-error,"Error on $1")
phony-git-$1 = \
    $$(quiet) $$(call model-git-$1,$$1)
endef
$(foreach c,\
    ADD CLONE COMMIT DIFF INIT LS_FILES PULL PUSH REMOTE REMOTE_ADD \
    RM SUBMODULE SUBMODULE_ADD SUBMODULE_INIT SUBMODULE_DEINIT TAG, \
    $(eval $(call git-cmd-factory,$(subst _,-,$(call lc,$c)),$c)))

define git-clone
	$(call phony-status,$(MSG_GIT_CLONE))
	$(call phony-git-clone,$1 $2)
	$(call phony-ok,$(MSG_GIT_CLONE))
endef

define git-init
	$(quiet) if ! [ -d .git ]; \
	         then \
	             $(call model-status,$(MSG_GIT_INIT)); \
	             $(call model-git-init);               \
	             $(call model-ok,$(MSG_GIT_INIT));     \
	         fi
endef

define git-tag
	$(quiet) if ! $(GIT_TAG) | grep -q $1; \
	         then \
	             $(call model-status,$(MSG_GIT_TAG)); \
	             $(call model-git-tag,$1);            \
	             $(call model-ok,$(MSG_GIT_TAG));     \
	         fi
endef

define git-add
	$(quiet) if ! $(GIT_LS_FILES) $1 || ! $(GIT_DIFF) $1; \
	         then \
	             $(call model-status,$(MSG_GIT_ADD)); \
	             $(call model-git-add,$1);            \
	             $(call model-ok,$(MSG_GIT_ADD));     \
	         fi
endef

define git-commit
	$(quiet) if ! $(GIT_DIFF) --cached $1; \
             then \
                 $(call model-status,$(MSG_GIT_COMMIT)); \
                 $(call model-git-commit,$(strip $2));   \
                 $(call model-ok,$(MSG_GIT_COMMIT));     \
             fi
endef

define git-add-commit
	$(quiet) if ! $(GIT_LS_FILES) $1 || ! $(GIT_DIFF) $1; \
	         then \
	             $(call model-status,$(MSG_GIT_COMMIT)); \
	             $(call model-git-add,$1);               \
	             $(call model-git-commit,$(strip $2));   \
	             $(call model-ok,$(MSG_GIT_COMMIT));     \
	         fi
endef

define git-submodule-add
	$(call phony-status,$(MSG_GIT_SUB_ADD))
	$(quiet) if [ -f $(call rm-trailing-bar,$(dir $2))/.git ]; \
	         then \
	             cd $(dir $2);                                     \
	             $(call model-git-submodule-add,$1 $(notdir $2));  \
	             $(call model-git-submodule-init,$(notdir $2));    \
	             $(call model-git-commit,"Add $(notdir $2)");      \
	             cd $(MAKECURRENTDIR);                             \
	             $(call model-git-add,$(dir $2));                  \
	             $(call model-git-commit,"Add sub-submodule $2");  \
	         else \
	             $(call model-git-submodule-add,$1 $2);            \
	             $(call model-git-submodule-init,$2);              \
	             $(call model-git-commit,"Add submodule $2");      \
	         fi
	$(call phony-ok,$(MSG_GIT_SUB_ADD))
endef

define git-submodule-rm
	$(call phony-status,$(MSG_GIT_SUB_RM))
	$(quiet) if [ -f $(call rm-trailing-bar,$(dir $1))/.git ]; \
	         then \
	             cd $(dir $1);                                       \
	             $(call model-git-submodule-deinit,$(notdir $1));    \
	             $(call model-git-rm,--cached $(notdir $1));         \
	             $(call model-git-commit,"Remove $(notdir $1)");     \
	             $(RMDIR) $1 $(ERROR);                               \
	             cd $(MAKECURRENTDIR);                               \
	             $(call model-git-add,$(dir $1));                    \
	             $(call model-git-commit,"Remove sub-submodule $1"); \
	             $(RMDIR) .git/modules/$(notdir $1) $(ERROR);        \
	         else \
	             $(call model-git-submodule-deinit,$1);              \
	             $(call model-git-rm,--cached $1);                   \
	             $(call model-git-commit,"Remove submodule $1");     \
	             $(RMDIR) $1 $(ERROR);                               \
	             $(RMDIR) .git/modules/$1 $(ERROR);                  \
	         fi 
	$(call phony-ok,$(MSG_GIT_SUB_RM))
endef

ifneq (,$(or $(strip $(GIT_REMOTE_PATH)),$(strip \
             $(findstring upgrade,$(MAKECMDGOALS)))))

define git-remote-add
	$(quiet) if ! $(GIT_REMOTE) | grep "^$1$$" $(NO_OUTPUT); \
	         then \
	             $(call model-status,$(MSG_GIT_REM_ADD)); \
	             $(call model-git-remote-add,$1 $2);      \
	             $(call model-ok,$(MSG_GIT_REM_ADD));     \
	         fi
endef

define git-pull
	$(call phony-status,$(MSG_GIT_PULL))
	$(quiet) $(if $(strip $3),cd $3 && ) \
	         $(call model-git-pull,$(or $(strip $1),origin) \
	                               $(or $(strip $2),master))
	$(call phony-ok,$(MSG_GIT_PULL))
endef

define git-push
	$(call phony-status,$(MSG_GIT_PUSH))
	$(quiet) $(if $(strip $3),cd $3 && ) \
	         $(call model-git-push,$(or $(strip $1),origin) \
	                               $(or $(strip $2),master))
	$(call phony-ok,$(MSG_GIT_PUSH))
endef

endif # not empty GIT_REMOTE_PATH

endif # ifndef NO_GIT

## WEB DEPENDENCIES ####################################################
define web-clone
	$(call phony-status,$(MSG_WEB_CLONE))
	$(quiet) $(CURL) $2 $1 $(NO_OUTPUT) $(NO_ERROR)
	$(quiet) $(call model-git-add,$2)
	$(quiet) $(call model-git-commit,"Add web dependency $2")
	$(call phony-ok,$(MSG_WEB_CLONE))
endef

########################################################################
##                           MANAGEMENT                               ##
########################################################################

# Executes iff one of the make goals is 'new' or 'delete'
ifneq (,$(foreach g,$(MAKECMDGOALS),$(filter $g,new delete update)))

# Namespace/Module variable
# ===========================
# 1) Remove trailing bars if it is a directory-only name
# 2) Substitute C++ namespace style (::) by path style (/)
# 3) If the name includes a root src/inc directory, remove-it.
# 4) Manipulates IN to be used in a #ifndef C/C++ preproc directive
# 5) Define identation accordingly to namespace depth
ifdef IN
#------------------------------------------------------------------[ 1 ]
override IN := $(strip $(call rm-trailing-bar,$(IN)))
#------------------------------------------------------------------[ 2 ]
override IN := $(subst ::,/,$(IN))
#------------------------------------------------------------------[ 3 ]
override IN := $(strip $(or $(strip $(foreach d,$(srcdir) $(incdir),\
                   $(if $(strip $(patsubst $d%,%,$(call root,$(IN)))),,\
                       $(call not-root,$(IN))\
               ))),$(IN)))
$(shell echo $(wildcard $(IN)/*))
#------------------------------------------------------------------[ 4 ]
indef       := $(strip $(call uc,$(subst /,_,$(strip $(IN)))))_
#------------------------------------------------------------------[ 5 ]
idnt        := $(if $(strip $(IN)),    )
endif

# Extension variables
# =====================
override SRC_EXT := $(strip $(if $(strip $(SRC_EXT)),\
    $(or $(filter .%,$(SRC_EXT)),.$(SRC_EXT))))
override INC_EXT := $(strip $(if $(strip $(INC_EXT)),\
    $(or $(filter .%,$(INC_EXT)),.$(INC_EXT))))

# Function: sfmt
# Format to make a preprocessor symbol
# $1 File name
define sfmt
$(call uc,$1)
endef

# Function: invalid-ext
# $1 File extension
# $2 List of extensions to validate as correct $1, if it is not empty
define invalid-ext
$(if $(strip $1),$(if $(findstring $(strip $1),$2),,\
    $(call phony-error,$(MSG_NEW_EXT))\
))
endef

# Function: start-namespace
# Create new namespaces from the IN variable
# If there is 'n' namespace, put the first 'n-1' with open curly-braces
# in the same line, and the last one in the last line
define start-namespace
$(if $(strip $(IN)),\
    $(call cat,$(subst \\n ,\\n,\
        $(patsubst %,namespace % {\\n,\
            $(subst $(lastword $(subst /, ,$(IN))),,\
                $(subst /, ,$(IN))\
            )\
        )$(patsubst %,namespace % \\n{,\
            $(lastword $(subst /, ,$(IN))))\
)))
endef

# Function: end-namespace
# End the namespaces using the IN variable for namespace depth
define end-namespace
$(if $(strip $(IN)),\
    $(call cat,$(subst } ,},$(foreach n,$(subst /, ,$(IN)),}))))
endef

# Function: include-files
# Create include directives (#include) for all files in $1
define include-files
$(call cat,$(subst \\n ,\\n,\
    $(patsubst %,'#include "%"'\\n,$(sort $1))))
endef

# Path variables
# ================
# Auxiliar variables to the default place to create/remove
# files created by this makefile (usually the first inc/src dirs)
override incbase := $(strip $(firstword $(incdir)))$(if $(IN),/$(IN))
override srcbase := $(strip $(firstword $(srcdir)))$(if $(IN),/$(IN))

# Check if namespace exists
$(if $(or $(call rsubdir,$(incbase)),$(call rsubdir,$(srcbase))),,\
    $(error Namespace "$(IN)" does not exist))

# Artifacts
# ===========
# C/C++ Artifacts that may be created by this Makefile
override NAMESPACE     := $(strip $(notdir $(NAMESPACE)))
override NMS_HEADER    := $(strip $(basename $(notdir $(NMS_HEADER))))
override LIBRARY       := $(strip $(notdir $(LIBRARY)))
override LIB_HEADER    := $(strip $(basename $(notdir $(LIB_HEADER))))
override CLASS         := $(strip $(basename $(notdir $(CLASS))))
override F_FILE        := $(strip $(basename $(notdir $(F_FILE))))
override C_FILE        := $(strip $(basename $(notdir $(C_FILE))))
override CXX_FILE      := $(strip $(basename $(notdir $(CXX_FILE))))
override C_MAIN        := $(strip $(basename $(notdir $(C_MAIN))))
override CXX_MAIN      := $(strip $(basename $(notdir $(CXX_MAIN))))
override TEMPLATE      := $(strip $(basename $(notdir $(TEMPLATE))))
override C_MODULE      := $(strip $(basename $(notdir $(C_MODULE))))
override CXX_MODULE    := $(strip $(basename $(notdir $(CXX_MODULE))))
override TRANSLATION   := $(strip $(basename $(notdir $(TRANSLATION))))
override NLS_HEADER    := $(strip $(basename $(notdir $(NLS_HEADER))))

# Check if there is at least one artifact to be created/deleted
$(if $(strip \
    $(or $(NAMESPACE),$(NMS_HEADER),$(LIBRARY),$(LIB_HEADER),\
         $(CLASS),$(F_FILE),$(C_FILE),$(CXX_FILE),$(C_MAIN),\
         $(CXX_MAIN),$(TEMPLATE),$(C_MODULE),$(CXX_MODULE),\
         $(TRANSLATION),$(NLS_HEADER))),,\
     $(error No filetype defined. Type 'make projecthelp' for info))

.PHONY: new
new: | $(call root,$(incbase)) $(call root,$(srcbase))
ifdef NAMESPACE
	$(call mkdir,$(incbase)/$(subst ::,/,$(NAMESPACE)))
	$(call mkdir,$(srcbase)/$(subst ::,/,$(NAMESPACE)))
endif
ifdef NMS_HEADER
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	
	@# NMSH: Namespace directory
	$(eval NMSH       := $(subst ::,/,$(NMS_HEADER)))
	$(eval NMSH       := $(if $(strip $(IN)),$(IN)/)$(NMSH))
	$(eval NMSH       := $(firstword $(filter %$(NMSH)/,\
	                         $(sort $(dir $(incall))))))
	$(eval NMSH       := $(call rm-trailing-bar,$(NMSH)))
	
	@# NMSH_NAME: File name for the Namespace header
	$(eval NMSH_NAME  := $(notdir $(basename $(NMSH))))
	
	@# NMSH_FILES: Files to be put in the Namespace Header
	$(eval NMSH_FILES := $(filter $(NMSH)/%,$(incall)))
	$(eval NMSH_FILES := $(call not-root,\
	    $(filter-out $(NMSH)/$(NMSH_NAME).%,\
	        $(foreach f,$(NMSH_FILES),\
	            $(firstword $(filter %$f,$(incall)))\
	))))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(NMSH)/$(NMSH_NAME)$(INC_EXT),$(notice))
	$(call select,$(NMSH)/$(NMSH_NAME)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef NMS_$(indef)$(call sfmt,$(NMSH_NAME))_DEFINED' )
	$(call cat,'#define NMS_$(indef)$(call sfmt,$(NMSH_NAME))_DEFINED' )
	$(call cat,''                                                      )
	$(call cat,'// Libraries'                                          )
	$(call include-files,$(NMSH_FILES)                                 )
	$(call cat,'#endif'                                                )
	
	$(call select,stdout)
endif
ifdef LIBRARY
	$(call mkdir,$(incbase)/$(subst ::,/,$(LIBRARY)))
endif
ifdef LIB_HEADER
	$(if $(INC_EXT),,$(eval override INC_EXT := .tcc))
	
	@# LIBH: Library directory
	$(eval LIBH       := $(subst ::,/,$(LIB_HEADER)))
	$(eval LIBH       := $(if $(strip $(IN)),$(IN)/)$(LIBH))
	$(eval LIBH       := $(firstword $(filter %$(LIBH)/,\
	                         $(sort $(dir $(incall))))))
	$(eval LIBH       := $(call rm-trailing-bar,$(LIBH)))
	
	@# LIBH_NAME: File name for the Library header
	$(eval LIBH_NAME  := $(notdir $(basename $(LIBH))))
	
	@# LIBH_FILES: Files to be put in the Library header
	$(eval LIBH_FILES := $(filter $(LIBH)/%,$(incall)))
	$(eval LIBH_FILES := $(call not-root,\
	    $(filter-out $(LIBH)/$(LIBH_NAME).%,\
	        $(foreach f,$(LIBH_FILES),\
	            $(firstword $(filter %$f,$(incall)))\
	))))
	
	$(call invalid-ext,$(INC_EXT),$(tlext))
	$(call touch,$(LIBH)/$(LIBH_NAME)$(INC_EXT),$(notice))
	$(call select,$(LIBH)/$(LIBH_NAME)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef LIB_$(indef)$(call sfmt,$(LIBH_NAME))_DEFINED' )
	$(call cat,'#define LIB_$(indef)$(call sfmt,$(LIBH_NAME))_DEFINED' )
	$(call cat,''                                                      )
	$(call cat,'// Libraries'                                          )
	$(call include-files,$(LIBH_FILES)                                 )
	$(call cat,'#endif'                                                )
	
	$(call select,stdout)
endif
ifdef CLASS
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .cpp))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(incbase)/$(CLASS)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(CLASS)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef HPP_$(indef)$(call sfmt,$(CLASS))_DEFINED'     )
	$(call cat,'#define HPP_$(indef)$(call sfmt,$(CLASS))_DEFINED'     )
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)class $(CLASS)'                                 )
	$(call cat,'$(idnt){'                                              )
	$(call cat,'$(idnt)$(idnt)'                                        )
	$(call cat,'$(idnt)};'                                             )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call invalid-ext,$(SRC_EXT),$(cxxext))
	$(call touch,$(srcbase)/$(CLASS)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(CLASS)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'// Libraries'                                          )
	$(call cat,'#include "$(CLASS)$(INC_EXT)"'                         )
	$(call cat,$(if $(IN),'using namespace $(subst /,::,$(IN));')      )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef F_FILE
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .f))
	
	$(call invalid-ext,$(SRC_EXT),$(fext))
	$(call touch,$(srcbase)/$(F_FILE)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(F_FILE)$(SRC_EXT))
	$(call cat,'c $(call lc,$(F_FILE))$(SRC_EXT)'                      )
	$(call cat,''                                                      )
	$(call cat,'      program $(call lc,$(F_FILE))'                    )
	$(call cat,'          stop'                                        )
	$(call cat,'      end'                                             )
	
	$(call select,stdout)
endif
ifdef C_FILE
	$(if $(INC_EXT),,$(eval override INC_EXT := .h))
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .c))
	
	$(call invalid-ext,$(INC_EXT),$(hext))
	$(call touch,$(incbase)/$(C_FILE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(C_FILE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef H_$(indef)$(call sfmt,$(C_FILE))_DEFINED'      )
	$(call cat,'#define H_$(indef)$(call sfmt,$(C_FILE))_DEFINED'      )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call invalid-ext,$(SRC_EXT),$(cext))
	$(call touch,$(srcbase)/$(C_FILE)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(C_FILE)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'/* Libraries */'                                       )
	$(call cat,'#include "$(C_FILE)$(INC_EXT)"'                        )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef CXX_FILE
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .cpp))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(incbase)/$(CXX_FILE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(CXX_FILE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef HPP_$(indef)$(call sfmt,$(CXX_FILE))_DEFINED'  )
	$(call cat,'#define HPP_$(indef)$(call sfmt,$(CXX_FILE))_DEFINED'  )
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)'                                               )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call invalid-ext,$(SRC_EXT),$(cxxext))
	$(call touch,$(srcbase)/$(CXX_FILE)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(CXX_FILE)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'// Libraries'                                          )
	$(call cat,'#include "$(CXX_FILE)$(INC_EXT)"'                      )
	$(call cat,$(if $(IN),'using namespace $(subst /,::,$(IN));')      )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef C_MAIN
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .c))
	
	$(call invalid-ext,$(SRC_EXT),$(cext))
	$(call touch,$(srcbase)/$(C_MAIN)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(C_MAIN)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'int main(int argc, char **argv)'                       )
	$(call cat,'{'                                                     )
	$(call cat,'    return 0;'                                         )
	$(call cat,'}'                                                     )
	
	$(call select,stdout)
endif
ifdef CXX_MAIN
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .cpp))
	
	$(call invalid-ext,$(SRC_EXT),$(cxxext))
	$(call touch,$(srcbase)/$(CXX_MAIN)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(CXX_MAIN)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'// Default libraries'                                  )
	$(call cat,'using namespace std;'                                  )
	$(call cat,''                                                      )
	$(call cat,'int main(int argc, char **argv)'                       )
	$(call cat,'{'                                                     )
	$(call cat,'    return 0;'                                         )
	$(call cat,'}'                                                     )
	
	$(call select,stdout)
endif
ifdef TEMPLATE
	$(if $(INC_EXT),,$(eval override INC_EXT := .tcc))
	
	$(call invalid-ext,$(INC_EXT),$(tlext))
	$(call touch,$(incbase)/$(TEMPLATE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(TEMPLATE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef TCC_$(indef)$(call sfmt,$(TEMPLATE))_DEFINED'  )
	$(call cat,'#define TCC_$(indef)$(call sfmt,$(TEMPLATE))_DEFINED'  )
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)'                                               )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call select,stdout)
endif
ifdef C_MODULE
	$(if $(INC_EXT),,$(eval override INC_EXT := .h))
	
	$(call invalid-ext,$(INC_EXT),$(hext))
	$(call touch,$(incbase)/$(C_MODULE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(C_MODULE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef H_$(indef)$(call sfmt,$(C_MODULE))_DEFINED'    )
	$(call cat,'#define H_$(indef)$(call sfmt,$(C_MODULE))_DEFINED'    )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call mkdir,$(srcbase)/$(C_MODULE))
	
	$(call select,stdout)
endif
ifdef CXX_MODULE
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(incbase)/$(CXX_MODULE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(CXX_MODULE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef HPP_$(indef)$(call sfmt,$(CXX_MODULE))_DEFINED')
	$(call cat,'#define HPP_$(indef)$(call sfmt,$(CXX_MODULE))_DEFINED')
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)'                                               )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call mkdir,$(srcbase)/$(CXX_MODULE))
	
	$(call select,stdout)
endif
ifneq (,$(strip $(ENABLE_NLS)))
ifdef TRANSLATION
new: $(foreach t,$(intltl),$(foreach e,$(firstword $(poext)),\
        $(localedir)/$(TRANSLATION)$d/$(call not-root,$(basename $t))$e))
endif
ifdef NLS_HEADER
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	$(if $(call not-empty,$(c_all)),\
	    $(if $(INC_EXT),,$(eval override INC_EXT := .h)))
	$(if $(call not-empty,$(cxx_all)),\
	    $(if $(INC_EXT),,$(eval override INC_EXT := .hpp)))
	
	$(call invalid-ext,$(INC_EXT),$(hext) $(hxxext))
	$(call touch,$(incbase)/$(NLS_HEADER)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(NLS_HEADER)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef HPP_$(indef)$(call sfmt,$(NLS_HEADER))_DEFINED')
	$(call cat,'#define HPP_$(indef)$(call sfmt,$(NLS_HEADER))_DEFINED')
	$(call cat,''                                                      )
	$(call cat,'#ifdef ENABLE_NLS'                                     )
	$(call cat,''                                                      )
	$(call cat,'/* I18n libraries */'                                  )
	$(foreach l,$(NLSREQINC),$(call cat,'#include <$l>')$(newline))
	$(call cat,''                                                      )
	$(call cat,'/* I18n macros */'                                     )
	$(call cat,'#define _(String) gettext (String)'                    )
	$(call cat,'#define gettext_noop(String) String'                   )
	$(call cat,'#define N_(String) gettext_noop (String)'              )
	$(call cat,''                                                      )
	$(call cat,'#else'                                                 )
	$(call cat,''                                                      )
	$(call cat,'/* I18n macros */'                                     )
	$(call cat,'#define _(String) String'                              )
	$(call cat,'#define gettext_noop(String) String'                   )
	$(call cat,'#define N_(String) gettext_noop (String)'              )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call select,stdout)
endif
endif

.PHONY: update
update:
ifdef NMS_HEADER
	$(call phony-status,$(MSG_UPDATE_NMSH))
	@$(MAKE) delete new NMS_HEADER=$(NMS_HEADER) D=1 SILENT=1
	$(call phony-ok,$(MSG_UPDATE_NMSH))
endif
ifdef LIB_HEADER
	$(call phony-status,$(MSG_UPDATE_LIBH))
	@$(MAKE) delete new LIB_HEADER=$(LIB_HEADER) D=1 SILENT=1
	$(call phony-ok,$(MSG_UPDATE_LIBH))
endif

# Function: delete-file
# $1 File basename to be deleted
# $2 Extensions allowed for the basename above
define delete-file
$(if $(strip $(firstword $(foreach e,$2,$(wildcard $1$e)))),\
    $(call rm,$(firstword $(foreach e,$2,$(wildcard $1$e)))))
endef

.PHONY: delete
delete:
ifndef D
	@echo $(MSG_DELETE_WARN)
	@echo $(MSG_DELETE_ALT)
else
ifdef NAMESPACE
	$(call rm-if-empty,$(incbase)/$(subst ::,/,$(NAMESPACE)))
	$(call rm-if-empty,$(srcbase)/$(subst ::,/,$(NAMESPACE)))
endif
ifdef NMS_HEADER
	@# NMSH: Namespace directory
	$(eval NMSH       := $(subst ::,/,$(NMS_HEADER)))
	$(eval NMSH       := $(if $(strip $(IN)),$(IN)/)$(NMSH))
	$(eval NMSH       := $(firstword $(filter %$(NMSH)/,\
	                         $(sort $(dir $(incall))))))
	$(eval NMSH       := $(call rm-trailing-bar,$(NMSH)))
	
	@# NMSH_NAME: Namespace include files
	$(eval NMSH_NAME  := $(notdir $(basename $(NMSH))))
	
	$(call delete-file,$(NMSH)/$(NMSH_NAME),$(INC_EXT) $(hxxext))
endif
ifdef LIBRARY
	$(call rm-if-empty,$(incbase)/$(subst ::,/,$(LIBRARY)))
endif
ifdef LIB_HEADER
	@# LIBH: Namespace directory
	$(eval LIBH       := $(subst ::,/,$(LIB_HEADER)))
	$(eval LIBH       := $(if $(strip $(IN)),$(IN)/)$(LIBH))
	$(eval LIBH       := $(firstword $(filter %$(LIBH)/,\
	                         $(sort $(dir $(incall))))))
	$(eval LIBH       := $(call rm-trailing-bar,$(LIBH)))
	
	@# LIBH_NAME: Namespace include files
	$(eval LIBH_NAME  := $(notdir $(basename $(LIBH))))
	
	$(call delete-file,$(LIBH)/$(LIBH_NAME),$(INC_EXT) $(tlext))
endif
ifdef CLASS
	$(call delete-file,$(incbase)/$(CLASS),$(INC_EXT) $(hxxext))
	$(call delete-file,$(srcbase)/$(CLASS),$(SRC_EXT) $(cxxext))
endif
ifdef F_FILE
	$(call delete-file,$(srcbase)/$(F_FILE),$(SRC_EXT) $(fext))
endif
ifdef C_FILE
	$(call delete-file,$(incbase)/$(C_FILE),$(INC_EXT) $(hext))
	$(call delete-file,$(srcbase)/$(C_FILE),$(SRC_EXT) $(cext))
endif
ifdef CXX_FILE
	$(call delete-file,$(incbase)/$(CXX_FILE),$(INC_EXT) $(hxxext))
	$(call delete-file,$(srcbase)/$(CXX_FILE),$(SRC_EXT) $(cxxext))
endif
ifdef C_MAIN
	$(call delete-file,$(srcbase)/$(C_MAIN),$(SRC_EXT) $(cext))
endif
ifdef CXX_MAIN
	$(call delete-file,$(srcbase)/$(CXX_MAIN),$(SRC_EXT) $(cxxext))
endif
ifdef TEMPLATE
	$(call delete-file,$(incbase)/$(TEMPLATE),$(INC_EXT) $(tlext))
endif
ifdef C_MODULE
	$(call delete-file,$(incbase)/$(C_MODULE),$(INC_EXT) $(hext))
	$(call rm-if-empty,$(srcbase)/$(C_MODULE))
endif
ifdef CXX_MODULE
	$(call delete-file,$(incbase)/$(CXX_MODULE),$(INC_EXT) $(hxxext))
	$(call rm-if-empty,$(srcbase)/$(CXX_MODULE))
endif
ifneq (,$(strip $(ENABLE_NLS)))
ifdef TRANSLATION
delete: r := $(localedir)
delete: d := $(TRANSLATION)
delete:
	$(foreach t,$(intltl),$(call delete-file,\
	    $r/$d/$(call not-root,$(basename $b)),$(poext)))
	$(foreach t,$(intltl),$(call delete-file,\
	    $r/$d/LC_MESSAGES/$(call not-root,$b),$(moext)))
	$(call rm-if-empty,$r/$d/LC_MESSAGES)
	$(call rm-if-empty,$r/$d)
endif
ifdef NLS_HEADER
	$(call delete-file,$(incbase)/$(NLS_HEADER),\
	                   $(INC_EXT) $(hext) $(hxxext))
endif
endif
endif # Check if D was defined

endif # Check if one goal is 'new' or 'delete'

########################################################################
##                         CONFIGURATION FILES                        ##
########################################################################

.PHONY: config
config:
	@echo ""
	@echo "############################################################"
	@echo "##     UNCOMMENT ANY TARGET TO OVERWRITE THE DEFAULT!     ##"
	@echo "############################################################"
	@echo ""
	@echo "# Project info"
	@echo "# ==============="
	@echo "# PROJECT         := # Project name (def: Default)"
	@echo "# VERSION         := # Version (def: 1.0.0)"
	@echo "# GIT_REMOTE_PATH := # Remote path for git repository"
	@echo "# MAINTEINER_NAME := # Your name"
	@echo "# MAINTEINER_MAIL := # your_name@mail.com"
	@echo "# COPYRIGHT       := # Copyright Holder"
	@echo "# SYNOPSIS        := # One-line description of the program"
	@echo "# DESCRIPTION     := # Longer description of the program"
	@echo ""
	@echo "# Program settings"
	@echo "# =================="
	@echo "# BIN             := # Binaries' names. If a subdir of any"
	@echo "#                    # src dir has the same name of this bin"
	@echo "#                    # it and all its subdir will be compiled"
	@echo "#                    # only for this specific binary"
	@echo "# ARLIB           := # Static/Shared libraries' names. If"
	@echo "# SHRLIB          := # one is a dir, all srcs within will"
	@echo "                     # make the lib"
	@echo ""
	@echo "# Dependencies"
	@echo "# =============="
	@echo "# GIT_DEPENDENCY  := # List of git dependencies in the form: "
	@echo "#                    # DEP_NAME => dep_path build_cmd        "
	@echo "# WEB_DEPENDENCY  := # Same as above, but for URL downloads  "
	@echo "#                    # with 'curl -o' (default) or 'wget -O' "
	@echo ""
	@echo "# Paths"
	@echo "# ======="
	@echo "# ASLIBS          := # Assembly paths"
	@echo "# CLIBS           := # C paths"
	@echo "# CXXLIBS         := # C++ paths"
	@echo "# LDLIBS          := # Linker paths"
	@echo ""
	@echo "# Flags"
	@echo "# ======="
	@echo "# CPPFLAGS        := # Precompiler Flags"
	@echo "# ASFLAGS         := # Assembly Flags"
	@echo "# CFLAGS          := # C Flags"
	@echo "# CXXFLAGS        := # C++ Flags"
	@echo "# LDFLAGS         := # Linker flags"
	@echo ""
	@echo "# Documentation"
	@echo "# ==============="
	@echo "# LICENSE         := # File with a License (def: LICENSE)"
	@echo "# NOTICE          := # Notice of the License, to be put in "
	@echo "#                    # the top of any file (def: NOTICE)."
	@echo "# DOXYFILE        := # Dxygen config file (def: Doxyfile)"
	@echo ""
	@echo "# Makeball list"
	@echo "# ==============="
	@echo "# 'include conf/makeball.mk' for pre-configured options"
	@echo "# to use the library 'makeball'"
	@echo ""

.PHONY: version
version:
	@echo "override VERSION := $(VERSION)"

.PHONY: compiler
compiler:
	@echo ""
	@echo "############################################################"
	@echo "##     UNCOMMENT ANY TARGET TO OVERWRITE THE DEFAULT!     ##"
	@echo "############################################################"
	@echo ""
	@echo "# AR     := # Create static libraries (default: ar)"
	@echo "# AS     := # Compile assembly        (default: nasm)"
	@echo "# CC     := # Compile C               (default: gcc)"
	@echo "# FC     := # Compile C++             (default: gfortran)"
	@echo "# CXX    := # Compile Fortran         (default: g++)"
	@echo "# RANLIB := # Update static libraries (default: ranlib)"

.PHONY: gitignore
gitignore:
	@echo ""
	@echo "# Automatically generated directories"
	@echo "#======================================"
	@$(foreach d,$(depdir),echo $d/; )
	@$(foreach d,$(objdir),echo $d/; )
	@$(foreach d,$(bindir),echo $d/; )
	@$(foreach d,$(sbindir),echo $d/; )
	@$(foreach d,$(execdir),echo $d/; )
	@$(foreach d,$(distdir),echo $d/; )
	@echo $(firstword $(libdir))
	@echo ""
	@echo "# Objects, Libraries and Binaries"
	@echo "#=================================="
	@$(foreach e,$(moext),echo *$e; )
	@$(foreach e,$(objext),echo *$e; )
	@$(foreach e,$(libext),echo *$e; )
	@$(foreach e,$(binext),echo *$e; )
	@echo ""
	@echo "# Make auxiliars"
	@echo "#================="
	@$(if $(strip $(doxyfile)),echo $(docdir)/doxygen/)
	@$(if $(strip $(doxyfile)),echo $(docdir)/$(doxyfile).mk)
	@$(foreach e,$(depext) $(sysext),echo *$e; )
	@echo ""

.PHONY: help
help:
	@echo "                                                            "
	@echo "AIO Makefile for C/C++/Fortran by Renato Cordeiro Ferreira. "
	@echo "Type 'make projecthelp' for additional info.                "
	@echo "                                                            "

.PHONY: projecthelp
projecthelp:
	@echo "                                                            "
	@echo "All-in-One Makefile                                         "
	@echo "=====================                                       "
	@echo "                                                            "
	@echo "Default targets:                                            "
	@echo "-----------------                                           "
	@echo " * all:              Generates all executables              "
	@echo " * check:            Compiles and run Unit Tests            "
	@echo " * compiler:         Outputs Compiler.mk to define compilers"
	@echo " * config:           Outputs Config.mk for user's options   "
	@echo " * coverage:         Creates coverage analysis information  "
	@echo " * depend:           Checks all dependencies needed to build"
	@echo " * deploy:           Deploys changes in BRANCH to REMOTE    "
	@echo " * dist-*:           As 'dist', with many compressions      "
	@echo " * dist:             Creates .tar.gz with bins and libs     "
	@echo " * docs:             Generates docs in all formats avaiable "
	@echo " * doxy:             Creates Doxygen docs                   "
	@echo " * dpkg:             Creates the project's debian package   "
	@echo " * gitignore:        Outputs .gitignore model for user      "
	@echo " * init:             Creates dirs for beggining projects    "
	@echo " * install-*:        Installs one info/html/dvi/pdf/ps docs "
	@echo " * install-docs:     Installs documentation in all formats  "
	@echo " * install:          Installs executables and libraries     "
	@echo " * installcheck:     Runs installation tests (if avaiable)  "
	@echo " * package-*:        As 'package', with many compressions   "
	@echo " * package:          As 'dist', but also with src and data  "
	@echo " * standard:         Moves files to standard directories    "
	@echo " * statistics:       Outputs file countage and LOC          "
	@echo " * sync:             Synchronizes from REMOTE to BRANCH     "
	@echo " * tar:              Creates .tar with bins and libs        "
	@echo " * translation:      Creates files for internationalization "
	@echo " * uninstall-*:      Uninstalls info/html/dvi/pdf/ps docs   "
	@echo " * uninstall:        Uninstalls anything created by installs"
	@echo " * upgrade:          Upgrades Makefile from remote repo     "
	@echo " * version:          Outputs .version.mk to store VERSION   "
	@echo "                                                            "
	@echo "Management targets:                                         "
	@echo "--------------------                                        "
	@echo " * new:              Creates C/C++/Fortran artifact         "
	@echo " * delete:           Removes C/C++/Fortran artifact         "
	@echo " * update:           Updates C/C++/Fortran artifact         "
	@echo "                                                            "
	@echo "Tags targets:                                               "
	@echo "--------------                                              "
	@echo " * ctags:            Creates tags for VI/Vim editor         "
	@echo " * etags:            Creates tags for Emacs editor          "
	@echo " * TAGS:             Creates tags for both VI/Vim and Emacs "
	@echo "                                                            "
	@echo "Debug targets:                                              "
	@echo "---------------                                             "
	@echo " * dump:             Main variables used in this Makefile   "
	@echo " * nothing:          Self-explicative, hun?                 "
	@echo "                                                            "
	@echo "Cleaning targets:                                           "
	@echo "------------------                                          "
	@echo " * mostlyclean:      Cleans all object files                "
	@echo " * clean:            Above and all types of binaries        "
	@echo " * distclean:        Above and libraries, .tar and .tar.gz  "
	@echo " * docclean:         Removes all documentation files        "
	@echo " * packageclean:     Removes all debian and RPM packages    "
	@echo " * coverageclean:    Removes all coverage analysis info     "
	@echo " * translationclean: Removes all debian and RPM packages    "
	@echo " * realclean:        Above, auto-generated source and docs  "
	@echo " * uninitialize:     Above and source/include directories   "
	@echo "                                                            "
	@echo "Help targets:                                               "
	@echo "--------------                                              "
	@echo " * help:             Info about this Makefile               "
	@echo " * projecthelp:      Perharps you kwnow if you are here...  "
	@echo "                                                            "
	@echo "Special flags:                                              "
	@echo "---------------                                             "
	@echo " * D:                Allows deletion of a C/C++ artifact    "
	@echo " * U:                Allows uninitilization of the project  "
	@echo " * V:                Allows printing the command line rules "
	@echo " * MORE:             With errors, use 'more' to read stderr "
	@echo " * SILENT:           Outputs no messages in execution       "
	@echo " * NO_GIT:           Disables git commands executed by make "
	@echo " * NO_COLORS:        Outputs are made without any color     "
	@echo " * ENABLE_NLS:       Allows internationalization            "
	@echo "                                                            "
	@echo "Management auxiliars:                                       "
	@echo "----------------------                                      "
	@echo " * IN:               Directory for 'new' files              "
	@echo " * INC_EXT:          Include extension for 'new' files      "
	@echo " * SRC_EXT:          Source extension for 'new' files       "
	@echo "                                                            "
	@echo "Management flags:                                           "
	@echo "------------------                                          "
	@echo " * NAMESPACE:        Directories for namespace (src/inc)    "
	@echo " * NMS_HEADER:       Header with all includes in a namespace"
	@echo " * LIBRARY:          Directory for library (of templates)   "
	@echo " * LIB_HEADER:       Header with all includes in a library  "
	@echo " * CLASS:            New file for a C++ class               "
	@echo " * F_FILE:           Ordinary C file                        "
	@echo " * C_FILE:           Ordinary C source and header           "
	@echo " * CXX_FILE:         Ordinary C++ source and header         "
	@echo " * C_MAIN:           Ordinary C main                        "
	@echo " * CXX_MAIN:         Ordinary C++ main                      "
	@echo " * C_MODULE:         C header and dir for its sources       "
	@echo " * CXX_MODULE:       C++ header and dif for its sources     "
	@echo " * TEMPLATE:         C++ template file                      "
	@echo " * TRANSLATION:      Portable object translation            "
	@echo " * NLS_HEADER:       Header with i18n headers and macros    "
	@echo "                                                            "

########################################################################
##                            DEBUGGING                               ##
########################################################################

define prompt
@echo "${YELLOW}"$1"${RES}"\
      $(if $(strip $2),"$(strip $2)","${RED}Empty${RES}")
endef

.PHONY: dump
dump:
ifdef VAR ####
	@echo "${YELLOW}$(VAR):${RES}"\
	      $(if $(strip $(filter undefined,$(origin $(VAR)))),\
	          "${RED}Undefined${RES}",\
	          "$(or $(strip $($(VAR))),${RED}Empty${RES})")
else
	@echo "${WHITE}\nCONFIGURATION           ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"license:      ",$(license)      )
	$(call prompt,"notice:       ",$(notice)       )
	$(call prompt,"contributors: ",$(contributors) )
	$(call prompt,"doxyfile:     ",$(doxyfile)     )
	
	@echo "${WHITE}\nIGNORED FILES           ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"ignored:      ",$(ignored)      )
	
	@echo "${WHITE}\nACCEPTED EXTENSIONS     ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"srcext:       ",$(srcext)       )
	$(call prompt,"incext:       ",$(incext)       )
	$(call prompt,"libext:       ",$(libext)       )
	$(call prompt,"lexext:       ",$(lexext)       )
	$(call prompt,"lexxext:      ",$(lexxext)      )
	$(call prompt,"yaccext:      ",$(yaccext)      )
	$(call prompt,"yaxxext:      ",$(yaxxext)      )
	$(call prompt,"esqlext:      ",$(esqlext)      )
	$(call prompt,"docext:       ",$(docext)       )
	
	@echo "${WHITE}\nLEXER                   ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"alllexer:     ",$(alllexer)     )
	$(call prompt,"clexer:       ",$(clexer)       )
	$(call prompt,"cxxlexer:     ",$(cxxlexer)     )
	$(call prompt,"lexflags:     ",$(lexflags)     )
	$(call prompt,"lexall:       ",$(lexall)       )
	$(call prompt,"lexlibs:      ",$(lexlibs)      )
	$(call prompt,"lexinc:       ",$(lexinc)       )
	
	@echo "${WHITE}\nPARSER                  ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"allparser:    ",$(allparser)    )
	$(call prompt,"cparser:      ",$(cparser)      )
	$(call prompt,"cxxparser:    ",$(cxxparser)    )
	$(call prompt,"yaccflags:    ",$(yaccflags)    )
	$(call prompt,"yaccall:      ",$(yaccall)      )
	$(call prompt,"yacclibs:     ",$(yacclibs)     )
	$(call prompt,"yaccinc:      ",$(yaccinc)      )
	
	@echo "${WHITE}\nEMBEDDED SQL PREPROC    ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"cesql:        ",$(cesql)        )
	$(call prompt,"esqlflags:    ",$(esqlflags)    )
	$(call prompt,"esqllibs:     ",$(esqllibs)     )
	$(call prompt,"esqlall:      ",$(esqlall)      )
	
	@echo "${WHITE}\nSOURCE                  ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"srcall:       ",$(srcall)       )
	$(call prompt,"srccln:       ",$(srccln)       )
	$(call prompt,"src:          ",$(src)          )
	$(call prompt,"asmall:       ",$(asmall)       )
	$(call prompt,"asmcln:       ",$(asmcln)       )
	$(call prompt,"asmsrc:       ",$(asmsrc)       )
	$(call prompt,"autoall:      ",$(autoall)      )
	$(call prompt,"autocln:      ",$(autocln)      )
	$(call prompt,"autosrc:      ",$(autosrc)      )
	$(call prompt,"c_all:        ",$(c_all)        )
	$(call prompt,"f_all:        ",$(f_all)        )
	$(call prompt,"cxx_all:      ",$(cxx_all)      )
	
	@echo "${WHITE}\nHEADERS                 ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"incall:       ",$(incall)       )
	$(call prompt,"incsub:       ",$(incsub)       )
	$(call prompt,"autoinc:      ",$(autoinc)      )
	
	@echo "${WHITE}\nSTATIC LIBRARY          ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"ar_in:        ",$(ar_in)        )
	$(call prompt,"arpat:        ",$(arpat)        )
	$(call prompt,"arpatsrc:     ",$(arpatsrc)     )
	$(call prompt,"arlibname:    ",$(arlibname)    )
	$(call prompt,"arlib:        ",$(arlib)        )
	
	@echo "${WHITE}\nDYNAMIC LIBRARY         ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"shr_in:       ",$(shr_in)       )
	$(call prompt,"shrpat:       ",$(shrpat)       )
	$(call prompt,"shrpatsrc:    ",$(shrpatsrc)    )
	$(call prompt,"shrall:       ",$(shrall)       )
	$(call prompt,"shrlibname:   ",$(shrlibname)   )
	$(call prompt,"shrlib:       ",$(shrlib)       )
	
	@echo "${WHITE}\nSYSTEM LIBRARY          ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"syslib:       ",$(syslib)       )
	$(call prompt,"syslibname:   ",$(syslibname)   )
	
	@echo "${WHITE}\nLOCAL LIBRARY           ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"loclib:       ",$(loclib)       )
	$(call prompt,"loclibname:   ",$(loclibname)   )
	
	@echo "${WHITE}\nDEPENDENCY LIBRARY      ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"deplib:       ",$(deplib)       )
	$(call prompt,"deplibname:   ",$(deplibname)   )
	
	@echo "${WHITE}\nLIBRARY                 ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"lib_in:       ",$(lib_in)       )
	$(call prompt,"libpat:       ",$(libpat)       )
	$(call prompt,"liball:       ",$(liball)       )
	$(call prompt,"libsrc:       ",$(libsrc)       )
	$(call prompt,"libname:      ",$(libname)      )
	$(call prompt,"lib:          ",$(lib)          )
	
	@echo "${WHITE}\nTEST                    ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"testall:      ",$(testall)      )
	$(call prompt,"testsrc:      ",$(testsrc)      )
	$(call prompt,"testobj:      ",$(testobj)      )
	$(call prompt,"testdep:      ",$(testdep)      )
	$(call prompt,"testbin:      ",$(testbin)      )
	$(call prompt,"testrun:      ",$(testrun)      )
	
	@echo "${WHITE}\nCOVERAGE                ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"covbin:       ",$(covbin)       )
	$(call prompt,"covall:       ",$(covall)       )
	
	@echo "${WHITE}\nOBJECT                  ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"obj:          ",$(obj)          )
	$(call prompt,"arobj:        ",$(arobj)        )
	$(call prompt,"shrobj:       ",$(shrobj)       )
	$(call prompt,"autoobj:      ",$(autoobj)      )
	$(call prompt,"objall:       ",$(objall)       )
	
	@echo "${WHITE}\nDEPENDENCY              ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"depall:       ",$(depall)       )
	$(call prompt,"progdep:      ",$(progdep)      )
	$(call prompt,"externdep:    ",$(externdep)    )
	$(call prompt,"syslibdep:    ",$(syslibdep)    )
	
	@echo "${WHITE}\nBINARY                  ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"bin:          ",$(bin)          )
	$(call prompt,"sbin:         ",$(sbin)         )
	$(call prompt,"libexec:      ",$(libexec)      )
	
	@echo "${WHITE}\nINSTALLATION            ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"destdir:      ",$(destdir)      )
	$(call prompt,"prefix:       ",$(prefix)       )
	$(call prompt,"exec_prefix:  ",$(exec_prefix)  )
	$(call prompt,"i_bindir:     ",$(i_bindir)     )
	$(call prompt,"i_sbindir:    ",$(i_sbindir)    )
	$(call prompt,"i_libexecdir: ",$(i_libexecdir) )
	$(call prompt,"i_docdir:     ",$(i_docdir)     )
	
	@echo "${WHITE}\nDOCUMENTATION           ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"texiall:      ",$(texiall)      )
	$(call prompt,"texisrc:      ",$(texiall)      )
	$(call prompt,"texiinfo:     ",$(texiinfo)     )
	$(call prompt,"texihtml:     ",$(texihtml)     )
	$(call prompt,"texidvi:      ",$(texidvi)      )
	$(call prompt,"texipdf:      ",$(texipdf)      )
	$(call prompt,"texips:       ",$(texips)       )
	
	@echo "${WHITE}\nCOMPILER FLAGS          ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"asflags:      ",$(asflags)      )
	$(call prompt,"cflags:       ",$(cflags)       )
	$(call prompt,"fflags:       ",$(fflags)       )
	$(call prompt,"cxxflags:     ",$(cxxflags)     )
	
	@echo "${WHITE}\nCOMPILER PATHS          ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"aslibs:       ",$(aslibs)       )
	$(call prompt,"clibs:        ",$(clibs)        )
	$(call prompt,"flibs:        ",$(flibs)        )
	$(call prompt,"cxxlibs:      ",$(cxxlibs)      )
	
	@echo "${WHITE}\nLINKER FLAGS            ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"ldflags:      ",$(ldflags)      )
	$(call prompt,"ldc:          ",$(ldc)          )
	$(call prompt,"ldf:          ",$(ldf)          )
	$(call prompt,"ldcxx:        ",$(ldcxx)        )
	$(call prompt,"ldlex:        ",$(ldlex)        )
	$(call prompt,"ldyacc:       ",$(ldyacc)       )
	$(call prompt,"ldesql:       ",$(ldesql)       )
	
	@echo "${WHITE}\nLINKER PATHS            ${RES}"
	@echo "----------------------------------------"
	$(call prompt,"ldlibs:       ",$(ldlibs)       )

endif #### ifdef VAR