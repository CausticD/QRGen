# https://pypi.org/project/qrcode/
# https://en.wikipedia.org/wiki/QR_code
# https://github.com/zxing/zxing/wiki/Barcode-Contents

import qrcode
import math
import argparse

# Notes:
# - Pre-escape your SSID and/or password if you have any special characters in them. Special characters \ ; , " : should be escaped with a backslash \.
# - Doesn't support WPA2-EAP.
# - WEP and hidden SSIDs are now supported but untested.
# - Always using low error correct for the QR code.
# - Should scale the QR code up in size if needed.

parser = argparse.ArgumentParser(description='Generate data for QR code for provided Wifi network into scad file.')
parser.add_argument('SSID', help='The WiFi networks SSID.')
parser.add_argument('Password', help='The password for that SSDID.')
parser.add_argument("--wep", help="Set if using WEP security. Defaults to WPA.", action="store_true")
parser.add_argument("--hidden", help="Set if the SSID in question is hidden.", action="store_true")
parser.add_argument("--quiet", help="Don't output anything to command line.", action="store_true")
args = parser.parse_args()

security = "WPA"
hidden = ""

if args.wep:
	security = "WEP"
	
if args.hidden:
	hidden = "H:true"

data = "WIFI:T:" + security + ";S:" + args.SSID + ";P:" + args.Password + ";" + hidden + ";"

qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=1,
    border=0,
)

qr.add_data(data)
qr.make(fit=True)

img = qr.make_image(fill_color="black", back_color="white")

mylist = list(img.getdata())
size = int(math.sqrt(len(mylist)))
count = 0;

if not args.quiet:
	print(data)
	print(size, 'x', size)

f = open("data.scad", "w")

f.write("qrsize = " + str(size) + ";\n")
f.write("qrdata = [")

for j in range(0, size):
	for i in range(0, size):
		val = mylist[count]
		if val:
			f.write("0, ")
		else:
			f.write("1, ")
		count += 1
	f.write("\n")
f.write("];")
f.close()