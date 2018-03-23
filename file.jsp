<%-- 
    Document   : index
    Created on : Mar 17, 2018, 9:15:32 PM
    Author     : MICHAEL
--%>

<%@page import="java.io.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FileUpload tryout</title>
    </head>
    <body>
        </form>
        <form name="uploadForm" action="file.jsp" method="POST" enctype="multipart/form-data">
            <%
                String saveFile = new String ();
                String contentType = request.getContentType();
                if((contentType!=null)&&(contentType.indexOf("multipart/form-data") >= 0)){
                    DataInputStream in = new DataInputStream(request.getInputStream());
                    int formatDataLength=request.getContentLength();
                    byte dataByte[] = new byte[formatDataLength];
                    int byteRead = 0;
                    int totalBytesRead = 0;
                    while(totalBytesRead < formatDataLength){
                        byteRead = in.read(dataByte, totalBytesRead,formatDataLength);
                        totalBytesRead+=byteRead;
                        
                    }
                    String file =new String(dataByte);
                    System.out.println(saveFile);
                    saveFile = file.substring(file.indexOf("filename=\"")+10);
                    System.out.println(saveFile);
                    saveFile = saveFile.substring(0,saveFile.indexOf("\n"));
                    System.out.println(saveFile);
                    saveFile = saveFile.substring(saveFile.lastIndexOf("\\")+1,saveFile.indexOf("\""));
                    System.out.println(saveFile);
                    
                    int lastIndex = contentType.lastIndexOf("=");
                    
                    String boundary  = contentType.substring(lastIndex + 1,contentType.length());
                  
                  int pos;
                  pos = file.indexOf("file=\"");
                  pos = file.indexOf("\n",pos) + 1;
                  pos = file.indexOf("\n",pos)+ 1;
                  pos = file.indexOf("\n",pos)+ 1;
                  pos = file.indexOf("\n",pos)+ 1;
                  
                  int boundaryLocation = file.indexOf(boundary,pos) - 4;
                  int startPos = (file.substring(0,pos).getBytes()).length;
                  int endPos = ((file.substring(0,boundaryLocation)).getBytes()).length;
                  String [] folder = saveFile.split("\\.");
                  System.out.println(folder[0]);
                 
                  String folderFinal = "C:/uploaddir/"+folder[0];
                  String filedata = "C:/uploaddir/"+folder[0]+"/"+saveFile;
                  File ff = new File(folderFinal); 
                  File imagegreat = new File(filedata);
                  
                  
                  
                  try{
                      if(!ff.exists()){
                          //// creating the directory
                          try{
                              ff.mkdir();
                              FileOutputStream fileOut = new FileOutputStream (imagegreat);
                              fileOut.write(dataByte,startPos,(endPos-startPos));
                              fileOut.flush();
                              fileOut.close();
                          }
                          catch(Exception ex){
                              System.out.println(ex.getMessage());
                          }
                      }else{
                          filedata = "C:/uploaddir/"+folder[0]+"/"+saveFile;
                          System.out.println(filedata);
                          imagegreat = new File(filedata);
                          FileOutputStream fileOut = new FileOutputStream (imagegreat);
                          fileOut.write(dataByte,startPos,(endPos-startPos));
                          fileOut.flush();
                          fileOut.close();
                          

                      }
                  }catch(Exception ex){
                     System.err.println("an error occured ");
                  }
                  
               } else {
                    System.out.println("dead end");  
            }
            %>
            <input type="file" name="file" value="" width="200" />
            <input type="submit" value="submit" name="submit" />
    </body>
  
</html>
