class UploadSchema {
  static String uploadJson = r""" 
 mutation ($name: String!, $type: String!, $basestr64:String! ) {
  uploadfile( name:$name, type: $type ,basestr64: $basestr64) {
    file_path
  }
}

    """;
}
