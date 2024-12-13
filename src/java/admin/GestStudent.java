/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.dao.EtudiantDaoImpl;
import model.entity.User;


/**
 *
 * @author yahya
 */

public class GestStudent extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                HttpSession session = request.getSession(false);
                if (session == null || session.getAttribute("cne") == null) {
                    response.sendRedirect("/TP5");
                    return;
                } 
                try {                  
                    EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestAccesBD-JPAPU");
                    EntityManager em = emf.createEntityManager();
                    EtudiantDaoImpl etudiant = new EtudiantDaoImpl();
                    etudiant.setEntityManager(em);
                    User users = etudiant.searchByCne(request.getParameter("cne"));
                    request.setAttribute("user", users);
                } catch (Exception e) {
                    request.setAttribute("error", "An error occurred while fetching data: " + e.getMessage());
                }

        // Forward to JSP for rendering
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/adminDash/gestStudent.jsp");
        dispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            EntityManagerFactory emf = null;
            EntityManager em = null;
            try {
                // Initialize EntityManager
                emf = Persistence.createEntityManagerFactory("TestAccesBD-JPAPU");
                em = emf.createEntityManager();
                EtudiantDaoImpl etudiant = new EtudiantDaoImpl();
                etudiant.setEntityManager(em);
                // Parse date of birth
                try {
                // Parse date of birth
                    String dateString = request.getParameter("dateNaissance");
                    Date date = null;
                    if (dateString != null && !dateString.trim().isEmpty()) {
                        try {
                            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                            date = format.parse(dateString);
                        } catch (ParseException e) {
                            throw new ServletException("Invalid date format: " + dateString, e);
                        }
                    }

                    // Fetch and validate updated notes
                    Map<String, Double> updatedNotes = new HashMap<>();
                    List<String> MODULES = List.of("Geographie", "Histoire", "Biologie", "Chimie", "Physique", "Informatique", "Mathematiques");
                    for (String module : MODULES) {
                        String noteString = request.getParameter(module);
                        if (noteString != null && !noteString.trim().isEmpty()) {
                            try {
                                updatedNotes.put(module, Double.valueOf(noteString.trim()));
                            } catch (NumberFormatException e) {
                                throw new ServletException("Invalid note value for module: " + module, e);
                            }
                        }
                    }
                    
                    
                    // Use injected service/DAO layer for database operation
                    etudiant.updateUserAndNotes(
                            request.getParameter("id"),
                            request.getParameter("cne"),
                            request.getParameter("nom"),
                            request.getParameter("prenom"),
                            request.getParameter("adresse"),
                            date,
                            request.getParameter("motDePasse"),
                            updatedNotes
                    );

                    // Redirect to the admin page
                    response.sendRedirect("/TP5/admin");
                } catch (ServletException | IOException e) {
                    // Log the error and display a user-friendly message
                    request.setAttribute("error", "An error occurred while processing the request: " + e.getMessage());
                    request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                }
            }catch (ServletException | IOException e) {
                    // Log the error and display a user-friendly message
                    request.setAttribute("error", "An error occurred while processing the request: " + e.getMessage());
                    request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
            } 
        }

    
}
