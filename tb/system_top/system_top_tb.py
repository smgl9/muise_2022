# -*- coding: utf-8 -*-
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

@cocotb.test()
async def run_test(dut):
  PERIOD = 10
  cocotb.fork(Clock(dut.clk_50mhz_in, PERIOD, 'ns').start(start_high=False))


  await Timer(20*PERIOD, units='ns')



  await Timer(20000*PERIOD, units='ns')

    