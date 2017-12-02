# Canon-CAPT Printer Drivers
**(for solus primarily but should work on other distros)**

#### Drivers for Canon i-Sensys and LBP**** series Printers

This repo contains the Canon CAPT drivers and a Makefile written by me to install the Canon CAPT drivers effortlessy.

The Canon drivers are released under a proprietary license with opensource licensed components.

The driver folder structure is modified to get it to compile properly since some components like captstatusui, the printer status monitor were difficult to compile and so are included are binary blobs (extracted from Canon packaged rpm) in this repo.

Also included as a binary is the libpopt.so library since I couldn't find the 32 bit package for it in Solus.

### Installing CAPT Drivers

 Download the __eopkgs__ in the release section. Install them with the --ignore-file-conflicts flag.
 →i.e, in the directory containing the package,run __sudo eopkg it --ignore-file-conflicts *.eopkg__
      
***OR***

__git clone https://github.com/gkr09/Canon-CAPT.git__

__cd Canon-CAPT__

__make install__

### Configuring the Printer

Open a terminal window and run the following commands sequentially.

__sudo lpadmin -p LBP2900 -m CNCUPSLBP2900CAPTK.ppd -v ccp:/var/ccpd/fifo0 -E__

__sudo ccpdadmin -p LBP2900 -o /dev/usb/lp0__

__sudo systemctl stop org.cups.cupsd.service__     (Stopping the cups daemon)

__sudo systemctl start org.cups.cupsd.service__    (Restarting the cups daemon)

__sudo /etc/init.d/ccpd start__                    (Starting the ccp daemon, ccpd)

Now, to check whether the Printer is recognised, run __captstatusui -P MODEL__ where MODEL is the Printer model no. like LBP2900,LBP3000 etc.
For eg., __captstatusui -P LBP2900__
If everything is installed/configured fine the captstatusui window will show __Ready to Print__

### Trouble ?

captstatusui window refuses to start with  __Socket Error__ : 

                     Restart the cups daemon
             
             sudo systemctl stop org.cups.cupsd.service
             sudo systemctl start org.cups.cupsd.service
             sudo /etc/init.d/ccpd restart
             
captstatusui window shows __No specified printer__ :

             1. Try reinstalling the printer again ,see above
             2. Try restarting your Computer.
             3. Restart the cups daemon and the ccp daemon (ccpd), see above
