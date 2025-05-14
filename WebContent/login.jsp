<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion Utilisateur</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            width: 300px;
        }
        .login-container h2 {
            margin-top: 0;
            text-align: center;
            color: #333;
        }
        .login-container label {
            display: block;
            margin-top: 1rem;
            color: #555;
        }
        .login-container input[type="email"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 0.5rem;
            margin-top: 0.25rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .login-container button {
            width: 100%;
            padding: 0.75rem;
            margin-top: 1.5rem;
            background: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 1rem;
            cursor: pointer;
        }
        .login-container button:hover {
            background: #0056b3;
        }
        .error-message {
            color: #d9534f;
            text-align: center;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Connexion</h2>
        <form action="login" method="post">
            <label for="email">Email :</label>
            <input type="email" id="email" name="email" required />

            <label for="password">Mot de passe :</label>
            <input type="password" id="password" name="password" required />

            <button type="submit">Se connecter</button>
        </form>
        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
    </div>
</body>
</html>
