<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Escáner de Vulnerabilidades - Lozada</title>
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
            .form-card {
                border-radius: 15px;
                border: none;
            }
            .input-group-text {
                background-color: #212529;
                color: #00ff41;
                border: none;
            }
            /* Efecto de pulso para el botón de escaneo */
            .btn-scan {
                background-color: #dc3545;
                color: white;
                transition: all 0.3s ease;
            }
            .btn-scan:hover {
                background-color: #c82333;
                box-shadow: 0 0 15px rgba(220, 53, 69, 0.5);
            }
        </style>
    </head>
    <body>

        <header class="header-scanner text-center mb-5">
            <div class="container">
                <h2><i class="fas fa-radar"></i> Motor de Análisis de Superficie</h2>
                <p class="mb-0">Ingresa el objetivo para buscar puertos abiertos y vulnerabilidades (XSS, SQLi)</p>
            </div>
        </header>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    
                    <div class="card form-card shadow-lg">
                        <div class="card-header bg-dark text-white text-center py-3" style="border-radius: 15px 15px 0 0;">
                            <h4 class="mb-0 text-success"><i class="fas fa-crosshairs"></i> Configurar Objetivo</h4>
                        </div>
                        <div class="card-body p-4 text-center">
                            
                            <p class="text-muted mb-4">El sistema realizará peticiones automatizadas al objetivo para detectar posibles vectores de ataque.</p>

                            <form action="guardar.jsp" method="post" id="scanForm">
                                
                                <div class="mb-4">
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text"><i class="fas fa-globe"></i></span>
                                        <input type="url" class="form-control" name="url" placeholder="Ej. https://misitio.com" required>
                                    </div>
                                </div>

                                <div class="alert alert-warning py-2 mb-4" role="alert" style="font-size: 0.85rem;">
                                    <i class="fas fa-exclamation-triangle"></i> Asegúrate de contar con autorización antes de escanear este dominio.
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-scan btn-lg fw-bold" id="btnSubmit">
                                        <i class="fas fa-search"></i> Iniciar Análisis y Registrar
                                    </button>
                                </div>
                            </form>
                            
                        </div>
                    </div>

                    <div class="d-flex justify-content-between mt-4 mb-5">
                        <a href="index.html" class="btn btn-outline-dark">
                            <i class="fas fa-arrow-left"></i> Volver al Menú
                        </a>
                        <a href="listar_vulne.jsp" class="btn btn-primary shadow-sm">
                            <i class="fas fa-list"></i> Ver Resultados Previos
                        </a>
                    </div>

                </div>
            </div>
        </div>

        <script>
            document.getElementById('scanForm').addEventListener('submit', function() {
                var btn = document.getElementById('btnSubmit');
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Ejecutando escáner...';
                btn.classList.add('disabled');
            });
        </script>
    </body>
</html>