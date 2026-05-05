<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    Usuario userLogueado = (Usuario) sesion.getAttribute("usuario");
    
    // Si el usuario no ha iniciado sesión, lo mandamos al login
    if(userLogueado == null) {
        response.sendRedirect("login.jsp");
        return; 
    }

    // 🔥 CÓDIGO NUEVO PARA EVITAR EL CACHÉ DEL BOTÓN ATRÁS 🔥
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html>
    <head>
        <title>GenAI Academy - Lozada 144</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .hero-section { background: #1a237e; color: white; padding: 60px 0; }
            /* Mejoré un poco el efecto hover para que se vea más moderno */
            .card-hover:hover { transform: translateY(-5px); transition: 0.3s; box-shadow: 0 10px 20px rgba(0,0,0,0.2) !important; }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">Shield Lozada 144</a>
                
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link text-warning" href="Controlador?accion=ListarLogs"><i class="fas fa-shield-alt"></i> Auditoría WAF</a>
                    </li>
                </ul>

                <div class="d-flex align-items-center">
                    <%-- BARRA INTELIGENTE: Dependiendo de si hay sesión o no --%>
                    <% if(userLogueado != null) { %>
                        <span class="text-white me-3"><i class="fas fa-user"></i> Bienvenido, <%= userLogueado.getUser() %></span>
                        <a href="Controlador?accion=Salir" class="btn btn-outline-danger btn-sm">Cerrar Sesión</a>
                    <% } else { %>
                        <a href="login.jsp" class="btn btn-primary btn-sm">Iniciar Sesión</a>
                    <% } %>
                </div>
            </div>
        </nav>

        <header class="hero-section text-center">
            <div class="container">
                <h1>Academia de IA Generativa</h1>
                <p class="lead">Aprende a manejar la IA generativa de forma dinámica y segura.</p>
            </div>
        </header>

        <main class="container my-5">
            <div class="row g-4 justify-content-center">
                
                <div class="col-md-4">
                    <div class="card h-100 shadow card-hover border-primary">
                        <div class="card-body text-center d-flex flex-column">
                            <i class="fas fa-lightbulb fa-3x mb-3 text-primary"></i>
                            <h4 class="card-title">Tips de IA</h4>
                            <p class="flex-grow-1">Consulta nuestra base de conocimientos o aporta nuevos consejos a la comunidad.</p>
                            <a href="index.jsp" class="btn btn-primary mt-auto">Ir a Gestión de Tips</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card h-100 shadow card-hover border-success">
                        <div class="card-body text-center d-flex flex-column">
                            <i class="fas fa-graduation-cap fa-3x mb-3 text-success"></i>
                            <h4 class="card-title">Curso de Aprendizaje</h4>
                            <p class="flex-grow-1">Lecciones interactivas con videos, imágenes y cuestionarios para expertos.</p>
                            <a href="curso.jsp" class="btn btn-success mt-auto">Comenzar Lecciones</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card h-100 shadow card-hover border-dark">
                        <div class="card-body text-center d-flex flex-column">
                            <i class="fas fa-network-wired fa-3x mb-3 text-dark"></i>
                            <h4 class="card-title">Superficie de Ataque</h4>
                            <p class="flex-grow-1">Plataforma de pruebas para análisis de vulnerabilidades web y de base de datos.</p>
                            <a href="index.html" class="btn btn-dark mt-auto">Ir a la Plataforma</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mt-5">
                    <div class="card shadow card-hover border-danger">
                        <div class="card-body text-center">
                            <i class="fas fa-user-shield fa-3x mb-3 text-danger"></i>
                            <h5>Monitor de Ataques</h5>
                            <p>Revisa los intentos de intrusión bloqueados por el WAF.</p>
                            <a href="Controlador?accion=ListarLogs" class="btn btn-outline-danger">
                                Ver Bitácora de Seguridad
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </body>
</html>