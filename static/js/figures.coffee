class window.MoleculeLeg extends Figure
  constructor: (@options) ->
    head = new Ellipsoid({
      "radius_x": @options["head"]["radius"]
      "radius_y": @options["head"]["radius"]
      "radius_z": @options["head"]["radius"]
      "color":    @options["head"]["color"]
      "height":   500
    })
    # head_2 = new Ellipsoid({
    #   "radius_x": @options["head"]["radius"]
    #   "radius_y": @options["head"]["radius"]
    #   "radius_z": @options["head"]["radius"]
    #   "color":    @options["head"]["color"]
    #   "height":   500
    # })
    leg = new EllipticCylinder( {
      "radius_x": @options["leg"]["radius"]
      "radius_y": @options["leg"]["radius"]
      "height":   @options["leg"]["height"]
      "color":    @options["leg"]["color"] or @options["head"]["color"]
    })
    leg_z_offset = @options["head"]["radius"] - @options["leg"]["radius"] / 3
    
    leg.offset(x=0, y=0, z=leg_z_offset)
    # head_2.rotate(x=0, y=90, z=0)
    
    @shapes = [
      head
      # head_2
      leg
    ]
    
class window.Molecule extends FigureCollection
  constructor: (@canvas_context) ->
    molecule_leg_options =
      "head":
        "radius": 30
        "color":  "rgba(111, 204, 255, 0.1)"
      "leg":
        "radius": 10
        "height": 90
    
    colorize = false
    colorize = true
    
    # create 3 legs
    @figures = []
    for i in [0..11]
      if colorize
        switch i
          when 0 then molecule_leg_options["head"]["color"] = "rgba(111, 204, 255, 0.1)"
          when 1 then molecule_leg_options["head"]["color"] = "rgba(255, 255, 0, 0.1)"
          when 2 then molecule_leg_options["head"]["color"] = "rgba(255, 0, 0, 0.1)"
          when 3 then molecule_leg_options["head"]["color"] = "rgba(134, 255, 0, 0.1)"
          when 4 then molecule_leg_options["head"]["color"] = "rgba(134, 0, 255, 0.1)"
          when 5 then molecule_leg_options["head"]["color"] = "rgba(255, 181, 40, 0.1)"
      if i > 5
        # heads begins
        molecule_leg_options["head"]["color"] = "rgba(255, 255, 255, 0.1)"
        molecule_leg_options["head"]["radius"] = 25
        molecule_leg_options["leg"]["radius"] = 7
        molecule_leg_options["leg"]["height"] = 50
      
      molecule_leg = new MoleculeLeg(molecule_leg_options, 
                                     canvas_context=canvas_context)
      @figures.push(molecule_leg)
    
    # rotate
    @figures[0].rotate(x=90, y=0, z=60)   # blue
    @figures[6].rotate(x=90, y=0, z=135)  # blue head
    
    @figures[4].rotate(x=-90, y=0, z=-60) # fiolet
    @figures[7].rotate(x=-90, y=0, z=0)  # fiolet head
    
    @figures[1].rotate(x=-90, y=0, z=0)   # yellow
    @figures[8].rotate(x=-90, y=0, z=45)   # yellow head
    
    @figures[3].rotate(x=-90, y=0, z=60)  # green
    @figures[9].rotate(x=90, y=0, z=-45)  # green head
    
    @figures[5].rotate(x=90, y=0, z=-60)  # orange
    @figures[10].rotate(x=90, y=0, z=0)  # orange head
    
    @figures[2].rotate(x=90, y=0, z=0)    # red
    @figures[11].rotate(x=90, y=0, z=45)   # red head    
    
    # offset
    @figures[0].offset(x=-120, y=-70,  z=0) # blue
    @figures[6].offset(x=-197, y=-138, z=0) # blue head
    
    @figures[4].offset(x=0,    y=-140, z=0) # fiolet
    @figures[7].offset(x=0, y=-241, z=0)    # fiolet head
    
    @figures[1].offset(x=120,  y=-70,  z=0) # yellow
    @figures[8].offset(x=197, y=-138, z=0)    # yellow head
    
    @figures[3].offset(x=120,  y=70,   z=0) # green
    @figures[9].offset(x=195, y=140, z=0)    # yellow head
    
    @figures[5].offset(x=0,    y=140, z=0)  # orange
    @figures[10].offset(x=0, y=241, z=0)    # orange head
    
    @figures[2].offset(x=-120, y=70,   z=0) # red
    @figures[11].offset(x=-195, y=140, z=0)  # red head