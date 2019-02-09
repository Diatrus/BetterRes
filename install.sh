echo "Creating SetRes resolution files..."
cp /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak
cp /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setresoriginal.bak
echo "Copying launchdaemons..."
cp ./com.horizon.setres.setresoriginal.plist /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/
cp ./com.horizon.setres.setrestarget.plist /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/
echo "Done! Set your custom resolution in /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak then reboot and rejailbreak!"
