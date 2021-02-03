onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_hw3_prob3/segg
add wave -noupdate /tb_hw3_prob3/segf
add wave -noupdate /tb_hw3_prob3/sege
add wave -noupdate /tb_hw3_prob3/segd
add wave -noupdate /tb_hw3_prob3/segc
add wave -noupdate /tb_hw3_prob3/segb
add wave -noupdate /tb_hw3_prob3/sega
add wave -noupdate /tb_hw3_prob3/sysclk
add wave -noupdate /tb_hw3_prob3/sysreset
add wave -noupdate /tb_hw3_prob3/disply
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {2370 ns} {3370 ns}
