export LD_LIBRARY_PATH=/mnt/us/DK_System/lib/:${LD_LIBRARY_PATH}
chmod a+x /mnt/us/DK_System/bin/ebook
/mnt/us/DK_System/bin/ebook >/dev/null 2>/dev/null
/etc/init.d/framework start 
