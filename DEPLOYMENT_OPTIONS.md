# 🚀 Deployment Options for Your Customized Chatwoot App

Your Chatwoot fork at `https://github.com/Xjkk-7/chatwoot` includes several custom features:
- Enhanced conversation analytics
- Assistant to Topic rebranding  
- Captain to AI Assistant rebranding
- Logo rebranding
- Ruby version update to 3.2.2

## Option 1: Heroku Deployment (Easiest - Recommended)

### Step 1: Deploy to Heroku
1. Visit: `https://heroku.com/deploy?template=https://github.com/Xjkk-7/chatwoot/tree/deployment/all-features`
2. Click "Deploy to Heroku"
3. Fill in the required environment variables:
   - **App name**: Choose a unique name for your app
   - **SECRET_KEY_BASE**: Use a secure random string (you can generate one)
   - **FRONTEND_URL**: Will be `https://YOUR_APP_NAME.herokuapp.com`

### Step 2: Configure Environment Variables
After deployment, go to your Heroku app settings and configure:
```env
SECRET_KEY_BASE=your_secure_random_string_here
FRONTEND_URL=https://YOUR_APP_NAME.herokuapp.com
MAILER_SENDER_EMAIL=YourName <your-email@domain.com>
REDIS_OPENSSL_VERIFY_MODE=none
```

---

## Option 2: Docker Deployment (Self-hosted)

### Prerequisites
- Docker and Docker Compose installed
- A server or VPS

### Step 1: Clone Your Repository
```bash
git clone https://github.com/Xjkk-7/chatwoot.git
cd chatwoot
git checkout deployment/all-features
```

### Step 2: Configure Environment
```bash
cp .env.example .env
```

Edit `.env` with your production values:
```env
SECRET_KEY_BASE=your_secure_random_string_here
FRONTEND_URL=https://your-domain.com
POSTGRES_PASSWORD=your_secure_postgres_password
REDIS_PASSWORD=your_secure_redis_password
MAILER_SENDER_EMAIL=YourName <your-email@domain.com>
RAILS_ENV=production
```

### Step 3: Deploy with Docker Compose
```bash
docker-compose -f docker-compose.production.yaml up -d
```

---

## Option 3: DigitalOcean Kubernetes (One-click)

1. Visit: [DigitalOcean Marketplace](https://marketplace.digitalocean.com/apps/chatwoot)
2. Click "Create App"
3. Use your fork repository: `https://github.com/Xjkk-7/chatwoot`
4. Select branch: `deployment/all-features`
5. Configure environment variables as needed

---

## Option 4: Manual Server Deployment

### For Ubuntu 20.04+ servers:
```bash
# Clone your repository
git clone https://github.com/Xjkk-7/chatwoot.git
cd chatwoot
git checkout deployment/all-features

# Run the setup script
sudo deployment/setup_20.04.sh
```

---

## Post-Deployment Steps

### 1. Create Admin Account
After deployment, access your app and create the first admin account.

### 2. Configure Email Settings
Update your email configuration in the environment variables for notifications.

### 3. Set up SSL Certificate
For production, ensure you have SSL configured (Heroku provides this automatically).

### 4. Custom Domain (Optional)
If using a custom domain, update the `FRONTEND_URL` environment variable.

---

## Environment Variables Reference

Key variables you need to configure:

| Variable | Description | Required |
|----------|-------------|----------|
| `SECRET_KEY_BASE` | Secure random string for sessions | Yes |
| `FRONTEND_URL` | Your app's public URL | Yes |
| `POSTGRES_PASSWORD` | Database password | Yes (Docker) |
| `REDIS_PASSWORD` | Redis password | Yes (Docker) |
| `MAILER_SENDER_EMAIL` | Email for notifications | Recommended |
| `SMTP_*` | Email server settings | Optional |

---

## Recommended: Start with Heroku

For the quickest deployment with your customizations:
1. Use the Heroku one-click deploy
2. Your app will be available at `https://YOUR_APP_NAME.herokuapp.com`
3. All your custom features will be included automatically 