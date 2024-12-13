/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.EtudiantDaoImpl;

/**
 *
 * @author yahya
 */

public class DeleteStudent extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestAccesBD-JPAPU");
                EntityManager em = emf.createEntityManager();
                EtudiantDaoImpl etudiant = new EtudiantDaoImpl();
                etudiant.setEntityManager(em);
                try{
                    etudiant.deleteUserByCne(request.getParameter("cne"));
                    response.sendRedirect("/TP5/admin");
                } catch (IOException e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Error occurred while adding student: " + e.getMessage());
                }
            
    }
}
