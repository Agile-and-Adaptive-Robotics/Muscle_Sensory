LOCAL_PATH:= $(call my-dir)
 
 
include $(CLEAR_VARS)
 
LOCAL_MODULE_TAGS := eng
LOCAL_SRC_FILES:=vl53l0x_test.c
LOCAL_MODULE:=vl53l0x_test
LOCAL_CPPFLAGS += -DANDROID
LOCAL_SHARED_LIBRARIES:=libc
LOCAL_STATIC_LIBRARIES := 
LOCAL_C_INCLUDES += $(LOCAL_PATH) $(LOCAL_PATH)/$(KERNEL_DIR)/include
include $(BUILD_EXECUTABLE)
 
include $(CLEAR_VARS)
 
LOCAL_MODULE_TAGS := eng
LOCAL_SRC_FILES:=vl53l0x_reg.c
LOCAL_MODULE:=vl53l0x_reg
LOCAL_CPPFLAGS += -DANDROID
LOCAL_SHARED_LIBRARIES:=libc
LOCAL_STATIC_LIBRARIES := 
LOCAL_C_INCLUDES += $(LOCAL_PATH) $(LOCAL_PATH)/$(KERNEL_DIR)/include
include $(BUILD_EXECUTABLE)
 
include $(CLEAR_VARS)
 
LOCAL_MODULE_TAGS := eng
LOCAL_SRC_FILES:=vl53l0x_parameter.c
LOCAL_MODULE:=vl53l0x_parameter
LOCAL_CPPFLAGS += -DANDROID
LOCAL_SHARED_LIBRARIES:=libc
LOCAL_STATIC_LIBRARIES := 
LOCAL_C_INCLUDES += $(LOCAL_PATH) $(LOCAL_PATH)/$(KERNEL_DIR)/include
include $(BUILD_EXECUTABLE)

