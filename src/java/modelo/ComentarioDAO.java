/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import config.Conexion; // Ajusta según tu paquete de conexión

public class ComentarioDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;

    public int agregar(Comentario com) {
        String sql = "INSERT INTO comentarios (usuario, mensaje) VALUES (?, ?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, com.getUsuario());
            ps.setString(2, com.getMensaje());
            return ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error al guardar comentario: " + e);
        }
        return 0;
    }
}