onerror {resume}
radix fpoint 20
radix fpoint 12
radix fpoint 3
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mlp_single/DUT/clk
add wave -noupdate /tb_mlp_single/DUT/nrst
add wave -noupdate -radix decimal /tb_mlp_single/DUT/X
add wave -noupdate -radix decimal -childformat {{/tb_mlp_single/DUT/output(2) -radix decimal} {/tb_mlp_single/DUT/output(1) -radix decimal} {/tb_mlp_single/DUT/output(0) -radix decimal}} -subitemconfig {/tb_mlp_single/DUT/output(2) {-radix decimal} /tb_mlp_single/DUT/output(1) {-radix decimal} /tb_mlp_single/DUT/output(0) {-radix decimal}} /tb_mlp_single/DUT/output
add wave -noupdate -radix decimal /tb_mlp_single/DUT/NEURON_INS/b
add wave -noupdate -radix decimal -childformat {{/tb_mlp_single/DUT/NEURON_INS/W(2) -radix decimal} {/tb_mlp_single/DUT/NEURON_INS/W(1) -radix decimal} {/tb_mlp_single/DUT/NEURON_INS/W(0) -radix decimal}} -subitemconfig {/tb_mlp_single/DUT/NEURON_INS/W(2) {-radix decimal} /tb_mlp_single/DUT/NEURON_INS/W(1) {-radix decimal} /tb_mlp_single/DUT/NEURON_INS/W(0) {-radix decimal}} /tb_mlp_single/DUT/NEURON_INS/W
add wave -noupdate -radix decimal -childformat {{/tb_mlp_single/DUT/NEURON_INS/X(2) -radix decimal} {/tb_mlp_single/DUT/NEURON_INS/X(1) -radix decimal} {/tb_mlp_single/DUT/NEURON_INS/X(0) -radix decimal}} -expand -subitemconfig {/tb_mlp_single/DUT/NEURON_INS/X(2) {-radix decimal} /tb_mlp_single/DUT/NEURON_INS/X(1) {-radix decimal} /tb_mlp_single/DUT/NEURON_INS/X(0) {-radix decimal}} /tb_mlp_single/DUT/NEURON_INS/X
add wave -noupdate -radix decimal /tb_mlp_single/DUT/NEURON_INS/result
add wave -noupdate -radix decimal /tb_mlp_single/DUT/DATA_RAM_INS/X_input
add wave -noupdate /tb_mlp_single/DUT/DATA_RAM_INS/data_enable
add wave -noupdate /tb_mlp_single/DUT/DATA_RAM_INS/data_address
add wave -noupdate /tb_mlp_single/DUT/DATA_RAM_INS/feedback_enable
add wave -noupdate /tb_mlp_single/DUT/DATA_RAM_INS/feedback_address_N
add wave -noupdate /tb_mlp_single/DUT/DATA_RAM_INS/feedback_address_M
add wave -noupdate -radix decimal /tb_mlp_single/DUT/DATA_RAM_INS/feedback
add wave -noupdate -radix decimal /tb_mlp_single/DUT/DATA_RAM_INS/X_output
add wave -noupdate /tb_mlp_single/DUT/WEIGHT_ROM_INS/weight_rom_enable
add wave -noupdate /tb_mlp_single/DUT/WEIGHT_ROM_INS/weight_rom_address_M
add wave -noupdate /tb_mlp_single/DUT/WEIGHT_ROM_INS/weight_rom_address_N
add wave -noupdate -radix decimal /tb_mlp_single/DUT/WEIGHT_ROM_INS/weight_output
add wave -noupdate -radix decimal -childformat {{/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0) -radix decimal -childformat {{/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0) -radix decimal -childformat {{/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(0) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(1) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(2) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(3) -radix decimal}}} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(1) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(2) -radix decimal}}} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(1) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(2) -radix decimal}} -subitemconfig {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0) {-radix decimal -childformat {{/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0) -radix decimal -childformat {{/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(0) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(1) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(2) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(3) -radix decimal}}} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(1) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(2) -radix decimal}}} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0) {-radix decimal -childformat {{/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(0) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(1) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(2) -radix decimal} {/tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(3) -radix decimal}}} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(0) {-radix decimal} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(1) {-radix decimal} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(2) {-radix decimal} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(0)(3) {-radix decimal} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(1) {-radix decimal} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(0)(2) {-radix decimal} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(1) {-radix decimal} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory(2) {-radix decimal}} /tb_mlp_single/DUT/WEIGHT_ROM_INS/memory
add wave -noupdate /tb_mlp_single/DUT/FSM_INS/end_state
add wave -noupdate /tb_mlp_single/DUT/FSM_INS/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {82 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 355
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {133 ns}
