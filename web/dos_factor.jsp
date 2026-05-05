<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>NovaSec - Autenticación 2FA</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { background: linear-gradient(135deg, #0f0c29, #302b63, #24243e); min-height: 100vh; display: flex; align-items: center; }
        .card { border: none; border-radius: 15px; overflow: hidden; background: rgba(255, 255, 255, 0.95); }
        .card-header { background: #1a237e; color: white; border: none; }
        .otp-input { letter-spacing: 10px; font-weight: bold; font-size: 2rem; border: 2px solid #1a237e; }
        .btn-verify { background: #1a237e; color: white; font-weight: 600; border-radius: 8px; transition: 0.3s; }
        .btn-verify:hover { background: #3949ab; color: white; transform: scale(1.02); }
    </style>
</head>
<body>
    <div class="container">
        <div class="card mx-auto shadow-lg" style="max-width: 450px;">
            <div class="card-header text-center py-4">
                <i class="fas fa-user-shield fa-3x mb-2"></i>
                <h3>Verificación 2FA</h3>
                <p class="mb-0 text-white-50">Criterio 3.1.5 - Tema Optativo</p>
            </div>
            <div class="card-body p-4 text-center">
                <p class="text-muted">Para continuar a las áreas administrativas, confirma tu identidad con el código dinámico.</p>
                
                <button type="button" class="btn btn-outline-primary btn-sm mb-4" onclick="generarCodigo()">
                    <i class="fas fa-paper-plane"></i> Enviar Código al dispositivo
                </button>
                
                <div id="area-codigo" class="alert alert-warning d-none mb-4 animate__animated animate__fadeIn">
                    <small>CÓDIGO GENERADO (Simulación):</small>
                    <h2 id="codigo-display" class="mb-0"></h2>
                </div>

                <form action="Validar2FAServlet" method="POST">
                    <div class="mb-4">
                        <input type="text" name="user_otp" class="form-control text-center otp-input" 
                               placeholder="000000" maxlength="6" required autocomplete="off">
                        <input type="hidden" id="hidden_otp" name="hidden_otp">
                    </div>
                    <button type="submit" class="btn btn-verify w-100 py-3">
                        <i class="fas fa-check-circle"></i> VERIFICAR IDENTIDAD
                    </button>
                </form>
                <div class="mt-3">
                    <a href="indexdos.jsp" class="text-decoration-none text-muted small"><i class="fas fa-arrow-left"></i> Volver al panel</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        function generarCodigo() {
            const nuevoCodigo = Math.floor(100000 + Math.random() * 900000);
            document.getElementById('codigo-display').innerText = nuevoCodigo;
            document.getElementById('hidden_otp').value = nuevoCodigo;
            document.getElementById('area-codigo').classList.remove('d-none');
            
            Swal.fire({
                icon: 'success',
                title: 'Código Enviado',
                text: 'Se ha enviado un código de 6 dígitos a su aplicación de autenticación.',
                timer: 2000,
                showConfirmButton: false
            });
        }

        // Lógica para detectar si regresamos con error del Servlet
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            Swal.fire({
                icon: 'error',
                title: 'Acceso Denegado',
                text: 'El código ingresado es incorrecto o ha expirado.',
                confirmButtonColor: '#d33'
            });
        }
    </script>
</body>
</html>