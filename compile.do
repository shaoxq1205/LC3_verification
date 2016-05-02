	
vlog *.v 
vlog *.vp
vlog -sv Testbench.sv
#-sv will affect the address
#restart -f
vsim -novopt top_testbench 
#if want to read coverage
#vsim -novopt -coverage top_testbench
#vsim -novopt top_testbench -l output

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider AllTransaction
add wave sim:top_testbench/intf/*

add wave -noupdate -divider Fetch
add wave sim:/top_testbench/intf/clock
add wave sim:top_testbench/intf/reset
add wave sim:/top_testbench/prob_ft/*

add wave -noupdate -divider Decode
add wave sim:top_testbench/intf/clock
add wave sim:top_testbench/intf/reset
add wave sim:top_testbench/prob_de/*

add wave -noupdate -divider Execute
add wave sim:top_testbench/intf/clock
add wave sim:top_testbench/intf/reset
add wave sim:top_testbench/prob_ex/*

add wave -noupdate -divider Writeback
add wave sim:top_testbench/intf/clock
add wave sim:top_testbench/intf/reset
add wave sim:top_testbench/prob_wb/*

add wave -noupdate -divider Controller
add wave sim:top_testbench/intf/clock
add wave sim:top_testbench/intf/reset
add wave sim:top_testbench/prob_cnt/*

add wave -noupdate -divider MemoryAccess
add wave sim:top_testbench/intf/clock
add wave sim:top_testbench/intf/reset
add wave sim:top_testbench/prob_ma/*

do wave_format.do

run 2000000ns
stop