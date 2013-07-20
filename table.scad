// CONFIGURATION

// Outer dimensions
table_width = 50;
table_depth = 30;
table_height = 20;

foot_rest_height = 5; // Height of the *top*

tube_thickness = 1;
tube_gauge = 1/8;
tube_corner_radius = 1/8;

$fn = 20;

// CONFIGURATION END

// CALCULATIONS

table_x_size = table_width;
table_y_size = table_depth;
table_z_size = table_height;

foot_rest_z_position = foot_rest_height - tube_thickness;

// CALCULATIONS END

// MODULES

module leg() {
    difference() {
        translate([tube_corner_radius, tube_corner_radius, 0]) {
            minkowski() {
                cube(size = [tube_thickness - tube_corner_radius * 2, tube_thickness - tube_corner_radius * 2, table_z_size]);
                cylinder(r = tube_corner_radius, h = 0.01);
            }
        }
        translate([tube_gauge, tube_gauge, -1]) {
            cube(size = [tube_thickness - tube_gauge * 2, tube_thickness - tube_gauge * 2, table_z_size + 2]);
        }
    }
}

module legs() {
    union() {
        translate([tube_thickness, tube_thickness, 0]) {
            leg();
        }
        translate([table_x_size - tube_thickness * 2, tube_thickness, 0]) {
            leg();
        }
        translate([table_x_size - tube_thickness * 2, table_y_size - tube_thickness * 2, 0]) {
            leg();
        }
        translate([tube_thickness, table_y_size - tube_thickness * 2, 0]) {
            leg();
        }
    }
}

module width_bar() {
    difference() {
        translate([0, tube_corner_radius, tube_corner_radius]) {
            minkowski() {
                cube(size = [table_x_size, tube_thickness - tube_corner_radius * 2, tube_thickness - tube_corner_radius * 2]);
                rotate(a=[0,90,0]) {
                    cylinder(r = tube_corner_radius, h = 0.01);
                }
            }
        }
        translate([-1, tube_gauge, tube_gauge]) {
            cube(size = [table_x_size + 2, tube_thickness - tube_gauge * 2, tube_thickness - tube_gauge * 2]);
        }
    }
}

module width_bars() {
    union() {
        translate([0, 0, foot_rest_z_position]) {
            width_bar();
        }
        translate([0, 0, table_z_size - tube_thickness]) {
            width_bar();
        }
    }
}

module depth_bar() {
    difference() {
        translate([tube_corner_radius, 0, tube_corner_radius]) {
            minkowski() {
                cube(size = [tube_thickness - tube_corner_radius * 2, table_y_size - tube_thickness, tube_thickness - tube_corner_radius * 2]);
                rotate(a=[90,0,0]) {
                    cylinder(r = tube_corner_radius, h = 0.01);
                }
            }
        }
        translate([tube_gauge, -1, tube_gauge]) {
            cube(size = [tube_thickness - tube_gauge * 2, table_y_size + 2, tube_thickness - tube_gauge * 2]);
        }
    }
}

module depth_bars() {
    union() {
        translate([0, tube_thickness, foot_rest_z_position]) {
            depth_bar();
        }
        translate([table_x_size - tube_thickness, tube_thickness, foot_rest_z_position]) {
            depth_bar();
        }
        translate([0, tube_thickness, table_z_size - tube_thickness]) {
            depth_bar();
        }
        translate([table_x_size - tube_thickness, tube_thickness, table_z_size - tube_thickness]) {
            depth_bar();
        }
    }
}

module table() {
    color("Blue") legs();
    color("Orange") width_bars();
    color("Green") depth_bars();
}

// MODULES END

table();
