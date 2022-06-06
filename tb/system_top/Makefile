

TOPLEVEL_LANG ?= verilog
SIM=icarus
WAVES=1

PWD=$(shell pwd)

ifeq ($(OS),Msys)
WPWD=$(shell sh -c 'pwd -W')
else
WPWD=$(shell pwd)
endif

PYTHONPATH := $(PWD):$(PYTHONPATH)

VERILOG_SOURCES = $(WPWD)/../../src/*.v

TOPLEVEL := system_top
MODULE   := system_top_tb

include $(shell cocotb-config --makefiles)/Makefile.sim
