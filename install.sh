MODEL=$(uname -m)
case $MODEL in
	iPhone6,1 | iPhone6,2 | iPhone8,4) RES=640x1136;;
	iPhone7,2 | iPhone8,1 | iPhone9,1 | iPhone9,3 | iPhone 10,1 | Phone10,4) RES=750x1334;;
	iPhone7,1 | iPhone8,2 | iPhone9,2 | iPhone 9,4 | iPhone 10,2 | iPhone 10,5) RES=1080x1920;;
	iPhone10,3 | iPhone10,6) RES=1125x2436
esac
echo $MODEL detected!
echo $RES is your default resolution.

echo Crerating stock IOMobileGraphicsFamily.plist...
if [ ! -f /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist ]
	rm -f /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist
fi
cp Defaults/$RES/com.apple.iokit.IOMobileGraphicsFamily.plist /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist
echo Default IOMobileGraphicsFamily.plist copied! 
echo Creating SetRes resolution files...
cp /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak
cp /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setresoriginal.bak
echo Copying launchdaemons...
cp ./com.horizon.setres.setresoriginal.plist /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/
cp ./com.horizon.setres.setrestarget.plist /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/
echo Done! Set your custom resolution in /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak then reboot and rejailbreak!

