package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;
import modelo.UsuarioDAO;
import java.util.List;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login", "/logout"})
public class LoginServlet extends HttpServlet {

    @Override


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    System.out.println(">>> ¡SI ENTRO AL LOGIN! <<<"); // <-- Agrega esta línea aquí
    
    String correo = request.getParameter("correo");
    String password = request.getParameter("password");
    // ... el resto de tu código

UsuarioDAO dao = new UsuarioDAO();
// Ahora le pasamos el correo y la contraseña al DAO
Usuario u = dao.validar(correo, password);

    if (u != null) {
        HttpSession session = request.getSession();
        session.setAttribute("usuarioLogueado", u.getNombre());
        session.setAttribute("emailUsuario", u.getCorreo());
        
        session.setAttribute("rolUsuario", u.getRol());
        response.sendRedirect("home.jsp");
    } else {
        // Redirige pasando el parámetro de error
        response.sendRedirect("index.jsp?error=true");
    }
}

    @Override
 
 protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Recogemos el parámetro de búsqueda de la vista
        String busqueda = request.getParameter("busqueda");
        
        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> lista = dao.listar(busqueda); // Pasamos el filtro al DAO
        
        request.setAttribute("usuarios", lista);
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    }
}
