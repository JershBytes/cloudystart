<div align="center" id="top"> 
  <img src="./.github/assets/github-header-image.png" alt="Cloudystart" />

  &#xa0;

  <!-- <a href="https://cloudystart.netlify.app">Demo</a> -->
</div>

<h1 align="center">Cloudystart</h1>

<p align="center">
  <img alt="Github top language" src="https://img.shields.io/github/languages/top/{{YOUR_GITHUB_USERNAME}}/cloudystart?color=56BEB8">

  <img alt="Github language count" src="https://img.shields.io/github/languages/count/{{YOUR_GITHUB_USERNAME}}/cloudystart?color=56BEB8">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/{{YOUR_GITHUB_USERNAME}}/cloudystart?color=56BEB8">

  <img alt="License" src="https://img.shields.io/github/license/{{YOUR_GITHUB_USERNAME}}/cloudystart?color=56BEB8">

  <!-- <img alt="Github issues" src="https://img.shields.io/github/issues/{{YOUR_GITHUB_USERNAME}}/cloudystart?color=56BEB8" /> -->

  <!-- <img alt="Github forks" src="https://img.shields.io/github/forks/{{YOUR_GITHUB_USERNAME}}/cloudystart?color=56BEB8" /> -->

  <!-- <img alt="Github stars" src="https://img.shields.io/github/stars/{{YOUR_GITHUB_USERNAME}}/cloudystart?color=56BEB8" /> -->
</p>

<!-- Status -->

<!-- <h4 align="center"> 
	🚧  Cloudystart 🚀 Under construction...  🚧
</h4> 

<hr> -->

<p align="center">
  <a href="#dart-about">About</a> &#xa0; | &#xa0; 
  <a href="#sparkles-features">Features</a> &#xa0; | &#xa0;
  <a href="#rocket-technologies">Technologies</a> &#xa0; | &#xa0;
  <a href="#white_check_mark-requirements">Requirements</a> &#xa0; | &#xa0;
  <a href="#checkered_flag-starting">Starting</a> &#xa0; | &#xa0;
  <a href="#memo-license">License</a> &#xa0; | &#xa0;
  <a href="https://github.com/{{YOUR_GITHUB_USERNAME}}" target="_blank">Author</a>
</p>

<br>

## :dart: About ##

I've used Proxmox for years and when I came back last year I found out about Cloud-init templates and was blown away by how easy it was. I had one issue though any time I wanted to change the specs of the VM I always needed to clone the Template and then modify the specs. A Little tedious for me So I need an idea.

## :heavy_check_mark: Solution

**CloudyStart**, is my Solution. As I started getting more into scripting. I worked on this as a side project as I still work a full-time job as an IT Analyst. The cool thing about this script is it still uses cloud-init at its core but it lets you spec down the VM on all sides. Minus Advanced cloud-init configs. Still a WIP but this has done wonders in automating my workflow within Proxmox.

## :sparkles: Features ##

:heavy_check_mark: Uses whiptail for easy navigation;\
:heavy_check_mark: Removes remintes after so always getting a fresh iamge 2;\
:heavy_check_mark: FOSS;

## :rocket: Technologies ##

The following tools were used in this project:

- [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
- [Proxmox](https://www.proxmox.com/en/)
- [Linux](https://en.wikipedia.org/wiki/Bash_(Unix_shell))

## :white_check_mark: Requirements ##

Before starting :checkered_flag:, you need to have [Git](https://git-scm.com) and [Curl](https://github.com/curl/curl) installed.

## :checkered_flag: Starting ##

```bash
# Clone this project
$ git clone https://github.com/{{YOUR_GITHUB_USERNAME}}/cloudystart /opt/cloudystart

# Link to **/usr/local/bin**
$ ln -s /opt/cloudystart/cloudystart.sh /usr/local/bin/cloudystart

# Change the Variables mentioned in the Caution Tag, Then run the script
$ cloudystart
```

> [!CAUTION]
> For this script to run properly, two variables need to be changed on your end.<br>
> -  **Change these before running the script.**

```bash
VM_STO="" # Set to the storage used for VMs
CIDR="23 # Change to your CIDR notation.
```

## :memo: License ##

This project is under license from MIT. For more details, see the [LICENSE](LICENSE.md) file.


Made with :heart: by <a href="https://github.com/{{YOUR_GITHUB_USERNAME}}" target="_blank">{{YOUR_NAME}}</a>

&#xa0;

<a href="#top">Back to top</a>
