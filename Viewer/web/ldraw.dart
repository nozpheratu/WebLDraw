library LDRAW;

import 'dart:typed_data';

import 'package:vector_math/vector_math.dart';

import 'MeshModel.dart';
import 'LDrawLoader.dart';

class LDrawColor{
  int r, g, b; //Main color
  int er, eg, eb; //Edge color
  int alpha = 255;
  //Not supported:
  //Luminance
  //Materials
  
  LDrawColor( this.r, this.g, this.b, this.er, this.eg, this.eb, [this.alpha=255] );
}
class LDrawColorIndex{
  //TODO: this makes new colors work for the entire file, we only want it for the remaining of the file!
  Map<int,LDrawColor> colors = new Map<int,LDrawColor>();
  LDrawColorIndex(){
    colors = new Map<int,LDrawColor>();
  }
  
  LDrawColorIndex combine( LDrawColorIndex parent ){
    LDrawColorIndex combined = new LDrawColorIndex();
    combined.colors.addAll(parent.colors);
    combined.colors.addAll(colors);
    return combined;
  }
  
  LDrawColor lookUp( int index ){
    if( colors.containsKey( index ) )
      return colors[index];
    else
      return colors[0]; //Note: black must be defined
      //TODO: throw exception instead?
  }
  
  LDrawColorIndex.officialColors(){
    colors = {
0: new LDrawColor( 5, 19, 29, 89, 89, 89, 255 ),
1: new LDrawColor( 0, 85, 191, 51, 51, 51, 255 ),
2: new LDrawColor( 37, 122, 62, 51, 51, 51, 255 ),
3: new LDrawColor( 0, 131, 143, 51, 51, 51, 255 ),
4: new LDrawColor( 201, 26, 9, 51, 51, 51, 255 ),
5: new LDrawColor( 200, 112, 160, 51, 51, 51, 255 ),
6: new LDrawColor( 88, 57, 39, 30, 30, 30, 255 ),
7: new LDrawColor( 155, 161, 157, 51, 51, 51, 255 ),
8: new LDrawColor( 109, 110, 92, 51, 51, 51, 255 ),
9: new LDrawColor( 180, 210, 227, 51, 51, 51, 255 ),
10: new LDrawColor( 75, 159, 74, 51, 51, 51, 255 ),
11: new LDrawColor( 85, 165, 175, 51, 51, 51, 255 ),
12: new LDrawColor( 242, 112, 94, 51, 51, 51, 255 ),
13: new LDrawColor( 252, 151, 172, 51, 51, 51, 255 ),
14: new LDrawColor( 242, 205, 55, 51, 51, 51, 255 ),
15: new LDrawColor( 255, 255, 255, 51, 51, 51, 255 ),
17: new LDrawColor( 194, 218, 184, 51, 51, 51, 255 ),
18: new LDrawColor( 251, 230, 150, 51, 51, 51, 255 ),
19: new LDrawColor( 228, 205, 158, 51, 51, 51, 255 ),
20: new LDrawColor( 201, 202, 226, 51, 51, 51, 255 ),
22: new LDrawColor( 129, 0, 123, 51, 51, 51, 255 ),
23: new LDrawColor( 32, 50, 176, 30, 30, 30, 255 ),
25: new LDrawColor( 254, 138, 24, 51, 51, 51, 255 ),
26: new LDrawColor( 146, 57, 120, 51, 51, 51, 255 ),
27: new LDrawColor( 187, 233, 11, 51, 51, 51, 255 ),
28: new LDrawColor( 149, 138, 115, 51, 51, 51, 255 ),
29: new LDrawColor( 228, 173, 200, 51, 51, 51, 255 ),
30: new LDrawColor( 172, 120, 186, 51, 51, 51, 255 ),
31: new LDrawColor( 225, 213, 237, 51, 51, 51, 255 ),
68: new LDrawColor( 243, 207, 155, 51, 51, 51, 255 ),
69: new LDrawColor( 205, 98, 152, 51, 51, 51, 255 ),
70: new LDrawColor( 88, 42, 18, 89, 89, 89, 255 ),
71: new LDrawColor( 160, 165, 169, 51, 51, 51, 255 ),
72: new LDrawColor( 108, 110, 104, 51, 51, 51, 255 ),
73: new LDrawColor( 92, 157, 209, 51, 51, 51, 255 ),
74: new LDrawColor( 115, 220, 161, 51, 51, 51, 255 ),
77: new LDrawColor( 254, 204, 207, 51, 51, 51, 255 ),
78: new LDrawColor( 246, 215, 179, 51, 51, 51, 255 ),
84: new LDrawColor( 204, 112, 42, 51, 51, 51, 255 ),
85: new LDrawColor( 63, 54, 145, 30, 30, 30, 255 ),
86: new LDrawColor( 124, 80, 58, 51, 51, 51, 255 ),
89: new LDrawColor( 76, 97, 219, 51, 51, 51, 255 ),
92: new LDrawColor( 208, 145, 104, 51, 51, 51, 255 ),
100: new LDrawColor( 254, 186, 189, 51, 51, 51, 255 ),
110: new LDrawColor( 67, 84, 163, 51, 51, 51, 255 ),
112: new LDrawColor( 104, 116, 202, 51, 51, 51, 255 ),
115: new LDrawColor( 199, 210, 60, 51, 51, 51, 255 ),
118: new LDrawColor( 179, 215, 209, 51, 51, 51, 255 ),
120: new LDrawColor( 217, 228, 167, 51, 51, 51, 255 ),
125: new LDrawColor( 249, 186, 97, 51, 51, 51, 255 ),
151: new LDrawColor( 230, 227, 224, 51, 51, 51, 255 ),
191: new LDrawColor( 248, 187, 61, 51, 51, 51, 255 ),
212: new LDrawColor( 134, 193, 225, 51, 51, 51, 255 ),
216: new LDrawColor( 179, 16, 4, 51, 51, 51, 255 ),
226: new LDrawColor( 255, 240, 58, 51, 51, 51, 255 ),
232: new LDrawColor( 86, 190, 214, 51, 51, 51, 255 ),
272: new LDrawColor( 13, 50, 91, 30, 30, 30, 255 ),
288: new LDrawColor( 24, 70, 50, 89, 89, 89, 255 ),
308: new LDrawColor( 53, 33, 0, 89, 89, 89, 255 ),
313: new LDrawColor( 84, 169, 200, 51, 51, 51, 255 ),
320: new LDrawColor( 114, 14, 15, 51, 51, 51, 255 ),
321: new LDrawColor( 20, 152, 215, 51, 51, 51, 255 ),
322: new LDrawColor( 62, 194, 221, 51, 51, 51, 255 ),
323: new LDrawColor( 189, 220, 216, 51, 51, 51, 255 ),
326: new LDrawColor( 223, 238, 165, 51, 51, 51, 255 ),
330: new LDrawColor( 155, 154, 90, 51, 51, 51, 255 ),
335: new LDrawColor( 214, 117, 114, 51, 51, 51, 255 ),
351: new LDrawColor( 247, 133, 177, 51, 51, 51, 255 ),
366: new LDrawColor( 250, 156, 28, 51, 51, 51, 255 ),
373: new LDrawColor( 132, 94, 132, 51, 51, 51, 255 ),
378: new LDrawColor( 160, 188, 172, 51, 51, 51, 255 ),
379: new LDrawColor( 89, 113, 132, 51, 51, 51, 255 ),
450: new LDrawColor( 182, 123, 80, 51, 51, 51, 255 ),
462: new LDrawColor( 255, 167, 11, 51, 51, 51, 255 ),
484: new LDrawColor( 169, 85, 0, 51, 51, 51, 255 ),
503: new LDrawColor( 230, 227, 218, 51, 51, 51, 255 ),
47: new LDrawColor( 252, 252, 252, 195, 195, 195, 128 ),
40: new LDrawColor( 99, 95, 82, 23, 19, 22, 128 ),
36: new LDrawColor( 201, 26, 9, 136, 0, 0, 128 ),
38: new LDrawColor( 255, 128, 13, 189, 36, 0, 128 ),
57: new LDrawColor( 240, 143, 28, 164, 92, 40, 128 ),
54: new LDrawColor( 218, 176, 0, 195, 186, 63, 128 ),
46: new LDrawColor( 245, 205, 47, 142, 116, 0, 128 ),
42: new LDrawColor( 192, 255, 0, 132, 195, 0, 128 ),
35: new LDrawColor( 86, 230, 70, 157, 168, 107, 128 ),
34: new LDrawColor( 35, 120, 65, 30, 98, 57, 128 ),
33: new LDrawColor( 0, 32, 160, 0, 0, 100, 128 ),
41: new LDrawColor( 85, 154, 183, 25, 105, 115, 128 ),
43: new LDrawColor( 174, 233, 239, 114, 179, 176, 128 ),
39: new LDrawColor( 193, 223, 240, 133, 163, 180, 128 ),
44: new LDrawColor( 150, 112, 159, 90, 52, 99, 128 ),
52: new LDrawColor( 165, 165, 203, 40, 0, 37, 128 ),
37: new LDrawColor( 223, 102, 149, 163, 42, 89, 128 ),
45: new LDrawColor( 252, 151, 172, 168, 113, 140, 128 ),
334: new LDrawColor( 187, 165, 61, 187, 178, 61, 255 ),
383: new LDrawColor( 224, 224, 224, 164, 164, 164, 255 ),
60: new LDrawColor( 100, 90, 76, 40, 30, 16, 255 ),
64: new LDrawColor( 27, 42, 52, 89, 89, 89, 255 ),
61: new LDrawColor( 108, 150, 191, 32, 42, 104, 255 ),
62: new LDrawColor( 60, 179, 113, 0, 119, 53, 255 ),
63: new LDrawColor( 170, 77, 142, 110, 17, 82, 255 ),
183: new LDrawColor( 242, 243, 242, 51, 51, 51, 255 ),
150: new LDrawColor( 187, 189, 188, 51, 51, 51, 255 ),
135: new LDrawColor( 156, 163, 168, 51, 51, 51, 255 ),
179: new LDrawColor( 137, 135, 136, 51, 51, 51, 255 ),
148: new LDrawColor( 87, 88, 87, 51, 51, 51, 255 ),
137: new LDrawColor( 86, 119, 186, 51, 51, 51, 255 ),
142: new LDrawColor( 220, 190, 97, 51, 51, 51, 255 ),
297: new LDrawColor( 204, 156, 43, 51, 51, 51, 255 ),
178: new LDrawColor( 180, 136, 62, 51, 51, 51, 255 ),
134: new LDrawColor( 150, 74, 39, 51, 51, 51, 255 ),
80: new LDrawColor( 165, 169, 180, 51, 51, 51, 255 ),
81: new LDrawColor( 137, 155, 95, 51, 51, 51, 255 ),
82: new LDrawColor( 219, 172, 52, 51, 51, 51, 255 ),
83: new LDrawColor( 26, 40, 49, 51, 51, 51, 255 ),
87: new LDrawColor( 109, 110, 92, 51, 51, 51, 255 ),
79: new LDrawColor( 255, 255, 255, 195, 195, 195, 224 ),
21: new LDrawColor( 224, 255, 176, 164, 195, 116, 250 ),
294: new LDrawColor( 189, 198, 173, 129, 138, 113, 250 ),
114: new LDrawColor( 223, 102, 149, 154, 42, 102, 128 ),
117: new LDrawColor( 255, 255, 255, 195, 195, 195, 128 ),
129: new LDrawColor( 100, 0, 97, 40, 0, 37, 128 ),
132: new LDrawColor( 0, 0, 0, 137, 135, 136, 255 ),
133: new LDrawColor( 0, 0, 0, 219, 172, 52, 255 ),
75: new LDrawColor( 0, 0, 0, 171, 96, 56, 255 ),
76: new LDrawColor( 99, 95, 97, 137, 135, 136, 255 ),
65: new LDrawColor( 245, 205, 47, 51, 51, 51, 255 ),
66: new LDrawColor( 202, 176, 0, 142, 116, 0, 128 ),
67: new LDrawColor( 255, 255, 255, 195, 195, 195, 128 ),
256: new LDrawColor( 33, 33, 33, 89, 89, 89, 255 ),
273: new LDrawColor( 0, 51, 178, 51, 51, 51, 255 ),
324: new LDrawColor( 196, 0, 38, 51, 51, 51, 255 ),
350: new LDrawColor( 208, 102, 16, 51, 51, 51, 255 ),
375: new LDrawColor( 193, 194, 193, 51, 51, 51, 255 ),
406: new LDrawColor( 0, 29, 104, 89, 89, 89, 255 ),
449: new LDrawColor( 129, 0, 123, 51, 51, 51, 255 ),
490: new LDrawColor( 215, 240, 0, 51, 51, 51, 255 ),
496: new LDrawColor( 163, 162, 164, 51, 51, 51, 255 ),
504: new LDrawColor( 137, 135, 136, 51, 51, 51, 255 ),
511: new LDrawColor( 250, 250, 250, 51, 51, 51, 255 ),
16: new LDrawColor( 127, 127, 127, 51, 51, 51, 255 ),
24: new LDrawColor( 127, 127, 127, 51, 51, 51, 255 ),
32: new LDrawColor( 0, 0, 0, 51, 51, 51, 200 ),
493: new LDrawColor( 101, 103, 97, 89, 89, 89, 255 ),
494: new LDrawColor( 208, 208, 208, 51, 51, 51, 255 ),
495: new LDrawColor( 174, 122, 89, 51, 51, 51, 255 ),
      };
  }
}

