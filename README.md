![Header](assets/github-header-image.png)

1. [Purpose](#purpose)
2. [Instructions](#instructions)
3. [Slight Modifications](#slight-modifications)


## Purpose 🤔

This was created as I loved the idea of using proxmox templates, But Did not want to always go to the webUI to clone the template. So I came up with the idea of why not just write a script that lives on the server and all I need to do is ssh in run the script and then boom. We got a vm ready to rock.

## Instructions

- **Clone the repo.**
```
git clone https://github.com/ColoredBytes/CloudyStart.git
```


- **Make the script executable.**
 ```
 chmod +x CloudyStart/CloudyStart.sh
 ```

- **Run the script.**
 ```
 ./CloudyStart/CloudyStart.sh
```

## Slight Modifications

- For this script two variables need to be changed on your end.
    - **Change these before running the script.**

```
IMAGE_DIR="" # Set to where you want the images to temporarily be downloaded. 
VM_STO="" # Set to the storage used for VMs
```
