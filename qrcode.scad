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

/*color("pink") translate([0,0,base_height+code_height/2]) cube([code_width_x, code_width_y, code_height], center = true);*/

color("yellow") scale([code_width_x/qrsize, code_width_y/qrsize, 1.0])
    translate([-qrsize/2, -qrsize/2, base_height])
    {
        for(val_y = [0:qrsize-1])
            for(val_x = [0:qrsize-1])
                if(qrdata[val_y*qrsize+val_x] > 0)
                    translate([val_x,qrsize-val_y,0]) cube([1,1,code_height]);
    }