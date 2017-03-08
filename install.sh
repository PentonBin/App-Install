#! /bin/bash

read -p "Enter you sudo password: " -s PASSWORD

#######################################################################
# Path
#######################################################################
CURRENT_PATH="$(pwd)"
cd ~
HOME_PATH="$(pwd)"
HOSTS_PATH="$CURRENT_PATH/hosts"
TAR_GZ_PATH="$CURRENT_PATH/tars"
DEB_PATH="$CURRENT_PATH/debs"
LOG_PATH="$CURRENT_PATH/logs"
SCRIPT_PATH="$CURRENT_PATH/scripts"

# APP
JAVA_PATH="$HOME_PATH/JDK"
ANDROID_PATH="$HOME_PATH/Android"
HEXO_PATH="$HOME_PATH/Hexo"
IDEA_PATH="$HOME_PATH/Idea"
PYCHARM_PATH="$HOME_PATH/Pycharm"
WECHAT_PATH="$HOME_PATH/Wechat"
INODE_PATH="$HOME_PATH/iNode"


#######################################################################
# Declare some common method
#######################################################################
function error()
{
  echo "[ERROR]: $1"
  echo "$1">>$LOG_PATH/install-log
}


#######################################################################
# Check or make the folder
#######################################################################
cd $CURRENT_PATH
if [ ! -x $LOG_PATH ]; then
  mkdir $LOG_PATH
fi  

if [ ! -x $DEB_PATH ]; then
  error 'Cannot install without deb packages'
  exit 1
fi

if [ ! -x "$JAVA_PATH" ]; then
  mkdir $JAVA_PATH
fi

if [ ! -x "$ANDROID_PATH" ]; then
  mkdir $ANDROID_PATH
fi

if [ ! -x "$IDEA_PATH" ]; then
  mkdir $IDEA_PATH
fi

if [ ! -x "$PYCHARM_PATH" ]; then
  mkdir $PYCHARM_PATH
fi

if [ ! -x "$WECHAT_PATH" ]; then
  mkdir $WECHAT_PATH
fi

if [ ! -x "$INODE_PATH" ]; then
  mkdir $INODE_PATH
fi

touch $LOG_PATH/install-log
# exec 2>$LOG_PATH/install-log


#######################################################################
# Update and Upgrade
#######################################################################
echo "$PASSWORD" | sudo -S apt-get update
echo "$PASSWORD" | sudo -S apt-get upgrade -y


#######################################################################
# Install personal app
#######################################################################
# Wiznote
echo -ne '\n' | sudo add-apt-repository ppa:wiznote-team
# Docky
echo -ne '\n' | sudo add-apt-repository ppa:ricotz/docky
# Ultra-flat-icons
echo -ne '\n' | sudo add-apt-repository ppa:noobslab/icons
# Codeblocks
echo -ne '\n' | sudo add-apt-repository ppa:damien-moore/codeblocks-stable
# Indicator-sysmonitor
echo -ne '\n' | sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor
echo "$PASSWORD" | sudo -S apt-get update
echo "$PASSWORD" | sudo -S apt-get install wiznote docky ultra-flat-icons ultra-flat-icons-orange ultra-flat-icons-green codeblocks indicator-sysmonitor -y

# VLC, Unity Tweak Tool, GIMP, Shutter
echo "$PASSWORD" | sudo -S apt-get install vlc unity-tweak-tool gimp gimp-gap gimp-helpbrowser gimp-help-common shutter -y

# Wine: TrueType core fonts for the web eula, eula license terms

# Vim, SSH, Git, Unzip
echo "$PASSWORD" | sudo -S apt-get install vim openssh-client openssh-server git unzip -y

# Config Git
git config --global user.name "pentonbin"
git config --global user.email "pentonbin@gmail.com"

# Install deb packages
cd $DEB_PATH
# Dpkg install
echo "$PASSWORD" | sudo -S dpkg -i *.deb
# Install dependency
echo "$PASSWORD" | sudo -S apt-get -f install -y

