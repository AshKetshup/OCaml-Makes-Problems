PROBLEMA = C
SOURCE = $(PROBLEMA).ml
EXEC = a.out
TEST_FOLDER = Tests
ER_FOLDER = Expected_Results
RESULTS = Results

all: compile test compare

compile:
	@ echo "\nCOMPILING."
	ocamlopt $(SOURCE)
	@ echo "DONE COMPILING\n"

test:
	@ echo "\nTESTING"
	@ cd $(TEST_FOLDER) &&                                   \
	for file in *.in;   									 \
	do                                                       \
		echo $$file;										 \
		../$(EXEC) < "$$file" > "$(RESULTS)/$$file.out";     \
	done
	@ echo "DONE TESTING\n"

compare:
	@ echo "\nCOMPARING."
	@ cd $(ER_FOLDER) &&                                     \
	for file in *.out;   									 \
	do                                                       \
		echo $$file;                                         \
		diff "$$file" "../$(TEST_FOLDER)/$(RESULTS)/$$file"; \
	done
	@ echo "DONE COMPARING\n"

clean:
	@ echo "\nCLEANING" 
	@ echo "Removing complementary files."
	@ rm a.out $(PROBLEMA).cmi $(PROBLEMA).cmx $(PROBLEMA).o
	@ echo "Removing $(RESULTS) folder."
	@ rm -r $(TEST_FOLDER)/$(RESULTS)
	@ echo "Creating $(RESULTS) folder."
	@ mkdir $(TEST_FOLDER)/$(RESULTS)
	@ echo "DONE CLEANING\n"

setup:
	@ echo "\nSETTING UP"
	@ echo "Criar: $(TEST_FOLDER)"
	@ mkdir $(TEST_FOLDER)
	@ echo "Criar: $(TEST_FOLDER)/$(RESULTS)"
	@ mkdir $(TEST_FOLDER)/$(RESULTS)
	@ echo "Criar: $(ER_FOLDER)"
	@ mkdir $(ER_FOLDER)
	@ echo "DONE SETTING UP\n"