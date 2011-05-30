# расширяем стандартный контекст своим методом
CanvasRenderingContext2D::add_point = (x, y, color="rgb(255, 255, 255)") ->
  # draws pixel at (x, y) coordinates
  this.fillStyle = color
  this.fillRect(x, y, 1, 1)
  this
CanvasRenderingContext2D::clear = () ->
  # cleares canvas
  canvas = this.canvas
  this.clearRect(-canvas.width / 2 , 
                 -canvas.height / 2, 
                 canvas.width, 
                 canvas.height );
  this

class Point
  constructor: (x, y, z=nil) ->
    @coordinates = []
    @coordinates.x = x
    @coordinates.y = y
    @coordinates.z = z
    
class PointsCollection
  constructor:(@color) ->
    @points = []
  
  rotate:(x=0, y=0, z=0) ->  
    # rotates collection
    koef = 3.1
    [x_degrees, y_degrees, z_degrees] = [koef*x/180, koef*y/180, koef*z/180]
    # [x_degrees, y_degrees, z_degrees] = [x/180, y/180, z/180]
    
    for point in @points
      if x_degrees != 0
        y_temp = point.coordinates.y
        point.coordinates.y = (point.coordinates.y * Math.cos(x_degrees)) - (point.coordinates.z * Math.sin(x_degrees))
        point.coordinates.z = (y_temp * Math.sin(x_degrees)) + (point.coordinates.z * Math.cos(x_degrees))
        
      if y_degrees != 0
        x_temp = point.coordinates.x
        point.coordinates.x = (point.coordinates.x * Math.cos(y_degrees)) + (point.coordinates.z * Math.sin(y_degrees))
        point.coordinates.z = (point.coordinates.z * Math.cos(y_degrees)) - (Math.sin(y_degrees) * x_temp)
        
      if z_degrees != 0
        x_temp = point.coordinates.x
        point.coordinates.x = (point.coordinates.x * Math.cos(z_degrees)) - (point.coordinates.y * Math.sin(z_degrees))
        point.coordinates.y = (x_temp * Math.sin(z_degrees)) + (point.coordinates.y * Math.cos(z_degrees))
  
  scale:(x=0, y=0, z=0) ->
    # scales by axis. Params should be in percents
    [x_percents, y_percents, z_percents] = [(x/100), (y/100), (z/100)]
    
    for point in @points
      if x_percents != 0
        point.coordinates.x = point.coordinates.x * x_percents
      if y_percents != 0
        point.coordinates.y = point.coordinates.y * y_percents
      if z_percents != 0
        point.coordinates.z = point.coordinates.z * z_percents
        
  offset:(x=0, y=0, z=0) ->
    # offset points
    [x_offset, y_offset, z_offset] = [x, y, z]
    for point in @points
      if x_offset != 0
        point.coordinates.x = point.coordinates.x + x_offset
      if y_offset != 0
        point.coordinates.y = point.coordinates.y + y_offset
      if z_offset != 0
        point.coordinates.z = point.coordinates.z + z_offset
    
    # if z_offset != 0
      # this.scale(x=50, y=50, z=50)
        
  render: (canvas_context)->
    # renders points to canvas
    for point in @points
      canvas_context.add_point(point.coordinates.x, point.coordinates.y, @color)
      
class Shape extends PointsCollection
  constructor:(@options) ->
    super color=@options["color"]
    this.init_points()
    
  init_points: ->
    for u in [0..10] by 0.4
      for v in [0..@options["height"]]
        [x, y, z] = this.coordinates_from_functions(u, v)
        point = new Point(x, y, z)
        this.points.push(point)
        
  coordinates_from_functions: ->
    # every Shape object should specify it's own method
      
class window.Ellipsoid extends Shape
  # site - http://www.wolframalpha.com/input/?i=Ellipsoid
  # example 
  #   ellips = new Ellipsoid( 
  #                         {
  #                           "radius_x": 100
  #                           "radius_y": 100
  #                           "radius_z": 100
  #                           "color":    "#6fccff"
  #                           "height":   360
  #                         })

  coordinates_from_functions: (u, v) ->
    [a, b, c] = [@options["radius_x"], @options["radius_y"], @options["radius_z"]]
    x = a*Math.sin(u) * Math.cos(v) 
    y = b*Math.sin(u) * Math.sin(v)
    z = c*Math.cos(u)
    
    return [x, y, z]
    
class window.EllipticCylinder extends Shape
  # site - http://www.wolframalpha.com/input/?i=elliptic+cylinder
  # example
  #   elliptic_cylinder_2 = new EllipticCylinder( 
  #                         {
  #                           "radius_x": 50
  #                           "radius_y": 50
  #                           "height":   300
  #                           "color":    "red"
  #                         })
  coordinates_from_functions: (u, v) ->
    [a, b, c] = [@options["radius_x"], @options["radius_y"]]
    x = Math.cos(u) * a 
    y = Math.sin(u) * b
    z = v

    return [x, y, z]
    
    
class ShapesCollection
  # collection of shapes
  constructor:(@shapes, @canvas_context) ->
    @shapes or= []
    
  render: ->
    # renders all shapes
    for shape in @shapes
      shape.render(canvas_context=@canvas_context)
      
  rotate:(x=0, y=0, z=0) ->
    # scale figure
    for shape in @shapes
      shape.rotate(x, y, z)
      
  scale:(x=0, y=0, z=0) ->
    # scale figure
    for shape in @shapes
      shape.scale(x, y, z)
  
  offset:(x=0, y=0, z=0) ->
    # offset figure
    for shape in @shapes
      shape.offset(x, y, z)
    
class window.Figure extends ShapesCollection
  
class window.FigureCollection
  constructor: (@figures=[], @canvas_context) ->
    # pass
    
  render: ->
    for figure in @figures
      for shape in figure.shapes
        shape.render(@canvas_context)
        
  rotate:(x, y, z) ->
    for figure in @figures
      for shape in figure.shapes
        shape.rotate(x, y, z)
      
  offset:(x, y, z) ->
    for figure in @figures
      for shape in figure.shapes
        shape.offset(x, y, z)
        
  scale:(x, y, z) ->
    for figure in @figures
      for shape in figure.shapes
        shape.scale(x, y, z)
      
      