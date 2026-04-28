/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import config.Conexion;
import java.security.MessageDigest;
import java.sql.*;

public class UsuarioDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

   
    
    public void actualizarProgreso(int idUsuario, int nuevaLeccion) {
    String sql = "UPDATE usuarios SET progreso_leccion = ? WHERE id_usuario = ?";
    try {
        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, nuevaLeccion);
        ps.setInt(2, idUsuario);
        ps.executeUpdate();
    } catch (Exception e) { System.out.println("Error progreso: " + e); }
}
    
    
    // Método para cifrar (Capa de protección)
    
    public String hashPassword(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception ex) { return null; }
    }

    public int registrar(Usuario u) {
        String sql = "INSERT INTO usuarios(nombre_usuario, password_hash) VALUES(?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, u.getUser());
            ps.setString(2, hashPassword(u.getPass())); // Guardamos la clave cifrada
            return ps.executeUpdate();
        } catch (Exception e) { return 0; }
    }

    public Usuario validar(String user, String pass) {
        Usuario u = new Usuario();
        String sql = "SELECT * FROM usuarios WHERE nombre_usuario=? AND password_hash=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, hashPassword(pass)); // Comparamos contra el hash
            rs = ps.executeQuery();
            while (rs.next()) {
                u.setId(rs.getInt("id_usuario"));
                u.setUser(rs.getString("nombre_usuario"));
                u.setProgreso(rs.getInt("progreso_leccion"));
            }
        } catch (Exception e) {}
        return u;
        
              
    }
}