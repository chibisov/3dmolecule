jQuery ->
  init_figure()

init_figure = () ->
  canvas = document.getElementById('canvas_board')
  canvas_context = get_canvas_context(canvas)
  
  molecule = new Molecule(canvas_context=canvas_context)
  
  # init events
      
  $("#form_params").bind "submit", (e) =>
    e.preventDefault()
    
    data =
      "rotate":
        "x": Number $(".to_rotate input[name=coord_x]").val()
        "y": Number $(".to_rotate input[name=coord_y]").val()
        "z": Number $(".to_rotate input[name=coord_z]").val()
        
      "offset":
        "x": Number $(".to_offset input[name=coord_x]").val()
        "y": Number $(".to_offset input[name=coord_y]").val()
        "z": Number $(".to_offset input[name=coord_z]").val()
        
      "scale":
        "x": Number $(".to_scale input[name=coord_x]").val()
        "y": Number $(".to_scale input[name=coord_y]").val()
        "z": Number $(".to_scale input[name=coord_z]").val()
    
    molecule.rotate(x=data["rotate"]["x"], 
                    y=data["rotate"]["y"], 
                    z=data["rotate"]["z"])

    molecule.offset(x=data["offset"]["x"], 
                    y=data["offset"]["y"], 
                    z=data["offset"]["z"])
                    
    molecule.scale(x=data["scale"]["x"], 
                    y=data["scale"]["y"], 
                    z=data["scale"]["z"])
                    
    canvas_context.clear()
    molecule.render()
    
  $("#reset_settings").click ->
    $("input[name^=coord_]").val(0)
  
  $("#set_to_default_position").click ->
    molecule = new Molecule(canvas_context=canvas_context)
    
    canvas_context.clear()
    molecule.render()
  
  interval_id = ""  
  $("#animate").change ->
    if this.checked
      interval_id = setInterval( ->
        canvas_context.clear()
        molecule.rotate(x=5, y=5, z=0)
        molecule.render()
      , 500)
    else
      if interval_id
        clearInterval(interval_id)
  $("#animate").trigger "change"
    
  $("#form_params").trigger "submit"
  
  # $(".canvas_map").click( =>
  #   canvas_context.clear()
  #   molecule.rotate(x=10, y=0, z=0)
  #   molecule.render()
  # )
  # 


get_canvas_context = (canvas_element) ->
  if canvas_element.getContext
    canvas_context = canvas_element.getContext('2d')
    canvas_context.translate(canvas_element.width / 2, 
                             canvas_element.height / 2) # set grig to center
    return canvas_context
  else
    alert("Ваш браузер не поддерживает canvas")
    return nil