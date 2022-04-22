#!/bin/bash

ansible-inventory -i inst_all_st.ini --list | tee inventory.json
