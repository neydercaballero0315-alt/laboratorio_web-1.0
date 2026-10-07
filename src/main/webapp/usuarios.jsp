<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Usuarios</title>
    <!-- CSS de Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <%-- Seguridad: Si no hay sesión activa, redirige al login --%>
    <c:if test="${empty sessionScope.usuarioLogueado}">
        <c:redirect url="index.jsp"/>
    </c:if>

   <div class="container my-5">
        
        <!-- Encabezado y acciones -->
        <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <h2 class="fw-bold mb-1">Lista de Usuarios Registrados</h2>
                    <span class="badge bg-success fs-6">Estado BD: Conectado</span>
                </div>
                
                <!-- Botones de navegación -->
                <div class="d-flex gap-2">
                    <a href="home.jsp" class="btn btn-secondary fw-semibold">
                        ⬅ Volver a Bienvenida
                    </a>
                    <a href="logout" class="btn btn-danger fw-semibold">
                        Finalizar Sesión 🚪
                    </a>
                </div>
            </div>
        </div>

        <!-- 🔍 AQUÍ PEGATELAS LA BARRA DE BÚSQUEDA INTERACTIVA -->
        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body">
                <form action="UsuarioServlet" method="GET" class="row g-3">
                    <div class="col-md-10">
                        <input type="text" name="busqueda" class="form-control" placeholder="Buscar por nombre o correo electrónico..." value="${param.busqueda}">
                    </div>
                    <div class="col-md-2 d-grid">
                        <button type="submit" class="btn btn-primary fw-bold">Filtrar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabla de Usuarios -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-primary">
                            <tr>
                                <th class="py-3 px-4">ID</th>
                                <th class="py-3 px-4">Nombre</th>
                                <th class="py-3 px-4">Correo</th>
                                <th class="py-3 px-4">Rol</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${usuarios}">
                                <tr>
                                    <td class="px-4 fw-bold text-secondary">${u.id}</td>
                                    <td class="px-4">${u.nombre}</td>
                                    <td class="px-4">${u.correo}</td>
                                    <td class="px-4">
                                        <span class="badge bg-info text-dark">${u.rol}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
                    

    <!-- JS de Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>