

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

VERILOG_SOURCES = $(WPWD)/../../src/video_generator.v

TOPLEVEL := video_generator
MODULE   := video_generator_tb

include $(shell cocotb-config --makefiles)/Makefile.sim
