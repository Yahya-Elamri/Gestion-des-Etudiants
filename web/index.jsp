<%-- 
    Document   : login
    Created on : 2 déc. 2024, 19:35:41
    Author     : yahya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <script rel="preload" as="script" src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50 flex items-center justify-center min-h-screen">
    <div class="w-full max-w-md bg-white p-8 rounded-xl shadow-md">
         <div class="flex justify-center mb-8">
            <img 
                src="https://www.ump.ma/assets/logo.webp" 
                alt="Logo" 
                class="h-24 w-24 object-contain"
            />
        </div>
        <h2 class="text-center text-3xl font-bold text-gray-800 mb-8">Connexion</h2>
        
        <form class="space-y-6" action="auth" method="POST">
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                    Entrez votre Cne
                </label>
                <input 
                    type="text" 
                    id="cne" 
                    name="cne"
                    required 
                    class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    placeholder="F12345"
                />
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                    Mot de passe
                </label>
                <input 
                    type="password" 
                    id="password" 
                    name="password"
                    required 
                    class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    placeholder="Entrez votre mot de passe"
                />
            </div>

                <div class="${errMsg != null ? errMsg : 'hidden'} bg-red-50 border border-red-400 text-red-700 px-4 py-3 rounded relative">
                    <strong class="font-bold">Erreur : </strong>
                    <span id="errorText" class="block sm:inline">Email ou mot de passe incorrect.</span>
                </div>
            </c:set>
            <div class="flex items-center justify-between">
                <div class="flex items-center">
                    <input 
                        type="checkbox" 
                        id="remember" 
                        class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                    />
                    <label for="remember" class="ml-2 block text-sm text-gray-900">
                        Se souvenir de moi
                    </label>
                </div>

                <div class="text-sm">
                    <a href="#" class="font-medium text-blue-600 hover:text-blue-500">
                        Mot de passe oublié ?
                    </a>
                </div>
            </div>

            <div>
                <button 
                    type="submit" 
                    class="w-full py-2 px-4 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-300"
                >
                    Se connecter
                </button>
            </div>
        </form>
    </div>
</body>
</html>
