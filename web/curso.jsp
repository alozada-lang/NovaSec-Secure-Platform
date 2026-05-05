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
    <title>Academia NovaSec - Curso</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        
        /* Sidebar Estilo Dashboard */
        .sidebar { 
            min-height: 100vh; 
            background: #1a1d20; 
            color: white; 
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
        }
        .nav-link { 
            color: #ced4da; 
            border-radius: 8px;
            margin-bottom: 5px;
            transition: 0.3s;
        }
        .nav-link:hover { background: rgba(255,255,255,0.1); color: #0dcaf0; }
        .nav-link.active { background: #0dcaf0; color: #1a1d20; fw-bold; }
        
        /* Contenido Principal */
        .main-content { padding: 40px; }
        .video-container { 
            border-radius: 15px; 
            overflow: hidden; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.15); 
        }
        .progress { height: 12px; border-radius: 10px; background-color: #343a40; }
        .card-quiz { border: none; border-radius: 15px; border-left: 5px solid #0dcaf0; }
        
        .congrats-card {
            background: linear-gradient(135deg, #ffffff 0%, #e3f2fd 100%);
            border: none;
            border-radius: 20px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <nav class="col-md-3 col-lg-2 d-md-block sidebar p-4">
            <div class="text-center mb-4">
                <i class="fas fa-graduation-cap fa-3x text-info mb-2"></i>
                <h5 class="fw-bold">NovaSec Academy</h5>
            </div>
            
            <div class="mb-4 text-center">
                <p class="small mb-1 text-uppercase text-muted">Progreso General</p>
                <div class="progress mb-2">
                    <div class="progress-bar progress-bar-striped progress-bar-animated bg-info" 
                         role="progressbar" style="width: <%= porcentaje %>%;"></div>
                </div>
                <span class="badge bg-info text-dark"><%= porcentaje %>% completado</span>
            </div>

            <hr class="text-muted">
            <p class="small text-muted text-uppercase fw-bold">Módulos del Curso</p>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link <%= (request.getParameter("leccion") == null || "1".equals(request.getParameter("leccion"))) ? "active" : "" %>" 
                       href="curso.jsp?leccion=1">
                        <i class="fas fa-play-circle me-2"></i> Lección 1
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= "2".equals(request.getParameter("leccion")) ? "active" : "" %>" 
                       href="curso.jsp?leccion=2">
                        <i class="fas fa-play-circle me-2"></i> Lección 2
                    </a>
                </li>
            </ul>

            <div class="mt-5 d-grid">
                <a href="indexdos.jsp" class="btn btn-outline-light btn-sm rounded-pill">
                    <i class="fas fa-home me-2"></i> Panel Principal
                </a>
            </div>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
            <%
                String leccionParam = request.getParameter("leccion");
                int idLeccion = (leccionParam != null) ? Integer.parseInt(leccionParam) : 1;
                
                if (idLeccion > totalLecciones) {
            %>
                <div class="card congrats-card shadow-lg p-5 text-center">
                    <div class="card-body">
                        <div class="mb-4">
                            <i class="fas fa-award fa-5x text-warning animate__animated animate__bounceIn"></i>
                        </div>
                        <h1 class="display-4 fw-bold text-dark">¡Enhorabuena, <%= userLogueado.getUser() %>!</h1>
                        <p class="lead text-muted">Has completado el entrenamiento en IA Generativa y Seguridad.</p>
                        
                        <div class="row justify-content-center mt-5">
                            <div class="col-md-8 text-start bg-white p-4 rounded-4 shadow-sm">
                                <h4 class="text-primary fw-bold mb-3"><i class="fas fa-comment-dots"></i> Feedback del Estudiante</h4>
                                <form action="Controlador" method="POST">
                                    <div class="mb-3">
                                        <label class="form-label text-muted">Usuario Activo</label>
                                        <input type="text" class="form-control bg-light" value="<%= userLogueado.getUser() %>" disabled>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">¿Qué te pareció el contenido?</label>
                                        <textarea class="form-control" name="mensaje" rows="4" placeholder="Tu opinión nos ayuda a mejorar..." required></textarea>
                                    </div>
                                    <button type="submit" name="accion" value="GuardarComentario" class="btn btn-primary btn-lg w-100 rounded-pill">
                                        Enviar y Finalizar <i class="fas fa-paper-plane ms-2"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            <% } else { 
                String titulo = (idLeccion == 1) ? "Introducción a la IA Generativa" : "Módulo 2: Ética y Buenas Prácticas";
                String videoID = (idLeccion == 1) ? "dQw4w9WgXcQ" : "BaaUbPSaZFo";
                String pregunta = (idLeccion == 1) ? "¿Qué es una 'alucinación' de la IA?" : "¿Cuál es una buena práctica de uso?";
                String opcionA = (idLeccion == 1) ? "Cuando la IA inventa datos falsos." : "Validar siempre la información generada.";
                String opcionB = (idLeccion == 1) ? "Cuando la IA se queda sin internet." : "Copiar y pegar sin revisar nada.";
            %>
            
                <div class="d-flex align-items-center mb-4">
                    <div class="bg-info p-3 rounded-3 me-3 text-white">
                        <i class="fas fa-book-open fa-2x"></i>
                    </div>
                    <div>
                        <h6 class="text-muted mb-0 text-uppercase">Lección <%= idLeccion %></h6>
                        <h2 class="fw-bold m-0"><%= titulo %></h2>
                    </div>
                </div>

                <div class="video-container ratio ratio-16x9 mb-5">
                    <iframe src="https://www.youtube.com/embed/<%= videoID %>" allowfullscreen></iframe>
                </div>

                <div class="card card-quiz shadow-sm">
                    <div class="card-body p-4">
                        <h4 class="fw-bold mb-4 text-dark"><i class="fas fa-question-circle text-info me-2"></i> Comprobación de Aprendizaje</h4>
                        <form action="Controlador" method="POST">
                            <input type="hidden" name="leccionID" value="<%= idLeccion %>">
                            <p class="fs-5 mb-4"><%= pregunta %></p>
                            
                            <div class="list-group mb-4">
                                <label class="list-group-item d-flex gap-3 py-3 border-0 bg-light rounded-3 mb-2">
                                    <input class="form-check-input flex-shrink-0" type="radio" name="q1" value="0" required>
                                    <span><%= opcionA %></span>
                                </label>
                                <label class="list-group-item d-flex gap-3 py-3 border-0 bg-light rounded-3">
                                    <input class="form-check-input flex-shrink-0" type="radio" name="q1" value="10" required>
                                    <span><%= opcionB %></span>
                                </label>
                            </div>
                            
                            <button type="submit" name="accion" value="ValidarLeccion" class="btn btn-dark btn-lg px-5 rounded-pill shadow">
                                Enviar y Seguir <i class="fas fa-arrow-right ms-2"></i>
                            </button>
                        </form>
                    </div>
                </div>
            <% } %>
        </main>
    </div>
</div>
</body>
</html>