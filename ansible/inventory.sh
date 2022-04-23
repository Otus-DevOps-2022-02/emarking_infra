#!/bin/bash

ansible-inventory -i inventory --list | tee inventory.json

sed -i 's/"ungrouped"/ /' ./inventory.json | sed -i 's/"db-stage",/"db-stage"/' ./inventory.json
