#!/bin/bash

# It is worth using set -o pipefail without -e or explicitly handling errors.
set -ou pipefail

HOST=$(hostname)
refresh=1

while true; do
    clear
    echo "[$(date +%H:%M:%S)] Monitoring ${HOST}"
    echo ""

    # Total CPU usage

    read load_average_1 load_average_5 load_average_15 _ < /proc/loadavg
    cpu_cores=$(nproc)

    la5_int=${load_average_5%.*}
    if (( la5_int >= cpu_cores )); then
       echo -e "[CPU usage]\tWARNING LA5M!"
    else
       echo "[CPU usage]"
    fi
    echo "Load average in 1  minute (LA1M)  ${load_average_1}"
    echo "Load average in 5  minute (LA5M)  ${load_average_5}"
    echo "Load average in 15 minute (LA15M) ${load_average_15}"
    echo ""

    # Total memory usage (Free vs Used including percentage)

    read -r mem_total_label mem_total_value _ <<< "$(grep '^MemTotal:' /proc/meminfo)"
    read -r mem_free_label mem_free_value _ <<< "$(grep '^MemFree:' /proc/meminfo)"
    read -r mem_avl_label mem_avl_value _ <<< "$(grep '^MemAvailable:' /proc/meminfo)"

    if [[ -z "$mem_total_value" || -z "$mem_avl_value" ]]; then
        echo "ERROR: Failed to read memory info"
        exit 1
    fi

    mem_used=$((mem_total_value - mem_avl_value))
    mem_used_percent=$((mem_used * 100 / mem_total_value)) || exit 1

    echo "[Total memory usage] ${mem_used_percent}%"
    echo "Total: ${mem_total_value} kB | $((mem_total_value / 1048576)) GB"
    echo "Free:  ${mem_free_value} kB | $((mem_free_value / 1048576)) GB"
    echo "Used:  ${mem_used} kB | $((mem_used / 1048576)) GB"
    echo ""

    # Total disk usage (Free vs Used including percentage)

    mapfile -t devices < <(lsblk -n -o NAME)

    echo "[Total disk usage]"
    for device in "${devices[@]}"; do
        read -r fstype size avail pcent <<< "$(df --output=fstype,size,avail,pcent /dev/${device} 2>/dev/null | awk 'NR==2')" 
        echo -e "/dev/${device} | ${fstype} | ${pcent} \nfree: $((avail / 1048576)) GB \nused: $(((size - avail) / 1048576)) GB \n"
    done

    # Top 5 processes by CPU usage

    echo "[Top 5 processes by CPU usage]"
    ps --sort=-%cpu | head -n 6 | column -t
    echo ""

    # Top 5 processes by memory usage

    echo "[Top 5 processes by memory usage]"
    ps --sort=-%mem | head -n 6 | column -t
    echo ""

    sleep $refresh

done
