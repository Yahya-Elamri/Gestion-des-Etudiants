<%-- 
    Document   : home
    Created on : 2 déc. 2024, 20:52:13
    Author     : yahya
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Étudiant</title>
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
            <p class="text-sm text-gray-500">Tableau de Bord Étudiant</p>
        </div>
        
        <nav class="p-4">
            <ul class="space-y-2">
                <li>
                    <a href="#profile" class="flex items-center p-2 text-gray-700 bg-gray-100 rounded-lg hover:bg-gray-200 group">
                        <i class="ri-user-line mr-3 text-gray-600"></i>
                        <span>Profil</span>
                    </a>
                </li>
                <li>
                    <a href="#grades" class="flex items-center p-2 text-gray-700 rounded-lg hover:bg-gray-200 group">
                        <i class="ri-book-line mr-3 text-gray-600"></i>
                        <span>Mes Notes</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <!-- Profile Section -->
        <div id="profile" class="mb-12">
            <h1 class="text-3xl font-bold text-gray-800 mb-4">Mon Profil</h1>
            <div class="bg-white shadow-md rounded-lg p-6">
                <div class="flex items-center space-x-4">
                    <img 
                        src="https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg" 
                        alt="Photo de profil" 
                        class="h-24 w-24 rounded-full object-cover border"
                    />
                    <div>
                        <h2 class="text-lg font-bold text-gray-800">${user.nom} ${user.prenom}</h2>
                        <p class="text-gray-500">CNE: ${user.cne}</p>
                        <p class="text-gray-500">Adresse: ${user.adresse}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Grades Section -->
        <div id="grades">
            <h1 class="text-3xl font-bold text-gray-800 mb-4">Mes Notes</h1>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach var="m" items="${user.modulesEtudiants}">
                        <div class="bg-white shadow-md rounded-lg overflow-hidden">
                            <div class="p-6 bg-gradient-to-r from-blue-500 to-blue-600 text-white">
                                <h3 class="text-lg font-bold">${m.module}</h3>
                            </div>
                            <div class="p-6">
                                <p class="text-gray-500 mb-2">Note obtenue :</p>
                                <c:if test="${m.note == -1}">
                                    <p class="text-2xl font-bold text-red-500">(Absent)</p>
                                </c:if>
                                <c:if test="${m.note != -1}">
                                    <p class="text-2xl font-bold text-blue-600">${m.note} / 20</p>
                                </c:if>
                            </div>
                        </div>
                </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>



