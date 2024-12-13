/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package authentification;

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
public class auth extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                String cne = request.getParameter("cne");
                String password = request.getParameter("password");
                if ("admin".equals(cne) && "admin".equals(password)){
                    HttpSession session = request.getSession();
                    session.setAttribute("cne", "admin");
                    session.setMaxInactiveInterval(2 * 60);
                    response.sendRedirect("admin");
                } else {
                    EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestAccesBD-JPAPU");
                    EntityManager em = emf.createEntityManager();
                    EtudiantDaoImpl etudiant = new EtudiantDaoImpl();
                    etudiant.setEntityManager(em);
                    User user = etudiant.searchByCne(cne);
                    if (cne.equals(user.getCne()) && password.equals(user.getMotDePasse())){
                        HttpSession session = request.getSession();
                        session.setAttribute("cne", cne);
                        session.setAttribute("id", user.getId());
                        session.setMaxInactiveInterval(2 * 60);
                        response.sendRedirect("home");
                    }else {
                        request.setAttribute("errMsg", "block");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                        dispatcher.forward(request, response);
                    }
                }
    }
}
