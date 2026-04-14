<%-- 
    Document   : editar
    Created on : 14/04/2026, 10:56:49 AM
    Author     : PC-13
--%>

<%@page import="modelo.Consejo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Registro</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow">
                        <div class="card-header bg-warning">Actualizar Información</div>
                        <div class="card-body">
                            <% Consejo c = (Consejo) request.getAttribute("consejo"); %>
                            <form action="Controlador" method="POST">
                                <input type="hidden" name="txtId" value="<%= c.getId() %>">
                                <div class="mb-3">
                                    <label>Título:</label>
                                    <input type="text" name="txtTitulo" value="<%= c.getTitulo() %>" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label>Categoría:</label>
                                    <input type="text" name="txtCategoria" value="<%= c.getCategoria() %>" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label>Descripción:</label>
                                    <textarea name="txtDesc" class="form-control"><%= c.getDescripcion() %></textarea>
                                </div>
                                <div class="mb-3">
                                    <label>Nivel de Riesgo:</label>
                                    <input type="text" name="txtRiesgo" value="<%= c.getNivel_riesgo() %>" class="form-control">
                                </div>
                                <input type="submit" name="accion" value="Actualizar" class="btn btn-primary w-100">
                                <a href="Controlador?accion=listar" class="btn btn-secondary w-100 mt-2">Cancelar</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>