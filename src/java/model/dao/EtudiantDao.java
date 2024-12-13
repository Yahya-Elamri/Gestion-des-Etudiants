/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dao;

/**
 *
 * @author yahya
 */
import java.util.Date;
import java.util.List;
import java.util.Map;
import model.entity.User;

public interface EtudiantDao {
    List<User> searchByNameOrCne(String keyword);
    User searchByCne(String keyword);
    void updateUserAndNotes(String etudiantId,String cne, String newNom, String newPrenom, String newAdresse, Date newDateNaissance,String newMotDePasse,Map<String, Double> updatedNotes);
    void saveWithDefaultNotes(User etudiant);
    public List<User> getAllEtudiantsWithNotes();
    User getEtudiantWithCne(String cne);
    void deleteUserByCne(String cne);
}

