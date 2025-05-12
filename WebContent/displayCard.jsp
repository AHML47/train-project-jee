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
    </style>
</head>
<body>
    <div class="card">
        <h2>Votre Carte Métro</h2>
        <p><strong>Nom :</strong> ${param.nom}</p>
        <p><strong>Prénom :</strong> ${param.prenom}</p>
        <p><strong>Email :</strong> ${param.email}</p>
        <p><strong>Téléphone :</strong> ${param.tel}</p>
        <p><strong>CIN :</strong> ${param.cin}</p>
        <p><strong>Direction :</strong> ${param.direction}</p>
        <p><strong>Adresse :</strong> ${param.adresse}</p>
        <p><strong>Date de Naissance :</strong> ${param.dob}</p>
        <p><strong>Carte de Paiement :</strong> ${param.cardNumber}</p>
        <!-- Omitting password display for security -->
    </div>
</body>
</html>
