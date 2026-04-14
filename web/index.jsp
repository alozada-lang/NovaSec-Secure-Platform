<%-- 
    Document   : index
    Created on : 14/04/2026, 10:45:29 AM
    Author     : PC-13
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Consejo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seguridad Informática Personal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <h2 class="text-center mb-4">Plataforma de Seguridad Informática Personal</h2>
            
            <div class="row">
                <div class="col-md-4">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">Nuevo Consejo/Tip</div>
                        <div class="card-body">
                            <form action="Controlador" method="POST">
                                <div class="mb-3">
                                    <label>Título:</label>
                                    <input type="text" name="txtTitulo" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label>Categoría:</label>
                                    <select name="txtCategoria" class="form-select">
                                        <option>Tip Técnico</option>
                                        <option>Legislación</option>
                                        <option>Consejo Personal</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label>Descripción:</label>
                                    <textarea name="txtDesc" class="form-control" rows="3" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label>Nivel de Riesgo:</label>
                                    <select name="txtRiesgo" class="form-select">
                                        <option>Bajo</option>
                                        <option>Medio</option>
                                        <option>Alto</option>
                                        <option>Crítico</option>
                                    </select>
                                </div>
                                <input type="submit" name="accion" value="Agregar" class="btn btn-success w-100">
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card shadow">
                        <div class="card-header bg-dark text-white">Listado de Consejos y Legislación</div>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>TÍTULO</th>
                                        <th>CATEGORÍA</th>
                                        <th>DESCRIPCIÓN</th>
                                        <th>RIESGO</th>
                                        <th>ACCIONES</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<Consejo> lista = (List<Consejo>) request.getAttribute("lista");
                                        if (lista != null) {
                                            for (Consejo c : lista) {
                                    %>
                                    <tr>
                                        <td><%= c.getId()%></td>
                                        <td><%= c.getTitulo()%></td>
                                        <td><%= c.getCategoria()%></td>
                                        <td><%= c.getDescripcion()%></td>
                                        <td><span class="badge bg-info text-dark"><%= c.getNivel_riesgo()%></span></td>
                                        <td>
                                            <a href="Controlador?accion=editar&id=<%= c.getId()%>" class="btn btn-warning btn-sm">Editar</a>
                                            <a href="Controlador?accion=eliminar&id=<%= c.getId()%>" class="btn btn-danger btn-sm" onclick="return confirm('¿Seguro?')">Borrar</a>
                                        </td>
                                    </tr>
                                    <% } } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>