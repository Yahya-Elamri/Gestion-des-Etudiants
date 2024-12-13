<%-- 
    Document   : home
    Created on : 2 déc. 2024, 23:15:15
    Author     : yahya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entity.User" %>
<%@ page import="model.entity.Module" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Étudiants</title>
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
                    <a href="admin" class="flex items-center p-2 text-gray-700 rounded-lg bg-gray-100 hover:bg-gray-200 group">
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
                    <a href="gestStudent?cne=F123456" class="flex items-center p-2 text-gray-700  rounded-lg hover:bg-gray-200 group">
                        <i class="ri-settings-3-line mr-3 text-gray-600"></i>
                        <span>Gérer les étudiants</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-10">
                <!-- Header -->
                <div class="flex justify-between items-center mb-8">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-800">Liste des Étudiants</h1>
                        <p class="text-gray-500">Gérez les informations et les notes des étudiants</p>
                    </div>

                    <div class="flex space-x-4">
                        <!-- Search -->
                        <div class="relative">
                            
                            <form action="" method="GET">
                                <input 
                                    type="text"
                                    name="keyword"
                                    id="searchInput"
                                    placeholder="Rechercher..."
                                    class="w-64 pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none"
                                >
                                <i class="ri-search-line absolute left-3 top-3 text-gray-400"></i>                            
                            </form>
                        </div>

                        <a href="addStudent" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 flex items-center">
                            <i class="ri-add-line mr-2"></i>Ajouter
                        </a>
                    </div>
                </div>

                <%
            // Assume the list of users is set as a request attribute
            List<User> users = (List<User>) request.getAttribute("users");
        %>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <% for (User user : users) { %>
                <div class="bg-white shadow-md rounded-lg overflow-hidden">
                    <div class="p-6 bg-gradient-to-r from-blue-500 to-blue-600 text-white">
                        <div class="flex justify-between items-center">
                            <div>
                                <h3 class="text-lg font-bold"><%= user.getNom() %> <%= user.getPrenom() %></h3>
                                <p class="text-sm opacity-80">CNE: <%= user.getCne() %></p>
                            </div>
                            <div class="flex space-x-2">
                                <a href="gestStudent?cne=<%= user.getCne() %>" class="text-white hover:bg-white/20 py-1 px-2 rounded-full">
                                    <i class="ri-edit-line"></i>
                                </a>
                                <a href="gestStudent?cne=<%= user.getCne() %>" class="text-white hover:bg-white/20 py-1 px-2 rounded-full">
                                    <i class="ri-delete-bin-line"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="p-6">
                        <div class="grid grid-cols-2 gap-4">
                            <% 
                                List<Module> modules = user.getModulesEtudiants();
                                for (Module mod : modules) { 
                            %>
                                <div class="bg-gray-100 p-3 rounded-lg text-center">
                                    <span class="block text-xs text-gray-500 mb-1"><%= mod.getModule() %></span>
                                    <span class="text-lg font-bold <%= mod.getNote() >= 10 ? "text-blue-600" : "text-red-500" %>">
                                        <% if (mod.getNote() < 0) { %>
                                            (absent)
                                        <% } else { %>
                                            <%= mod.getNote() %>/20
                                        <% } %>
                                    </span>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
        </div>
    </div>
</body>
</html>

