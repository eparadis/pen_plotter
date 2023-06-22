
include <common.scad>
use <x_carriage.scad>
use <side_stand.scad>
use <y_axis_endcap.scad>
use <y_carriage.scad>

translate([0, 0, x_rod_height])
  x_carriage();

translate([x_rod_length/2, 0, 0])
  side_stand();

translate([-x_rod_length/2, 0, 0])
  rotate([0, 0, 180])
    side_stand();

translate([0, -y_rod_length, y_rod_height])
  y_axis_endcap();

translate([0, -y_rod_length/2, y_rod_height])
  y_carriage();
