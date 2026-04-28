/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/*") // Esto protege TODA la aplicación
public class WafFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    
    java.util.Enumeration<String> params = request.getParameterNames();
    while (params.hasMoreElements()) {
        String name = params.nextElement();
        String value = request.getParameter(name).toLowerCase();
        
        String tipoAtaque = "";
        String nivel = "";

        // Detectar tipo de ataque
        if (value.contains("<script>")) {
            tipoAtaque = "XSS (Cross Site Scripting)";
            nivel = "ALTA";
        } else if (value.contains("drop table") || value.contains("' or '1'='1")) {
            tipoAtaque = "Inyección SQL";
            nivel = "CRÍTICA";
        }

        // Si se detectó algo, guardamos en la bitácora y bloqueamos
        if (!tipoAtaque.equals("")) {
            try {
                // Conexión rápida para la bitácora
                Class.forName("com.mysql.jdbc.Driver");
                java.sql.Connection con = java.sql.DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/db_seguridad_personal", "root", "");
                java.sql.PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO bitacora_waf(tipo_ataque, descripcion_intento, nivel_amenaza) VALUES(?,?,?)");
                ps.setString(1, tipoAtaque);
                ps.setString(2, "Intento en campo '" + name + "' con valor: " + value);
                ps.setString(3, nivel);
                ps.executeUpdate();
                con.close();
            } catch (Exception e) {
                System.out.println("Error al registrar bitácora: " + e);
            }

            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<h1 style='color:red;'>BLOQUEO DE SEGURIDAD WAF</h1>");
            response.getWriter().write("<p>Se ha detectado una amenaza: <b>" + tipoAtaque + "</b></p>");
            response.getWriter().write("<p>Tu intento ha sido registrado en nuestra bitácora de seguridad.</p>");
            response.getWriter().write("<a href='Controlador?accion=listar'>Regresar</a>");
            return;
        }
    }
    chain.doFilter(request, response);
    }

    public void destroy() {}
    public void init(javax.servlet.FilterConfig filterConfig) {}
}