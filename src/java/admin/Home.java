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
import java.util.List;
import model.dao.EtudiantDaoImpl;
import model.entity.User;
/**
 *
 * @author yahya
 */
public class Home extends HttpServlet {
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
                    List<User> users;
                    if("".equals(request.getParameter("keyword")) || request.getParameter("keyword") == null ){
                        users = etudiant.getAllEtudiantsWithNotes();
                    }else {
                        users = etudiant.searchByNameOrCne(request.getParameter("keyword"));
                    } 
                    request.setAttribute("users", users);
                } catch (Exception e) {
                    request.setAttribute("error", "An error occurred while fetching data: " + e.getMessage());
                }

        // Forward to JSP for rendering
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/adminDash/home.jsp");
        dispatcher.forward(request, response);
    }
}