#######################################################################
# copy the script
#######################################################################
chmod a+x $SCRIPT_PATH/*
echo "$PASSWORD" | sudo cp $SCRIPT_PATH/* /usr/bin/


#######################################################################
# unzip and install app
#######################################################################
# Java
cd $TAR_GZ_PATH

# Get package name
jdk_pkg=$(ls -l | grep -i jdk | awk '{ print $9 }')
# File exist
if [ ! -z "$jdk_pkg" ]; then
  # Copy and unzip
  cp $jdk_pkg $JAVA_PATH
  cd $JAVA_PATH
  if [ "${jdk_pkg##*.}" = "zip" ]; then
    unzip $jdk_pkg
  elif [ "${jdk_pkg##*.}" = "gz" ]; then
    tar zxvf $jdk_pkg
  fi
  rm $jdk_pkg

  # Get JAVA_HOME path
  cd $(ls -l | grep -i jdk | awk '{ print $9 }')
  JAVA_HOME="$(pwd)"
  JRE_HOME="$JAVA_HOME/jre"

  # Write profile
  echo "# JAVA" | sudo tee -a /etc/profile
  echo "export JAVA_HOME=$JAVA_HOME" | sudo tee -a /etc/profile
  echo "export JRE_HOME=$JRE_HOME" | sudo tee -a /etc/profile
  echo 'export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin'  | sudo tee -a /etc/profile
  echo 'export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib' | sudo tee -a /etc/profile
  source /etc/profile
fi

# Android studio
cd $TAR_GZ_PATH

android_pkg=$(ls -l | grep -i studio | awk '{ print $9 }')
if [ ! -z "$android_pkg" ]; then
  cp $android_pkg $ANDROID_PATH
  cd $ANDROID_PATH

  if [ "${android_pkg##*.}" = "zip" ]; then
    unzip $android_pkg
  elif [ "${android_pkg##*.}" = "gz" ]; then
    tar zxvf $android_pkg
  fi
  rm $android_pkg
fi


# Idea
cd $TAR_GZ_PATH

idea_pkg=$(ls -l | grep -i idea | awk '{ print $9 }')
if [ ! -z "$idea_pkg" ]; then
  cp $idea_pkg $IDEA_PATH
  cd $IDEA_PATH

  if [ "${idea_pkg##*.}" = "zip" ]; then
    unzip $idea_pkg
  elif [ "${idea_pkg##*.}" = "gz" ]; then
    tar zxvf $idea_pkg
  fi
  rm $idea_pkg
fi


# PyCharm 
cd $TAR_GZ_PATH

pycharm_pkg=$(ls -l | grep -i pycharm | awk '{ print $9 }')
if [ ! -z "$pycharm_pkg" ]; then
  cp $pycharm_pkg $PYCHARM_PATH
  cd $PYCHARM_PATH

  if [ "${pycharm_pkg##*.}" = "zip" ]; then
    unzip $pycharm_pkg
  elif [ "${pycharm_pkg##*.}" = "gz" ]; then
    tar zxvf $pycharm_pkg
  fi
  rm $pycharm_pkg
fi


# Wechat
cd $TAR_GZ_PATH

wechat_pkg=$(ls -l | grep -i wechat | awk '{ print $9 }')
if [ ! -z "$wechat_pkg" ]; then
  cp $wechat_pkg $WECHAT_PATH
  cd $WECHAT_PATH

  if [ "${wechat_pkg##*.}" = "zip" ]; then
    unzip $wechat_pkg
  elif [ "${wechat_pkg##*.}" = "gz" ]; then
    tar zxvf $wechat_pkg
  fi
  rm $wechat_pkg
fi


# iNode
cd $TAR_GZ_PATH

inode_pkg=$(ls -l | grep -i iNode | awk '{ print $9 }')
if [ ! -z "$inode_pkg" ]; then
  cp $inode_pkg $INODE_PATH
  cd $INODE_PATH

  if [ "${inode_pkg##*.}" = "zip" ]; then
    unzip $inode_pkg
  elif [ "${inode_pkg##*.}" = "gz" ]; then
    tar zxvf $inode_pkg
  fi
  rm $inode_pkg
fi


#######################################################################
# Others
#######################################################################
cd $HOSTS_PATH
if [ -r "hosts" ]; then
  echo "$PASSWORD" | sudo -S cp hosts /etc/
fi


#######################################################################
# Final update & clean
#######################################################################
echo "$PASSWORD" | sudo -S apt-get update
echo "$PASSWORD" | sudo -S apt-get upgrade -y
echo "$PASSWORD" | sudo -S apt-get clean
echo "$PASSWORD" | sudo -S apt-get autoremove -y
echo "Finished! Had better reboot the ubuntu!"

