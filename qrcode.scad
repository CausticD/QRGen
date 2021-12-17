include<data.scad>;

code_width_x = 50;
code_width_y = 50;
code_height = 1;

base_height = 1;

wall_height = 1;

border_outer = 6;
border_inner = 4;

$fn = 100;

// Base

linear_extrude(height = base_height) offset(r = border_outer) {
    square([code_width_x,code_width_y], center = true);
}

// Wall

translate([0,0,base_height]) difference() {

    linear_extrude(height = wall_height) offset(r = border_outer) {
        square([code_width_x,code_width_y], center = true);
    }

    translate([0,0,-0.01]) linear_extrude(height = wall_height+0.02) offset(r = border_inner) {
        square([code_width_x,code_width_y], center = true);
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