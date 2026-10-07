<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Principal - Don Licor</title>
    <!-- CSS de Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <%-- Seguridad: Si no hay sesión activa, redirige al login --%>
    <c:if test="${empty sessionScope.usuarioLogueado}">
        <c:redirect url="index.jsp"/> 
    </c:if>

    <!-- Navbar superior -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">Don Licor</a>
            <div class="d-flex align-items-center text-white">
                <span class="me-3">Bienvenido, <strong>${sessionScope.usuarioLogueado}</strong></span>
                <a href="logout" class="btn btn-outline-danger btn-sm">Cerrar Sesión</a>
            </div>
        </div>
    </nav>

    <!-- Contenido Principal -->
    <div class="container">
        <div class="row">
            <div class="col-md-10 mx-auto">
                <div class="card border-0 shadow-sm rounded-4 mb-4">
                    <div class="card-body p-4">
                        <h4 class="card-title fw-bold text-dark">Panel de Control</h4>
                        <p class="text-muted mb-4">
                            Sesión iniciada con el correo: <strong>${sessionScope.emailUsuario}</strong><br>
                            Nivel de Acceso (Rol ID): <span class="badge bg-primary">${sessionScope.rolUsuario}</span>
                        </p>
                        
                        <div class="row">
                            <!-- 👑 VISTA EXCLUSIVA DEL ADMINISTRADOR (Rol 1) -->
                            <c:if test="${sessionScope.rolUsuario == '1'}">
                                <div class="col-md-6 mb-3">
                                    <div class="p-3 bg-danger bg-opacity-10 rounded-3 border border-danger">
                                        <h5 class="fw-semibold text-danger">Módulo de Seguridad</h5>
                                        <p class="text-secondary small">Gestiona usuarios, audita ingresos y bloqueos de cuenta.</p>
                                        <a href="UsuarioServlet" class="btn btn-danger fw-bold">Ver Lista de Usuarios</a>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="p-3 bg-dark bg-opacity-10 rounded-3 border border-dark">
                                        <h5 class="fw-semibold text-dark">Reportes Financieros</h5>
                                        <p class="text-secondary small">Visualiza ganancias y cuadres de caja general.</p>
                                        <button class="btn btn-dark fw-bold">Ver Reportes</button>
                                    </div>
                                </div>
                            </c:if>

                            <!-- 🛒 VISTA PARA VENDEDORES Y CAJEROS (Roles 2, 4 y Admin 1) -->
                            <c:if test="${sessionScope.rolUsuario == '1' || sessionScope.rolUsuario == '2' || sessionScope.rolUsuario == '4'}">
                                <div class="col-md-6 mb-3">
                                    <div class="p-3 bg-success bg-opacity-10 rounded-3 border border-success">
                                        <h5 class="fw-semibold text-success">Punto de Venta</h5>
                                        <p class="text-secondary small">Registra nuevas ventas y cobra a los clientes en tienda.</p>
                                        <button class="btn btn-success fw-bold">Abrir Caja</button>
                                    </div>
                                </div>
                            </c:if>

                            <!-- 📦 VISTA PARA EL ALMACENERO (Rol 5 y Admin 1) -->
                            <c:if test="${sessionScope.rolUsuario == '1' || sessionScope.rolUsuario == '5'}">
                                <div class="col-md-6 mb-3">
                                    <div class="p-3 bg-warning bg-opacity-10 rounded-3 border border-warning">
                                        <h5 class="fw-semibold text-dark">Inventario y Almacén</h5>
                                        <p class="text-secondary small">Registra el ingreso de mercadería y controla el stock.</p>
                                        <button class="btn btn-warning text-dark fw-bold">Ver Inventario</button>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JS de Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>