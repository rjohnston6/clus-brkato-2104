#!/usr/bin/env bash

ansible-playbook playbooks/external_route_change.yml -l clus-mdt-core1 -e if_enabled=no