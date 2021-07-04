PROBLEMA = E
SOURCE = $(PROBLEMA).ml
EXEC = a.out
TEST_FOLDER = Tests
ER_FOLDER = Expected_Results
RESULTS = Results


# Appearence
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White


# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White


all: compile test compare

compile:
	@ echo "\n\033[40m\033[0;32mCOMPILING\033[0m"
	ocamlopt $(SOURCE)
	@ echo "DONE COMPILING\033[0m\n"

test:
	@ echo "\n\033[40m\033[0;32mTESTING\033[0m"
	@ cd $(TEST_FOLDER) &&                                   \
	for file in *.in;   									 \
	do                                                       \
		echo "\n$$file";									 \
		time ../$(EXEC) < "$$file" > "$(RESULTS)/$$file.out";\
	done
	@ echo "DONE TESTING\n"

time:
	@ echo "\n\033[40m\033[0;32mTIMING\033[0m"
	@ cd $(TEST_FOLDER) &&                                   \
	for file in *.in;   									 \
	do                                                       \
		echo $$file;										 \
		time ../$(EXEC) < "$$file";     					 \
	done
	@ echo "DONE TESTING\033[0m\n"

compare:
	@ echo "\n\033[40m\033[0;32mCOMPARING\033[0m."
	@ cd $(ER_FOLDER) &&                                     \
	for file in *.out;   									 \
	do                                                       \
		echo $$file;                                         \
		diff "$$file" "../$(TEST_FOLDER)/$(RESULTS)/$$file"; \
	done
	@ echo "DONE COMPARING\033[0m\n"

clean:
	@ echo "\n\033[40m\033[0;32mCLEANING\033[0m" 
	@ echo "Removing complementary files."
	@ rm a.out $(PROBLEMA).cmi $(PROBLEMA).cmx $(PROBLEMA).o
	@ echo "Removing $(RESULTS) folder."
	@ rm -r $(TEST_FOLDER)/$(RESULTS)
	@ echo "Creating $(RESULTS) folder."
	@ mkdir $(TEST_FOLDER)/$(RESULTS)
	@ echo "DONE CLEANING\033[0m\n"

setup:
	@ echo "\n\033[40m\033[0;32mSETTING\033[0m UP"
	@ echo "Criar: $(TEST_FOLDER)"
	@ mkdir $(TEST_FOLDER)
	@ echo "Criar: $(TEST_FOLDER)/$(RESULTS)"
	@ mkdir $(TEST_FOLDER)/$(RESULTS)
	@ echo "Criar: $(ER_FOLDER)"
	@ mkdir $(ER_FOLDER)
	@ echo "DONE SETTING UP\033[0m\n"