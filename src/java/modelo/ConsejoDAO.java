/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ConsejoDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // 1. MÉTODO PARA LISTAR (CONSULTA)
    public List<Consejo> listar() {
        ArrayList<Consejo> lista = new ArrayList<>();
        String sql = "SELECT * FROM consejos";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Consejo c = new Consejo();
                c.setId(rs.getInt("id"));
                c.setTitulo(rs.getString("titulo"));
                c.setCategoria(rs.getString("categoria"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setNivel_riesgo(rs.getString("nivel_riesgo"));
                c.setFecha_registro(rs.getString("fecha_registro"));
                lista.add(c);
            }
        } catch (Exception e) {
            System.err.println("Error al listar: " + e);
        }
        return lista;
    }

    // 2. MÉTODO PARA AGREGAR (ALTA)
    public int agregar(Consejo c) {
        String sql = "INSERT INTO consejos(titulo, categoria, descripcion, nivel_riesgo) VALUES(?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, c.getTitulo());
            ps.setString(2, c.getCategoria());
            ps.setString(3, c.getDescripcion());
            ps.setString(4, c.getNivel_riesgo());
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error al agregar: " + e);
        }
        return 1;
    }

    // 3. MÉTODO PARA EDITAR (BUSCAR POR ID)
    public Consejo listarId(int id) {
        Consejo c = new Consejo();
        String sql = "SELECT * FROM consejos WHERE id=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                c.setId(rs.getInt("id"));
                c.setTitulo(rs.getString("titulo"));
                c.setCategoria(rs.getString("categoria"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setNivel_riesgo(rs.getString("nivel_riesgo"));
            }
        } catch (Exception e) {
        }
        return c;
    }

    // 4. MÉTODO PARA ACTUALIZAR (EDICIÓN)
    public int editar(Consejo c) {
        String sql = "UPDATE consejos SET titulo=?, categoria=?, descripcion=?, nivel_riesgo=? WHERE id=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, c.getTitulo());
            ps.setString(2, c.getCategoria());
            ps.setString(3, c.getDescripcion());
            ps.setString(4, c.getNivel_riesgo());
            ps.setInt(5, c.getId());
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return 1;
    }

    // 5. MÉTODO PARA ELIMINAR (BORRADO)
    public void eliminar(int id) {
        String sql = "DELETE FROM consejos WHERE id=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
}