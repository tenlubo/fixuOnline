# Introduction 
Script alfRun.sh helps manage Alfresco Docker installation. Use with git bash.

# Getting Started
There are several options of how to use alfRun.sh
- **./alfRun {up_log|up|down|purge}** docker commands to operate core alfresco services
- **./alfRun {up_log|up|down|purge} [env-file-name]** to operate alfresco instances with environment file

Examples
- to run core services used by all Alfresco instances: **./alfRun up**
- to shut down core services used by all Alfresco instances: **./alfRun down**
- to run Alfresco instance with env file *env/1.env*: **./alfRun up 1**
- to stop Alfresco instance and remove persistent data with env file *env/1.env*: **./alfRun purge 1**

# Build and Test
Project contains no build process of Alfresco Docker images and no tests.

# Contribute
Please send any comments by email
- [lubomir.sladok@bsp.sk](mailto:lubomir.sladok@bsp.sk)
