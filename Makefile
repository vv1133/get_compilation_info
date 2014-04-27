GCC_VERSION := $(shell `echo $(CC)|sed "s/^-//"` -v 2>&1 | grep "gcc version")
PLATFORM := $(shell cat -v /etc/issue | grep "[a-zA-Z0-9 ]" | grep -v "\^" | sed 's+\\+\\\\\\\\+g')
COMPILE_PARA := $(shell grep "\<FLAGS\> *[+: ]=" Makefile | sed -e "s/\<FLAGS\> *[+: ]=\(.*\)/\1/" -e "s/\(.*\)\#.*/\1/" -e "s/[ \t]\+/ /g")
GEN_VERSION := $(shell grep "genflash version:" main.c | sed "s/.*genflash version: *\(.*\)\"/\1/")

###########################################################################

all: info deps objects $(OBJS) $(LIB) $(BIN) $(DLL)

info: Makefile
	@chmod +x a.sh
	@./get_info.sh
	@echo "Generating compilation infomation...";
	@echo "#ifndef __INFO_H__" > info.h
	@echo "#define __INFO_H__" >> info.h
	@echo '#define GEN_VERSION "Genflash version: $(GEN_VERSION)"' >> info.h
	@echo '#define GCC_VERSION "Genflash compiler version: $(GCC_VERSION)"' >> info.h
	@echo '#define PLATFORM_INFO "Genflash platform: $(PLATFORM)"' >> info.h
	@echo '#define COMPILE_PARA "Genflash complier para:$(COMPILE_PARA)"' >> info.h
	@echo "#endif" >> info.h


