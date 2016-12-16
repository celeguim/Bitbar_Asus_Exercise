#
# Cookbook Name:: bitbar
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'open3'

package 'android-tools-adb' do
  action :install
end

file '/root/readtemperature.sh' do
  content "#!/bin/bash 
export CMD='/usr/bin/adb shell dumpsys battery'
${CMD} 2>out2 1>out1
while read line; do
  if [[ $line == *'temperature'* ]]
  then
    values=$(echo $line | tr ':' '\\n')
    for value in $values
    do 
      if [[ \"$value\" != \"temperature\" ]]
      then
        echo $value
	TEMP=$(echo $value|grep -o '[0-9]*')
	TEMP1=$(echo \"scale=2; ${TEMP} / 10\" | bc)
	echo ${TEMP1}
        cat <<EOF | curl --data-binary @- http://chef-workstation:9091/metrics/job/asus_metrics/instance/`hostname`
          # TYPE asus_metrics counter
          asus_metrics{label=\"temperature\"} ${TEMP1}
EOF
      fi
    done
  fi
done < out1 "
  mode "0755" 
end

# Crontab collector every 1 minute
cron 'cron_readtemperature' do
  command '/root/readtemperature.sh >/tmp/readtemperature.log'
end

