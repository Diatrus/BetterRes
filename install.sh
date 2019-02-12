MODEL=$(uname -m)
case ${MODEL} in
	iPhone6,1 | iPhone6,2 | iPhone8,4)
    X=640 Y=1136;;
	iPhone7,2 | iPhone8,1 | iPhone9,1 | iPhone9,3 | iPhone10,1 | iPhone10,4)
    X=750 Y=1334;;
	iPhone7,1 | iPhone8,2 | iPhone9,2 | iPhone9,4 | iPhone10,2 | iPhone10,5)
    X=1080 Y=1920;;
	iPhone10,3 | iPhone10,6)
    X=1125 Y=2436;;
esac
echo ${MODEL} detected!
echo ${X}x${Y} is your default resolution.
echo Creating stock IOMobileGraphicsFamily.plist...
if [ -f /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist ]; then
	rm -f /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist
fi
cat > /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>canvas_height</key>
	<integer>${Y}</integer>
	<key>canvas_width</key>
	<integer>${X}</integer>
</dict>
</plist>
EOF
chmod 0755 /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist
echo Default IOMobileGraphicsFamily.plist created! 
echo Creating SetRes resolution files...
cp /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak
cp /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setresoriginal.bak
echo Copying launchdaemons...
if [ -d /private/var/containers/Bundle/iosbinpack64/ ]; then
	cat > /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/com.horizon.setres.setrestarget.plist<< EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.horizon.setres.setrestarget</string>
	<key>LaunchOnlyOnce</key>
	<true/>
	<key>ProgramArguments</key>
	<array>
		<string>/var/containers/Bundle/iosbinpack64/bin/bash</string>
		<string>-c</string>
		<string>/private/var/containers/Bundle/iosbinpack64/bin/cp /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist ; /var/containers/Bundle/iosbinpack64/usr/bin/killall cfprefsd</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>
EOF
	cat > /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/com.horizon.setres.setresoriginal.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.horizon.setres.setresoriginal</string>
	<key>LaunchOnlyOnce</key>
	<true/>
	<key>ProgramArguments</key>
	<array>
		<string>/private/var/containers/Bundle/iosbinpack64/bin/cp</string>
		<string>/private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setresoriginal.bak</string>
		<string>/private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist</string>
	</array>
	<key>RunAtLoad</key>
	<false/>
	<key>StartInterval</key>
	<integer>30</integer>
</dict>
</plist>
EOF
chmod 0644 /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/com.horizon.setres.setresoriginal.plist
chmod 0644 /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/com.horizon.setres.setrestarget.plist
chown root:wheel /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/com.horizon.setres.setresoriginal.plist
chown root:wheel /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/com.horizon.setres.setrestarget.plist
else
	cat > /private/etc/rc.d/betterres << EOF
#!/bin/bash
/bin/cp /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist
EOF

	cat > /Library/LaunchDaemons/com.horizon.setres.setresoriginal.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.horizon.setres.setresoriginal</string>
	<key>LaunchOnlyOnce</key>
	<true/>
	<key>ProgramArguments</key>
	<array>
		<string>/bin/cp</string>
		<string>/private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setresoriginal.bak</string>
		<string>/private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist</string>
	</array>
	<key>RunAtLoad</key>
	<false/>
	<key>StartInterval</key>
	<integer>30</integer>
</dict>
</plist>
EOF
    chmod 0777 /private/etc/rc.d/betterres
    chmod 0644 /Library/LaunchDaemons/com.horizon.setres.setresoriginal.plist
   	chown root:wheel /Library/LaunchDaemons/com.horizon.setres.setresoriginal.plist
fi
echo Done! Set your custom resolution in /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak then reboot and rejailbreak!



