<%-- 
    Document   : login
    Created on : 27/04/2026, 08:02:37 PM
    Author     : Luis Torres
--%>
<%-- Mensaje de Error --%>
<% if(request.getAttribute("error") != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>⚠️ Error:</strong> <%= request.getAttribute("error") %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% } %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Acceso - Shield Lozada</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f4f7f6; display: flex; align-items: center; height: 100vh; }
            .login-container { max-width: 400px; margin: auto; background: white; padding: 30px; border-radius: 15px; shadow: 0 4px 15px rgba(0,0,0,0.1); }
            .nav-pills .nav-link.active { background-color: #1a237e; }
        </style>
    </head>
    <body>
        <div class="login-container shadow">
            <h3 class="text-center mb-4">🛡️ Shield Lozada</h3>
            
            <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="tab-login" data-bs-toggle="pill" href="#pills-login">Ingresar</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="tab-register" data-bs-toggle="pill" href="#pills-register">Registrar</a>
                </li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane fade show active" id="pills-login">
                    <form action="Controlador" method="POST">
                        <div class="mb-3">
                            <label class="form-label">Usuario</label>
                            <input type="text" name="txtUser" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contraseña</label>
                            <input type="password" name="txtPass" class="form-control" required>
                        </div>
                        <button type="submit" name="accion" value="Ingresar" class="btn btn-primary w-100">Entrar</button>
                    </form>
                </div>

                <div class="tab-pane fade" id="pills-register">
                    <form action="Controlador" method="POST">
                        <div class="mb-3">
                            <label class="form-label">Nuevo Usuario</label>
                            <input type="text" name="txtUser" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nueva Contraseña</label>
                            <input type="password" id="passInput" name="txtPass" class="form-control" required onkeyup="checkPasswordStrength()">
                            <div class="progress mt-2" style="height: 5px;">
                                <div id="strengthBar" class="progress-bar" role="progressbar" style="width: 0%"></div>
                            </div>
                            <small id="strengthText" class="form-text text-muted">Ingresa una contraseña segura.</small>
                        </div>
                        <button type="submit" name="accion" value="RegistrarUsuario" class="btn btn-success w-100">Crear Cuenta</button>
                    </form>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
        function checkPasswordStrength() {
    let pass = document.getElementById("passInput").value;
    let bar = document.getElementById("strengthBar");
    let text = document.getElementById("strengthText");
    let strength = 0;

    if (pass.length > 5) strength += 25; // Longitud mínima
    if (pass.match(/[a-z]/) && pass.match(/[A-Z]/)) strength += 25; // Mayúsculas y minúsculas
    if (pass.match(/\d/)) strength += 25; // Números
    if (pass.match(/[^a-zA-Z\d]/)) strength += 25; // Símbolos

    bar.style.width = strength + "%";
    
    if (strength <= 25) { bar.className = "progress-bar bg-danger"; text.innerHTML = "❌ Contraseña Muy Débil"; }
    else if (strength <= 50) { bar.className = "progress-bar bg-warning"; text.innerHTML = "⚠️ Contraseña Débil (usa números y símbolos)"; }
    else if (strength <= 75) { bar.className = "progress-bar bg-info"; text.innerHTML = "✔️ Contraseña Buena"; }
    else { bar.className = "progress-bar bg-success"; text.innerHTML = "🚀 Contraseña Excelente"; }
}
    
        </script>
    </body>
</html>