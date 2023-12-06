# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\sam\donkey_kong_ece385\mb_usb_hdmi_top\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\sam\donkey_kong_ece385\mb_usb_hdmi_top\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {mb_usb_hdmi_top}\
-hw {C:\Users\sam\donkey_kong_ece385\mb_usb_hdmi_top.xsa}\
-out {C:/Users/sam/donkey_kong_ece385}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform generate -quick
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/final_project_dk/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform create -name {mb_usb_hdmi_top}\
-hw {C:\Users\ryder\Documents\ECE385\donkey_kong_ece385\mb_usb_hdmi_top.xsa}\
-out {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform generate -quick
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/sam/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate
platform config -updatehw {C:/Users/sam/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate -domains 
<<<<<<< HEAD
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/ryder/Documents/ECE385/donkey_kong_ece385/mb_usb_hdmi_top.xsa}
platform generate
=======
>>>>>>> 90551e02da96a3d23a712602d717e3b11f2b8843
