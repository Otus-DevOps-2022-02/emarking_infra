#!/bin/bash

ansible-inventory -i inst_all_st.tpl --list | tee inventory.json
