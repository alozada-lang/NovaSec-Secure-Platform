<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vulnerabilidades Detectadas - Lozada</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background-color: #f4f7f9;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .header-scanner {
                background: #212529;
                color: #00ff41;
                padding: 30px 0;
                border-bottom: 4px solid #00ff41;
                text-shadow: 0 0 5px #00ff41;
            }
            .table-hover tbody tr:hover {
                background-color: #e9ecef;
            }
        </style>
    </head>
    <body>
        
        <%@ include file="conexion.jsp" %>

        <header class="header-scanner text-center mb-5">
            <div class="container">
                <h2><i class="fas fa-satellite-dish"></i> Superficie de Ataque Detectada</h2>
                <p class="mb-0">Monitoreo e inventario de vulnerabilidades del sistema</p>
            </div>
        </header>

        <div class="container">
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0"><i class="fas fa-list-ul"></i> Registros en Base de Datos</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th class="text-center"><i class="fas fa-hashtag"></i> ID</th>
                                    <th><i class="fas fa-link"></i> URL Afectada</th>
                                    <th class="text-center"><i class="fas fa-network-wired"></i> Puerto</th>
                                    <th><i class="fas fa-bug"></i> Vulnerabilidad</th>
                                    <th class="text-center"><i class="fas fa-exclamation-triangle"></i> Riesgo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                try {
                                    String sql = "SELECT * FROM dsa";
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery(sql);

                                    while(rs.next()){
                                        // 🎨 LÓGICA NUEVA: Colores dinámicos para el riesgo
                                        String riesgo = rs.getString("riesgo");
                                        String badgeClass = "bg-secondary"; // Color por defecto
                                        
                                        if(riesgo != null) {
                                            if(riesgo.equalsIgnoreCase("Alto") || riesgo.equalsIgnoreCase("Crítico") || riesgo.equalsIgnoreCase("Critico")) {
                                                badgeClass = "bg-danger"; // Rojo
                                            } else if(riesgo.equalsIgnoreCase("Medio")) {
                                                badgeClass = "bg-warning text-dark"; // Amarillo
                                            } else if(riesgo.equalsIgnoreCase("Bajo")) {
                                                badgeClass = "bg-success"; // Verde
                                            }
                                        }
                                %>
                                <tr>
                                    <td class="text-center fw-bold"><%= rs.getInt("id") %></td>
                                    <td><code><%= rs.getString("url") %></code></td>
                                    <td class="text-center"><span class="badge border border-dark text-dark"><%= rs.getInt("puerto") %></span></td>
                                    <td><%= rs.getString("vulnerabilidad") %></td>
                                    <td class="text-center">
                                        <span class="badge <%= badgeClass %> px-3 py-2"><%= riesgo.toUpperCase() %></span>
                                    </td>
                                </tr>
                                <%
                                    }
                                } catch(Exception e){
                                %>
                                    <tr>
                                        <td colspan="5" class="text-center text-danger fw-bold py-4">
                                            <i class="fas fa-times-circle"></i> Error al cargar datos: <%= e.getMessage() %>
                                        </td>
                                    </tr>
                                <%
                                } finally {
                                    // Buena práctica: cerrar la conexión en el finally
                                    if(con != null) con.close();
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row mt-4 mb-5">
                <div class="col text-center">
                    <a href="index.html" class="btn btn-outline-dark px-4 fw-bold">
                        <i class="fas fa-arrow-left"></i> Volver al Panel
                    </a>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>