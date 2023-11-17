# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\Users\ryder\Documents\ECE385\final_project_dk\donkey_kong_system\_ide\scripts\systemdebugger_donkey_kong_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\Users\ryder\Documents\ECE385\final_project_dk\donkey_kong_system\_ide\scripts\systemdebugger_donkey_kong_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "RealDigital Boo 887429230053A" && level==0 && jtag_device_ctx=="jsn1-0362f093-0"}
fpga -file C:/Users/ryder/Documents/ECE385/final_project_dk/donkey_kong/_ide/bitstream/mb_usb_hdmi_top.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top/export/mb_usb_hdmi_top/hw/mb_usb_hdmi_top.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow C:/Users/ryder/Documents/ECE385/final_project_dk/donkey_kong/Debug/donkey_kong.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
