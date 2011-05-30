(function() {
  var get_canvas_context, init_figure;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  jQuery(function() {
    return init_figure();
  });
  init_figure = function() {
    var canvas, canvas_context, interval_id, molecule;
    canvas = document.getElementById('canvas_board');
    canvas_context = get_canvas_context(canvas);
    molecule = new Molecule(canvas_context = canvas_context);
    $("#form_params").bind("submit", __bind(function(e) {
      var data, x, y, z;
      e.preventDefault();
      data = {
        "rotate": {
          "x": Number($(".to_rotate input[name=coord_x]").val()),
          "y": Number($(".to_rotate input[name=coord_y]").val()),
          "z": Number($(".to_rotate input[name=coord_z]").val())
        },
        "offset": {
          "x": Number($(".to_offset input[name=coord_x]").val()),
          "y": Number($(".to_offset input[name=coord_y]").val()),
          "z": Number($(".to_offset input[name=coord_z]").val())
        },
        "scale": {
          "x": Number($(".to_scale input[name=coord_x]").val()),
          "y": Number($(".to_scale input[name=coord_y]").val()),
          "z": Number($(".to_scale input[name=coord_z]").val())
        }
      };
      molecule.rotate(x = data["rotate"]["x"], y = data["rotate"]["y"], z = data["rotate"]["z"]);
      molecule.offset(x = data["offset"]["x"], y = data["offset"]["y"], z = data["offset"]["z"]);
      molecule.scale(x = data["scale"]["x"], y = data["scale"]["y"], z = data["scale"]["z"]);
      canvas_context.clear();
      return molecule.render();
    }, this));
    $("#reset_settings").click(function() {
      return $("input[name^=coord_]").val(0);
    });
    $("#set_to_default_position").click(function() {
      molecule = new Molecule(canvas_context = canvas_context);
      canvas_context.clear();
      return molecule.render();
    });
    interval_id = "";
    $("#animate").change(function() {
      if (this.checked) {
        return interval_id = setInterval(function() {
          var x, y, z;
          canvas_context.clear();
          molecule.rotate(x = 5, y = 5, z = 0);
          return molecule.render();
        }, 500);
      } else {
        if (interval_id) {
          return clearInterval(interval_id);
        }
      }
    });
    $("#animate").trigger("change");
    return $("#form_params").trigger("submit");
  };
  get_canvas_context = function(canvas_element) {
    var canvas_context;
    if (canvas_element.getContext) {
      canvas_context = canvas_element.getContext('2d');
      canvas_context.translate(canvas_element.width / 2, canvas_element.height / 2);
      return canvas_context;
    } else {
      alert("Ваш браузер не поддерживает canvas");
      return nil;
    }
  };
}).call(this);
