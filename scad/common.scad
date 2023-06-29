
eps = 0.01;
$fn= $preview ? 32 : 128;

x_carriage_width = 65;
y_carriage_depth = 50;

x_rod_spacing = 30;
x_rod_height = 40;
y_rod_spacing = 30;
y_rod_height = 48;

lin_bearing_OD_measured = 9.97;
lin_bearing_OD = lin_bearing_OD_measured + 0.2; // needs more clearance when 3D printing in XY plane
lin_bearing_length = 14.95;

rod_OD = 4.98;
rod_clr = 1;
rod_pressfit_horiz = 5.0; // a bit tight, but a little filing makes a good snug fit
x_rod_length = 215;
y_rod_length = 215;

M3_self_thread = 3.0; // for vertical (along 3D printer Z axis) holes only.
M3_pass_through = 3.2; // for vertical holes only
M3_self_thread_horiz = 2.6; // for horizontal (along 3D printer XY plane) holes only.
M3_pass_through_horiz = 3.0; // for horizontal holes only

pulley_deck_height = 54;

pen_lifter_bolt_pattern_diameter = 25;

// LIN Engineering stepper 4118M-39D-01
stepper_bolt_pattern_diameter = 43.51;
stepper_axle_diameter = 4.98;
stepper_axle_length = 22;
stepper_body_width = 42.5;
stepper_body_depth = 42.5;
stepper_body_height = 39.6;
stepper_boss_diameter = 22;
stepper_boss_height = 2;
stepper_rear_axle_length = 8.5;

pulley_diameter = 11.81; // the effective diameter of the pulley. from highest points on teeth across (from a printed 20T pulley)
belt_thickness = 1.06; // the thickness of the belt, not including the teeth
// the belt wrapped around the pulley is 14.17mm in diameter
// larger than the 13.93 you'd expect from belt_thickness * 2 + pulley_diameter

inner_idler_spacing = 2*(pulley_diameter + belt_thickness); // the distance between the two inner idlers on the x carriage
outer_idler_spacing = 4*(pulley_diameter + belt_thickness); // the distance between the two outer idlers on the x carriage
outer_idler_offset = pulley_diameter; // how far forward the outer idlers are offset from the center line of the x axis
