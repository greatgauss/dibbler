LOCAL_PATH:= $(call my-dir)

etc_dir := $(TARGET_OUT)/etc/dibbler
 
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_PREBUILT_LIBS := libdibbler_supc++.a 
LOCAL_STATIC_LIBRARIES := libdibbler_supc++

include $(BUILD_MULTI_PREBUILT)


include $(CLEAR_VARS)
LOCAL_MODULE := client.conf
LOCAL_MODULE_TAGS := optional 
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(etc_dir)
LOCAL_SRC_FILES := client.conf
include $(BUILD_PREBUILT)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
		poslib/dnsmessage.cpp \
		poslib/dnssec-sign.cpp \
		poslib/domainfn.cpp \
		poslib/exception.cpp \
		poslib/lexfn.cpp \
		poslib/masterfile.cpp \
		poslib/postime.cpp \
		poslib/random.cpp \
		poslib/resolver.cpp \
		poslib/rr.cpp \
		poslib/socket.cpp \
		poslib/vsnprintf.cpp \
		poslib/w32poll.cpp

LOCAL_SRC_FILES+= \
		nettle/base64-decode.c \
		nettle/base64-encode.c \
		nettle/base64-meta.c \
		nettle/hmac.c \
		nettle/hmac-md5.c \
		nettle/md5.c \
		nettle/md5-meta.c \
		nettle/memxor.c 

LOCAL_SRC_FILES+= \
		Port-linux/interface.c \
		Port-linux/iproute.c \
		Port-linux/libnetlink.c \
		Port-linux/ll_map.c \
		Port-linux/ll_types.c \
		Port-linux/lowlevel-linux.c \
		Port-linux/lowlevel-linux-link-state.c \
		Port-linux/lowlevel-options-linux.c \
		Port-linux/utils.c

LOCAL_SRC_FILES+= \
		ClntOptions/ClntOptAAAAuthentication.cpp \
		ClntOptions/ClntOptAddrParams.cpp \
		ClntOptions/ClntOptAuthentication.cpp \
		ClntOptions/ClntOptElapsed.cpp \
		ClntOptions/ClntOptFQDN.cpp \
		ClntOptions/ClntOptIAAddress.cpp \
		ClntOptions/ClntOptIA_NA.cpp \
		ClntOptions/ClntOptIA_PD.cpp \
		ClntOptions/ClntOptIAPrefix.cpp \
		ClntOptions/ClntOptKeyGeneration.cpp \
		ClntOptions/ClntOptLifetime.cpp \
		ClntOptions/ClntOptOptionRequest.cpp \
		ClntOptions/ClntOptPreference.cpp \
		ClntOptions/ClntOptStatusCode.cpp \
		ClntOptions/ClntOptTA.cpp \
		ClntOptions/ClntOptTimeZone.cpp \
		ClntOptions/ClntOptUserClass.cpp \
		ClntOptions/ClntOptVendorClass.cpp \
		ClntOptions/ClntOptVendorSpec.cpp

LOCAL_SRC_FILES+= \
		ClntMessages/ClntMsgAdvertise.cpp \
		ClntMessages/ClntMsgConfirm.cpp \
		ClntMessages/ClntMsg.cpp \
		ClntMessages/ClntMsgDecline.cpp \
		ClntMessages/ClntMsgInfRequest.cpp \
		ClntMessages/ClntMsgRebind.cpp \
		ClntMessages/ClntMsgRelease.cpp \
		ClntMessages/ClntMsgRenew.cpp \
		ClntMessages/ClntMsgReply.cpp \
		ClntMessages/ClntMsgRequest.cpp \
		ClntMessages/ClntMsgSolicit.cpp

LOCAL_SRC_FILES+= \
		Options/OptAAAAuthentication.cpp \
		Options/OptAddr.cpp \
		Options/OptAddrLst.cpp \
		Options/OptAuthentication.cpp \
		Options/Opt.cpp \
		Options/OptDomainLst.cpp \
		Options/OptDUID.cpp \
		Options/OptEmpty.cpp \
		Options/OptFQDN.cpp \
		Options/OptGeneric.cpp \
		Options/OptIAAddress.cpp \
		Options/OptIA_NA.cpp \
		Options/OptIA_PD.cpp \
		Options/OptIAPrefix.cpp \
		Options/OptInteger.cpp \
		Options/OptKeyGeneration.cpp \
		Options/OptOptionRequest.cpp \
		Options/OptRtPrefix.cpp \
		Options/OptStatusCode.cpp \
		Options/OptString.cpp \
		Options/OptTA.cpp \
		Options/OptUserClass.cpp \
		Options/OptVendorData.cpp \
		Options/OptVendorSpecInfo.cpp

LOCAL_SRC_FILES+= \
		AddrMgr/AddrAddr.cpp \
		AddrMgr/AddrClient.cpp \
		AddrMgr/AddrIA.cpp \
		AddrMgr/AddrMgr.cpp \
		AddrMgr/AddrPrefix.cpp

LOCAL_SRC_FILES+= \
		Misc/DHCPClient.cpp \
		Misc/DHCPConst.cpp \
		Misc/DUID.cpp \
		Misc/FQDN.cpp \
		Misc/IPv6Addr.cpp \
		Misc/Key.cpp \
		Misc/KeyList.cpp \
		Misc/Logger.cpp \
		Misc/long128.cpp \
		Misc/ScriptParams.cpp \
		Misc/addrpack.c \
		Misc/base64.c \
		Misc/hmac-sha-md5.c \
		Misc/lowlevel-posix.c \
		Misc/md5.c \
		Misc/sha1.c \
		Misc/sha256.c \
		Misc/sha512.c

