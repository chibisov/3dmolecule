(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.MoleculeLeg = (function() {
    __extends(MoleculeLeg, Figure);
    function MoleculeLeg(options) {
      var head, head_2, leg, leg_z_offset, x, y, z;
      this.options = options;
      head = new Ellipsoid({
        "radius_x": this.options["head"]["radius"],
        "radius_y": this.options["head"]["radius"],
        "radius_z": this.options["head"]["radius"],
        "color": this.options["head"]["color"],
        "height": 500
      });
      head_2 = new Ellipsoid({
        "radius_x": this.options["head"]["radius"],
        "radius_y": this.options["head"]["radius"],
        "radius_z": this.options["head"]["radius"],
        "color": this.options["head"]["color"],
        "height": 500
      });
      leg = new EllipticCylinder({
        "radius_x": this.options["leg"]["radius"],
        "radius_y": this.options["leg"]["radius"],
        "height": this.options["leg"]["height"],
        "color": this.options["leg"]["color"] || this.options["head"]["color"]
      });
      leg_z_offset = this.options["head"]["radius"] - this.options["leg"]["radius"] / 3;
      leg.offset(x = 0, y = 0, z = leg_z_offset);
      head_2.rotate(x = 0, y = 90, z = 0);
      this.shapes = [head, leg];
    }
    return MoleculeLeg;
  })();
  window.Molecule = (function() {
    __extends(Molecule, FigureCollection);
    function Molecule(canvas_context) {
      var colorize, i, molecule_leg, molecule_leg_options, x, y, z;
      this.canvas_context = canvas_context;
      molecule_leg_options = {
        "head": {
          "radius": 30,
          "color": "rgba(111, 204, 255, 0.1)"
        },
        "leg": {
          "radius": 10,
          "height": 90
        }
      };
      colorize = false;
      colorize = true;
      this.figures = [];
      for (i = 0; i <= 11; i++) {
        if (colorize) {
          switch (i) {
            case 0:
              molecule_leg_options["head"]["color"] = "rgba(111, 204, 255, 0.1)";
              break;
            case 1:
              molecule_leg_options["head"]["color"] = "rgba(255, 255, 0, 0.1)";
              break;
            case 2:
              molecule_leg_options["head"]["color"] = "rgba(255, 0, 0, 0.1)";
              break;
            case 3:
              molecule_leg_options["head"]["color"] = "rgba(134, 255, 0, 0.1)";
              break;
            case 4:
              molecule_leg_options["head"]["color"] = "rgba(134, 0, 255, 0.1)";
              break;
            case 5:
              molecule_leg_options["head"]["color"] = "rgba(255, 181, 40, 0.1)";
          }
        }
        if (i > 5) {
          molecule_leg_options["head"]["color"] = "rgba(255, 255, 255, 0.1)";
          molecule_leg_options["head"]["radius"] = 25;
          molecule_leg_options["leg"]["radius"] = 7;
          molecule_leg_options["leg"]["height"] = 50;
        }
        molecule_leg = new MoleculeLeg(molecule_leg_options, canvas_context = canvas_context);
        this.figures.push(molecule_leg);
      }
      this.figures[0].rotate(x = 90, y = 0, z = 60);
      this.figures[6].rotate(x = 90, y = 0, z = 135);
      this.figures[4].rotate(x = -90, y = 0, z = -60);
      this.figures[7].rotate(x = -90, y = 0, z = 0);
      this.figures[1].rotate(x = -90, y = 0, z = 0);
      this.figures[8].rotate(x = -90, y = 0, z = 45);
      this.figures[3].rotate(x = -90, y = 0, z = 60);
      this.figures[9].rotate(x = 90, y = 0, z = -45);
      this.figures[5].rotate(x = 90, y = 0, z = -60);
      this.figures[10].rotate(x = 90, y = 0, z = 0);
      this.figures[2].rotate(x = 90, y = 0, z = 0);
      this.figures[11].rotate(x = 90, y = 0, z = 45);
      this.figures[0].offset(x = -120, y = -70, z = 0);
      this.figures[6].offset(x = -197, y = -138, z = 0);
      this.figures[4].offset(x = 0, y = -140, z = 0);
      this.figures[7].offset(x = 0, y = -241, z = 0);
      this.figures[1].offset(x = 120, y = -70, z = 0);
      this.figures[8].offset(x = 197, y = -138, z = 0);
      this.figures[3].offset(x = 120, y = 70, z = 0);
      this.figures[9].offset(x = 195, y = 140, z = 0);
      this.figures[5].offset(x = 0, y = 140, z = 0);
      this.figures[10].offset(x = 0, y = 241, z = 0);
      this.figures[2].offset(x = -120, y = 70, z = 0);
      this.figures[11].offset(x = -195, y = 140, z = 0);
    }
    return Molecule;
  })();
}).call(this);
