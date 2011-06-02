(function() {
  var Point, PointsCollection, Shape, ShapesCollection;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  CanvasRenderingContext2D.prototype.add_point = function(x, y, color) {
    if (color == null) {
      color = "rgb(255, 255, 255)";
    }
    this.fillStyle = color;
    this.fillRect(x, y, 1, 1);
    return this;
  };
  CanvasRenderingContext2D.prototype.clear = function() {
    var canvas;
    canvas = this.canvas;
    this.clearRect(-canvas.width / 2, -canvas.height / 2, canvas.width, canvas.height);
    return this;
  };
  Point = (function() {
    function Point(x, y, z) {
      if (z == null) {
        z = nil;
      }
      this.coordinates = [];
      this.coordinates.x = x;
      this.coordinates.y = y;
      this.coordinates.z = z;
    }
    return Point;
  })();
  PointsCollection = (function() {
    function PointsCollection(color) {
      this.color = color;
      this.points = [];
    }
    PointsCollection.prototype.rotate = function(x, y, z) {
      var koef, point, x_degrees, x_temp, y_degrees, y_temp, z_degrees, _i, _len, _ref, _ref2, _results;
      if (x == null) {
        x = 0;
      }
      if (y == null) {
        y = 0;
      }
      if (z == null) {
        z = 0;
      }
      koef = 3.14;
      _ref = [koef * x / 180, koef * y / 180, koef * z / 180], x_degrees = _ref[0], y_degrees = _ref[1], z_degrees = _ref[2];
      _ref2 = this.points;
      _results = [];
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        point = _ref2[_i];
        if (x_degrees !== 0) {
          y_temp = point.coordinates.y;
          point.coordinates.y = (point.coordinates.y * Math.cos(x_degrees)) - (point.coordinates.z * Math.sin(x_degrees));
          point.coordinates.z = (y_temp * Math.sin(x_degrees)) + (point.coordinates.z * Math.cos(x_degrees));
        }
        if (y_degrees !== 0) {
          x_temp = point.coordinates.x;
          point.coordinates.x = (point.coordinates.x * Math.cos(y_degrees)) + (point.coordinates.z * Math.sin(y_degrees));
          point.coordinates.z = (point.coordinates.z * Math.cos(y_degrees)) - (Math.sin(y_degrees) * x_temp);
        }
        _results.push(z_degrees !== 0 ? (x_temp = point.coordinates.x, point.coordinates.x = (point.coordinates.x * Math.cos(z_degrees)) - (point.coordinates.y * Math.sin(z_degrees)), point.coordinates.y = (x_temp * Math.sin(z_degrees)) + (point.coordinates.y * Math.cos(z_degrees))) : void 0);
      }
      return _results;
    };
    PointsCollection.prototype.scale = function(x, y, z) {
      var point, x_percents, y_percents, z_percents, _i, _len, _ref, _ref2, _results;
      if (x == null) {
        x = 0;
      }
      if (y == null) {
        y = 0;
      }
      if (z == null) {
        z = 0;
      }
      _ref = [x / 100, y / 100, z / 100], x_percents = _ref[0], y_percents = _ref[1], z_percents = _ref[2];
      _ref2 = this.points;
      _results = [];
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        point = _ref2[_i];
        if (x_percents !== 0) {
          point.coordinates.x = point.coordinates.x * x_percents;
        }
        if (y_percents !== 0) {
          point.coordinates.y = point.coordinates.y * y_percents;
        }
        _results.push(z_percents !== 0 ? point.coordinates.z = point.coordinates.z * z_percents : void 0);
      }
      return _results;
    };
    PointsCollection.prototype.offset = function(x, y, z) {
      var point, x_offset, y_offset, z_offset, _i, _len, _ref, _ref2, _results;
      if (x == null) {
        x = 0;
      }
      if (y == null) {
        y = 0;
      }
      if (z == null) {
        z = 0;
      }
      _ref = [x, y, z], x_offset = _ref[0], y_offset = _ref[1], z_offset = _ref[2];
      _ref2 = this.points;
      _results = [];
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        point = _ref2[_i];
        if (x_offset !== 0) {
          point.coordinates.x = point.coordinates.x + x_offset;
        }
        if (y_offset !== 0) {
          point.coordinates.y = point.coordinates.y + y_offset;
        }
        _results.push(z_offset !== 0 ? point.coordinates.z = point.coordinates.z + z_offset : void 0);
      }
      return _results;
    };
    PointsCollection.prototype.render = function(canvas_context) {
      var point, _i, _len, _ref, _results;
      _ref = this.points;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        point = _ref[_i];
        _results.push(canvas_context.add_point(point.coordinates.x, point.coordinates.y, this.color));
      }
      return _results;
    };
    return PointsCollection;
  })();
  Shape = (function() {
    __extends(Shape, PointsCollection);
    function Shape(options) {
      var color;
      this.options = options;
      Shape.__super__.constructor.call(this, color = this.options["color"]);
      this.init_points();
    }
    Shape.prototype.init_points = function() {
      var point, u, v, x, y, z, _results, _step;
      _results = [];
      for (u = 0, _step = 0.4; u <= 10; u += _step) {
        _results.push((function() {
          var _ref, _ref2, _results2;
          _results2 = [];
          for (v = 0, _ref = this.options["height"]; 0 <= _ref ? v <= _ref : v >= _ref; 0 <= _ref ? v++ : v--) {
            _ref2 = this.coordinates_from_functions(u, v), x = _ref2[0], y = _ref2[1], z = _ref2[2];
            point = new Point(x, y, z);
            _results2.push(this.points.push(point));
          }
          return _results2;
        }).call(this));
      }
      return _results;
    };
    Shape.prototype.coordinates_from_functions = function() {};
    return Shape;
  })();
  window.Ellipsoid = (function() {
    __extends(Ellipsoid, Shape);
    function Ellipsoid() {
      Ellipsoid.__super__.constructor.apply(this, arguments);
    }
    Ellipsoid.prototype.coordinates_from_functions = function(u, v) {
      var a, b, c, x, y, z, _ref;
      _ref = [this.options["radius_x"], this.options["radius_y"], this.options["radius_z"]], a = _ref[0], b = _ref[1], c = _ref[2];
      x = a * Math.sin(u) * Math.cos(v);
      y = b * Math.sin(u) * Math.sin(v);
      z = c * Math.cos(u);
      return [x, y, z];
    };
    return Ellipsoid;
  })();
  window.EllipticCylinder = (function() {
    __extends(EllipticCylinder, Shape);
    function EllipticCylinder() {
      EllipticCylinder.__super__.constructor.apply(this, arguments);
    }
    EllipticCylinder.prototype.coordinates_from_functions = function(u, v) {
      var a, b, c, x, y, z, _ref;
      _ref = [this.options["radius_x"], this.options["radius_y"]], a = _ref[0], b = _ref[1], c = _ref[2];
      x = Math.cos(u) * a;
      y = Math.sin(u) * b;
      z = v;
      return [x, y, z];
    };
    return EllipticCylinder;
  })();
  ShapesCollection = (function() {
    function ShapesCollection(shapes, canvas_context) {
      this.shapes = shapes;
      this.canvas_context = canvas_context;
      this.shapes || (this.shapes = []);
    }
    ShapesCollection.prototype.render = function() {
      var canvas_context, shape, _i, _len, _ref, _results;
      _ref = this.shapes;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        shape = _ref[_i];
        _results.push(shape.render(canvas_context = this.canvas_context));
      }
      return _results;
    };
    ShapesCollection.prototype.rotate = function(x, y, z) {
      var shape, _i, _len, _ref, _results;
      if (x == null) {
        x = 0;
      }
      if (y == null) {
        y = 0;
      }
      if (z == null) {
        z = 0;
      }
      _ref = this.shapes;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        shape = _ref[_i];
        _results.push(shape.rotate(x, y, z));
      }
      return _results;
    };
    ShapesCollection.prototype.scale = function(x, y, z) {
      var shape, _i, _len, _ref, _results;
      if (x == null) {
        x = 0;
      }
      if (y == null) {
        y = 0;
      }
      if (z == null) {
        z = 0;
      }
      _ref = this.shapes;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        shape = _ref[_i];
        _results.push(shape.scale(x, y, z));
      }
      return _results;
    };
    ShapesCollection.prototype.offset = function(x, y, z) {
      var shape, _i, _len, _ref, _results;
      if (x == null) {
        x = 0;
      }
      if (y == null) {
        y = 0;
      }
      if (z == null) {
        z = 0;
      }
      _ref = this.shapes;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        shape = _ref[_i];
        _results.push(shape.offset(x, y, z));
      }
      return _results;
    };
    return ShapesCollection;
  })();
  window.Figure = (function() {
    __extends(Figure, ShapesCollection);
    function Figure() {
      Figure.__super__.constructor.apply(this, arguments);
    }
    return Figure;
  })();
  window.FigureCollection = (function() {
    function FigureCollection(figures, canvas_context) {
      this.figures = figures != null ? figures : [];
      this.canvas_context = canvas_context;
    }
    FigureCollection.prototype.render = function() {
      var figure, shape, _i, _len, _ref, _results;
      _ref = this.figures;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        figure = _ref[_i];
        _results.push((function() {
          var _j, _len2, _ref2, _results2;
          _ref2 = figure.shapes;
          _results2 = [];
          for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
            shape = _ref2[_j];
            _results2.push(shape.render(this.canvas_context));
          }
          return _results2;
        }).call(this));
      }
      return _results;
    };
    FigureCollection.prototype.rotate = function(x, y, z) {
      var figure, shape, _i, _len, _ref, _results;
      _ref = this.figures;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        figure = _ref[_i];
        _results.push((function() {
          var _j, _len2, _ref2, _results2;
          _ref2 = figure.shapes;
          _results2 = [];
          for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
            shape = _ref2[_j];
            _results2.push(shape.rotate(x, y, z));
          }
          return _results2;
        })());
      }
      return _results;
    };
    FigureCollection.prototype.offset = function(x, y, z) {
      var figure, shape, _i, _len, _ref, _results;
      _ref = this.figures;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        figure = _ref[_i];
        _results.push((function() {
          var _j, _len2, _ref2, _results2;
          _ref2 = figure.shapes;
          _results2 = [];
          for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
            shape = _ref2[_j];
            _results2.push(shape.offset(x, y, z));
          }
          return _results2;
        })());
      }
      return _results;
    };
    FigureCollection.prototype.scale = function(x, y, z) {
      var figure, shape, _i, _len, _ref, _results;
      _ref = this.figures;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        figure = _ref[_i];
        _results.push((function() {
          var _j, _len2, _ref2, _results2;
          _ref2 = figure.shapes;
          _results2 = [];
          for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
            shape = _ref2[_j];
            _results2.push(shape.scale(x, y, z));
          }
          return _results2;
        })());
      }
      return _results;
    };
    return FigureCollection;
  })();
}).call(this);
