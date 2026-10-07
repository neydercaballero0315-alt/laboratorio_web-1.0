package modelo;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    
public List<Usuario> listar(String busqueda) {
        List<Usuario> lista = new ArrayList<>();
        String sql;
        boolean filtrar = (busqueda != null && !busqueda.trim().isEmpty());
        
        if (filtrar) {
            sql = "SELECT * FROM usuarios WHERE nombre LIKE ? OR correo LIKE ?";
        } else {
            sql = "SELECT * FROM usuarios";
        }
        
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            if (filtrar) {
                ps.setString(1, "%" + busqueda.trim() + "%");
                ps.setString(2, "%" + busqueda.trim() + "%");
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setCorreo(rs.getString("correo"));
                    u.setRol(rs.getString("id_rol"));
                    lista.add(u);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    // Sobrecarga por si alguna otra parte del código llama a listar() sin parámetros
    public List<Usuario> listar() {
        return listar(null);
    }
public Usuario validar(String correo, String password) {
    Usuario u = null;
    try {
        java.sql.Connection cn = config.Conexion.getConexion();
        System.out.println("--- INICIANDO VALIDACIÓN ---");
        System.out.println("Correo recibido del formulario: [" + correo + "]");
        
        String sql = "SELECT * FROM usuarios WHERE correo = ?";
        java.sql.PreparedStatement ps = cn.prepareStatement(sql);
        ps.setString(1, correo.trim());
        java.sql.ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            System.out.println(" ¡Usuario encontrado en la base de datos!");
            int id = rs.getInt("id");
            String dbPassword = rs.getString("password"); 
            String estado = rs.getString("estado_cuenta");
            int intentos = rs.getInt("intentos_fallidos");

            System.out.println("Password en BD: [" + dbPassword + "]");
            System.out.println("Password ingresado: [" + password + "]");
            System.out.println("Estado de cuenta: [" + estado + "]");

            if (estado != null && estado.equals("Bloqueada")) {
                System.out.println("❌ ACCESO DENEGADO: La cuenta está bloqueada.");
                registrarHistorial(id, "Bloqueado");
                return null;
            }

            // Comparamos las contraseñas
            if (password.trim().equals(dbPassword.trim())) {
                System.out.println(" ¡CONTRASEÑA CORRECTA! Generando acceso...");
                
                String sqlExito = "UPDATE usuarios SET intentos_fallidos = 0, ultimo_acceso = NOW() WHERE id = ?";
                java.sql.PreparedStatement psExito = cn.prepareStatement(sqlExito);
                psExito.setInt(1, id);
                psExito.executeUpdate();

                registrarHistorial(id, "Exitoso");

                u = new Usuario();
                u.setId(id);
                u.setNombre(rs.getString("nombre")); 
                u.setCorreo(rs.getString("correo"));
                u.setRol(rs.getString("id_rol"));
            } else {
                System.out.println("❌ CONTRASEÑA INCORRECTA. Sumando intento fallido.");
                intentos++; 
                String nuevoEstado = (intentos >= 3) ? "Bloqueada" : "Activa";
                
                String sqlFallo = "UPDATE usuarios SET intentos_fallidos = ?, estado_cuenta = ? WHERE id = ?";
                java.sql.PreparedStatement psFallo = cn.prepareStatement(sqlFallo);
                psFallo.setInt(1, intentos);
                psFallo.setString(2, nuevoEstado);
                psFallo.setInt(3, id);
                psFallo.executeUpdate();

                registrarHistorial(id, "Fallido");
            }
        } else {
            System.out.println("❌ ERROR: No se encontró ningún registro con el correo: [" + correo + "]");
        }
    } catch (Exception e) {
        System.out.println("❌ EXCEPCIÓN SQL/JAVA: " + e.getMessage());
        e.printStackTrace();
    }
    return u;
}
    // Método auxiliar para guardar en historial_logins
    private void registrarHistorial(int idUsuario, String estadoIntento) {
        try {
            java.sql.Connection cn = config.Conexion.getConexion();
            String sql = "INSERT INTO historial_logins (id_usuario, estado_intento) VALUES (?, ?)";
            java.sql.PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            ps.setString(2, estadoIntento);
            ps.executeUpdate();
        } catch (Exception e) {
             e.printStackTrace();
        }
    }
}