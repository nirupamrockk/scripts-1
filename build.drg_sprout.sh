#!/bin/bash
#
# RAGHU VARMA Build Script 
# Coded by RV 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

clear
# Init Methods
LINEAGE-SOURCE()
{
    mkdir los
    cd los
    echo -ne '\n' | repo init -u git://github.com/LineageOS/android.git -b lineage-16.0 --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -r packages/resources/devicesettings
    rm -r device/lineage/sepolicy
    git clone https://github.com/RaghuVarma331/android_device_lineage_sepolicy.git -b pie device/lineage/sepolicy    
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-16.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout.git -b los device/nokia/DRG_sprout
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b pie --depth=1 kernel/nokia/sdm660
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia_DRG_sprout.git -b pie --depth=1 vendor/nokia/DRG_sprout
} 
PE-SOURCE()
{
    mkdir pe
    cd pe
    echo -ne '\n' | repo init -u https://github.com/PixelExperience/manifest -b pie --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -r packages/resources/devicesettings
    rm -r device/custom/sepolicy
    rm -r packages/apps/Settings
    rm -r packages/apps/Updates    
    rm -r vendor/aosp
    git clone https://github.com/RaghuVarma331/android_device_custom_sepolicy.git -b pe-pie device/custom/sepolicy
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-16.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout.git -b pe-pie device/nokia/DRG_sprout
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b pie --depth=1 kernel/nokia/sdm660
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia_DRG_sprout.git -b pie --depth=1 vendor/nokia/DRG_sprout
    git clone https://github.com/RaghuVarma331/android_packages_apps_Settings.git -b pie --depth=1 packages/apps/Settings
    git clone https://github.com/RaghuVarma331/android_packages_apps_Updater.git -b pie packages/apps/Updater  
    git clone https://github.com/RaghuVarma331/vendor_aosp.git -b pie --depth=1  vendor/aosp
}
TWRP-P-SOURCE()
{
    mkdir DRG_sprout
    mkdir twrp
    cd twrp
    repo init -u git://github.com/omnirom/android.git -b android-9.0 --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -rf bootable/recovery
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-9.0 device/nokia/DRG_sprout    
    git clone https://github.com/RaghuVarma331/android_bootable_recovery.git -b android-9.0 bootable/recovery
    git clone https://github.com/TeamWin/external_magisk-prebuilt -b master external/magisk-prebuilt
    git clone https://github.com/TeamWin/android_external_busybox.git -b android-9.0 external/busybox
    git clone https://github.com/omnirom/android_external_toybox.git -b android-9.0 external/toybox
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    cd out/target/product/DRG_sprout
    mv recovery.img twrp-3.3.1-0-DRG_sprout.img
    cp -r twrp-3.3.1-0-DRG_sprout.img /var/lib/jenkins/workspace/Nokia/DRG_sprout
    cd
    cd /var/lib/jenkins/workspace/Nokia/twrp
    rm -r device/nokia
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-9.0-IS device/nokia/DRG_sprout    
    rm -r build/tools/buildinfo.sh
    cp -r device/nokia/DRG_sprout/buildinfo.sh /var/lib/jenkins/workspace/Nokia/twrp/build/tools
    rm -r device/nokia/DRG_sprout/buildinfo.sh
    rm -r out
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    cd out/target/product/DRG_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio /var/lib/jenkins/workspace/Nokia/twrp/device/nokia/DRG_sprout/installer
    cd
    cd /var/lib/jenkins/workspace/Nokia/twrp/device/nokia/DRG_sprout/installer
    zip -r twrp-installer-3.3.1-0-DRG_sprout.zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-DRG_sprout.zip /var/lib/jenkins/workspace/Nokia/DRG_sprout    
}
TWRP-O-SOURCE()
{
    mkdir DRG_sprout
    mkdir twrp
    cd twrp
    repo init -u git://github.com/omnirom/android.git -b android-8.1 --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -rf bootable/recovery
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-8.1 device/nokia/DRG_sprout    
    git clone https://github.com/RaghuVarma331/android_bootable_recovery.git -b android-8.1 bootable/recovery
    git clone https://github.com/omnirom/android_external_busybox.git -b android-8.1 external/busybox
    git clone https://github.com/omnirom/android_external_toybox.git -b android-8.1 external/toybox
    git clone https://github.com/TeamWin/android_device_qcom_common -b android-8.0 device/qcom/common
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    cd out/target/product/DRG_sprout
    mv recovery.img twrp-3.2.3-0-DRG_sprout.img
    cp -r twrp-3.2.3-0-DRG_sprout.img /var/lib/jenkins/workspace/Nokia/DRG_sprout
    cd
    cd /var/lib/jenkins/workspace/Nokia
    rm -r twrp
    
}

CLEAN_SOURCE()
{
	rm -r  out
}

TOOLS_SETUP()
{
        sudo apt-get update 
        echo -ne '\n' | sudo apt-get upgrade
        echo -ne '\n' | sudo apt install openjdk-8-jdk lunzip android-tools-adb bc bison build-essential ccache curl flex g++-multilib gcc-multilib git-core gnupg gperf htop imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libc6-dev libcurl4-openssl-dev libesd0-dev libgl1-mesa-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libx11-dev libxml2 libxml2-utils lzop maven ncftp nss-updatedb pngcrush python-lunch rsync schedtool screen squashfs-tools tmux unzip w3m x11proto-core-dev xsltproc yasm zip zlib1g-dev device-tree-compiler repo
        sudo swapon --show
        sudo fallocate -l 20G /swapfile
        ls -lh /swapfile
        sudo chmod 600 /swapfile
        sudo mkswap /swapfile
        sudo swapon /swapfile
        sudo swapon --show
        sudo cp /etc/fstab /etc/fstab.bak
        echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
	git config --global user.email "raghuvarma331@gmail.com"
	git config --global user.name "RaghuVarma331"
}


