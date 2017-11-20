#!/bin/bash

TARGETS="neko cpp html5"
BUILD_DIR=${TRAVIS_BUILD_DIR:-$(pwd)}

# HaxePunk tool
echo "Compiling tool.n"
cd $BUILD_DIR/tools
haxe tool.hxml

# Unit testing
if [[ $TEST ]]; then
    echo "Running unit tests"
    cd $BUILD_DIR/tests
    haxelib run munit test test-${TEST}.hxml -coverage
fi

# Examples
if [[ $COMMAND ]]; then
    for TARGET in $TARGETS; do
        echo "Building examples with" $TARGET "using" $COMMAND
        cd $BUILD_DIR
	    for EXAMPLE in `find examples -mindepth 1 -maxdepth 1 -type d`; do
            echo "Building" $EXAMPLE "..."
            cd $BUILD_DIR/$EXAMPLE
            haxelib run $COMMAND build $TARGET || exit
        done
    done
fi

# Documentation
if [[ $COMMAND ]] && [[ $DOCS ]]; then
    echo "Generating documentation"
	cd $BUILD_DIR/doc
    for TARGET in $TARGETS; do
        haxelib run $COMMAND build $TARGET -xml
    done
    haxelib run dox -i `find bin -name 'types.xml'` -o pages/ -theme theme/ \
        -in haxepunk --title "HaxePunk" \
        -D source-path "https://github.com/HaxePunk/HaxePunk/tree/master" > log.txt || cat log.txt
fi