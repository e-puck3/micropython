
ALLDEFS +=	-DNO_QSTR

# Include directories
#Need to add to USE_OPT and not ALLINC if we want to use -isystem option
#otherwisee it is bypassed by -I in the rules.mk of ChibiOS
USE_OPT += 	-isystem $(MPTOP) \
			-isystem $(MPTOP)/ports/ChibiOS \
			-isystem $(MPTOP)/ports/ChibiOS/python_flash_code \
# 			$(MPTOP)/ports/ChibiOS/build \
# 			$(BUILD)/genhdr

ALLCSRC	+=	$(MPTOP)/ports/ChibiOS/flash/flash.c

ALLINC	+=	$(MPTOP)/ports/ChibiOS/flash/

preall: 
	$(MAKE) -C $(MPTOP)/ports/ChibiOS/;
	$(MAKE) all

CLEAN_RULE_HOOK:
	$(MAKE) -C $(MPTOP)/ports/ChibiOS/ clean;
