package controlador;

import modelo.Usuario;
import modelo.UsuarioDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {

    private UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // 1. Capturamos lo que el usuario escribió en la caja de texto
    String busqueda = request.getParameter("busqueda");
    
    // 2. Creamos el DAO y le pasamos el filtro (si está vacío, traerá a todos)
    UsuarioDAO dao = new UsuarioDAO();
    List<Usuario> lista = dao.listar(busqueda); 
    
    // 3. Enviamos la lista filtrada a la vista (usuarios.jsp)
    request.setAttribute("usuarios", lista);
    request.getRequestDispatcher("usuarios.jsp").forward(request, response);
}
}