class LDrawColorId{
  int code = 16;
  LDrawColorId();
  LDrawColorId.parse( String part ){
    code = int.parse( part );
    //TODO: support rgb definition
  }
}

class LDrawContext{
  LDrawColorIndex index = new LDrawColorIndex.officialColors();
  Matrix4 offset = new Matrix4.identity();
  LDrawColor color;
  
  LDrawContext(){
    color = index.lookUp(0);
  }
  LDrawContext.subpart( LDrawContext context, this.color, this.offset ){
    index = context.index;
  }
  LDrawContext.subfile( LDrawContext context, LDrawColorIndex index ){
    offset = context.offset;
    color = context.color;
    this.index = index.combine( context.index );
  }
  
  LDrawColor lookUp( LDrawColorId color_id ){
    if( color_id.code == 16 || color_id.code == 24 )
      return color;
    else
      return index.lookUp( color_id.code );
  }
}

class LDrawFileContent extends LDrawPrimitive{
  LDrawColorIndex color_index = new LDrawColorIndex();
  List<LDrawPrimitive> primitives = new List<LDrawPrimitive>();

  void to_mesh( MeshModel model, LDrawContext context ){
    LDrawContext new_context = new LDrawContext.subfile( context, color_index );
    primitives.forEach( (x) => x.to_mesh( model, new_context ) );
  }
  void init( String content, LDrawLoader loader ){
    try{
    List<String> lines = content.split("\n");
    lines.removeWhere((test)=>test.isEmpty);
    lines.forEach((line){
      List<String> parts = line.trim().split(" ");
      parts.removeWhere((test)=>test.isEmpty); //Note: could mess up file names if they contain spaces 
      
      if( parts.length > 0 )
         switch( parts.removeAt(0) ){
           case '0': parse_comment(parts); break;
           case '1': parse_subfile(parts,loader); break;
           case '2': parse_line(parts); break;
           case '3': parse_triangle(parts); break;
           case '4': parse_quad(parts); break;
           case '5': parse_optional(parts); break;
         }
    });
    }
    catch(object){
      print(object);
    }
  }
  
