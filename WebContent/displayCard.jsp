<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Affichage Carte Utilisateur</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eaeaea;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            background: #fff;
            width: 400px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .card h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .card p {
            margin: 8px 0;
        }
        .card strong {
            display: inline-block;
            width: 140px;
        }
        .back-btn {
            display: block;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
            text-decoration: none;
            font-size: 16px;
        }
        .back-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>Votre Carte Métro</h2>
        <p><strong>Nom :</strong> ${user.nom}</p>
        <p><strong>Prénom :</strong> ${user.prenom}</p>
        <p><strong>Email :</strong> ${user.email}</p>
        <p><strong>Téléphone :</strong> ${user.tel}</p>
        <p><strong>CIN :</strong> ${user.cin}</p>
        <p><strong>Direction :</strong> ${user.direction}</p>
        <p><strong>Adresse :</strong> ${user.adresse}</p>
        <p><strong>Date de Naissance :</strong> ${user.dob}</p>
        <p><strong>Carte de Paiement :</strong> ${user.cardNumber}</p>
        <!-- Omitting password display for security -->
        
        <a href="metroInterfaceS" class="back-btn">Retour au Tableau de Bord</a>
    </div>
</body>
</html>