BUILD_pixelexperiance()
{	
        . build/envsetup.sh && lunch aosp_DRG_sprout-userdebug && make -j32 bacon
 	cd out/target/product/DRG_sprout
        rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
        cd ..
	cp -r DRG_sprout /var/lib/jenkins/workspace/Nokia
	cd 
	cd /var/lib/jenkins/workspace/Nokia
	mv DRG_sprout pixel
	rm -r pe
}	
	
BUILD_LineageOS()
{	
        . build/envsetup.sh && lunch lineage_DRG_sprout-userdebug && make -j32 bacon
	cd out/target/product/DRG_sprout
        rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
        cd ..
	cp -r DRG_sprout /var/lib/jenkins/workspace/Nokia
	cd 
	cd /var/lib/jenkins/workspace/Nokia
        mv DRG_sprout lineage
	rm -r los	
}	

# Main Menu
clear
echo "----------------------------------------------------------------------------------------"
echo "Welcome To DRG_sprout Nokia 6.1 Plus Remote Script Made By Raghu Varma"
echo "Coded By Raghu Varma.G #Developer"
echo "----------------------------------------------------------------------------------------"
PS3='Please select your option (1-5): '
menuvar=("BasicSetup" "pixelexperiance" "LineageOS" "twrp" "all_roms" "Exit")
select menuvar in "${menuvar[@]}"
do
    case $menuvar in
        "BasicSetup")
            clear
            echo "----------------------------------------------"
            echo "Started Settingup Basic Stuff For pc..."
            echo "Please be patient..."
            # BasicSetup
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Settingup Basic Stuff For pc finished."
            echo " "
            echo "----------------------------------------------"
            echo "@DRG_sprout 2019 Settingup Basic Stuff For pc finished."
            echo "Happy Building ROMS."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;; 
        "twrp")
            clear
            echo "----------------------------------------------"
            echo "Started Building TWRP-3.3.1-0 & TWRP-3.2.3-0 For DRG_sprout  ."
            echo "Please be patient..."
            # twrp
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up twrp oreo source..."
            echo " "
            TWRP-O-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Setting up twrp pie source..."
            echo " "
            TWRP-P-SOURCE
	    echo " "	    
            echo "----------------------------------------------"
            echo "TWRP-3.3.1-0 & TWRP-3.2.3-0 build finished."
            echo " "
            echo "----------------------------------------------"
            echo "DRG_sprout 2019 TWRP-3.3.1-0 & TWRP-3.2.3-0 build finished."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;	   	    
        "LineageOS")
            clear
            echo "----------------------------------------------"
            echo "Started Building LineageOS-16.0 For DRG_sprout  ."
            echo "Please be patient..."
            # LineageOS
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up Environment & source..."
            echo " "
            LINEAGE-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE            
	    echo " "
            echo "----------------------------------------------"
            echo "Compilation Started..."
            echo " "
            BUILD_LineageOS
            echo " "
            echo "----------------------------------------------"
            echo "LineageOS Rom build finished."
            echo " "
            echo "----------------------------------------------"
            echo "DRG_sprout 2019 LineageOS build finished."
            echo "Flashable zip is located into /root."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "pixelexperiance")
            clear
            echo "----------------------------------------------"
            echo "Started Building PixelExperiance-P For DRG_sprout  ."
            echo "Please be patient..."
            # pixelexperiance
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "            
	    echo "----------------------------------------------"
            echo "Setting up Environment & source..."
            echo " "
            PE-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Compilation Started..."
	    echo " "
            BUILD_pixelexperiance
            echo " "
            echo "----------------------------------------------"
            echo "pixelexperiance Rom build finished."
            echo " "
            echo "----------------------------------------------"
            echo "DRG_sprout 2019 pixelexperiance build finished."
            echo "Flashable zip is located into /root."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;; 	    
	"all_roms")
            clear
            echo "----------------------------------------------"
            echo "Started Building All Roms For DRG_sprout  ."
            echo "Please be patient..."
            # all_roms
            echo "----------------------------------------------"
            echo "Setting up PE & source..."
            echo " "
            PE-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE
            echo " "
            echo "----------------------------------------------"
            echo "Compilation Started..."
	    echo " "
            BUILD_pixelexperiance
            echo " "  
            echo "----------------------------------------------"
            echo "Setting up Lineage & source..."
            echo " "
            LINEAGE-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE            
	    echo " "
            echo "----------------------------------------------"
            echo "Compilation Started..."
            echo " "
            BUILD_LineageOS
            echo " "	    
            echo "----------------------------------------------"
            echo "all 2 completed."
            echo " "
            echo "----------------------------------------------"
            echo "DRG_sprout 2019 All 4 roms compilation completed."
            echo "Flashable zips is located /root."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;	    
        "Exit")
            break
            ;;
        *) echo Invalid option.;;
    esac
done  