  Float32List from_string_list( List<String> parts, int start, int amount ){
    Float32List list = new Float32List( amount );
    for( int i=0; i<amount; i++ ){
      list[i]=( double.parse( parts[i+start] ) );
    }
    return list;
  }
  
  List<int> colorFromHex( String hex ){
    if( hex.startsWith( '#' ) )
      hex = hex.substring( 1 );
    else if( hex.startsWith( '0x' ) )
      hex = hex.substring( 2 );
    //TODO: else exception
    
    //TODO: exception if lenght != 6
    
    //Parse
    int r = int.parse( hex.substring(0, 2), radix: 16 ); 
    int g = int.parse( hex.substring(2, 4), radix: 16 ); 
    int b = int.parse( hex.substring(4, 6), radix: 16 );

    return [ r, g, b ];
  }
  void parse_comment(List<String> parts){
    if( parts.length > 0 )
      switch( parts[0] ){
        case "STEP": break;
        case "ROTATION": break;
        case "!COLOUR":
            //TODO: real implementation instead of this shit
            int code = int.parse( parts[3] );
            List<int> main = colorFromHex( parts[5] );
            List<int> edge = colorFromHex( parts[7] );
            int alpha = 255;
            if( parts.length > 9 && parts[8] == "ALPHA" )
              alpha = int.parse( parts[9] );
            color_index.colors[code] = new LDrawColor( main[0], main[1], main[2], edge[0], edge[1], edge[2], alpha );
          break;
        //default: print("comment");
      }
  }
  
