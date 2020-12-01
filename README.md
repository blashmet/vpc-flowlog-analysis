# Introduction 
 This code repository contains scripts and configuration files to implement a VPC flow log analysis solution.

# Architecture
![Architecture](./diagrams/architecture.png)

# Deployment Process
1.  Install runway
2.  In config.yml, enter the region and VPC ID to create visualization flows for.
3.  Change working directory to env\vpc_flowlog_analysis.cfn
4.  Run $env:CI=$null; runway deploy
5.  Browse to the CloudFormation console to view progress.