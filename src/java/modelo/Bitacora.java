/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

public class Bitacora {
    
    private int id;
    private String tipoAtaque;
    private String descripcion;
    private String nivelAmenaza;
    private String fecha;

    // Constructor
    public Bitacora(int id, String tipoAtaque, String descripcion, String nivelAmenaza, String fecha) {
        this.id = id;
        this.tipoAtaque = tipoAtaque;
        this.descripcion = descripcion;
        this.nivelAmenaza = nivelAmenaza;
        this.fecha = fecha;
    }

    // --- ESTOS SON LOS GETTERS QUE TE FALTABAN ---
    public int getId() {
        return id;
    }

    public String getTipoAtaque() {
        return tipoAtaque;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getNivelAmenaza() {
        return nivelAmenaza;
    }

    public String getFecha() {
        return fecha;
    }

    // --- SETTERS ---
    public void setId(int id) {
        this.id = id;
    }

    public void setTipoAtaque(String tipoAtaque) {
        this.tipoAtaque = tipoAtaque;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setNivelAmenaza(String nivelAmenaza) {
        this.nivelAmenaza = nivelAmenaza;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
}