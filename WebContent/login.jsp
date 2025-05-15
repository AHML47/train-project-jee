<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Sahel Metro</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/design-system.css">
    <link rel="stylesheet" href="css/components.css">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--primary-100), var(--neutral-200));
            display: flex;
            flex-direction: column;
            font-family: var(--font-primary);
        }

        .auth-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: var(--spacing-2xl);
            margin-top: var(--spacing-2xl);
        }

        .auth-card {
            width: 100%;
            max-width: 420px;
            background: var(--neutral-100);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-xl);
            padding: var(--spacing-2xl);
            animation: slideUp var(--transition-normal);
        }

        .auth-header {
            text-align: center;
            margin-bottom: var(--spacing-xl);
        }

        .auth-icon {
            font-size: var(--text-4xl);
            color: var(--primary-600);
            margin-bottom: var(--spacing-md);
            animation: fadeIn var(--transition-normal) 0.3s forwards;
        }

        .auth-title {
            font-size: var(--text-2xl);
            color: var(--neutral-900);
            margin-bottom: var(--spacing-xs);
            font-weight: 600;
        }

        .auth-subtitle {
            color: var(--neutral-600);
            font-size: var(--text-base);
        }

        .form-group {
            margin-bottom: var(--spacing-lg);
        }

        .auth-input {
            width: 100%;
            padding: var(--spacing-md) var(--spacing-xl);
            border: 2px solid var(--neutral-300);
            border-radius: var(--radius-lg);
            font-size: var(--text-base);
            transition: all var(--transition-fast);
            background: var(--neutral-100);
        }

        .auth-input:focus {
            border-color: var(--primary-400);
            box-shadow: 0 0 0 4px var(--primary-100);
        }

        .auth-btn {
            width: 100%;
            padding: var(--spacing-md);
            background: var(--primary-600);
            color: white;
            border: none;
            border-radius: var(--radius-lg);
            font-size: var(--text-base);
            font-weight: 500;
            cursor: pointer;
            transition: all var(--transition-fast);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: var(--spacing-sm);
        }

        .auth-btn:hover {
            background: var(--primary-700);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .auth-btn:active {
            transform: translateY(0);
        }

        .auth-links {
            text-align: center;
            margin-top: var(--spacing-xl);
            font-size: var(--text-sm);
        }

        .auth-links a {
            color: var(--primary-600);
            text-decoration: none;
            font-weight: 500;
            transition: color var(--transition-fast);
        }

        .auth-links a:hover {
            color: var(--primary-700);
            text-decoration: underline;
        }

        .error-message {
            margin-top: var(--spacing-md);
            padding: var(--spacing-md);
            background: var(--error);
            color: white;
            border-radius: var(--radius-md);
            font-size: var(--text-sm);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            animation: slideUp var(--transition-normal);
        }

        .input-icon {
            position: relative;
        }

        .input-icon i {
            position: absolute;
            left: var(--spacing-md);
            top: 50%;
            transform: translateY(-50%);
            color: var(--neutral-500);
            transition: color var(--transition-fast);
        }

        .input-icon input:focus + i {
            color: var(--primary-600);
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .floating-icon {
            animation: float 3s ease-in-out infinite;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="metroInterfaceS" class="logo">
            <i class="fas fa-train floating-icon"></i> Sahel Metro
        </a>
        <ul class="nav-links">
            <li><a href="metroInterfaceS" class="hover-scale"><i class="fas fa-map-marked-alt"></i> Map</a></li>
            <li><a href="#" class="hover-scale"><i class="fas fa-info-circle"></i> About</a></li>
            <li><a href="#" class="hover-scale"><i class="fas fa-phone"></i> Contact</a></li>
        </ul>
    </nav>

    <div class="auth-container">
        <div class="auth-card hover-lift">
            <div class="auth-header">
                <div class="auth-icon floating-icon">
                    <i class="fas fa-user-circle"></i>
                </div>
                <h2 class="auth-title text-gradient">Welcome Back</h2>
                <p class="auth-subtitle">Sign in to your Metro account</p>
            </div>
            
            <form action="login" method="post" id="loginForm" class="fade-in">
                <div class="form-group">
                    <div class="input-icon">
                        <input type="email" id="email" name="email" class="auth-input" 
                            placeholder="Email" required autofocus />
                        <i class="fas fa-envelope"></i>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-icon">
                        <input type="password" id="password" name="password" class="auth-input" 
                            placeholder="Password" required />
                        <i class="fas fa-lock"></i>
                    </div>
                </div>

                <button type="submit" class="auth-btn">
                    <i class="fas fa-sign-in-alt"></i>
                    <span>Sign In</span>
                    <div class="loading-dots" style="display: none;">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </button>
            </form>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${error}</span>
                </div>
            </c:if>
            
            <div class="auth-links">
                <p>Don't have an account? <a href="signUp" class="hover-scale">Create an account</a></p>
                <p><a href="metroInterfaceS" class="hover-scale"><i class="fas fa-arrow-left"></i> Back to metro map</a></p>
            </div>
        </div>
    </div>
    
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <h4>Sahel Metro</h4>
                <p>Your trusted partner for modern metro transportation in the Sahel region.</p>
            </div>
            <div class="footer-section">
                <h4>Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="metroInterfaceS">Live Map</a></li>
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h4>Contact Us</h4>
                <ul class="footer-links">
                    <li><i class="fas fa-phone"></i> +216 XX XXX XXX</li>
                    <li><i class="fas fa-envelope"></i> contact@sahelmetro.tn</li>
                    <li><i class="fas fa-map-marker-alt"></i> Sousse, Tunisia</li>
                </ul>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('loginForm');
            const submitBtn = form.querySelector('.auth-btn');
            const loadingDots = submitBtn.querySelector('.loading-dots');
            
            form.addEventListener('submit', function(e) {
                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;
                
                if (!email || !password) {
                    e.preventDefault();
                    showError('Please enter both email and password.');
                    return false;
                }
                
                // Show loading animation
                submitBtn.querySelector('span').style.display = 'none';
                loadingDots.style.display = 'inline-flex';
                submitBtn.disabled = true;
                
                return true;
            });
            
            function showError(message) {
                const existingError = document.querySelector('.error-message');
                if (existingError) existingError.remove();
                
                const errorDiv = document.createElement('div');
                errorDiv.className = 'error-message slide-up';
                errorDiv.innerHTML = `
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${message}</span>
                `;
                
                form.after(errorDiv);
                
                // Reset button state
                submitBtn.querySelector('span').style.display = 'inline';
                loadingDots.style.display = 'none';
                submitBtn.disabled = false;
            }

            // Add focus animations for inputs
            const inputs = document.querySelectorAll('.auth-input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.querySelector('i').style.color = 'var(--primary-600)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.querySelector('i').style.color = 'var(--neutral-500)';
                });
            });
        });
    </script>
</body>
</html>
