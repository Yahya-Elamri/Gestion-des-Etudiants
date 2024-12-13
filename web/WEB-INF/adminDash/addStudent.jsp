<%-- 
    Document   : addStudent
    Created on : 3 déc. 2024, 12:59:25
    Author     : yahya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter Étudiant</title>
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
                    <a href="addStudent" class="flex items-center p-2 text-gray-700 rounded-lg bg-gray-100 hover:bg-gray-200 group">
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
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Ajouter un Étudiant</h1>
        <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-4xl">
            <form action="addStudent" method="POST" class="space-y-6" id="addStudentForm">
                <!-- First Row -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                        <input type="text" id="prenom" name="prenom" required class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                    </div>
                    <div>
                        <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
                        <input type="text" id="nom" name="nom" required class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                    </div>
                </div>

                <!-- Second Row -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="cne" class="block text-sm font-medium text-gray-700">CNE</label>
                        <input type="text" id="cne" name="cne" required class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                    </div>
                    <div>
                        <label for="dateNaissance" class="block text-sm font-medium text-gray-700">Date de Naissance</label>
                        <input type="date" id="dateNaissance" name="dateNaissance" required class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                    </div>
                </div>

                <!-- Third Row -->
                <div>
                    <label for="adresse" class="block text-sm font-medium text-gray-700">Adresse</label>
                    <input type="text" id="adresse" name="adresse" required class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                </div>

                <!-- Fourth Row -->
                    <div>
                        <label for="motDePasse" class="block text-sm font-medium text-gray-700">Mot de Passe</label>
                        <input type="password" id="motDePasse" name="motDePasse" required class="w-full px-4 py-2 border rounded-lg focus:ring-blue-500 focus:outline-none">
                    </div>

                <!-- Submit Button -->
                <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700">Ajouter</button>
            </form>
        </div>
    </div>
    <script>
        document.getElementById('addStudentForm').addEventListener('submit', function(event) {
            // Get form inputs
            const prenom = document.getElementById('prenom').value;
            const nom = document.getElementById('nom').value;
            const motDePasse = document.getElementById('motDePasse').value;

            // Validate prenom and nom (only alphabetic characters)
            const nameRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s'-]+$/;
            if (!nameRegex.test(prenom)) {
                alert('Le prénom doit contenir uniquement des lettres.');
                event.preventDefault();
                return;
            }
            if (!nameRegex.test(nom)) {
                alert('Le nom doit contenir uniquement des lettres.');
                event.preventDefault();
                return;
            }

            // Validate motDePasse (at least 8 characters)
            if (motDePasse.length < 8) {
                alert('Le mot de passe doit contenir au moins 8 caractères.');
                event.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>


