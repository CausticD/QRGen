include<data.scad>;

/* [Base] */

// The thickness (mm) of the base. Usually the bit printed in white.
base_height = 1; // [0.5:0.5:5]

/* [QR Code] */

// The size (mm) of just the QR code in both X and Y. Overall dimensions bigger.
QR_code_size = 50;  // [20:5:120]
// The height/depth (mm) of the QR code. Taller makes it harder to scan due to shadows.
QR_code_height = 1; // [0.5:0.5:2.5]

/* [Border and Wall] */

// The width (mm) of the rounded border around the QR Code.
border_width = 4; // [0:1:10]
// The thickness (mm) of the wall around the outside.
wall_height = 1; // [0.5:0.5:2.5]
// The width (mm) of the raised wall around the outside.
wall_width = 2; // [0:1:5]

module __Customizer_Limit__ () {}

code_width_x = QR_code_size;
code_width_y = QR_code_size;
code_height = QR_code_height;
border_inner = border_width;
border_outer = border_width + wall_width;
$fn = 100;

// Base

linear_extrude(height = base_height) offset(r = border_outer) {
    square([code_width_x,code_width_y], center = true);
}

// Wall

if(wall_width > 0)
{
    translate([0,0,base_height]) difference() {

        linear_extrude(height = wall_height) offset(r = border_outer) {
            square([code_width_x,code_width_y], center = true);
        }

        translate([0,0,-0.01]) linear_extrude(height = wall_height+0.02) offset(r = border_inner) {
            square([code_width_x,code_width_y], center = true);
        }

    }
}

// QR Code

color("yellow") scale([code_width_x/qrsize, code_width_y/qrsize, 1.0])
    translate([-qrsize/2, -qrsize/2, base_height])
    {
        for(triplet = [0:qrdata2count-1])
        {
            x = qrdata2[triplet*3+0];
            y = qrdata2[triplet*3+1];
            l = qrdata2[triplet*3+2];
            translate([x,qrsize-y-1,0]) cube([l,1,code_height]);
        }
    }