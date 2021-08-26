#!/usr/bin/env sh

while true; do
  running_vms=$( VBoxManage list runningvms | awk '{print $2}' 2>&1 )
  if [ -z "$running_vms" ]
  then
    # output is empty - success - leave the loop:
    break
  else
    VBoxManage list runningvms | awk '{print $2}' | xargs -I vmid VBoxManage controlvm vmid poweroff
  fi
done
VBoxManage list vms | awk '{print $2}' | xargs -I vmid VBoxManage unregistervm --delete vmid
vagrant global-status --prune