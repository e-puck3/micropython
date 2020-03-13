include ../../py/mkenv.mk

all:lib

# qstr definitions (must come before including py.mk)
QSTR_DEFS = qstrdefsport.h

# include py core make definitions
include $(TOP)/py/py.mk

CROSS_COMPILE ?= arm-none-eabi-

INC += -I.
INC += -I$(TOP)
INC += -I$(BUILD)

DFU = $(TOP)/tools/dfu.py
PYDFU = $(TOP)/tools/pydfu.py
CFLAGS_CORTEX_M7 = -mthumb -mtune=cortex-m7 -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-sp-d16 -fsingle-precision-constant -Wdouble-promotion
CFLAGS = $(INC) -Wall -Werror -std=c99 -nostdlib $(CFLAGS_CORTEX_M7) $(COPT)
LDFLAGS = -nostdlib -T stm32f405.ld -Map=$@.map --cref --gc-sections

CFLAGS += -Os -DNDEBUG -ggdb
CFLAGS += -fdata-sections -ffunction-sections

LIBS =

FROZEN_PY_FILE = frozentest.py

MPY_CROSS_FLAGS = 

SRC_C = \
	mpport.c \
	lib/utils/printf.c \
	lib/utils/stdout_helpers.c \
	lib/utils/pyexec.c \
	lib/libc/string0.c \
	lib/mp-readline/readline.c \
	lib/utils/interrupt_char.c \
	$(BUILD)/_frozen_mpy.c \

OBJ = $(PY_CORE_O) $(addprefix $(BUILD)/, $(SRC_C:.c=.o))

CLEAN_EXTRA = ./libmicropython.a frozentest.mpy


$(BUILD)/_frozen_mpy.c: $(FROZEN_PY_FILE:.py=.mpy) $(BUILD)/genhdr/qstrdefs.generated.h
	$(ECHO) "MISC freezing bytecode"
	$(Q)$(TOP)/tools/mpy-tool.py -f -q $(BUILD)/genhdr/qstrdefs.preprocessed.h -mlongint-impl=none $< > $@

$(FROZEN_PY_FILE:.py=.mpy):
	$(TOP)/mpy-cross/mpy-cross $(FROZEN_PY_FILE) $(MPY_CROSS_FLAGS)


include $(TOP)/py/mkrules.mk
