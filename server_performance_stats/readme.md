# Server Performance Stats

Task source: https://roadmap.sh/projects/server-stats

Goal of this project is to write a script to analyse server performance stats.

# Requirements
You are required to write a script server-stats.sh that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:
- Total CPU usage
- Total memory usage (Free vs Used including percentage)
- Total disk usage (Free vs Used including percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage

Stretch goal: Feel free to optionally add more stats such as os version, uptime, load average, logged in users, failed login attempts etc.

Once you have completed this project, you will have some basic knowledge on how to analyse server performance stats in order to debug and get a better understanding of the server's performance.

Useful sources: 
    - https://www.linuxhowtos.org/System/procstat.htm
    - https://man7.org/linux/man-pages/man5/proc.5.html
    - https://www.baeldung.com/linux/total-process-cpu-usage
    - https://blog.devgenius.io/how-does-process-monitoring-work-in-linux-a4f325f709b2
