include<data.scad>;

code_width_x = 8;
code_width_y = 8;
code_height = 0.5;

base_height = 0.5;

wall_height = 0.5;

$fn = 100;

// Base

linear_extrude(height = base_height) offset(r = 1) {
    square([code_width_x,code_width_y], center = true);
}

// Wall

translate([0,0,base_height]) difference() {

    linear_extrude(height = wall_height) offset(r = 1) {
        square([code_width_x,code_width_y], center = true);
    }

    translate([0,0,-0.01]) linear_extrude(height = wall_height+0.02) offset(r = 0.75) {
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
                    translate([val_x,val_y,0]) cube([1,1,code_height]);
    }