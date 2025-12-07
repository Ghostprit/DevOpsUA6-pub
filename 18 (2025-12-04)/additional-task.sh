#!/bin/bash

keyLocation=$1
isNamed=""
vmname=""
userInputNumberOfVMs="0"

# Error handling
if [ -z "$keyLocation" ]; then
    echo "Error: SSH key location not provided."
    echo "Usage: $0 <path-to-ssh-key>"
    exit 1
fi
if [ ! -f "$keyLocation" ]; then
    echo "Error: SSH key file not found at the specified location: $keyLocation"
    exit 1
fi

az login --use-device-code

read -p "Would you like to delete existing resource group 'additional-task-group', if you ran this script before? This will end the script. (Y/N): " deleteExistingRG

if [ "$deleteExistingRG" != "Y" ] && [ "$deleteExistingRG" != "y" ] && [ "$deleteExistingRG" != "N" ] && [ "$deleteExistingRG" != "n" ]; then
    echo "Error: Invalid input for deleting resource group. Please enter Y or N."
    exit 1
fi

if [ "$deleteExistingRG" == "Y" ] || [ "$deleteExistingRG" == "y" ]; then
    az group delete --name additional-task-group
    exit 0
else
    az group create --name additional-task-group --location switzerlandnorth
    az network vnet create --name additional-task-VN --resource-group additional-task-group
    az network vnet subnet create --resource-group additional-task-group --vnet-name additional-task-VN --name additional-task-VN-subnet --address-prefixes 10.0.1.0/24
    read -p "How many VM would you like to create? (Max. 3): " userInputNumberOfVMs
    read -p "Do you want to name your virtual machines? (Y/N): " isNamed

    if [ "$userInputNumberOfVMs" -gt 3 ] || [ "$userInputNumberOfVMs" -le 0 ]; then
        echo "Error: You can create between 1 to 3 VMs."
        exit 1
    fi
    if [ "$isNamed" != "Y" ] && [ "$isNamed" != "y" ] && [ "$isNamed" != "N" ] && [ "$isNamed" != "n" ]; then
        echo "Error: Invalid input for naming VMs. Please enter Y or N."
        exit 1
    fi

    if [ "$isNamed" != "Y" ] && [ "$isNamed" != "y" ]; then
        for i in $(seq 1 $userInputNumberOfVMs); do
            az vm create --resource-group additional-task-group --name additional-task-VM-$i --image Ubuntu2404 --vnet-name additional-task-VN --subnet additional-task-VN-subnet --ssh-key-values "$keyLocation" --size Standard_B2ats_v2
        done
    else
        for i in $(seq 1 $userInputNumberOfVMs); do
            read -p "Enter the name of VM nr. $i: " vmname
            az vm create --resource-group additional-task-group --name $vmname --image Ubuntu2404 --vnet-name additional-task-VN --subnet additional-task-VN-subnet --ssh-key-values "$keyLocation" --size Standard_B2ats_v2
        done
    fi
fi
