# AAEON NXP Manifest README
- This repo is dedicated to the NXP IMX-based modules. Here you can find the Yocto BSP recipes for AAEON.
- You can follow the same steps to build your own customized BSP based on your interests.
- For example, for i.MX Linux BSP releases based on Yocto Project `Kirkstone`, the branch is `kirkstone`
## Install the `repo` utility:
- To use this manifest repo, the `repo` tool must be installed first.
```bash
mkdir ~/bin
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo  > ~/bin/repo
chmod a+x ~/bin/repo
PATH=${PATH}:~/bin
```
## Install essential host packages
- Your Build Host must install required packages for the Yocto build. Reference to the section "Build Host Packages" in the document "Yocto Project Quick build".
    - [Build-Host-Packages](https://docs.yoctoproject.org/5.0.3/brief-yoctoprojectqs/index.html#build-host-packages)

## Download the Yocto Project BSP
```plaintext
mkdir <release> && cd <release>
repo init -u https://github.com/BSP-Dev/aaeon-manifest.git -b <branch name> [ -m <release manifest>]
repo sync
```
- Each branch has detailed READMEs describing exact syntax.

- Please see the corresponding sections below for details.

### Support Devices

| Machine  | DDR  |
| -------- | ---- |
| SRG-IMX8P| 2G/4G|
<!--|SRG-IMX8PL| 2G/4G|-->

### Build SRG-IMX8P BSP
- (1)	Download Yocto BSP with kernel 5.15.71
    ```bash!
    $ mkdir imx-yocto-bsp
    $ cd imx-yocto-bsp
    $ repo init -u https://github.com/BSP-Dev/aaeon-manifest.git -b kirkstone -m aaeon-kirkstone-v01.xml
    $ repo sync
    ```
- (2)	Environment setup
    ```bash!
    # SRG-IMX8P (4G DDR)
    $ DISTRO=fsl-imx-wayland MACHINE=srg-imx8p-4g source aaeon-imx-setup-release.sh -b imx8p_build
    ```
<!--
    # SRG-IMX8PL (4G DDR)
    $ DISTRO=fsl-imx-wayland MACHINE=srg-imx8pl-4g source aaeon-imx-setup-release.sh -b imx8pl_build
-->
- (3)	Build NXP IMX BSP
    ```bash!
    $ bitbake imx-image-full

    # For quick test
    $ bitbake core-image-minimal
    ```
- Note: (1)	If FetchError,then change git branch=master => branch=main