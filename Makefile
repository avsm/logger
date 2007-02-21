OCAMLMAKEFILE = ../../OCamlMakefile

SOURCES		= logger.mli logger.ml
PRE_TARGETS	= pa_logger.cma
PACKS		= strftime
RESULT		= logger
TRASH		= pa_logger.c* pa_logger.o

include ../../Makefile.global
include ../Makefile.inc
LIBINSTALL_FILES += pa_logger.cma

all: bcl ncl

test_view:
	camlp4o ./pa_logger.cma pr_o.cmo test.ml
test:
	ocamlfind ocamlopt -package unix,strftime -linkpkg -I . logger.cmxa \
		-pp 'camlp4o ./pa_logger.cma' test.ml -o test
	
pa_logger.cma: pa_logger.ml
	ocamlfind ocamlc -a -o pa_logger.cma \
	   -pp 'camlp4o pa_extend.cmo q_MLast.cmo' -package camlp4 \
	   pa_logger.ml

include $(OCAMLMAKEFILE)
