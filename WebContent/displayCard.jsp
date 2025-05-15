<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Metro Card - Sahel Metro</title>
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
            margin: 0;
            padding-top: 80px;
        }

        .page-header {
            text-align: center;
            margin-bottom: var(--spacing-2xl);
            animation: slideDown var(--transition-normal);
        }

        .page-header h1 {
            font-size: var(--text-3xl);
            color: var(--neutral-900);
            margin-bottom: var(--spacing-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: var(--spacing-sm);
        }

        .page-header p {
            color: var(--neutral-600);
            font-size: var(--text-lg);
            max-width: 600px;
            margin: 0 auto;
        }

        .metro-card {
            background: var(--neutral-100);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-xl);
            padding: var(--spacing-2xl);
            margin-bottom: var(--spacing-2xl);
            position: relative;
            overflow: hidden;
            animation: slideUp var(--transition-normal);
        }

        .metro-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 8px;
            background: linear-gradient(90deg, var(--primary-400), var(--primary-600));
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-xl);
            padding-bottom: var(--spacing-lg);
            border-bottom: 1px solid var(--neutral-200);
        }

        .card-logo {
            width: 64px;
            height: 64px;
            background: var(--primary-100);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-600);
            font-size: var(--text-2xl);
        }

        .card-title-group h2 {
            font-size: var(--text-2xl);
            color: var(--neutral-900);
            margin: 0 0 var(--spacing-xs);
        }

        .card-title-group p {
            color: var(--neutral-600);
            font-size: var(--text-base);
            margin: 0;
        }

        .card-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: var(--spacing-lg);
        }

        .detail-group {
            background: var(--neutral-50);
            padding: var(--spacing-lg);
            border-radius: var(--radius-lg);
            transition: all var(--transition-fast);
        }

        .detail-group:hover {
            background: var(--primary-50);
            transform: translateY(-2px);
        }

        .detail-label {
            color: var(--neutral-600);
            font-size: var(--text-sm);
            margin-bottom: var(--spacing-xs);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .detail-label i {
            color: var(--primary-600);
        }

        .detail-value {
            color: var(--neutral-900);
            font-size: var(--text-base);
            font-weight: 500;
        }

        .card-actions {
            margin-top: var(--spacing-2xl);
            display: flex;
            gap: var(--spacing-md);
            justify-content: center;
        }

        .card-btn {
            padding: var(--spacing-md) var(--spacing-xl);
            border-radius: var(--radius-lg);
            font-weight: 500;
            font-size: var(--text-base);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            transition: all var(--transition-fast);
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background: var(--primary-600);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-700);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: var(--neutral-200);
            color: var(--neutral-800);
        }

        .btn-secondary:hover {
            background: var(--neutral-300);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .qr-code {
            position: absolute;
            top: var(--spacing-xl);
            right: var(--spacing-xl);
            padding: var(--spacing-md);
            background: white;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-md);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .qr-code img {
            width: 100px;
            height: 100px;
        }

        .qr-code span {
            font-size: var(--text-xs);
            color: var(--neutral-600);
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .pulse {
            animation: pulse 2s infinite;
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

    <div class="container">
        <div class="page-header">
            <h1>
                <i class="fas fa-id-card text-gradient"></i>
                <span class="text-gradient">Your Metro Card</span>
            </h1>
            <p>Your digital pass to the Sahel Metro network</p>
        </div>

        <div class="metro-card hover-lift">
            <div class="card-header">
                <div class="card-logo floating-icon">
                    <i class="fas fa-subway"></i>
                </div>
                <div class="card-title-group">
                    <h2>Metro Pass</h2>
                    <p>Valid until December 2024</p>
                </div>
            </div>

            <div class="card-details">
                <div class="detail-group hover-scale">
                    <div class="detail-label">
                        <i class="fas fa-user"></i>
                        <span>Full Name</span>
                    </div>
                    <div class="detail-value">${user.nom} ${user.prenom}</div>
                </div>

                <div class="detail-group hover-scale">
                    <div class="detail-label">
                        <i class="fas fa-id-badge"></i>
                        <span>CIN</span>
                    </div>
                    <div class="detail-value">${user.cin}</div>
                </div>

                <div class="detail-group hover-scale">
                    <div class="detail-label">
                        <i class="fas fa-envelope"></i>
                        <span>Email</span>
                    </div>
                    <div class="detail-value">${user.email}</div>
                </div>

                <div class="detail-group hover-scale">
                    <div class="detail-label">
                        <i class="fas fa-phone"></i>
                        <span>Phone</span>
                    </div>
                    <div class="detail-value">${user.tel}</div>
                </div>

                <div class="detail-group hover-scale">
                    <div class="detail-label">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Address</span>
                    </div>
                    <div class="detail-value">${user.adresse}</div>
                </div>

                <div class="detail-group hover-scale">
                    <div class="detail-label">
                        <i class="fas fa-compass"></i>
                        <span>Direction</span>
                    </div>
                    <div class="detail-value">${user.direction}</div>
                </div>
            </div>

            <div class="qr-code pulse">
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${user.cin}" alt="QR Code">
                <span>Scan for verification</span>
            </div>

            <div class="card-actions">
                <button class="card-btn btn-primary" onclick="window.print()">
                    <i class="fas fa-print"></i>
                    <span>Print Card</span>
                </button>
                <a href="metroInterfaceS">
                    <button class="card-btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        <span>Back to Map</span>
                    </button>
                </a>
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
</body>
</html>