  void parse_subfile( List<String> parts, LDrawLoader loader ){
    assert(parts.length >= 14);
    
    LDrawFile sub = new LDrawFile();
    sub.color = new LDrawColorId.parse( parts[0] );
    double x = double.parse( parts[1] );
    double y = double.parse( parts[2] );
    double z = double.parse( parts[3] );
    double a = double.parse( parts[4] );
    double b = double.parse( parts[5] );
    double c = double.parse( parts[6] );
    double d = double.parse( parts[7] );
    double e = double.parse( parts[8] );
    double f = double.parse( parts[9] );
    double g = double.parse( parts[10] );
    double h = double.parse( parts[11] );
    double i = double.parse( parts[12] );
    sub.pos = new Matrix4( a, d, g, 0.0, b, e, h, 0.0, c, f, i, 0.0, x, y, z, 1.0 );
    
    String filepath = parts.sublist(13).join(" ").trim();
    loader.load_file( sub, filepath );
    primitives.add(sub);
  }
  void parse_line(List<String> parts){
    assert(parts.length >= 7);
    
    LDrawLine line = new LDrawLine();
    line.color = new LDrawColorId.parse( parts[0] );
    line.vertices = from_string_list( parts, 1, 6 );
    
    for(int i=0; i<primitives.length; i++)
      if( primitives[i] is LDrawLine ){
        LDrawLine old_line = primitives[i];
        if( old_line.color == line.color ){
          old_line.vertices = combine( old_line.vertices, line.vertices );
          return;
        }
      }
    
    primitives.add(line);
  }
  void parse_triangle(List<String> parts){
    assert(parts.length >= 10);
    
    LDrawTriangle tri = new LDrawTriangle();
    tri.color = new LDrawColorId.parse( parts[0] );
    tri.vertices = from_string_list( parts, 1, 9 );

    primitives.add(tri);
  }
  void parse_quad(List<String> parts){
    assert(parts.length >= 13);
    
    LDrawTriangle quad = new LDrawTriangle();
    quad.color = new LDrawColorId.parse( parts[0] );
    Float32List arr1 = from_string_list( parts, 1, 9 );
    Float32List arr2 = from_string_list( parts, 1+3, 9 );
    for(int i=0; i<3; i++)
      arr2[i] = arr1[i];
    quad.vertices = combine( arr1, arr2 );
    
    primitives.add(quad);
  }
  void parse_optional(List<String> parts){
    assert(parts.length >= 13);
    LDrawOptional opt = new LDrawOptional();
    opt.color = int.parse( parts[0] );
    opt.x1 = double.parse( parts[1] );
    opt.y1 = double.parse( parts[2] );
    opt.z1 = double.parse( parts[3] );
    opt.x2 = double.parse( parts[4] );
    opt.y2 = double.parse( parts[5] );
    opt.z2 = double.parse( parts[6] );
    opt.x3 = double.parse( parts[7] );
    opt.y3 = double.parse( parts[8] );
    opt.z3 = double.parse( parts[9] );
    opt.x4 = double.parse( parts[10] );
    opt.y4 = double.parse( parts[11] );
    opt.z4 = double.parse( parts[12] );
    primitives.add(opt);
  }
}
Float32List combine(Float32List arr1, Float32List arr2){
  Float32List arr = new Float32List( arr1.length + arr2.length );
  for(int i=0; i<arr1.length; i++)
    arr[i] = arr1[i];
  for(int i=0; i<arr2.length; i++)
    arr[i+arr1.length] = arr2[i];
  return arr;
}

