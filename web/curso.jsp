<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    Usuario userLogueado = (Usuario) sesion.getAttribute("usuario");
    
    if(userLogueado == null) {
        response.sendRedirect("login.jsp");
        return; 
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    // 🔥 LÓGICA DE PROGRESO (Solo se declara una vez aquí arriba)
    int totalLecciones = 2; 
    int leccionActual = userLogueado.getProgreso();
    
    if (leccionActual > totalLecciones) {
        leccionActual = totalLecciones;
    }
    
    int porcentaje = (leccionActual * 100) / totalLecciones;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Curso - Shield Lozada</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sidebar { min-height: 100vh; background: #212529; color: white; }
        .nav-link { color: #adb5bd; }
        .nav-link:hover { color: white; }
        .progress { height: 25px; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <nav class="col-md-3 col-lg-2 d-md-block sidebar p-3">
            <h4 class="text-center">Módulos</h4>
            <hr>
            <div class="mb-4">
                <small>Tu progreso: <%= porcentaje %>%</small>
                <div class="progress mt-2">
                    <div class="progress-bar bg-success" role="progressbar" style="width: <%= porcentaje %>%;"></div>
                </div>
            </div>
            <ul class="nav flex-column mb-4">
                <li class="nav-item"><a class="nav-link" href="curso.jsp?leccion=1">Lección 1</a></li>
                <li class="nav-item"><a class="nav-link" href="curso.jsp?leccion=2">Lección 2</a></li>
            </ul>
            <hr class="text-white"> 
            <div class="d-grid gap-2 mt-3">
                <a href="indexdos.jsp" class="btn btn-outline-light btn-sm">⬅️ Regresar al Inicio</a>
            </div>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <%
                String leccionParam = request.getParameter("leccion");
                int idLeccion = (leccionParam != null) ? Integer.parseInt(leccionParam) : 1;
                
                // Si la lección solicitada es mayor a las que tenemos (Lección 3 o más)
                if (idLeccion > totalLecciones) {
            %>
                <div class="card shadow border-success mt-5">
                    <div class="card-body text-center p-5">
                        <h1 class="text-success">¡Felicidades, <%= userLogueado.getUser() %>! 🎉</h1>
                        <p class="lead mt-3">Has concluido exitosamente todas las lecciones. Sigue aprendiendo en otras secciones de la página.</p>
                        <hr class="my-4">
                        
                        <div class="text-start bg-light p-4 rounded shadow-sm">
                            <h4 class="text-primary">📬 Buzón de Comentarios</h4>
                            <p class="text-muted">¿Qué te pareció el curso? Déjanos tu opinión.</p>
                            
                            <form action="Controlador" method="POST">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Usuario:</label>
                                    <input type="text" class="form-control" value="<%= userLogueado.getUser() %>" disabled>
                                </div>
                                <div class="mb-3">
                                    <label for="mensaje" class="form-label fw-bold">Tu mensaje:</label>
                                    <textarea class="form-control" id="mensaje" name="mensaje" rows="4" placeholder="Escribe aquí tu experiencia..." required></textarea>
                                </div>
                                <div class="d-flex justify-content-between mt-4">
                                    <a href="indexdos.jsp" class="btn btn-outline-secondary">Volver al Inicio</a>
                                    <button type="submit" name="accion" value="GuardarComentario" class="btn btn-success">
                                        Enviar Comentario
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            <% } else { 
                // --- CONFIGURACIÓN DINÁMICA POR LECCIÓN ---
                String titulo = "";
                String videoID = "";
                String pregunta = "";
                String opcionA = "";
                String opcionB = "";

                if (idLeccion == 1) {
                    titulo = "Introducción a la IA Generativa";
                    videoID = "dQw4w9WgXcQ"; // Video de prueba (Rickroll)
                    pregunta = "¿Qué es una 'alucinación' de la IA?";
                    opcionA = "Cuando la IA inventa datos falsos.";
                    opcionB = "Cuando la IA se apaga sola.";
                } else if (idLeccion == 2) {
                    titulo = "Módulo 2: ¿Qué es la inteligencia artificial?";
                    videoID = "BaaUbPSaZFo"; // 🔥 CAMBIA ESTE ID POR EL DE TU VIDEO DE YT
                    pregunta = "¿Cuál es una buena práctica de uso?";
                    opcionA = "Validar la información generada.";
                    opcionB = "Ataque físico a los servidores de la empresa";
                }
            %>
            
                <h2><%= titulo %></h2>
                <div class="ratio ratio-16x9 mb-4 shadow">
                    <iframe src="https://www.youtube.com/embed/<%= videoID %>" allowfullscreen></iframe>
                </div>

                <div class="card shadow-sm mt-4">
                    <div class="card-body">
                        <h4>📝 Mini Encuesta de Validación</h4>
                        <form action="Controlador" method="POST">
                            <input type="hidden" name="leccionID" value="<%= idLeccion %>">
                            
                            <p>1. <%= pregunta %></p>
                            
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="q1" value="0" required>
                                <label class="form-check-label"><%= opcionA %></label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="q1" value="10" required>
                                <label class="form-check-label"><%= opcionB %></label>
                            </div>
                            
                            <hr>
                            <button type="submit" name="accion" value="ValidarLeccion" class="btn btn-primary">
                                Enviar Respuestas y Continuar
                            </button>
                        </form>
                    </div>
                </div>
            <% } // Aquí cierra el bloque else %>
        </main>
    </div>
</div>
</body>
</html>