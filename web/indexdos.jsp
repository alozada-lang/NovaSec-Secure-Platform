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
        <title>CiberSegura - Lozada 144</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .hero-section { background: #1a237e; color: white; padding: 60px 0; }
            .card-hover:hover { transform: scale(1.05); transition: 0.3s; }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">Shield Lozada 144</a>
                <div class="d-flex align-items-center">
                    <%-- BARRA INTELIGENTE: Dependiendo de si hay sesión o no --%>
                    <% if(userLogueado != null) { %>
                        <span class="text-white me-3">👤 Bienvenido, <%= userLogueado.getUser() %></span>
                        <a href="Controlador?accion=Salir" class="btn btn-outline-danger btn-sm">Cerrar Sesión</a>
                    <% } else { %>
                        <a href="login.jsp" class="btn btn-primary btn-sm">Iniciar Sesión</a>
                    <% } %>
                </div>
            </div>
        </nav>

        <header class="hero-section text-center">
            <div class="container">
                <h1>Academia de Ciberseguridad</h1>
                <p class="lead">Aprende a protegerte de las amenazas digitales de forma dinámica.</p>
            </div>
        </header>

        <main class="container my-5">
            <div class="row g-4 justify-content-center">
                <div class="col-md-5">
                    <div class="card h-100 shadow card-hover">
                        <div class="card-body text-center">
                            <h3 class="card-title">🛡️ Tips de Seguridad</h3>
                            <p>Consulta nuestra base de conocimientos o aporta nuevos consejos a la comunidad.</p>
                            <a href="index.jsp" class="btn btn-primary">Ir a Gestión de Tips</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="card h-100 shadow card-hover">
                        <div class="card-body text-center">
                            <h3 class="card-title">🎓 Curso de Aprendizaje</h3>
                            <p>Lecciones interactivas con videos, imágenes y cuestionarios para expertos.</p>
                            <a href="curso.jsp" class="btn btn-success">Comenzar Lecciones</a>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>