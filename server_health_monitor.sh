#!/bin/bash

# Function to get Disk Space Usage
get_disk_usage() {
  echo "Disk Usage:"
  df -h | awk 'NR==1 || /^\/dev/'
  echo ""
}

# Function to get Memory Usage
get_memory_usage() {
  echo "Memory Usage:"
  free -h | awk 'NR==1 || /Mem|Swap/'
  echo ""
}

# Function to get CPU Usage
get_cpu_usage() {
  echo "CPU Usage:"
  top -l 1 | grep -E "^CPU" | awk '{print "CPU usage: " $3 + $5 "%"}'
  echo ""
}

# Function to get Network Interface Status
get_network_status() {
  echo "Network Interfaces:"
  ip -brief addr show
  echo ""
}

# Function to get Number of Running Processes
get_running_processes() {
  echo "Running Processes:"
  ps -e --no-headers | wc -l
  echo ""
}

# Main function to call all monitoring functions
monitor_server() {
  echo "Server Health Monitor"
  echo "======================"
  get_disk_usage
  get_memory_usage
  get_cpu_usage
  get_network_status
  get_running_processes
}

# Run the monitoring function
monitor_server
