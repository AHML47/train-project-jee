<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion Utilisateur</title>
</head>
<body>
    <h2>Connexion</h2>
    <form action="login" method="post">
        <label for="email">Email :</label>
        <input type="email" id="email" name="email" required /><br/><br/>

        <label for="password">Mot de passe :</label>
        <input type="password" id="password" name="password" required /><br/><br/>

        <button type="submit">Se connecter</button>
    </form>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
</body>
</html>
