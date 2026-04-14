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
        
        // Obtenemos todos los datos que el usuario envía
        java.util.Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String name = params.nextElement();
            String value = request.getParameter(name).toLowerCase();
            
            // Si detecta palabras de inyección SQL o XSS, bloquea
            if (value.contains("<script>") || value.contains("drop table") || value.contains("' or '1'='1")) {
                response.getWriter().write("<h1>Bloqueado por WAF: Intento de ataque detectado</h1>");
                return;
            }
        }
        chain.doFilter(request, response);
    }

    public void destroy() {}
    public void init(javax.servlet.FilterConfig filterConfig) {}
}