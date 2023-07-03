vlib work
vlib riviera

vlib riviera/fifo_generator_v13_2_6
vlib riviera/xil_defaultlib

vmap fifo_generator_v13_2_6 riviera/fifo_generator_v13_2_6
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work fifo_generator_v13_2_6  -v2k5 \
"../../../ipstatic/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_6 -93 \
"../../../ipstatic/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_6  -v2k5 \
"../../../ipstatic/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../../../../C-EGUZO-PHD-FZ/newProject/projects/ip_repo/fifo_generator_0_1/sim/fifo_generator_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

