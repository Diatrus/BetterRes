# BetterRes
### For RootlessJB and root-based jailbreaks (unc0ver and Electra)
### Only works on iPhones for now.

1.    Unzip BetterRes-0.5.zip. Find the BetterRes folder and copy it to "/var/mobile/".

2.   SSH into your phone as root, cd to the directory you copied BetterRes to, and run "chmod 0777 install.sh". After that, type "./install.sh" and wait for the script to finish installing.

3.    Go to /private/var/mobile/Library/Preferences/ and open com.apple.iokit.IOMobileGraphicsFamily.plist.setrestarget.bak with a text editor. Change the canvas_height and canvas_width to the values you want (make sure they apply to your phone's aspect ratio). Save the file and close it.

4.    Reboot the device and rejailbreak for your custom resolution to take effect!

### Disclaimer:
I am not responsible for any damages you may inflict on your device by installing and/or misusing this tool on your device.

#### CREDITS:
[/u/mahmoudnasha](https://www.reddit.com/user/mahmoudnashat) for SetRes, the basis for BetterRes.
