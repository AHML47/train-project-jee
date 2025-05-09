<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carte d'Identification Metro</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="date"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        .btn-container {
            text-align: center;
            margin-top: 30px;
        }
        
        .submit-btn {
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        
        .submit-btn:hover {
            background-color: #45a049;
        }
        
        .return-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #666;
            text-decoration: none;
        }
        
        .return-link:hover {
            text-decoration: underline;
        }
        
        .id-card {
            border: 2px solid #333;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
            background-color: #f9f9f9;
        }
        
        .id-card h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        
        .id-card-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        
        .id-card-info p {
            margin: 5px 0;
        }
        
        .id-card-info strong {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Carte d'Identification Metro</h1>
        
        <form id="userIdForm" action="carteutilisateur.jsp" method="post">
            <div class="form-group">
                <label for="nom">Nom:</label>
                <input type="text" id="nom" name="nom" required>
            </div>
            
            <div class="form-group">
                <label for="prenom">Prénom:</label>
                <input type="text" id="prenom" name="prenom" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="tel">Numéro de Téléphone:</label>
                <input type="tel" id="tel" name="tel" required>
            </div>
            
            <div class="form-group">
                <label for="cin">CIN (Carte d'Identité Nationale):</label>
                <input type="text" id="cin" name="cin" required>
            </div>
            
            <div class="form-group">
                <label for="direction">Direction:</label>
                <input type="text" id="direction" name="direction" required>
            </div>
            
            <div class="form-group">
                <label for="adresse">Adresse:</label>
                <input type="text" id="adresse" name="adresse" required>
            </div>
            
            <div class="form-group">
                <label for="dob">Date de Naissance:</label>
                <input type="date" id="dob" name="dob" required>
            </div>
            
            <div class="form-group">
                <label for="cardNumber">Numéro Carte de Paiement:</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
            </div>
            
            <div class="form-group">
                <label for="password">Mot de Passe:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="submit-btn">Enregistrer</button>
            </div>
        </form>
        
        <a href="metro-interface.jsp" class="return-link">Retour à la carte du métro</a>
        
        <!-- This section would be populated from the database for registered users -->
        <% if(request.getParameter("showCard") != null && request.getParameter("showCard").equals("true")) { %>
        <div class="id-card">
            <h2>Carte d'Identification Métro</h2>
            <div class="id-card-info">
                <p><strong>Nom:</strong> ${userInfo.nom}</p>
                <p><strong>Prénom:</strong> ${userInfo.prenom}</p>
                <p><strong>CIN:</strong> ${userInfo.cin}</p>
                <p><strong>Date de Naissance:</strong> ${userInfo.dob}</p>
                <p><strong>Email:</strong> ${userInfo.email}</p>
                <p><strong>Téléphone:</strong> ${userInfo.tel}</p>
                <p><strong>Direction:</strong> ${userInfo.direction}</p>
                <p><strong>Adresse:</strong> ${userInfo.adresse}</p>
            </div>
        </div>
        <% } %>
    </div>
    
    <script>
        // You can add client-side validation here if needed
        document.getElementById('userIdForm').addEventListener('submit', function(e) {
            // Form validation logic could go here
        });
    </script>
</body>
</html>