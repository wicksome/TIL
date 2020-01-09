#!/usr/bin/env bash
javac App.java -Xlint:deprecation && java App $@