class LDrawFile extends LDrawPrimitive{
  LDrawColorId color = new LDrawColorId();
  Matrix4 pos = new Matrix4.identity();
  LDrawFileContent content;

  void to_mesh( MeshModel model, LDrawContext context ){
    Matrix4 new_pos = context.offset.clone().multiply(pos);
    content.to_mesh( model, new LDrawContext.subpart( context, context.lookUp(color), new_pos ) );
  }
}

class LDrawLine extends LDrawPrimitive{
  LDrawColorId color;
  Float32List vertices;

  void to_mesh( MeshModel model, LDrawContext context ){
    LDrawColor c = context.lookUp( color );
    model.add_lines( vertices, context.offset, c.er/255, c.eg/255, c.eb/255, c.alpha/255 );
  }
}

class LDrawTriangle extends LDrawPrimitive{
  LDrawColorId color;
  Float32List vertices;

  void to_mesh( MeshModel model, LDrawContext context ){
    LDrawColor c = context.lookUp( color );
    model.add_triangle( vertices, context.offset, c.r/255, c.g/255, c.b/255, c.alpha/255 );
  }
}

class LDrawQuad extends LDrawPrimitive{
  int color = 16;
  Float32List vertices;

  void to_mesh( MeshModel model, LDrawContext context ){
    print( "not implemented" );
  }
}

class LDrawOptional extends LDrawPrimitive{
  int color = 16;
  double x1 = 0.0, y1 = 0.0, z1 = 0.0;
  double x2 = 0.0, y2 = 0.0, z2 = 0.0;
  double x3 = 0.0, y3 = 0.0, z3 = 0.0;
  double x4 = 0.0, y4 = 0.0, z4 = 0.0;
  
}

abstract class LDrawPrimitive{
  void to_mesh( MeshModel model, LDrawContext context ){ }
}
