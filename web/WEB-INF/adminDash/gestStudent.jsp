<%-- 
    Document   : gestStudent
    Created on : 3 déc. 2024, 13:13:24
    Author     : yahya
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.entity.Module" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gérer Étudiant</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body class="flex min-h-screen bg-gray-100">
    <!-- Sidebar -->
    <div class="w-64 bg-white shadow-md border-r">
        <div class="p-6 border-b flex justify-center items-center flex-col">
            <div class="flex justify-center mb-8">
                <img 
                    src="https://www.ump.ma/assets/logo.webp" 
                    alt="Logo" 
                    class="h-24 w-24 object-contain"
                />
            </div>
            <p class="text-sm text-gray-500">Tableau de Bord Admin</p>
        </div>
        
        <nav class="p-4">
            <ul class="space-y-2">
                <li>
                    <a href="admin" class="flex items-center p-2 text-gray-700 rounded-lg hover:bg-gray-200 group">
                        <i class="ri-user-line mr-3 text-gray-600"></i>
                        <span>Étudiants</span>
                    </a>
                </li>
                <li>
                    <a href="addStudent" class="flex items-center p-2 text-gray-700 rounded-lg hover:bg-gray-200 group">
                        <i class="ri-book-line mr-3 text-gray-600"></i>
                        <span>Ajouter Étudiants</span>
                    </a>
                </li>
                <li>
                    <a href="gestStudent?cne=F123456" class="flex items-center p-2 text-gray-700 bg-gray-100 rounded-lg hover:bg-gray-200 group">
                        <i class="ri-settings-3-line mr-3 text-gray-600"></i>
                        <span>Gérer les étudiants</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Gérer un Étudiant</h1>
        
        <!-- Search Student Section -->
        <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-3xl">
            <form action="gestStudent" method="GET" class="space-y-6">
                <div>
                    <label for="search" class="block text-sm font-medium text-gray-700">Rechercher l'Étudiant</label>
                    <input type="text" id="search" name="cne" placeholder="Entrez CNE de l'Étudiant" required
                        class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                </div>
                <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700">Rechercher</button>
            </form>
        </div>

        <!-- Student Management Form -->
        <div id="student-management" class="mt-10">
            <h2 class="text-2xl font-bold text-gray-700 mb-4">Modifier Étudiant</h2>
            <form action="gestStudent" method="POST" class="bg-white shadow rounded-lg px-6 py-2 space-y-6">
                <input type="hidden" name="id" value="${user.id}"> <!-- Replace with actual ID -->
                <input type="hidden" name="cne" value="${user.cne}"> <!-- Replace with actual ID -->
                <!-- Student Name -->
                <div>
                    <label for="student-name" class="block text-sm font-medium text-gray-700">Nom de l'Étudiant</label>
                    <input type="text" id="student-name" name="nom" value="${user.nom}" required
                        class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                </div>
                <div>
                    <label for="student-name" class="block text-sm font-medium text-gray-700">Prenom de l'Étudiant</label>
                    <input type="text" id="student-name" name="prenom" value="${user.prenom}" required
                        class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                </div>
                <div>
                    <label for="student-name" class="block text-sm font-medium text-gray-700">Date de naissance de l'Étudiant</label>
                    <input type="date" id="student-name" name="dateNaissance" value="${user.dateNaissance}" required
                        class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                </div>
                 <div>
                    <label for="student-name" class="block text-sm font-medium text-gray-700">Adresse de l'Étudiant</label>
                    <input type="text" id="student-name" name="adresse" value="${user.adresse}" required
                        class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                </div>
                <div>
                    <label for="student-name" class="block text-sm font-medium text-gray-700">Mot de passe de l'Étudiant</label>
                    <input type="text" id="student-name" name="motDePasse" value="${user.motDePasse}" required
                        class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                </div>
                    <c:forEach var="m" items="${user.modulesEtudiants}">
                        <div> 
                            <label for="student-name" class="block text-sm font-medium text-gray-700">Note de ${m.module}</label>
                            <input type="text" id="${m.id}" name="${m.module}" value="${m.note}" required
                                    class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none" />
                        </div>         
                    </c:forEach>                    
                <!-- Buttons -->
                <div class="flex space-x-4">
                    <button type="submit" class="bg-green-600 text-white py-2 px-4 rounded-lg hover:bg-green-700">
                        Enregistrer les Modifications
                    </button>
                </div>
            </form>
            <form method="POST" action="deleteStudent" class="p-6" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer cet étudiant ?')">
                <input type="hidden" name="cne" value="${user.cne}">
                <button type="submit" class="bg-red-600 text-white py-2 px-4 rounded-lg hover:bg-red-700">
                    Supprimer Étudiant
                </button>
            </form>
        </div>
    </div>
</body>
</html>

