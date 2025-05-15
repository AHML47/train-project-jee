<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carte Utilisateur - Sahel Metro</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/metro-style.css">
</head>
<body>
    <nav class="navbar">
        <a href="metroInterfaceS" class="logo">
            <i class="fas fa-train"></i> Sahel Metro
        </a>
        <ul class="nav-links">
            <li><a href="metroInterfaceS"><i class="fas fa-map-marked-alt"></i> Map</a></li>
            <li><a href="#"><i class="fas fa-info-circle"></i> About</a></li>
            <li><a href="#"><i class="fas fa-phone"></i> Contact</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="user-card-container">
            <div class="card user-card">
                <div class="user-card-header">
                    <div class="profile-img">
                        <i class="fas fa-user"></i>
                    </div>
                    <h2>${user.prenom} ${user.nom}</h2>
                    <p><i class="fas fa-id-card"></i> Metro User Card</p>
                </div>
                
                <div class="user-card-body">
                    <div class="user-detail">
                        <strong><i class="fas fa-user"></i> Nom:</strong>
                        <span>${user.nom}</span>
                    </div>
                    
                    <div class="user-detail">
                        <strong><i class="fas fa-user"></i> Prénom:</strong>
                        <span>${user.prenom}</span>
                    </div>
                    
                    <div class="user-detail">
                        <strong><i class="fas fa-envelope"></i> Email:</strong>
                        <span>${user.email}</span>
                    </div>
                    
                    <div class="user-detail">
                        <strong><i class="fas fa-phone"></i> Téléphone:</strong>
                        <span>${user.tel}</span>
                    </div>
                    
                    <div class="user-detail">
                        <strong><i class="fas fa-id-badge"></i> CIN:</strong>
                        <span>${user.cin}</span>
                    </div>
                    
                    <div class="user-detail">
                        <strong><i class="fas fa-building"></i> Direction:</strong>
                        <span>${user.direction}</span>
                    </div>
                    
                    <div class="user-detail">
                        <strong><i class="fas fa-map-marker-alt"></i> Adresse:</strong>
                        <span>${user.adresse}</span>
                    </div>
                    
                    <div class="user-detail">
                        <strong><i class="fas fa-birthday-cake"></i> Date de Naissance:</strong>
                        <span>${user.dob}</span>
                    </div>
                    
                    <div class="user-detail">
                        <strong><i class="fas fa-credit-card"></i> Carte de Paiement:</strong>
                        <span>${user.cardNumber}</span>
                    </div>
                    
                    <div class="card-actions">
                        <a href="metroInterfaceS" class="btn">
                            <i class="fas fa-map-marked-alt"></i> Tableau de Bord
                        </a>
                        <a href="logout" class="btn btn-danger">
                            <i class="fas fa-sign-out-alt"></i> Déconnexion
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <footer class="footer">
        <p>&copy; 2024 Sahel Metro Tracking System. All rights reserved.</p>
    </footer>
</body>
</html>