#!/usr/bin/env bash

ansible-playbook playbooks/shutdown_bgp_peer.yml -e shut_peer=no