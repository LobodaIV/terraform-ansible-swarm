#!/bin/sh -x
playbook=${1}
state_file_name="terraform.tfstate"

(cd ../terraform && terraform state pull) > ${state_file_name}
(sed -i -r 's/^.{2}//' terraform.tfstate && ./terraform.py ${1})

#rm ${state_file_name}
