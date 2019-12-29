#!/usr/bin/env bash

# while-menu-dialog: a menu driven system information program

DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=25
WIDTH=50

display_result() {
  dialog --title "$1" \
    --no-collapse \
    --msgbox "$result" 0 0
}

while true; do
  exec 3>&1
  selection=$(dialog \
    --backtitle "THIS IS A VULTR PLUGIN FOR VAGRANT" \
    --title "MENU" \
    --clear \
    --cancel-label "EXIT" \
    --menu "Please select:" $HEIGHT $WIDTH 4 \
    "0" "Add Token" \
    "1" "Select Server" \
    "2" "Select OS" \
    "3" "Select Region" \
    "4" "Add Hostname" \
    "5" "Add Label" \
    "6" "Add Tag" \
    2>&1 1>&3)
  exit_status=$?
  exec 3>&-
  case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
  esac
  case $selection in
    0 )
      clear
      echo "Program terminated."
      ;;
    1 )
      result=$(echo "Hostname: $HOSTNAME"; uptime)
      display_result "System Information"
      ;;
    2 )
      result=$(df -h)
      display_result "Disk Space"
      ;;
    3 )
      if [[ $(id -u) -eq 0 ]]; then
        result=$(du -sh /home/* 2> /dev/null)
        display_result "Home Space Utilization (All Users)"
      else
        result=$(du -sh $HOME 2> /dev/null)
        display_result "Home Space Utilization ($USER)"
      fi
      ;;
    4 )
      result=$(echo "Hostname: $USER"; cat /etc/os-release)
      display_result "System Information"
      ;;
    5 )
      result=$(echo "Hostname: $USER"; netstat -tulpn)
      display_result "Open ports List"
      ;;
    6 )
      result=$(echo "Hostname: $HOSTNAME"; uptime)
      display_result "System Information"
      ;;
  esac
done
