![Header](assets/github-header-image.png)

# :link: Table of Contents

- [:x: Problem](#x-problem)
- [:heavy\_check\_mark: Solution](#heavy_check_mark-solution)
- [:gear: Instructions](#gear-instructions)
- [:memo: Notes](#memo-notes)
- [:balance\_scale: **LICENSE**](#balance_scale-license)


## :x: Problem

I've used Proxmox for years and when I came back last year I found out about Cloud-init templates and was blown away by how easy it was. I had one issue though any time I wanted to change the specs of the VM I always needed to clone the Template and then modify the specs. A Little tedious for me So I need an idea. 

## :heavy_check_mark: Solution

**CloudyStart**, is my Solution. As I started getting more into scripting. I worked on this as a side project as I still work a full-time job as an IT Analyst. The cool thing about this script is it still uses cloud-init at its core but it lets you spec down the VM on all sides. Minus Advanced cloud-init configs. Still a WIP but this has done wonders in automating my workflow within Proxmox.

## :gear: Instructions

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

## :memo: Notes
For this script, two variables need to be changed on your end.
    
- :warning: **Change these before running the script.**

```
 VM_STO="" # Set to the storage used for VMs
 CIDR="23 # Should be changed to whatever the CIDR notation is used on your end. 
```
I've added a secondary verison of this script using [`whiptail`](CloudyStart-whiptail.sh).

- This is a more interactive version if that's something you like.
    -  Same Changes are required as stated in the notes as well!

## :balance_scale: **LICENSE**

```
MIT License

Copyright (c) 2024 Joshua Ross

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

