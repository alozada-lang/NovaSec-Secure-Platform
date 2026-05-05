<%@page import="java.sql.*"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. Recibir la URL del formulario de escaneo
    String url = request.getParameter("url");

    // Validar que la URL no llegue vacía
    if (url != null && !url.isEmpty()) {
        
        // --- 2. SIMULACIÓN DEL MOTOR DE ESCANEO ---
        // Generamos datos aleatorios para simular un análisis real de seguridad
        Random rand = new Random();
        
        String[] vulnes = {
            "Inyección SQL (SQLi) detectada", 
            "XSS Reflejado en parámetro URL", 
            "Puerto 8080 (Proxy) Abierto", 
            "Falta de Certificado SSL/TLS",
            "Directorio Sensible Expuesto (/config)",
            "Configuración de Seguridad CORS Débil"
        };
        
        String[] riesgos = {"Alto", "Alto", "Medio", "Bajo", "Medio", "Bajo"};
        int[] puertos = {80, 443, 8080, 3306, 21, 22};
        
        // Seleccionamos un índice aleatorio para la vulnerabilidad y el riesgo
        int indexAleatorio = rand.nextInt(vulnes.length);
        
        String vulnerabilidadSimulada = vulnes[indexAleatorio];
        String riesgoSimulado = riesgos[indexAleatorio];
        int puertoSimulado = puertos[rand.nextInt(puertos.length)];
        // ------------------------------------------

        try {
            // 3. Incluir la conexión (Asegúrate que 'con' esté definido en conexion.jsp)
%>
            <%@ include file="conexion.jsp" %>
<%
            // 4. Preparar la consulta SQL de inserción
            String sql = "INSERT INTO dsa (url, puerto, vulnerabilidad, riesgo) VALUES (?, ?, ?, ?)";
            
            // 5. Usar PreparedStatement para enviar los datos de forma segura
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, url);
            ps.setInt(2, puertoSimulado);
            ps.setString(3, vulnerabilidadSimulada);
            ps.setString(4, riesgoSimulado);
            
            // 6. Ejecutar la operación en la base de datos
            int resultado = ps.executeUpdate();
            
            // 7. Cerrar recursos y redirigir si todo salió bien
            ps.close();
            con.close();
            
            if (resultado > 0) {
                response.sendRedirect("listar_vulne.jsp");
            } else {
                out.println("No se pudo insertar el registro.");
            }

        } catch (Exception e) {
            // Si hay un error (ej. nombre de tabla mal escrito), aquí te dirá qué es
            out.println("<h3>Error en el proceso de guardado:</h3>");
            out.println("<p style='color:red'>" + e.getMessage() + "</p>");
            out.println("<a href='insertar_vulne.jsp'>Volver a intentar</a>");
        }
    } else {
        // Si el usuario entró a guardar.jsp sin pasar por el formulario
        response.sendRedirect("insertar_vulne.jsp");
    }
%>