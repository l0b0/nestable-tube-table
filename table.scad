// CONFIGURATION

// Outer dimensions
table_width = 50;
table_depth = 30;
table_height = 20;

foot_rest_height = 5; // Height of the *top*

tube_thickness = 1;
tube_gauge = 1/8;
tube_corner_radius = 1/8;

qr_code = false; // Include QR code with link to Thingiverse

$fn = 20;

// CONFIGURATION END

// CALCULATIONS

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

module legs(table_x_size, table_y_size) {
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

module width_bar(table_x_size) {
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

module width_bars(table_x_size) {
    include <qr_code.scad>;

    union() {
        translate([0, 0, foot_rest_z_position]) {
            width_bar(table_x_size);
        }
        translate([0, 0, table_z_size - tube_thickness]) {
            difference() {
                width_bar(table_x_size);
                if (qr_code) {
                    translate([tube_corner_radius, 0, tube_corner_radius]) { // Position on bar
                        scale(v = [(tube_thickness - 2 * tube_corner_radius) / (qr_code_size + 2), (tube_thickness - 2 * tube_corner_radius) / (qr_code_size + 2), (tube_thickness - 2 * tube_corner_radius) / (qr_code_size + 2)]) { // + 2 for a frame
                            rotate(a = [90, 0, 0]) { // To be used in XZ plane
                                translate([qr_code_size / 2, qr_code_size / 2 + 0.5, 0]) { // Move corner to [0, 0.5, 0]
                                    qr_code();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module depth_bar(table_y_size) {
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

module depth_bars(table_x_size, table_y_size) {
    union() {
        translate([0, tube_thickness, foot_rest_z_position]) {
            depth_bar(table_y_size);
        }
        translate([table_x_size - tube_thickness, tube_thickness, foot_rest_z_position]) {
            depth_bar(table_y_size);
        }
        translate([0, tube_thickness, table_z_size - tube_thickness]) {
            depth_bar(table_y_size);
        }
        translate([table_x_size - tube_thickness, tube_thickness, table_z_size - tube_thickness]) {
            depth_bar(table_y_size);
        }
    }
}

module table(table_x_size, table_y_size) {
    color("Blue") legs(table_x_size, table_y_size);
    color("Orange") width_bars(table_x_size);
    color("Green") depth_bars(table_x_size, table_y_size);

    echo (str("Inventory:"));
    echo (str("2 x ", table_x_size, " for table width bars"));
    echo (str("4 x ", table_y_size - tube_thickness, " for table depth bars"));
    echo (str("4 x ", table_z_size, " for legs"));
}

// MODULES END

table(table_width, table_depth);

// Inner table example
% translate([2.5 * tube_thickness, 2 * tube_thickness, 0]) {
    table(table_width - 5 * tube_thickness, table_depth - tube_thickness);
}
