#!/bin/bash

ansible-inventory -i inventory --list | tee inventory.json
