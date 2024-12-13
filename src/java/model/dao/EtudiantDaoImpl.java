/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

/**
 *
 * @author yahya
 */

import jakarta.persistence.*;
import jakarta.transaction.Transactional;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import model.entity.User;
import model.entity.Module;

public class EtudiantDaoImpl implements EtudiantDao {
    @PersistenceContext(unitName = "TestAccesBD-JPAPU")
    private EntityManager em;

    private static final List<String> MODULES = List.of(
        "Geographie", "Histoire", "Biologie", "Chimie", "Physique", "Informatique", "Mathematiques"
    );

    
    @Override
    @Transactional
    public List<User> getAllEtudiantsWithNotes() {
        List<User> etudiants = new ArrayList<>();
        try {
            // Correct entity name with capital letters
            TypedQuery<User> query = em.createQuery("SELECT e FROM User e", User.class);
            etudiants = query.getResultList();

            if (etudiants.isEmpty()) {
                System.out.println("No students found.");
            }

            for (User etudiant : etudiants) {
                TypedQuery<Module> notesQuery = em.createQuery(
                    "SELECT n FROM Module n WHERE n.etudiant.id = :etudiantId", Module.class
                );
                notesQuery.setParameter("etudiantId", etudiant.getId());
                List<Module> notes = notesQuery.getResultList();

                if (notes.isEmpty()) {
                    System.out.println("No modules found for student with ID: " + etudiant.getId());
                }

                etudiant.setModulesEtudiants(notes);
            }
        } catch (Exception e) {
            throw new RuntimeException("Error while fetching students and notes", e);
        }

        return etudiants;
    }

    @Override
    @Transactional
    public User getEtudiantWithCne(String cne) {
        User etudiant = null;
        try {
            // Query to find the user by CNE
            TypedQuery<User> userQuery = em.createQuery(
                "SELECT e FROM User e WHERE e.cne = :cne",
                User.class
            );
            userQuery.setParameter("cne", cne);

            List<User> users = userQuery.getResultList();

            if (users.isEmpty()) {
                System.out.println("No student found with CNE: " + cne);
                return null;
            }

            etudiant = users.get(0); // Assuming CNE is unique

            // Query to fetch modules for the specific user
            TypedQuery<Module> notesQuery = em.createQuery(
                "SELECT n FROM Module n WHERE n.etudiant.id = :etudiantId",
                Module.class
            );
            notesQuery.setParameter("etudiantId", etudiant.getId());

            List<Module> notes = notesQuery.getResultList();

            if (notes.isEmpty()) {
                System.out.println("No modules found for student with CNE: " + cne);
            }

            etudiant.setModulesEtudiants(notes);

        } catch (Exception e) {
            throw new RuntimeException("Error while fetching student and notes", e);
        }

        return etudiant;
    }


    @Override
    @Transactional
    public void saveWithDefaultNotes(User etudiant) {
        em.getTransaction().begin();
        em.persist(etudiant);

        // Initialize notes for all modules
        for (String module : MODULES) {
            Module note = new Module();
            note.setEtudiant(etudiant);
            note.setModule(module);
            note.setNote(0.0);
            em.persist(note);
        }

        em.getTransaction().commit();
    }

    @Override
    @Transactional
    public void updateUserAndNotes(String etudiantId,String cne, String newNom, String newPrenom, String newAdresse, Date newDateNaissance, String newMotDePasse, Map<String, Double> updatedNotes) {
        try {
            em.getTransaction().begin();
            if (etudiantId == null) {
                throw new IllegalArgumentException("User with CNE " + cne + " not found.");
            }

            // Step 2: Update the user's personal information
            em.createQuery(
                    "UPDATE User u SET u.nom = :newNom, u.prenom = :newPrenom, " +
                    "u.adresse = :newAdresse, u.dateNaissance = :newDateNaissance, " +
                    "u.motDePasse = :newMotDePasse WHERE u.cne = :cne")
                    .setParameter("newNom", newNom)
                    .setParameter("newPrenom", newPrenom)
                    .setParameter("newAdresse", newAdresse)
                    .setParameter("newDateNaissance", newDateNaissance)
                    .setParameter("newMotDePasse", newMotDePasse)
                    .setParameter("cne", cne)
                    .executeUpdate();

            // Step 3: Update the notes for the modules
            for (Map.Entry<String, Double> entry : updatedNotes.entrySet()) {
                em.createQuery(
                        "UPDATE Module m SET m.note = :newNote " +
                        "WHERE m.module = :module AND m.etudiant.id = :etudiantId")
                        .setParameter("newNote", entry.getValue())
                        .setParameter("module", entry.getKey())
                        .setParameter("etudiantId", etudiantId)
                        .executeUpdate();
            }
            em.getTransaction().commit();
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Error updating user and notes", e);
        }
    }
 

    @Override
    @Transactional
    public List<User> searchByNameOrCne(String keyword) {
        List<User> etudiants = new ArrayList<>();
        try {
            // Correct entity name with capital letters
            TypedQuery<User> query = em.createQuery("SELECT e FROM User e WHERE e.nom LIKE :keyword OR e.prenom LIKE :keyword OR e.cne LIKE :keyword", User.class)
                .setParameter("keyword", "%" + keyword + "%");
            etudiants = query.getResultList();

            if (etudiants.isEmpty()) {
                System.out.println("No students found.");
            }

            for (User etudiant : etudiants) {
                TypedQuery<Module> notesQuery = em.createQuery(
                    "SELECT n FROM Module n WHERE n.etudiant.id = :etudiantId", Module.class
                );
                notesQuery.setParameter("etudiantId", etudiant.getId());
                List<Module> notes = notesQuery.getResultList();

                if (notes.isEmpty()) {
                    System.out.println("No modules found for student with ID: " + etudiant.getId());
                }

                etudiant.setModulesEtudiants(notes);
            }
        } catch (Exception e) {
            throw new RuntimeException("Error while fetching students and notes", e);
        }

        return etudiants;
    }

    @Override
    public User searchByCne(String keyword) {
        return em.createQuery(
        "SELECT DISTINCT e FROM User e " + 
        "LEFT JOIN FETCH e.modulesEtudiants m " + 
        "WHERE e.cne = :cne", User.class)
        .setParameter("cne", keyword)
        .getSingleResult();
    }
    
    @Override
    @Transactional
    public void deleteUserByCne(String cne) {
        try {
            em.getTransaction().begin();
            TypedQuery<User> userQuery = em.createQuery(
                "SELECT e FROM User e WHERE e.cne = :cne",
                User.class
            );
            userQuery.setParameter("cne", cne);

            List<User> users = userQuery.getResultList();

            if (users.isEmpty()) {
                System.out.println("No student found with CNE: " + cne);
                return;
            }

            User etudiant = users.get(0); // Assuming CNE is unique

            System.out.println("******************** etudiant a : "+etudiant.getNom());
            // Remove the user
            em.remove(em.contains(etudiant) ? etudiant : em.merge(etudiant));
            System.out.println("Student with CNE: " + cne + " has been deleted.");
            em.getTransaction().commit();
        } catch (Exception e) {
            throw new RuntimeException("Error while deleting student with CNE: " + cne, e);
        }
    }
    
    // Setter for EntityManager (used in manual setup)
    public void setEntityManager(EntityManager em) {
        this.em = em;
    }

}

