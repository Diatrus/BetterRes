echo "Restoring default resolution and removing SetRes resolution files..."
rm /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak
mv /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist.setresoriginal.bak /private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist
echo "Removing BetterRes..."
rm /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/com.horizon.setres.setresoriginal.plist
rm /private/var/containers/Bundle/iosbinpack64/LaunchDaemons/com.horizon.setres.setrestarget.plist
rm /Library/LaunchDaemons/com.horizon.setres.setresoriginal.plist
rm /Library/LaunchDaemons/com.horizon.setres.setrestarget.plist
rm /private/etc/rc.d/betterres
echo "Done! Please reboot and rejailbreak!"
