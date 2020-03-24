
MPTOP_CHIBIOS ?= $(MPTOP)/Micropython_ChibiOS

ALLDEFS +=	-DNO_QSTR

# Include directories
#Need to add to USE_OPT and not ALLINC if we want to use -isystem option
#otherwisee it is bypassed by -I in the rules.mk of ChibiOS
USE_OPT += 	-isystem $(MPTOP) \
			-isystem $(MPTOP_CHIBIOS) \
			-isystem $(MPTOP_CHIBIOS)/python_flash_code \
# 			$(MPTOP)/ports/ChibiOS/build \
# 			$(BUILD)/genhdr

ALLCSRC	+=	$(MPTOP_CHIBIOS)/flash/mp_flash.c \
			$(MPTOP_CHIBIOS)/mp_platform.c

ALLINC	+=	$(MPTOP_CHIBIOS)/ \
			$(MPTOP_CHIBIOS)/mp_flash/

# yes or no to compile and include or not the frozen files described by manifest.py
MP_FROZEN_PYTHON ?= no
# yes or no to include or not the python script python_flash_code/py_flash.py in the flash
# needs to have correctly configured the .ld file
MP_PYTHON_FLASH_CODE ?= no

ifeq ($(MP_FROZEN_PYTHON),yes)
	ALLDEFS += -DFROZEN_PYTHON
endif

ifeq ($(MP_PYTHON_FLASH_CODE),yes)
	ALLDEFS += -DPYTHON_FLASH_CODE
endif

preall: 
	$(MAKE) -C $(MPTOP_CHIBIOS)/ MPTOP=$(MPTOP_FOR_MP_MAKEFILE) FROZEN_PYTHON=$(MP_FROZEN_PYTHON) PYTHON_FLASH_CODE=$(MP_PYTHON_FLASH_CODE);
	$(MAKE) all

CLEAN_RULE_HOOK:
	$(MAKE) -C $(MPTOP_CHIBIOS)/ clean MPTOP=$(MPTOP_FOR_MP_MAKEFILE);
