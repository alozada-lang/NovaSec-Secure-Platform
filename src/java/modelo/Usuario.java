/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

public class Usuario {
    private int id;
    private String user;
    private String pass;
    private int progreso;

    public Usuario() {}
    // Genera los Getters y Setters (clic derecho -> Insert Code -> Getter and Setter)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUser() { return user; }
    public void setUser(String user) { this.user = user; }
    public String getPass() { return pass; }
    public void setPass(String pass) { this.pass = pass; }
    public int getProgreso() { return progreso; }
    public void setProgreso(int progreso) { this.progreso = progreso; }
}