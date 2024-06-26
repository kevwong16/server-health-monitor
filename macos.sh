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
  vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages free:\s+(\d+)/ and $free=$1; /Pages active:\s+(\d+)/ and $active=$1; /Pages inactive:\s+(\d+)/ and $inactive=$1; /Pages speculative:\s+(\d+)/ and $speculative=$1; /Pages wired down:\s+(\d+)/ and $wired=$1; /Pages occupied by compressor:\s+(\d+)/ and $compressed=$1; END { printf("Free: %.2f GB\n", $free*$size/1024/1024/1024); printf("Active: %.2f GB\n", $active*$size/1024/1024/1024); printf("Inactive: %.2f GB\n", $inactive*$size/1024/1024/1024); printf("Speculative: %.2f GB\n", $speculative*$size/1024/1024/1024); printf("Wired: %.2f GB\n", $wired*$size/1024/1024/1024); printf("Compressed: %.2f GB\n", $compressed*$size/1024/1024/1024); }'
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
  ifconfig | grep -E "^(en|lo|bridge|fw|gif|stf)"
  echo ""
}

# Function to get Number of Running Processes
get_running_processes() {
  echo "Running Processes:"
  ps -e | wc -l
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
