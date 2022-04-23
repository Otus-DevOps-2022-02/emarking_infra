#!/bin/bash

ansible-inventory -i instventory --list | tee inventory.json
