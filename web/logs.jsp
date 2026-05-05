<%-- 
    Document   : logs
    Created on : 28/04/2026, 11:51:23 AM
    Author     : PC-13
--%>

<%@page import="modelo.Bitacora"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Auditoría de Seguridad - Shield Lozada</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-dark text-white">
        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>🛡️ Bitácora de Seguridad (WAF Alerts)</h2>
                <a href="Controlador?accion=listar" class="btn btn-outline-light">Volver al Inicio</a>
            </div>
            
            <p class="text-secondary">Intentos de intrusión detectados y bloqueados por el filtro de seguridad.</p>
            
            <table class="table table-dark table-hover table-striped shadow">
                <thead class="table-danger">
                    <tr>
                        <th>ID</th>
                        <th>Tipo de Ataque</th>
                        <th>Descripción del Intento</th>
                        <th>Nivel de Amenaza</th>
                        <th>Fecha y Hora</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Recuperamos la lista que envió el controlador
                        List<Bitacora> ataques = (List<Bitacora>) request.getAttribute("listaAtaques");
                        if (ataques != null) {
                            for (Bitacora a : ataques) {
                    %>
                    <tr>
                        <td><%= a.getId() %></td>
                         <td><span class="badge bg-warning text-dark"><%= a.getTipoAtaque() %></span></td>
                        <td><code><%= a.getDescripcion() %></code></td>
                        <td>
                            <span class="text-danger fw-bold"><%= a.getNivelAmenaza() %></span>
                        </td>
                        <td><%= a.getFecha() %></td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-center">No se han detectado ataques recientes.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </body>
</html>