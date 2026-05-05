<%-- 
    Document   : conexion
    Created on : 21/04/2026, 01:22:24 PM
    Author     : PC-27
--%>

<%@ page import="java.sql.*" %>

<%
Connection con = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost/bdasifinal",
        "root",
        ""
    );
} catch(Exception e){
    out.println("Error conexión: " + e);
}
%>