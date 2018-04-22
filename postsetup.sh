# pip install --upgrade pip
pip install --upgrade virtualenv


wget -O /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod a+x /usr/local/bin/lein
echo "#!/bin/bash
export LEIN_ROOT=true" > /etc/profile.d/leinroot.sh
export LEIN_ROOT=true
lein

mkdir -p /data/virtualenvs
#touch /root/.ssh/config

echo "/usr/lib/python2.7/plat-x86_64-linux-gnu" >> /etc/ld.so.conf.d/x86_64-linux-gnu.conf
ldconfig

mkdir -p /var/log/storm/streamparse
chown -R storm:hadoop /var/log/storm/streamparse

pip install git+https://github.com/srujun/streamparse.git
