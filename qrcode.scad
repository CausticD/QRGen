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

/* [Text] */

// Display the SSID name. Set to false to enter your own string.
text_use_ssid = true;
// Auto size the space based on the text.
text_auto_size = true;
// The message to display under the QR code (if not displaying SSID).
text_msg = "Testtest";
// The height (mm) of the text vertically.
text_height = 1; // [0.5:0.5:2.5]
// The extra space (mm) for the text to go.
text_vert_space = 10; // [6:1:80]
// Tweak the vertical offset (mm).
text_offset = 2; // [0:0.5:30]

module __Customizer_Limit__ () {}

code_width_x = QR_code_size;
code_width_y = QR_code_size;
code_height = QR_code_height;
border_inner = border_width;
border_outer = border_width + wall_width;
text_space_auto = ((QR_code_size * 1.33) / len(ssidname));

$fn = 100;

function text_space() = text_auto_size?text_space_auto:text_vert_space;

// Base

translate([0,-text_space()/2,0])
    linear_extrude(height = base_height) offset(r = border_outer) {
        square([code_width_x,code_width_y+text_space()], center = true);
    }

// Wall

if(wall_width > 0)
{
    translate([0,-text_space()/2,base_height]) difference() {

        linear_extrude(height = wall_height) offset(r = border_outer) {
            square([code_width_x,code_width_y+text_space()], center = true);
        }

        translate([0,0,-0.01]) linear_extrude(height = wall_height+0.02) offset(r = border_inner) {
            square([code_width_x,code_width_y+text_space()], center = true);
        }

    }
}

// Text
color("green") translate([0, -code_width_y/2 - text_space() + text_offset, base_height + text_height/2])
    linear_extrude(text_height, center = true, convexity = 4)
        resize([code_width_x, 0], auto = true)
        {
            if(text_use_ssid) text(ssidname, valign = "center", halign = "center");
            else text(text_msg, valign = "center", halign = "center");
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
            translate([x,qrsize-y-1,0]) cube([l,1,code_height]);     // Setting this to slightly less than 1 solves the warning message, but the resulting file slices worse.
        }
    }