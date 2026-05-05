/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import config.Conexion; // Importamos tu clase de conexión
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BitacoraDAO {
    
    // 1. Creamos los objetos para la conexión
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // 2. Metemos el método AQUÍ ADENTRO
    public List<Bitacora> listarAtaques() {
        List<Bitacora> lista = new ArrayList<>();
        String sql = "SELECT * FROM bitacora_waf ORDER BY fecha_intento DESC";
        
        try {
            con = cn.getConnection(); // Usamos tu método para conectar
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Bitacora b = new Bitacora(
                    rs.getInt("id"),
                    rs.getString("tipo_ataque"),
                    rs.getString("descripcion_intento"),
                    rs.getString("nivel_amenaza"),
                    rs.getString("fecha_intento")
                );
                lista.add(b);
            }
        } catch (Exception e) {
            System.err.println("Error en DAO: " + e);
        }
        return lista;
    }
}