// slides along X axis (left and right) and holds the Y axis rods

include <common.scad>;

width = x_carriage_width;
height = 1 + lin_bearing_OD + 1;
depth = x_rod_spacing + (lin_bearing_OD * 0.7);


module rod_clearances() {
  module rod_clearance() {
    translate([-width*0.55, 0, 0])
      rotate([0, 90, 0])
        cylinder(d=rod_OD+rod_clr, h=width*1.1);
  }
  translate([0, -x_rod_spacing/2, 0]) {
    rod_clearance();
    translate([0, x_rod_spacing, 0 ]) {
      rod_clearance();
    }
  }
}

module linear_bearings() {
  module linear_bearing() {
    rotate([0, 90, 0])
    cylinder(d=lin_bearing_OD, h=lin_bearing_length, center=true);
  }

  translate([-width/2+lin_bearing_length/2-eps, -x_rod_spacing/2, 0]) {
    linear_bearing();
    translate([0, x_rod_spacing, 0 ])
      linear_bearing();
  }

  translate([width/2-lin_bearing_length/2+eps, -x_rod_spacing/2, 0]) {
    linear_bearing();
    translate([0, x_rod_spacing, 0 ])
      linear_bearing();
  }
}

difference(){
  cube([width, depth, height], center=true);
  rod_clearances();
  linear_bearings();
}

