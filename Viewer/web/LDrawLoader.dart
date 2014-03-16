library LDRAW_LOADER;

import 'dart:html';
import 'dart:math' as math;

import 'ldraw.dart';
import 'viewer.dart';

class LDrawLoader{
  static Map<String,LDrawFileContent> cache = new Map<String,LDrawFileContent>();
  
  int files_loaded = 0;
  int files_failed = 0;
  int files_needed = 0;
  int total_file_size = 0;
  
  LDrawFile file;
  LDrawWidget viewer;
  
  LDrawLoader( String filename, [this.viewer=null] ){
    file = new LDrawFile( filename );
    load_file( file, true );
  }
  
  bool containsFolder( String path, String folder ){
    return path.startsWith( folder + "/" ) || path.startsWith( folder + "\\" );
  }
  
  List<String> standardLibraries( String filename ){
    //Parts last if more than 2 letters ( +3 for ".dat" )
    int letter_count = 0;
    for( int i=0; i<filename.length; i++ )
      if( filename[i].toUpperCase() != filename[i].toLowerCase() )
        letter_count++;
    bool p_first = letter_count > 5;
    
    //Use subfolders as a more precise estimation, if available
    if( containsFolder( filename, 's' ) )
      p_first = false;
    else if( containsFolder( filename, '48' ) || containsFolder( filename, '8' ) )
      p_first = true;
    
    List<String> paths = [
        "ldraw/parts/" + filename
      , "ldraw/p/" + filename
      , "ldraw/models/" + filename
      ];
    
    //Swap 'p/' and 'parts/'
    if( p_first )
      paths.insert( 0, paths.removeAt(1) );
    
    return paths;
  }
  
  void load_file( LDrawFile load, [bool local=false] ){
    String filename = load.name;
    if( cache.containsKey( filename ) )
      load.content = cache[filename];
    else{
      load.content = new LDrawFileContent();
      cache[filename] = load.content;
      files_needed++;

      List<String> names = standardLibraries( filename );
      if( local )
        names.insert( 0, filename );
      
      load_ldraw_list( names, filename );
    }
  }

  void load_ldraw_list( List<String> names, String name ){
    String try_load = names.removeAt(0);
    HttpRequest.getString( try_load )
    .then( (content){
      cache[name].init( content, this );
      total_file_size += content.length;
      files_loaded++;
      update_progress();
    } )
    .catchError( (onError){
      if( names.length > 0 )
        load_ldraw_list( names, name );
      else{
        print( "Could not retrive file: " + name + " :\\" );
        files_failed++;
        update_progress();
      }
    } );
  }
  
  void update_progress(){
    if( files_loaded + files_failed >= files_needed && viewer != null )
      viewer.show( file );
    //TODO: show progress
  }
}