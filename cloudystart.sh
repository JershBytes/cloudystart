#!/usr/bin/env bash
# Author Joshua Ross
# Purpose: CloudyStart a quick and easy cloudinit VM creation tool.
# Created on 06-01-2024

# Function for colors.
print_green() {
    echo -e "\e[32m$1\e[0m"
}

print_red() {
    echo -e "\e[31m$1\e[0m"
}


# Function to calculate gateway based on CIDR notation
calculate_gateway() {
    local ip=$1
    local cidr=$2

    gateway=$(echo "$ip" | awk -F'.' '{print $1"."$2"."$3".1"}')
    echo "$gateway"
}

# Set up Location Variables
TMP=$(mktemp -d)
LOG_FILE="/var/log/CloudyStart.txt"
IMAGE_DIR="$TMP" # Set to where you want the images to temporarily be downloaded. 
VM_STO="" # Set to the storage used for VMs

# Commands
exec > >(tee -a ${LOG_FILE})
exec 2> >(tee -a ${LOG_FILE} >&2)

# Function to handle exit on cancel or escape
handle_cancel() {
    local exit_status=$?
    if [ $exit_status -ne 0 ]; then
        print_red "User cancelled. Exiting..."
        exit 1
    fi
}

# Read parameters interactively using whiptail
VM_ID=$(whiptail --inputbox "Enter VM ID:" 8 39 --title "CloudyStart" 3>&1 1>&2 2>&3)
handle_cancel

VM_NAME=$(whiptail --inputbox "Enter VM Name:" 8 39 --title "CloudyStart" 3>&1 1>&2 2>&3)
handle_cancel

SOCKETS=$(whiptail --inputbox "Enter # of Sockets:" 8 39 --title "CloudyStart" 3>&1 1>&2 2>&3)
handle_cancel

CORES=$(whiptail --inputbox "Enter # of Cores:" 8 39 --title "CloudyStart" 3>&1 1>&2 2>&3)
handle_cancel

MEMORY=$(whiptail --inputbox "Enter Memory (MB):" 8 39 --title "CloudyStart" 3>&1 1>&2 2>&3)
handle_cancel

VLAN=$(whiptail --inputbox "Enter vLAN:" 8 39 --title "CloudyStart" 3>&1 1>&2 2>&3)
handle_cancel

IP=$(whiptail --inputbox "Enter the IP:" 8 39 --title "CloudyStart" 3>&1 1>&2 2>&3)
handle_cancel

CIDR=""

# Calculate gateway
GATEWAY=$(calculate_gateway "$IP" "$CIDR")

# Prompt user for the desired disk size in GB
TOTAL_DISK_SIZE_GB=$(whiptail --inputbox "Enter the desired disk size in GB:" 8 39 --title "CloudyStart" 3>&1 1>&2 2>&3)
handle_cancel

# Validate input
if ! [[ "$TOTAL_DISK_SIZE_GB" =~ ^[0-9]+$ ]]; then
    whiptail --msgbox "Error: Invalid input. Please enter a valid integer." 8 39 --title "CloudyStart"
    exit 1
fi

# Define image URLs for different distributions
declare -A IMAGE_URLS
IMAGE_URLS[1]="https://dl.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud.latest.x86_64.qcow2"
IMAGE_URLS[2]="https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2"
IMAGE_URLS[3]="https://download.fedoraproject.org/pub/fedora/linux/releases/40/Cloud/x86_64/images/Fedora-Cloud-Base-Generic.x86_64-40-1.14.qcow2"
IMAGE_URLS[4]="https://cloud.centos.org/centos/9-stream/x86_64/images/CentOS-Stream-GenericCloud-9-latest.x86_64.qcow2"
IMAGE_URLS[5]="https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
IMAGE_URLS[6]="https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
IMAGE_URLS[7]="https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img"

# Function to download the image for the selected distribution
download_distribution_image() {
    print_green "Downloading $DISTRIBUTION image from $IMAGE_URL..."
    wget -q --show-progress -O "$IMAGE_DIR/${DISTRIBUTION}.img" "$IMAGE_URL" || { print_red "Failed to download $DISTRIBUTION image from $IMAGE_URL"; exit 1; }
}

