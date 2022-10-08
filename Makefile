PROBLEM = #Input
SOURCE = $(PROBLEM).ml
EXEC = a.out
TEST_FOLDER = Tests
ER_FOLDER = Expected_Results
RESULTS = Results

IN = #INPUT
GEN_FOLDER = gen


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

showtime=time -f "Time:\t%U + %S"
showfile="\n"$(Black)$(On_White)$$file" "$(Color_Off)
initcolor=$(On_Black)$(BGreen)
donecolor=$(On_Green)$(BWhite)

all: compile test compare

compile:
	@ echo "\n"$(initcolor)"COMPILING "$(Color_Off)"\n"
	ocamlopt $(SOURCE)
	@ echo "\n"$(On_Green)$(BWhite)"DONE COMPILING "$(Color_Off)"\n"

test:
	@ echo "\n"$(initcolor)"TESTING "$(Color_Off)"\n"
	@ cd $(TEST_FOLDER) &&                                          \
	for file in *.in;                                               \
	do                                                              \
		echo $(showfile);                                           \
		$(showtime) ../$(EXEC) < "$$file" > "$(RESULTS)/$$file.out";\
	done
	@ echo $(donecolor)"DONE TESTING "$(Color_Off)"\n"

time:
	@ echo "\n"$(initcolor)"TIMING "$(Color_Off)"\n"
	@ cd $(TEST_FOLDER) &&                                          \
	for file in *.in;                                               \
	do                                                              \
		echo $(showfile);                                           \
		$(showtime) ../$(EXEC) < "$$file";                          \
	done
	@ echo "\n"$(donecolor)"DONE TESTING "$(Color_Off)"\n"

compare:
	@ echo "\n"$(initcolor)"COMPARING "$(Color_Off)"\n"
	@ cd $(ER_FOLDER) &&                                            \
	for file in *.out;                                              \
	do                                                              \
		echo $(showfile);                                           \
		diff "$$file" "../$(TEST_FOLDER)/$(RESULTS)/$$file";        \
	done
	@ echo "\n"$(donecolor)"DONE COMPARING "$(Color_Off)"\n"

clean:
	@ echo "\n"$(initcolor)"CLEANING "$(Color_Off) 
	@ echo "Removing complementary files."
	@ rm a.out $(PROBLEM).cmi $(PROBLEM).cmx $(PROBLEM).o
	@ cd $(GEN_FOLDER) && rm *.o *.cmi *.cmx *.out
	@ gen_clean
	@ echo "Removing $(RESULTS) folder."
	@ rm -r $(TEST_FOLDER)/$(RESULTS)
	@ echo "Creating $(RESULTS) folder."
	@ mkdir $(TEST_FOLDER)/$(RESULTS)
	@ echo "\n"$(donecolor)"DONE CLEANING "$(Color_Off)"\n"

setup:
	@ echo "\n"$(initcolor)"SETTING UP"$(Color_Off)"\n"
	@ echo "Criar: $(TEST_FOLDER)"
	@ mkdir $(TEST_FOLDER)
	@ echo "Criar: $(TEST_FOLDER)/$(RESULTS)"
	@ mkdir $(TEST_FOLDER)/$(RESULTS)
	@ echo "Criar: $(ER_FOLDER)"
	@ mkdir $(ER_FOLDER)
	@ echo "Criar: $(GEN_FOLDER)"
	@ mkdir $(GEN_FOLDER)
	@ touch $(GEN_FOLDER)/$(GEN_FOLDER).ml
	@ echo "\n"$(donecolor)"DONE SETTING UP"$(Color_Off)"\n"

generate:
	cd $(GEN_FOLDER) &&                                             \
	ocamlopt -o $(GEN_FOLDER).out $(GEN_FOLDER).ml
	date +%s%N | $(GEN_FOLDER)/$(GEN_FOLDER).out > "$(TEST_FOLDER)/$(IN).in"

gen_clean:
	cd $(GEN_FOLDER) &&                                             \
	rm *.o *.cmi *.cmx *.out

help:
	@ echo "\nMAKE [ARGS]\n"
	@ echo "[ARGUMENTS]:"
	@ echo "	compile   - Compiles defined Problem"
	@ echo "	test      - Tests defined Problem with each input inside 'Tests' folder"
	@ echo "	time      - _test_ command but outputting time taken"
	@ echo "	compare   - _test_ command but comparing output files with expected content from 'Expected_Results' folder"
	@ echo "	clean     - Cleans complementary files such as .out .cmi .cmx .o"
	@ echo "	setup     - Setups a new problem directory ready to new code"
	@ echo "	generate  - Based on the generation OCaml script generates a new random .in file randomly"
	@ echo "	gen_clean - Cleans generation folder from complementary files"
	@ echo ""
