
ALLDEFS +=	-DNO_QSTR

# Include directories
#Need to add to USE_OPT and not ALLINC if we want to use -isystem option
#otherwisee it is bypassed by -I in the rules.mk of ChibiOS
USE_OPT += 	-isystem $(MPTOP) \
			-isystem $(MPTOP)/ports/ChibiOS \
# 			$(MPTOP)/ports/ChibiOS/build \
# 			$(BUILD)/genhdr
