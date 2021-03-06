# QRGen

Offline (Local) STL/3MF generator for WiFi QR codes you can 3D print based around OpenSCAD and Python. Created after seeing https://printer.tools/qrcode2stl/ (https://github.com/flxn/qrcode2stl).

**Requirements:**
- Requires Python 3.X (https://www.python.org/) and the qrcode package (https://pypi.org/project/qrcode/) from pip.
- Needs OpenSCAD 2021.01 (https://openscad.org/) to be installed. Edit GenSTL.bat (and/or Gen3MF.bat and GenPNG.bat) to match path.
- Some slicing software to actually print it and two contrasting filament colours.

**Limitations:**
- WEP and hidden SSIDs are untested. WPA2-EAP not supported
- Changing the size of the output STL requires changing the main .scad file. No command line options.

**Guide:**
1) Run GenQRData.bat {SSID} {Password}
2) (Optional) Run GenPNG.bat to quickly create a preview PNG file with a to test.
3) Run GenSTL.bat (or Gen3MF.bat) (Takes a minute)
4) Slice (don't forget colour change) and print

**Interactive Mode:**
The main SCAD file now uses the OpenSCAD Customizer which allows altering size etc. There are two presets available as well. Default is a good all round look, minimal shows how to switch all but the QR COde off.

**Tips:**
- The slicer will need to be set up to do a colour change at the right layer. White first, then black.
- If using default sizes, slice with 100% infill (aka solid) so it doesn't have holes.
- After generating files, slicing and printing, run the CleanTempFiles.bat to remove files with sensitive data.
- The default size is 62mmx62mmx2mm with the base being 1mm and the QR code and border being 1mm. Don't make the QR code any taller as it hurts readability. All easy to change if required.
- The STL generation takes a little time. Perhaps a minute. The QR code part has now been sped up by about 30%, by combining adjacent squares.
- The output will display "WARNING: Object may not be a valid 2-manifold and may need repair!". This is because some of the QR Code square will touch by diagonal corners only. This can be fixed, see the SCAD file for how, but it results in a worse file after slicing.

**How it works:**
1) Step one uses a python script to take the SSID and password from the command line, create the specific WIFI string and convert into a QR code. It then exports this data as an array in an .SCAD file that is used in step 2. It doesn't export an image as SCAD has limited ability to read them in and create the vertical walls needed.
2) This uses OpenSCAD in command line mode to take the QR code data as an array and place cubes in a grid. This is then scaled down to the desired size and placed on the base. This takes a minute but creates an STL or 3MF file you can load in a slicer like Cura.
3) The final crucial part is to load the file created above and set a colour change to happen. This info is not contained in the STL/3MF so must be added manually. By default (and 0.2mm layer height) you will want to print the first 5 layers in white and the second 5 in black.
