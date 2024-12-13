/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  yahya
 * Created: 3 déc. 2024
 */

-- Create the database
CREATE DATABASE bd_m2i_s1;

-- Use the database
USE bd_m2i_s1;

-- Create the admin user
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'master2024';
GRANT ALL PRIVILEGES ON bd_m2i_s1.* TO 'admin'@'localhost';

-- Create the students table (Étudiants)
CREATE TABLE etudiants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    cne VARCHAR(15) UNIQUE NOT NULL,
    date_naissance DATE NOT NULL,
    adresse VARCHAR(255),
    mot_de_passe VARCHAR(255)
);

-- Create the grades table (Notes)
CREATE TABLE notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    etudiant_id INT NOT NULL,
    module VARCHAR(50) NOT NULL,
    note DECIMAL(4, 2) NOT NULL CHECK (note BETWEEN -1 AND 20),
    FOREIGN KEY (etudiant_id) REFERENCES etudiants(id) ON DELETE CASCADE
);