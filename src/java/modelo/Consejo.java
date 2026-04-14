/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

public class Consejo {
    private int id;
    private String titulo;
    private String categoria;
    private String descripcion;
    private String nivel_riesgo;
    private String fecha_registro;

    public Consejo() {
    }

    // --- AQUÍ ESTÁ LO QUE FALTABA: GETTERS Y SETTERS ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getNivel_riesgo() { return nivel_riesgo; }
    public void setNivel_riesgo(String nivel_riesgo) { this.nivel_riesgo = nivel_riesgo; }

    public String getFecha_registro() { return fecha_registro; }
    public void setFecha_registro(String fecha_registro) { this.fecha_registro = fecha_registro; }
}