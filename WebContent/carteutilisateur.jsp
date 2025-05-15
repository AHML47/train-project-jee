<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Sahel Metro</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/metro-style.css">
    <style>
        .signup-container {
            max-width: 800px;
            margin: 2rem auto;
            background-color: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }
        
        .signup-header {
            background-color: var(--primary-color);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }
        
        .signup-form {
            padding: 2rem;
        }
        
        .form-row {
            display: flex;
            gap: 1rem;
            margin-bottom: 0;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .btn-container {
            text-align: center;
            margin-top: 2rem;
        }
        
        .input-icon {
            position: relative;
        }
        
        .input-icon i {
            position: absolute;
            left: 0.8rem;
            top: 0.8rem;
            color: var(--text-light);
        }
        
        .input-icon input {
            padding-left: 2.5rem;
        }
        
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
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
        <div class="signup-container">
            <div class="signup-header">
                <h1><i class="fas fa-user-plus"></i> Create Your Metro Account</h1>
                <p>Fill in your details to register for a Metro card</p>
            </div>
            
            <div class="signup-form">
                <form id="userIdForm" action="signUp" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="nom"><i class="fas fa-user"></i> Nom</label>
                            <div class="input-icon">
                                <i class="fas fa-user form-icon"></i>
                                <input type="text" id="nom" name="nom" class="auth-input" placeholder="Votre nom" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="prenom"><i class="fas fa-user"></i> Prénom</label>
                            <div class="input-icon">
                                <i class="fas fa-user form-icon"></i>
                                <input type="text" id="prenom" name="prenom" class="auth-input" placeholder="Votre prénom" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email"><i class="fas fa-envelope"></i> Email</label>
                            <div class="input-icon">
                                <i class="fas fa-envelope form-icon"></i>
                                <input type="email" id="email" name="email" class="auth-input" placeholder="exemple@email.com" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="tel"><i class="fas fa-phone"></i> Numéro de Téléphone</label>
                            <div class="input-icon">
                                <i class="fas fa-phone form-icon"></i>
                                <input type="tel" id="tel" name="tel" class="auth-input" placeholder="Votre numéro de téléphone" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="cin"><i class="fas fa-id-badge"></i> CIN</label>
                            <div class="input-icon">
                                <i class="fas fa-id-badge form-icon"></i>
                                <input type="text" id="cin" name="cin" class="auth-input" placeholder="Numéro de CIN" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="direction"><i class="fas fa-compass"></i> Direction</label>
                            <div class="input-icon">
                                <i class="fas fa-compass form-icon"></i>
                                <input type="text" id="direction" name="direction" class="auth-input" placeholder="Votre direction" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="adresse"><i class="fas fa-map-marker-alt"></i> Adresse</label>
                        <div class="input-icon">
                            <i class="fas fa-map-marker-alt form-icon"></i>
                            <input type="text" id="adresse" name="adresse" class="auth-input" placeholder="Votre adresse complète" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="dob"><i class="fas fa-birthday-cake"></i> Date de Naissance</label>
                            <div class="input-icon">
                                <i class="fas fa-birthday-cake form-icon"></i>
                                <input type="date" id="dob" name="dob" class="auth-input" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="cardNumber"><i class="fas fa-credit-card"></i> Numéro Carte de Paiement</label>
                            <div class="input-icon">
                                <i class="fas fa-credit-card form-icon"></i>
                                <input type="text" id="cardNumber" name="cardNumber" class="auth-input" placeholder="Numéro de votre carte" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i> Mot de Passe</label>
                        <div class="input-icon">
                            <i class="fas fa-lock form-icon"></i>
                            <input type="password" id="password" name="password" class="auth-input" placeholder="Choisissez un mot de passe sécurisé" required>
                        </div>
                    </div>
                    
                    <div id="error-container" class="error-message" style="display: none;"></div>
                    
                    <div class="btn-container">
                        <button type="submit" class="btn btn-secondary">
                            <i class="fas fa-user-plus"></i> S'inscrire
                        </button>
                    </div>
                    
                    <div class="auth-links" style="text-align: center; margin-top: 1rem;">
                        <p>Déjà inscrit? <a href="login">Connectez-vous</a></p>
                        <p><a href="metroInterfaceS"><i class="fas fa-arrow-left"></i> Retour à la carte du métro</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <footer class="footer">
        <p>&copy; 2024 Sahel Metro Tracking System. All rights reserved.</p>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('userIdForm');
            const errorContainer = document.getElementById('error-container');
            
            form.addEventListener('submit', function(e) {
                let hasError = false;
                errorContainer.innerHTML = '';
                errorContainer.style.display = 'none';
                
                // Basic validation
                const password = document.getElementById('password').value;
                if (password.length < 6) {
                    showError('Le mot de passe doit contenir au moins 6 caractères');
                    hasError = true;
                }
                
                const email = document.getElementById('email').value;
                if (!validateEmail(email)) {
                    showError('Veuillez entrer une adresse email valide');
                    hasError = true;
                }
                
                if (hasError) {
                    e.preventDefault();
                }
            });
            
            function validateEmail(email) {
                const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return re.test(email);
            }
            
            function showError(message) {
                errorContainer.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;
                errorContainer.style.display = 'block';
            }
        });
    </script>
</body>
</html>
