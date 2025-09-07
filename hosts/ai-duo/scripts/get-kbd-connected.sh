#!/usr/bin/env bash
case $(lsusb | grep -c "0b05:1b2c") in
0)
  echo 0
  ;;
*)
  echo 1
  ;;
esac
