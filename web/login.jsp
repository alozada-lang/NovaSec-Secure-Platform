<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Acceso - NovaSec Shield</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            /* Fondo coherente con el 2FA */
            body { 
                background: linear-gradient(135deg, #0f0c29, #302b63, #24243e); 
                min-height: 100vh; 
                display: flex; 
                align-items: center; 
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .login-container { 
                max-width: 450px; 
                margin: auto; 
                background: rgba(255, 255, 255, 0.95); 
                padding: 40px; 
                border-radius: 20px; 
                border: none;
            }
            .nav-pills .nav-link { color: #555; font-weight: 600; border-radius: 10px; }
            .nav-pills .nav-link.active { background-color: #1a237e; box-shadow: 0 4px 10px rgba(26, 35, 126, 0.3); }
            .form-control { border-radius: 10px; padding: 12px; border: 1px solid #ddd; }
            .btn-primary { background-color: #1a237e; border: none; border-radius: 10px; padding: 12px; font-weight: 600; }
            .btn-primary:hover { background-color: #3949ab; transform: translateY(-2px); transition: 0.3s; }
            .btn-success { border-radius: 10px; padding: 12px; font-weight: 600; }
            .brand-icon { color: #1a237e; font-size: 3rem; margin-bottom: 10px; }
        </style>
    </head>
    <body>
        <div class="login-container shadow-lg">
            <div class="text-center mb-4">
                <i class="fas fa-user-shield brand-icon"></i>
                <h3 class="fw-bold" style="color: #1a237e;">NovaSec Shield</h3>
                <p class="text-muted small">Plataforma de Seguridad - Lozada 144</p>
            </div>
            
            <ul class="nav nav-pills nav-justified mb-4" id="ex1" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="tab-login" data-bs-toggle="pill" href="#pills-login">
                        <i class="fas fa-sign-in-alt"></i> Ingresar
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="tab-register" data-bs-toggle="pill" href="#pills-register">
                        <i class="fas fa-user-plus"></i> Registrar
                    </a>
                </li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane fade show active" id="pills-login">
                    <form action="Controlador" method="POST">
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Usuario</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="fas fa-user text-muted"></i></span>
                                <input type="text" name="txtUser" class="form-control" placeholder="Tu usuario" required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label small fw-bold">Contraseña</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="fas fa-lock text-muted"></i></span>
                                <input type="password" name="txtPass" class="form-control" placeholder="••••••••" required>
                            </div>
                        </div>
                        <button type="submit" name="accion" value="Ingresar" class="btn btn-primary w-100 shadow-sm">
                            ENTRAR AL SISTEMA
                        </button>
                    </form>
                </div>

                <div class="tab-pane fade" id="pills-register">
                    <form action="Controlador" method="POST">
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Nuevo Usuario</label>
                            <input type="text" name="txtUser" class="form-control" placeholder="Ej. alozada_sec" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Nueva Contraseña</label>
                            <input type="password" id="passInput" name="txtPass" class="form-control" placeholder="Mínimo 6 caracteres" required onkeyup="checkPasswordStrength()">
                            
                            <div class="progress mt-3" style="height: 6px; border-radius: 10px;">
                                <div id="strengthBar" class="progress-bar" role="progressbar" style="width: 0%"></div>
                            </div>
                            <small id="strengthText" class="form-text mt-2 d-block text-center fw-bold text-muted">Contraseña no analizada</small>
                        </div>
                        <button type="submit" name="accion" value="RegistrarUsuario" class="btn btn-success w-100 shadow-sm mt-2">
                            CREAR CUENTA SEGURA
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <%-- MANEJO DE ERRORES CON SWEETALERT --%>
        <% if(request.getAttribute("error") != null) { %>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Error de Acceso',
                    text: '<%= request.getAttribute("error") %>',
                    confirmButtonColor: '#1a237e'
                });
            </script>
        <% } %>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
        function checkPasswordStrength() {
            let pass = document.getElementById("passInput").value;
            let bar = document.getElementById("strengthBar");
            let text = document.getElementById("strengthText");
            let strength = 0;

            if (pass.length > 5) strength += 25;
            if (pass.match(/[a-z]/) && pass.match(/[A-Z]/)) strength += 25;
            if (pass.match(/\d/)) strength += 25;
            if (pass.match(/[^a-zA-Z\d]/)) strength += 25;

            bar.style.width = strength + "%";
            
            if (strength <= 25) { bar.className = "progress-bar bg-danger"; text.style.color = "#dc3545"; text.innerHTML = "❌ Muy Débil"; }
            else if (strength <= 50) { bar.className = "progress-bar bg-warning"; text.style.color = "#ffc107"; text.innerHTML = "⚠️ Débil"; }
            else if (strength <= 75) { bar.className = "progress-bar bg-info"; text.style.color = "#0dcaf0"; text.innerHTML = "✔️ Segura"; }
            else { bar.className = "progress-bar bg-success"; text.style.color = "#198754"; text.innerHTML = "🚀 Excelente"; }
        }
        </script>
    </body>
</html>