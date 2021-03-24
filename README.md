# Afterimage

Afterimage v1.0 is a Powershell script used to quickly set up Windows computers for businesses. 

## Features include:
- Set Static IP Addresses
- Download Files From the Internet
- Add New Local User Account

## Usage: 
1. Run Powershell as an Administrator
2. Navigate to location of afterimage download `cd ..\location\of\download\`
3. To run script type: `.\afterimage.ps1`

## Change/Add Downloads:
In order to change what will be downloaded you must first find the link to download and copy the address. Once you have copied the address you must change the `Invoke-WebRequest -uri "your new download address"` Do not forget to also change the `-Outfile` name so when you run the script it also automaticlly executes the program for you. 

## Purpose:
At the company I am currently working at, once a computer gets reimaged it needs a new local user account and static IP. Some master images do not have all the downloads that it needs; web tools, Antivirus, etc. As business changes, so do the programs and installations required on each computer. So this tool was made in an attempt to cut down and save the IT department time they otherwise would have spent googling and clicking around the Control Panel/Windows Settings. 

### Disclaimer:
The default programs used in this tool have been changed to protect the confidentiality of my employers computer systems. The License key for Avast is made up and if it works please let me know as my next attempt at guessing will be the lottery numbers.  
