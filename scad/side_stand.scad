// sits on either side of the X axis and holds the motors and axis rods


include <common.scad>

depth = x_rod_spacing + 10;
height = x_rod_height + 10;
width = 10;

module x_axis_rod_clamps() {
  translate([-eps, x_rod_spacing/2, x_rod_height])
    rotate([0, 90, 0])
      cylinder(d=rod_pressfit_horiz, h=width*1.1);
  translate([-eps, -x_rod_spacing/2, x_rod_height])
    rotate([0, 90, 0])
      cylinder(d=rod_pressfit_horiz, h=width*1.1);
}

module side_stand() {
  translate([-width, 0, 0])
  difference() {
    translate([0, -depth/2, 0])
      cube([width, depth, height]);
    x_axis_rod_clamps();
  }
}

side_stand();