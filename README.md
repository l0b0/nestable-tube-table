Nestable Tube Table
===================

[OpenSCAD](http://www.openscad.org/) model of a nestable tube table, based on [Tested](http://tested.com)'s [Jamie Hyneman On Welding in His Workshop video](http://www.youtube.com/watch?v=EA1jeViV4l8&t=10m58s). Really simple, sturdy table which can be cut out of square steel tubes and welded together quickly.

Previews
--------

* [Single table](table.stl)
* [Double table](tables.stl)

Configuration
-------------

You can configure all the important measurements [at the top of `table.scad`](table.scad#L1-L16):

* Table width: `table_width`
* Table depth: `table_depth`
* Table height: `table_height`
* Foot rest height: `foot_rest_height`
* Tube thickness: `tube_thickness`
* Tube gauge: `tube_gauge`
* Tube corner radius: `tube_corner_radius`

You can tweak these to fit your material dimensions and ergonomic needs. The rest of the file takes care of fitting the pieces together automatically.
