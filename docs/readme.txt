Accept Dockerization:-

Overview:
=========
	This tool automates all the steps required to install and run Oracle Database and Accept in the Linux environment, using docker.
	This document specifies the steps required for Accept Startup using docker.

Prerequesites:
==============
1. Install Docker for windows from https://docs.docker.com/docker-for-windows/
	Note : a. Download [Get Docker for Windows (stable)] and install
           b. Please say yes when installer asks for enabling Hyper-V
2. Copy the latest Accept installer zip to the current machine 
	and note down the absolute path of the file in this machine.

Terminologies used:
===================
DOCKER_HOME : The location where this tool(acceptdocker.zip) is extracted.

Automated Steps:
================
1. Preparing Oracle setup for Accept and importing the sample data.
2. Installing JDK 1.8.0_u111.
3. Installing Accept using the provided Accept installer path.
4. Config values updates using server.dtd
5. Copying the latest license file
6. Replaced tokens in startaccept.sh and server.xml file changes.
7. Creating database and accept images
8. Creating and starting database and accept containers with starting their respective servers.
	
Steps for Starting Accept in docker for Build Team
==================================================
1. Extract acceptdocker.zip to any directory and call it as DOCKER_HOME.
2. Open a command prompt and change directory to DOCKER_HOME\bin.
3. Execute buildacceptdocker.cmd with arguments <AcceptBuildZip> <AcceptImageName>
	AcceptBuildZip - Absolute path of the Accept installer zip file in this machine.
	AcceptImageName - Name of the image to be created after the configuration.
					- Name should not have capital letters and space, 
					- Special charaters like underscore(_) and hypen(-) are recommended.	
	Eg: buildacceptdocker c:\temp\2016.4_11252016_45335.zip accept_2016q4_45335
    Note : This command will take few minutes to download required base images, configure and start Accept.
4. Once the server is started, user can see the Accept login page from the host machine with the url : http://localhost:9001	
   then can proceed with the next steps.
5. To see the Accept Shell :  
	Open command prompt in DOCKER_HOME\bin and execute acceptshell.cmd
6. To commit and push the image to the hub:
	Open command prompt in DOCKER_HOME\bin and execute commitacceptbuildimg.cmd with argument <AcceptImageName>
	AcceptImageName - is the name of the image to be pushed to the hub.
	Eg: commitacceptbuildimg accept_2016q4_45335
7. After pushing the image will create two repositories in the docker hub as "acceptdockerrep\<AcceptImageName>" and "acceptdockerrep\accept-latest-img"
	Eg: acceptdockerrep\accept_2016q4_45335


Steps for Starting Accept in docker for Dev and QA Team
=======================================================
	1. Extract acceptdocker.zip to any directory and call it as DOCKER_HOME
	2. Open a command prompt and change directory to DOCKER_HOME\bin.
	3. Execute runacceptdocker.cmd with arguments <AcceptImageName>
		AcceptImageName - Name of the image to be downloaded for execution.
		Eg: runacceptdocker accept_2016q4_45335
	    Note :  If the image name is not provided it will download the default image with name accept-latest-img
	4. After the server startup, user can see the Accept login page from the host machine with the url : http://localhost:9001
	
Note : To regain the CPU space - 
	   Right click Whale symbol[docker symbol] in system tray and goto settings > Reset > Reset to factory defaults
	   This will reset the docker and regain the CPU space.
	   