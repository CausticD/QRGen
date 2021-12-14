# QRGen

Offline STL/3MF generator for WiFi QR codes you can 3D print.

Requirements:
- Requires Python 3.X and the qrcode package from pip.
- Needs OpenSCAD to be installed. Edit GenSTL.bat to match path.
- Some slicing software to actually print it and two contrasting filament colours.

Limitations:
- WEP and hidden SSIDs are untested. WPA2-EAP not supported

Guide:
1) Run GenQRData.bat {SSID} {Password}
2) Run GenSTL.bat (or Gen3MF.bat) (Takes a minute)
3) Slice (don't forget colour change) and print

Tips:
- The slicer will need to be set up to do a colour change at the right layer. White first, then black.
- If using default sizes, slice with 100% infill (aka solid) so it doesn't have holes.
- After generating files, slicing and printing, run the CleanTempFiles.bat to remove files with sensitive data.
