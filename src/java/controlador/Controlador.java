/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Consejo;
import modelo.ConsejoDAO;

public class Controlador extends HttpServlet {

    ConsejoDAO dao = new ConsejoDAO();
    Consejo c = new Consejo();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        
        // Acción por defecto: Listar
        if (accion == null || accion.equalsIgnoreCase("listar")) {
            List<Consejo> lista = dao.listar();
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } 
        
        // Acción para Agregar
        else if (accion.equalsIgnoreCase("Agregar")) {
            String titulo = request.getParameter("txtTitulo");
            String categoria = request.getParameter("txtCategoria");
            String desc = request.getParameter("txtDesc");
            String riesgo = request.getParameter("txtRiesgo");
            
            c.setTitulo(titulo);
            c.setCategoria(categoria);
            c.setDescripcion(desc);
            c.setNivel_riesgo(riesgo);
            dao.agregar(c);
            response.sendRedirect("Controlador?accion=listar");
        }
        
        // Acción para cargar datos en el formulario de Edición
        else if (accion.equalsIgnoreCase("editar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Consejo consejo = dao.listarId(id);
            request.setAttribute("consejo", consejo);
            request.getRequestDispatcher("editar.jsp").forward(request, response);
        }
        
        // Acción para actualizar los datos editados
        else if (accion.equalsIgnoreCase("Actualizar")) {
            int id = Integer.parseInt(request.getParameter("txtId"));
            String titulo = request.getParameter("txtTitulo");
            String categoria = request.getParameter("txtCategoria");
            String desc = request.getParameter("txtDesc");
            String riesgo = request.getParameter("txtRiesgo");
            
            c.setId(id);
            c.setTitulo(titulo);
            c.setCategoria(categoria);
            c.setDescripcion(desc);
            c.setNivel_riesgo(riesgo);
            dao.editar(c);
            response.sendRedirect("Controlador?accion=listar");
        }
        
        // Acción para Eliminar
        else if (accion.equalsIgnoreCase("eliminar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);
            response.sendRedirect("Controlador?accion=listar");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}