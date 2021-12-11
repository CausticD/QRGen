# https://pypi.org/project/qrcode/
# https://en.wikipedia.org/wiki/QR_code

import qrcode
import math
import argparse

parser = argparse.ArgumentParser(description='Generate data for QR code for provided Wifi network')
parser.add_argument('SSID', help='The WiFi networks SSID')
parser.add_argument('Password', help='The password for that SSDID')
args = parser.parse_args()

data = "WIFI:T:WPA;S:" + args.SSID + ";P:" + args.Password + ";;"

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