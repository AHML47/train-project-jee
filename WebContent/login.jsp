<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Sahel Metro</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/metro-style.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .auth-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .auth-card {
            width: 100%;
            max-width: 400px;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2rem;
        }
        
        .auth-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .auth-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .auth-title {
            font-size: 1.75rem;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }
        
        .auth-subtitle {
            color: var(--text-light);
            font-size: 0.875rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }
        
        .form-icon {
            position: absolute;
            left: 1rem;
            top: 0.85rem;
            color: var(--text-light);
        }
        
        .auth-input {
            padding-left: 2.5rem;
        }
        
        .auth-btn {
            width: 100%;
            padding: 0.75rem;
            border: none;
            background-color: var(--primary-color);
            color: white;
            border-radius: var(--radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .auth-btn:hover {
            background-color: var(--primary-dark);
        }
        
        .auth-links {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.875rem;
        }
        
        .auth-links a {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .auth-links a:hover {
            text-decoration: underline;
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
        <div class="auth-container">
            <div class="auth-card">
                <div class="auth-header">
                    <div class="auth-icon">
                        <i class="fas fa-user-circle"></i>
                    </div>
                    <h2 class="auth-title">Welcome Back</h2>
                    <p class="auth-subtitle">Sign in to your Metro account</p>
                </div>
                
                <form action="login" method="post" id="loginForm">
                    <div class="form-group">
                        <div class="input-icon">
                            <i class="fas fa-envelope form-icon"></i>
                            <input type="email" id="email" name="email" class="auth-input" 
                                placeholder="Email" required autofocus />
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-icon">
                            <i class="fas fa-lock form-icon"></i>
                            <input type="password" id="password" name="password" class="auth-input" 
                                placeholder="Password" required />
                        </div>
                    </div>

                    <button type="submit" class="auth-btn btn">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </button>
                </form>
                
                <c:if test="${not empty error}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>
                
                <div class="auth-links">
                    <p>Don't have an account? <a href="signUp">Create an account</a></p>
                    <p><a href="metroInterfaceS"><i class="fas fa-arrow-left"></i> Back to metro map</a></p>
                </div>
            </div>
        </div>
    </div>
    
    <footer class="footer">
        <p>&copy; 2024 Sahel Metro Tracking System. All rights reserved.</p>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('loginForm');
            
            form.addEventListener('submit', function(e) {
                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;
                
                if (!email || !password) {
                    e.preventDefault();
                    showError('Please enter both email and password.');
                    return false;
                }
                
                return true;
            });
            
            function showError(message) {
                // Remove any existing error
                const existingError = document.querySelector('.error-message');
                if (existingError) existingError.remove();
                
                // Create new error
                const errorDiv = document.createElement('div');
                errorDiv.className = 'error-message';
                errorDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;
                
                // Add after the form
                form.after(errorDiv);
            }
        });
    </script>
</body>
</html>