# Display distribution options
CHOICE=$(whiptail --title "CloudyStart" --menu "Select distribution:" 16 78 10 \
"1" "Rocky 9" \
"2" "Alma 9" \
"3" "Fedora 40" \
"4" "CentOS-Stream 9" \
"5" "Debian 12" \
"6" "Ubuntu 24.04" \
"7" "Ubuntu 22.04" 3>&1 1>&2 2>&3)
handle_cancel

# Check if the choice is valid
if [[ ! "${IMAGE_URLS[$CHOICE]+isset}" ]]; then
    whiptail --msgbox "Invalid choice. Exiting." 8 39 --title "CloudyStart"
    exit 1
fi

# Get the selected distribution and its image URL
DISTRIBUTION=""
IMAGE_URL=""
case $CHOICE in
    1) DISTRIBUTION="rocky 9.3";;
    2) DISTRIBUTION="alma 9.3";;
    3) DISTRIBUTION="fedora 40";;
    4) DISTRIBUTION="centos stream";;
    5) DISTRIBUTION="debian 12";;
    6) DISTRIBUTION="ubuntu 24.04";;
    7) DISTRIBUTION="ubuntu 22.04";;
    *) whiptail --msgbox "Invalid choice" 8 39 --title "CloudyStart"; exit 1;;
esac

# Retrieve the corresponding IMAGE_URL from the IMAGE_URLS array
IMAGE_URL="${IMAGE_URLS[$CHOICE]}"

# Download the image for the selected distribution
download_distribution_image

# Function to remove VM
remove_vm() {
    print_red "Removing VM $VM_ID"
    qm destroy $VM_ID
}

# Trap function to handle errors
handle_error() {
    local exit_code=$?
    print_red "Error occurred during VM setup. Cleaning up..."
    remove_vm
    exit $exit_code
}

# Set trap to call handle_error function on ERR or EXIT
trap 'handle_error' ERR EXIT

# Create a new virtual machine
print_green "Creating a new virtual machine..."
qm create $VM_ID --memory $MEMORY --cores $CORES --name $VM_NAME --net0 virtio,bridge=vmbr0,tag=$VLAN --scsihw virtio-scsi-pci --machine q35 --cpu host  || { print_red "Failed to create VM."; exit 1; }

# Set disk parameters and import from the base image
print_green "Setting disk parameters and importing from the base image..."
qm set $VM_ID --scsi0 $VM_STO:0,discard=on,ssd=1,format=raw,import-from="$IMAGE_DIR/${DISTRIBUTION}.img" || { print_red "Failed to set disk parameters or import base image."; exit 1; }

# Resize the disk within the VM to the desired size
print_green "Resizing disk within the VM to ${TOTAL_DISK_SIZE_GB}GB..."
qm disk resize $VM_ID scsi0 ${TOTAL_DISK_SIZE_GB}G || { print_red "Failed to resize disk in VM configuration."; exit 1; }

# Configuring BIOS and EFI
print_green "Configuring BIOS and EFI..."
qm set $VM_ID --bios ovmf --efidisk0 $VM_STO:1,format=raw,efitype=4m,pre-enrolled-keys=1 || { print_red "Failed to configure BIOS and EFI"; exit 1; }

# Add cloud-init drive
print_green "Adding cloud-init drive with configuration..."
qm set $VM_ID --ide2 $VM_STO:cloudinit,media=cdrom  || { print_red "Failed to add cloud-init drive."; exit 1; }
qm set $VM_ID --ipconfig0 ip=$IP/$CIDR,gw=$GATEWAY

# Make the cloud-init drive bootable and restrict BIOS to boot from disk only
print_green "Configuring boot options..."
qm set $VM_ID --boot c --bootdisk scsi0 || { print_red "Failed to configure boot options."; exit 1; }

# Enabling QEMU Guest Agent
print_green "Enabling QEMU Guest Agent..."
qm set $VM_ID  --agent enabled=1 || { print_red "Failed to add QEMU Guest Agent."; exit 1; }

# Disable trap for successful execution
trap - ERR EXIT

# Yay You win! Time to cleanup.
print_green "Setup completed successfully, cleaning log and removing image..."
rm -rf "$IMAGE_DIR"
> log.txt

