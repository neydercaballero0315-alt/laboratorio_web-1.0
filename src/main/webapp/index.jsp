<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - Laboratorio UTP</title>
    <!-- CSS de Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center vh-100">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card shadow-lg border-0 rounded-4">
                    <div class="card-body p-4 p-sm-5">
                        <h3 class="card-title text-center fw-bold text-primary mb-4">Iniciar Sesión</h3>
                        
                        <!-- Contenedor del mensaje de error -->
                        <div id="alertError" class="alert alert-danger d-none text-center fw-semibold py-2" role="alert">
                            Datos incorrectos
                        </div>

                        <form action="login" method="POST">
                       <div class="mb-3">
    <label for="correo" class="form-label fw-semibold">Correo Electrónico</label>
    <input type="email" class="form-control rounded-3" id="correo" name="correo" placeholder="ej. admin@donlicor.com" required>
</div>

<div class="mb-4">
    <label for="password" class="form-label fw-semibold">Contraseña</label>
    <!-- Aquí está el type="password" para ocultar el texto -->
    <input type="password" class="form-control rounded-3" id="password" name="password" placeholder="********" required>
</div>
                            

                            <button type="submit" class="btn btn-primary w-100 py-2 rounded-3 fw-bold">Ingresar al Sistema</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JS de Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Muestra la alerta "Datos incorrectos" si se detecta ?error=true
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            document.getElementById('alertError').classList.remove('d-none');
        }
    </script>
</body>
</html>