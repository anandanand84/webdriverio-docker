#!/usr/bin/env bash
selenium-standalone install
Xvfb :99 > xvfb.log 2>&1 &
selenium-standalone start > selenium.log 2>&1 &
wdio repl chrome