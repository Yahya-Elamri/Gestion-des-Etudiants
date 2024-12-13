/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  yahya
 * Created: 3 déc. 2024
 */

-- Insert Moroccan data into the etudiants table
INSERT INTO etudiants (nom, prenom, cne, date_naissance, adresse, mot_de_passe)
VALUES 
    ('El Bouzidi', 'Ahmed', 'F123456', '1998-03-15', 'Casablanca, Maroc', 'test'),
    ('Chafik', 'Fatima', 'A789012', '2000-07-22', 'Rabat, Maroc', 'A789012'),
    ('Benali', 'Mohamed', 'FA345678', '1997-11-05', 'Fès, Maroc', 'FA345678'),
    ('Haddadi', 'Sara', 'D901234', '1999-01-18', 'Marrakech, Maroc', 'D901234'),
    ('Ouazzani', 'Youssef', 'ED567890', '1998-05-10', 'Agadir, Maroc', 'ED567890');

-- Insert sample data into the notes table with 7 modules in French
INSERT INTO notes (etudiant_id, module, note)
VALUES
    (1, 'Mathematiques', 16.5),
    (1, 'Informatique', 14.0),
    (1, 'Physique', 17.5),
    (1, 'Chimie', 15.0),
    (1, 'Biologie', 16.0),
    (1, 'Histoire', 14.5),
    (1, 'Geographie', 13.0),
    
    (2, 'Mathematiques', 12.0),
    (2, 'Informatique', 10.0),
    (2, 'Physique', 13.0),
    (2, 'Chimie', 11.5),
    (2, 'Biologie', 12.0),
    (2, 'Histoire', 13.5),
    (2, 'Geographie', 14.0),
    
    (3, 'Mathematiques', -1),
    (3, 'Informatique', 15.0),
    (3, 'Physique', 16.0),
    (3, 'Chimie', 14.0),
    (3, 'Biologie', 15.5),
    (3, 'Histoire', 16.0),
    (3, 'Geographie', 14.5),
    
    (4, 'Mathematiques', 18.0),
    (4, 'Informatique', 19.5),
    (4, 'Physique', 17.0),
    (4, 'Chimie', 18.5),
    (4, 'Biologie', 19.0),
    (4, 'Histoire', 18.0),
    (4, 'Geographie', 17.5),
    
    (5, 'Mathematiques', 13.0),
    (5, 'Informatique', 11.0),
    (5, 'Physique', 14.5),
    (5, 'Chimie', 12.0),
    (5, 'Biologie', 13.5),
    (5, 'Histoire', 12.5),
    (5, 'Geographie', 14.0);

