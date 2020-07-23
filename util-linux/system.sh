#!/bin/bash

# 将硬件时间设置为系统的UTC时间
hwclock -s -u

# 启用 ntp 服务，获取网络时间并设置为当前系统时间
timedatectl set-ntp true

# 生成时间偏差（/etc/adjtime）
hwclock -w
