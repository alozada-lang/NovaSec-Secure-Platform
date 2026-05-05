<%@page import="java.util.List"%>
<%@page import="modelo.Consejo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NovaSec - Gestión de Tips</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body { 
                background: linear-gradient(135deg, #141e30, #243b55); 
                min-height: 100vh; 
                color: #fff;
                font-family: 'Segoe UI', sans-serif;
            }
            .glass-card {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 15px;
                color: #fff;
            }
            .table-glass {
                color: white;
                background: rgba(0, 0, 0, 0.2);
                border-radius: 15px;
                overflow: hidden;
            }
            .table-glass thead { background: rgba(26, 35, 126, 0.8); }
            .form-control, .form-select {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 8px;
            }
            .btn-back {
                background: rgba(255, 255, 255, 0.1);
                color: white;
                border: 1px solid white;
                transition: 0.3s;
            }
            .btn-back:hover { background: white; color: #141e30; }
            .badge-category { font-size: 0.8rem; padding: 5px 10px; border-radius: 20px; }
        </style>
    </head>
    <body>
        <div class="container py-5">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <a href="indexdos.jsp" class="btn btn-back">
                    <i class="fas fa-chevron-left"></i> Volver al Inicio
                </a>
                <h2 class="text-center fw-bold m-0">
                    <i class="fas fa-lightbulb text-warning"></i> Centro de Inteligencia NovaSec
                </h2>
                <div style="width: 100px;"></div> </div>

            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="card glass-card shadow">
                        <div class="card-header bg-transparent border-bottom border-light py-3">
                            <h5 class="m-0"><i class="fas fa-plus-circle text-info"></i> Nuevo Tip de Seguridad</h5>
                        </div>
                        <div class="card-body">
                            <form action="Controlador" method="POST">
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-uppercase">Título del Consejo</label>
                                    <input type="text" name="txtTitulo" class="form-control" placeholder="Ej. Contraseñas Seguras" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-uppercase">Categoría</label>
                                    <select name="txtCategoria" class="form-select">
                                        <option>Tip personal</option>
                                        <option>Legislación</option>
                                        <option>Consejo general</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-uppercase">Descripción Detallada</label>
                                    <textarea name="txtDesc" class="form-control" rows="4" placeholder="Explica el riesgo o solución..." required></textarea>
                                </div>
                                <button type="submit" name="accion" value="Agregar" class="btn btn-info w-100 fw-bold py-2 shadow-sm">
                                    <i class="fas fa-save"></i> PUBLICAR CONSEJO
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="card glass-card shadow">
                        <div class="card-header bg-transparent border-bottom border-light py-3">
                            <h5 class="m-0"><i class="fas fa-list text-info"></i> Repositorio de Conocimientos</h5>
                        </div>
                        <div class="table-responsive p-3">
                            <table class="table table-glass table-hover align-middle m-0">
                                <thead>
                                    <tr class="text-white">
                                        <th>ID</th>
                                        <th>CONTENIDO</th>
                                        <th>CATEGORÍA</th>
                                        <th class="text-center">ACCIONES</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<Consejo> lista = (List<Consejo>) request.getAttribute("lista");
                                        if (lista != null) {
                                            for (Consejo c : lista) {
                                    %>
                                    <tr class="text-white-50">
                                        <td class="fw-bold text-white"><%= c.getId()%></td>
                                        <td>
                                            <div class="fw-bold text-white"><%= c.getTitulo()%></div>
                                            <small><%= c.getDescripcion()%></small>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary badge-category">
                                                <%= c.getCategoria()%>
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <div class="btn-group shadow-sm">
                                                <a href="Controlador?accion=editar&id=<%= c.getId()%>" class="btn btn-warning btn-sm">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button class="btn btn-danger btn-sm" onclick="confirmDelete(<%= c.getId()%>)">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } } else { %>
                                    <tr>
                                        <td colspan="4" class="text-center py-4">No hay datos disponibles para mostrar.</td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function confirmDelete(id) {
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: "Esta acción no se puede deshacer.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Sí, eliminar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = "Controlador?accion=eliminar&id=" + id;
                    }
                })
            }
        </script>
    </body>
</html>