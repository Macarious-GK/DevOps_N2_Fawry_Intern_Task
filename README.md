# DevOps_N2_Fawry_Intern_Task
These are tasks completed as part of the Fawry Internship Selection Process.  
They demonstrate my Bash scripting & problem solving skills, as well as troubleshooting and investigation techniques.

# Table of Contents
1. [Repository Overview](#repository-overview)
2. [Task 1: Bash Script (mygrep.sh)](#task-1-bash-script-mygrepsh)
3. [Task 2: DNS Troubleshooting](#task-2-dns-troubleshooting)

## Repository Overview
This repository includes two main tasks:

- **Task 1**: Creating a custom Bash script called `mygrep.sh`
    - **Description**:  
      A mini version of the `grep` command that includes basic functionality, error handling, and flag support.
    - View the task [here](./Task1_Bash-Script-mygrep).

- **Task 2**: DNS Troubleshooting and Analysis
    - **Description**:  
      A troubleshooting scenario addressing common `host not found` errors.  
      It outlines best practice steps for investigating and troubleshooting DNS-related issues.
    - View the task [here](./Task2_DNS-Troubleshooting).

## Task 1: Bash Script (mygrep.sh)

A quick overview of the `mygrep.sh` Bash script:

- Core functionality
    - Search for a string (case-insensitive)
    - Print matching lines from a text file
    - Mimic `grep`'s behavior as closely as possible
    - 🔹 Flag options:
        - `-n` → Show line numbers for each match
        - `-v` → Invert the match (print lines that do not match)

- Optimization and error handling
    - This script uses an optimized approach to perform its functions and covers corner cases with error handling (e.g., missing search string, missing file, invalid flags).

- Automated testing
    - A script was created to test most of the scenarios for using this tool, automating the testing process when upgrading or modifying the code.
    
## Task 2: DNS Troubleshooting
Detailed steps and solutions related to DNS troubleshooting and root cause analysis.


1.  Verify DNS Resolution:
    - Compare resolution from /etc/resolv.conf DNS vs. 8.8.8.8.
2.  Diagnose Service Reachability:
    - Confirm whether the web service (port 80 or 443) is reachable on the resolved IP.
Use curl, telnet, netstat, or ss to find if the service is listening and responding.
3.  Trace the Issue – List All Possible Causes
    -  Your goal here is to identify and list all potential reasons why internal.example.com might be unreachable, even if the service is up and running. Consider both DNS and network/service layers.
