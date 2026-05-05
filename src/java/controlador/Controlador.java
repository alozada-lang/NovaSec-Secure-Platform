package controlador;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.*;

public class Controlador extends HttpServlet {

    // Instancias de los DAO
    ConsejoDAO dao = new ConsejoDAO();
    Consejo c = new Consejo();
    
    UsuarioDAO uDao = new UsuarioDAO();
    Usuario u = new Usuario();
    
    ComentarioDAO comDao = new ComentarioDAO(); // Motor para los comentarios
    
    // --- AQUÍ AGREGAMOS LA INSTANCIA DE BITACORA ---
    BitacoraDAO bDao = new BitacoraDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();
        
        // 1. ACCIÓN POR DEFECTO: LISTAR CONSEJOS
        if (accion == null || accion.equalsIgnoreCase("listar")) {
            List<Consejo> lista = dao.listar();
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } 
        
        // 2. REGISTRO DE USUARIOS
        else if (accion.equalsIgnoreCase("RegistrarUsuario")) {
            String nom = request.getParameter("txtUser");
            String pass = request.getParameter("txtPass");
            
            if(pass.length() < 8) {
                request.setAttribute("error", "La contraseña debe tener al menos 8 caracteres.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                u.setUser(nom);
                u.setPass(pass);
                uDao.registrar(u);
                request.setAttribute("error", "Cuenta creada con éxito. Ahora inicia sesión."); 
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }

        // 3. LOGIN (INGRESAR)
        else if (accion.equalsIgnoreCase("Ingresar")) {
            String nom = request.getParameter("txtUser");
            String pass = request.getParameter("txtPass");
            u = uDao.validar(nom, pass);
            
            if (u.getUser() != null) {
                session.setAttribute("usuario", u);
                request.getRequestDispatcher("indexdos.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Usuario o contraseña incorrectos");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
        
        // 4. CERRAR SESIÓN
        else if (accion.equalsIgnoreCase("Salir")) {
            session.invalidate(); 
            response.sendRedirect("login.jsp");
        }

        // 5. VALIDAR LECCIÓN (PROGRESO)
        else if (accion.equalsIgnoreCase("ValidarLeccion")) {
            int leccionID = Integer.parseInt(request.getParameter("leccionID"));
            Usuario userLogueado = (Usuario) session.getAttribute("usuario");
            
            int totalLecciones = 2;

            // Actualizamos progreso en el objeto de sesión
            if (userLogueado != null && userLogueado.getProgreso() < totalLecciones && userLogueado.getProgreso() < leccionID) {
                userLogueado.setProgreso(leccionID);
                // Si tienes un método en uDao para actualizar en DB, llámalo aquí:
                // uDao.actualizarProgreso(userLogueado);
            }
            
            session.setAttribute("usuario", userLogueado);
            response.sendRedirect("curso.jsp?leccion=" + (leccionID + 1));
        }

        // 6. GUARDAR COMENTARIO FINAL
        else if (accion.equalsIgnoreCase("GuardarComentario")) {
            Usuario userLogueado = (Usuario) session.getAttribute("usuario");
            String mensaje = request.getParameter("mensaje");
            String nombreUsuario = (userLogueado != null) ? userLogueado.getUser() : "Anónimo";
            
            // Creamos el objeto comentario y usamos el DAO para enviarlo a MySQL
            Comentario nuevoCom = new Comentario(nombreUsuario, mensaje);
            comDao.agregar(nuevoCom);
            
            response.sendRedirect("indexdos.jsp");
        }

        // 7. ACCIONES DE LOS TIPS (CRUD)
        else if (accion.equalsIgnoreCase("Agregar")) {
            c.setTitulo(request.getParameter("txtTitulo"));
            c.setCategoria(request.getParameter("txtCategoria"));
            c.setDescripcion(request.getParameter("txtDesc"));
            c.setNivel_riesgo(request.getParameter("txtRiesgo"));
            dao.agregar(c);
            response.sendRedirect("Controlador?accion=listar");
        }
        
        else if (accion.equalsIgnoreCase("editar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Consejo consejo = dao.listarId(id);
            request.setAttribute("consejo", consejo);
            request.getRequestDispatcher("editar.jsp").forward(request, response);
        }
        
        else if (accion.equalsIgnoreCase("Actualizar")) {
            c.setId(Integer.parseInt(request.getParameter("txtId")));
            c.setTitulo(request.getParameter("txtTitulo"));
            c.setCategoria(request.getParameter("txtCategoria"));
            c.setDescripcion(request.getParameter("txtDesc"));
            c.setNivel_riesgo(request.getParameter("txtRiesgo"));
            dao.editar(c);
            response.sendRedirect("Controlador?accion=listar");
        }
        
        else if (accion.equalsIgnoreCase("eliminar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);
            response.sendRedirect("Controlador?accion=listar");
        }
        
        // --- 8. NUEVO CASO: MOSTRAR LOGS DEL WAF ---
        else if (accion.equalsIgnoreCase("ListarLogs")) {
            List<Bitacora> listaLogs = bDao.listarAtaques();
            request.setAttribute("listaAtaques", listaLogs);
            request.getRequestDispatcher("logs.jsp").forward(request, response);
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