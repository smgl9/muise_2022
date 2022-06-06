# -*- coding: utf-8 -*-
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

@cocotb.test()
async def run_test(dut):
  PERIOD = 10
  cocotb.fork(Clock(dut.clk_i, PERIOD, 'ns').start(start_high=False))

  dut.m_axis_tready = 0
  dut.m_axis_tvalid = 0
  dut.m_axis_tdata = 0
  dut.m_axis_tlast = 0
  dut.m_axis_tuser = 0

  await Timer(20*PERIOD, units='ns')

  dut.m_axis_tready = 1

  await Timer(2000*PERIOD, units='ns')
  dut.m_axis_tready = 0
  await Timer(200*PERIOD, units='ns')
  dut.m_axis_tready = 1
  await Timer(2000*PERIOD, units='ns')

    