LOCAL_SRC_FILES += \
		ClntCfgMgr/ClntCfgAddr.cpp \
		ClntCfgMgr/ClntCfgIA.cpp \
		ClntCfgMgr/ClntCfgIface.cpp \
		ClntCfgMgr/ClntCfgMgr.cpp \
		ClntCfgMgr/ClntCfgPD.cpp \
		ClntCfgMgr/ClntCfgPrefix.cpp \
		ClntCfgMgr/ClntCfgTA.cpp \
		ClntCfgMgr/ClntLexer.cpp \
		ClntCfgMgr/ClntParsAddrOpt.cpp \
		ClntCfgMgr/ClntParser.cpp \
		ClntCfgMgr/ClntParsGlobalOpt.cpp \
		ClntCfgMgr/ClntParsIAOpt.cpp \
		ClntCfgMgr/ClntParsIfaceOpt.cpp

LOCAL_SRC_FILES += \
		CfgMgr/CfgMgr.cpp \
		CfgMgr/HostID.cpp \
		CfgMgr/HostRange.cpp \
		CfgMgr/TimeZone.cpp

LOCAL_SRC_FILES += \
		IfaceMgr/DNSUpdate.cpp \
		IfaceMgr/Iface.cpp \
		IfaceMgr/IfaceMgr.cpp \
		IfaceMgr/SocketIPv6.cpp

LOCAL_SRC_FILES += \
		ClntIfaceMgr/ClntIfaceIface.cpp \
		ClntIfaceMgr/ClntIfaceMgr.cpp

LOCAL_SRC_FILES += \
	        ClntTransMgr/ClntTransMgr.cpp	

LOCAL_SRC_FILES += \
	        ClntAddrMgr/ClntAddrMgr.cpp
	
LOCAL_SRC_FILES += \
	        Messages/Msg.cpp
	
LOCAL_CFLAGS := \
		-DLINUX \
		-fexceptions 

LOCAL_STATIC_LIBRARIES := libdibbler_supc++
LOCAL_SHARED_LIBRARIES := \
			libstlport

LOCAL_C_INCLUDES := \
                external/stlport/stlport \
                bionic \
		$(LOCAL_PATH) \
		$(LOCAL_PATH)/include \
		$(LOCAL_PATH)/nettle \
		$(LOCAL_PATH)/ClntAddrMgr \
		$(LOCAL_PATH)/ClntCfgMgr \
		$(LOCAL_PATH)/ClntIfaceMgr \
		$(LOCAL_PATH)/ClntMessages \
		$(LOCAL_PATH)/ClntOptions \
		$(LOCAL_PATH)/ClntTransMgr \
		$(LOCAL_PATH)/SrvAddrMgr \
		$(LOCAL_PATH)/SrvCfgMgr \
		$(LOCAL_PATH)/SrvIfaceMgr \
		$(LOCAL_PATH)/SrvMessages \
		$(LOCAL_PATH)/SrvOptions \
		$(LOCAL_PATH)/SrvTransMgr \
		$(LOCAL_PATH)/RelCfgMgr \
		$(LOCAL_PATH)/RelIfaceMgr \
		$(LOCAL_PATH)/RelMessages \
		$(LOCAL_PATH)/RelOptions \
		$(LOCAL_PATH)/RelTransMgr \
		$(LOCAL_PATH)/CfgMgr \
		$(LOCAL_PATH)/IfaceMgr \
		$(LOCAL_PATH)/AddrMgr \
		$(LOCAL_PATH)/Options \
		$(LOCAL_PATH)/Messages \
		$(LOCAL_PATH)/Misc \
		$(LOCAL_PATH)/poslib 
 
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libdibbler
LOCAL_PRELINK_MODULE := false
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES :=  \
                Port-linux/daemon.cpp \
                Port-linux/dibbler-client.cpp

LOCAL_C_INCLUDES := \
                external/stlport/stlport \
                bionic \
		$(LOCAL_PATH) \
		$(LOCAL_PATH)/include \
		$(LOCAL_PATH)/nettle \
		$(LOCAL_PATH)/ClntAddrMgr \
		$(LOCAL_PATH)/ClntCfgMgr \
		$(LOCAL_PATH)/ClntIfaceMgr \
		$(LOCAL_PATH)/ClntMessages \
		$(LOCAL_PATH)/ClntOptions \
		$(LOCAL_PATH)/ClntTransMgr \
		$(LOCAL_PATH)/SrvAddrMgr \
		$(LOCAL_PATH)/SrvCfgMgr \
		$(LOCAL_PATH)/SrvIfaceMgr \
		$(LOCAL_PATH)/SrvMessages \
		$(LOCAL_PATH)/SrvOptions \
		$(LOCAL_PATH)/SrvTransMgr \
		$(LOCAL_PATH)/RelCfgMgr \
		$(LOCAL_PATH)/RelIfaceMgr \
		$(LOCAL_PATH)/RelMessages \
		$(LOCAL_PATH)/RelOptions \
		$(LOCAL_PATH)/RelTransMgr \
		$(LOCAL_PATH)/CfgMgr \
		$(LOCAL_PATH)/IfaceMgr \
                $(LOCAL_PATH)/AddrMgr \
                $(LOCAL_PATH)/Options \
                $(LOCAL_PATH)/Messages \
                $(LOCAL_PATH)/Misc \
                $(LOCAL_PATH)/poslib

LOCAL_CFLAGS := \
		-DLINUX \
		-fno-rtti  


LOCAL_SHARED_LIBRARIES := \
			libstlport \
			libdibbler 

LOCAL_MODULE = dibbler-client
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)


