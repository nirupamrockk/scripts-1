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
    rm -r prebuilts/clang
    git clone https://github.com/PixelExperience/prebuilts_clang_host_linux-x86.git prebuilts/clang/host/linux-x86    
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-16.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_kernel_xiaomi_whyred.git --depth=1 -b pie-whyred kernel/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/android_device_xiaomi_whyred.git -b lineage-16.0 device/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_xiaomi_whyred.git -b pie vendor/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_MiuiCamera.git -b pie vendor/MiuiCamera
} 

ONUI_PENDRO-SOURCE()
{
    mkdir onui
    cd onui
    echo -ne '\n' | repo init -u https://github.com/onui-pendro-1-5/onui_pendro_manifest.git -b pie --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -r packages/resources/devicesettings   
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-16.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_kernel_xiaomi_whyred.git --depth=1 -b pie-whyred kernel/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/android_device_xiaomi_whyred.git -b onui-pie device/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_xiaomi_whyred.git -b pie vendor/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_MiuiCamera.git -b pie vendor/MiuiCamera
} 

PE-SOURCE()
{
    mkdir pe
    cd pe
    echo -ne '\n' | repo init -u https://github.com/PixelExperience/manifest -b pie --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -r packages/resources/devicesettings
    rm -r prebuilts/clang
    rm -r packages/apps/Settings
    rm -r packages/apps/Updates    
    rm -r vendor/aosp    
    git clone https://github.com/PixelExperience/prebuilts_clang_host_linux-x86.git prebuilts/clang/host/linux-x86    
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-16.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_kernel_xiaomi_whyred.git --depth=1 -b pie-whyred kernel/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/android_device_xiaomi_whyred.git -b pie-whyred device/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_xiaomi_whyred.git -b pie vendor/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_MiuiCamera.git -b pie vendor/MiuiCamera
    git clone https://github.com/RaghuVarma331/android_packages_apps_Settings.git -b pie --depth=1 packages/apps/Settings
    git clone https://github.com/RaghuVarma331/android_packages_apps_Updater.git -b pie packages/apps/Updater
    git clone https://github.com/RaghuVarma331/vendor_aosp.git -b pie --depth=1  vendor/aosp    
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

BUILD_LineageOS()
{	
        . build/envsetup.sh && lunch lineage_whyred-userdebug && make -j32 bacon
 	cd out/target/product/whyred
        rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
        cd ..
	cp -r whyred /var/lib/jenkins/workspace/Xiaomi
	cd 
	cd /var/lib/jenkins/workspace/Xiaomi
	mv whyred lineage
	rm -r los	
}

BUILD_pixelexperiance()
{	
        . build/envsetup.sh && lunch aosp_whyred-userdebug && make -j32 bacon
 	cd out/target/product/whyred
        rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
        cd ..
	cp -r whyred /var/lib/jenkins/workspace/Xiaomi
	cd 
	cd /var/lib/jenkins/workspace/Xiaomi
	mv whyred pixel
	rm -r pe		
}

BUILD_onuipendro()
{	
        . build/envsetup.sh && lunch aosp_whyred-userdebug && make -j32 bacon
 	cd out/target/product/whyred
        rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
        cd ..
	cp -r whyred /var/lib/jenkins/workspace/Xiaomi
	cd 
	cd /var/lib/jenkins/workspace/Xiaomi
	mv whyred pendro
	rm -r onui
}

# Main Menu
clear
echo "----------------------------------------------------------------------------------------"
echo "Welcome To Whyred Redmi note5 pro Remote Script Made By Raghu Varma"
echo "Coded By Raghu Varma.G #Developer"
echo "----------------------------------------------------------------------------------------"
PS3='Please select your option (1-5): '
menuvar=("BasicSetup" "LineageOS"  "PixelExperience" "OnUI-Pendro" "all_roms" "Exit")
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
            echo "@whyred 2019 Settingup Basic Stuff For pc finished."
            echo "Happy Building ROMS."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;   
        "LineageOS")
            clear
            echo "----------------------------------------------"
            echo "Started Building LineageOS-16.0 For whyred  ."
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
            echo "whyred 2019 LineageOS build finished."
            echo "Flashable zip is located into /root."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "OnUI-Pendro")
            clear
            echo "----------------------------------------------"
            echo "Started Building OnUI-Pendro For whyred  ."
            echo "Please be patient..."
            # OnUI-Pendro
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up Environment & source..."
            echo " "
            ONUI_PENDRO-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Cleaning up source..."
            echo " "
            CLEAN_SOURCE            
	    echo " "
            echo "----------------------------------------------"
            echo "Compilation Started..."
            echo " "
            BUILD_onuipendro
            echo " "
            echo "----------------------------------------------"
            echo "OnUI-Pendro Rom build finished."
            echo " "
            echo "----------------------------------------------"
            echo "whyred 2019 OnUI-Pendro build finished."
            echo "Flashable zip is located into /root."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;	   	    
        "PixelExperience")
            clear
            echo "----------------------------------------------"
            echo "Started Building PixelExperience For whyred  ."
            echo "Please be patient..."
            # PixelExperience
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
            echo "PixelExperience Rom build finished."
            echo " "
            echo "----------------------------------------------"
            echo "whyred 2019 PixelExperience build finished."
            echo "Flashable zip is located into /root."
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;	    
	"all_roms")
            clear
            echo "----------------------------------------------"
            echo "Started Building All Roms For whyred  ."
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
            echo "whyred 2019 All 4 roms compilation completed."
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
