#!/bin/bash -x
# 
# The object of this is to
#  - format all source files with https://github.com/google/yapf
#  - quickly run all specified tests when a file changes
#  - create a new git commit if all of the tests are passing :white_check_mark:
# 
# In general, while working on the project, I use https://github.com/cespare/reflex to run the tests passively while I make changes. From this working directory, I can run:
# 
# $ reflex bash runtests.sh
# 
# This will watch for any file modifications in the project, and re-run the tests (and possibly commit the code) when they occur (wow such TDD)
# 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

testSuperlists() {
    cd superlists || exit 1
    # sleep 1 \
    python3 manage.py test lists \
    && python3 manage.py test selenium_tests
}

formatCode() {
	cd "$DIR" || exit
	printf "\033[32mApplying yapf...\033[0m\n"
	python3 -m yapf -i -r -e "*.py" .
}

commitCode() {
	cd "$DIR" || exit
	git add .
	git status
	git commit && git push
	printf "\033[32mEverything's looking good :)\033[0m\n\n"
	return 0 # just in case nothing to commit
}

echo ""
echo "$(date) :  Testing out new changes now :)"

formatCode
testSuperlists
STATUS=$?
sleep 1
if [[ $STATUS == "0" ]]; then
	printf "\033[32mPassing tests!\033[0m\n"
	echo "I am in this directory: $(pwd)"
	commitCode
else
	printf "\033[31mNot passing tests... :(\033[0m\n"
fi
