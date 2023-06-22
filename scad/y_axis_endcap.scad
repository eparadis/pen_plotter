// sits opposite the X carriage on the Y axis rods
// maintains Y axis rod separation and has two pulleys the belt wraps around

include <common.scad>

width = y_rod_spacing + 10;
depth = 10;
height = 1 + rod_pressfit_horiz + 1;

pm_height = 5;
module pulley_mount() {
  inner = 10;
  outer = 15;
  pulleys = [
    [-outer, 0],
    [+outer, 0]
  ];
  difference() {
    cube([width, depth, pm_height], center=true);
    for (i=[0:1])
      translate([pulleys[i].x, pulleys[i].y, -pm_height/2-eps])
        cylinder(d=3mm_self_thread, h=pm_height*1.1);
  }
}

module y_axis_endcap() {
  difference() {
    union() {
      cube([width, depth, height], center=true);
      translate([0, 0, pm_height+1])
        pulley_mount();
    }
    translate([-y_rod_spacing/2, depth/2+eps, 0])
      rotate([90, 0, 0])
        cylinder(d=rod_pressfit_horiz, h=depth*1.1);
    translate([+y_rod_spacing/2, depth/2+eps, 0])
      rotate([90, 0, 0])
        cylinder(d=rod_pressfit_horiz, h=depth*1.1);
  }
}


y_axis_endcap();