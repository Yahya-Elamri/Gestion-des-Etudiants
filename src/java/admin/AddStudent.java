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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.dao.EtudiantDaoImpl;
import model.entity.User;

/**
 *
 * @author yahya
 */
public class AddStudent extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            RequestDispatcher rd = null;
            rd = getServletContext().getRequestDispatcher("/WEB-INF/adminDash/addStudent.jsp");
            rd.forward(request,response );
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestAccesBD-JPAPU");
                EntityManager em = emf.createEntityManager();
                User user = new User();
                EtudiantDaoImpl etudiant = new EtudiantDaoImpl();
                etudiant.setEntityManager(em);
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                user.setPrenom(request.getParameter("prenom"));
                user.setNom(request.getParameter("nom"));
                user.setCne(request.getParameter("cne"));
                user.setAdresse(request.getParameter("adresse"));
                user.setMotDePasse(request.getParameter("motDePasse"));
                String dateString = request.getParameter("dateNaissance"); 
                
                try {
                    Date date = format.parse(dateString);
                    user.setDateNaissance(date);
                } catch (ParseException e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Error occurred while parsing date " + e.getMessage());
                }

                try{
                    etudiant.saveWithDefaultNotes(user);
                    response.sendRedirect("/TP5/admin");
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Error occurred while adding student: " + e.getMessage());
                }
            
    }
}