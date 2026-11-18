# 🚀 Rupkala Hosting & Deployment Guide

This guide covers the best, simplest, and most reliable ways to host Rupkala live on the web for free or production.

---

## 🌟 Method 1: Render.com (Recommended — 1-Click Free Full-Stack)

Render allows you to host both the **Frontend** and the **Express Backend** together as a single unified service.

### Step-by-Step:
1. **Push your code to GitHub**:
   ```bash
   git init
   git add .
   git commit -m "feat: setup rupkala for deployment"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/rupkala.git
   git push -u origin main
   ```
2. Go to [render.com](https://render.com) and log in.
3. Click **"New +"** $\rightarrow$ **"Web Service"**.
4. Connect your GitHub repository `rupkala`.
5. Fill in the deployment settings:
   - **Name**: `rupkala` (or your preferred name)
   - **Runtime**: `Node`
   - **Build Command**: `npm install && npm run build`
   - **Start Command**: `npm start`
   - **Instance Type**: `Free`
6. (Optional) Add Environment Variables:
   - `NODE_ENV`: `production`
   - `GEMINI_API_KEY`: *(Your Google Gemini API Key for AI features)*
7. Click **"Deploy Web Service"**.
8. In ~2 minutes, Render will provide a live URL like `https://rupkala.onrender.com`!

---

## 🚂 Method 2: Railway.app (Fastest 1-Click Deploy)

Railway automatically detects Node.js and builds the project with persistent storage.

### Step-by-Step:
1. Push your code to GitHub.
2. Go to [railway.app](https://railway.app) and sign in.
3. Click **"New Project"** $\rightarrow$ **"Deploy from GitHub repo"**.
4. Select `rupkala`.
5. Add a variable in **Variables**:
   - `PORT`: `5000` (or Railway's default)
   - `GEMINI_API_KEY`: *(Optional)*
6. Railway will automatically execute `npm install`, `npm run build`, and `npm start`.
7. Click **"Generate Domain"** under Settings to get your public live URL.

---

## ⚡ Method 3: Split Deployment (Vercel Frontend + Render/Railway Backend)

If you prefer using Vercel's Edge CDN for the React frontend:

### 1. Deploy the Backend (on Render or Railway)
- Deploy the repo on Render/Railway.
- Note the backend URL (e.g., `https://rupkala-api.onrender.com`).

### 2. Deploy the Frontend on Vercel
- Go to [vercel.com](https://vercel.com) $\rightarrow$ **"Add New Project"** $\rightarrow$ Select repo.
- **Framework Preset**: `Vite`
- **Build Command**: `npm run build`
- **Output Directory**: `dist`
- **Environment Variables**:
  - `VITE_API_BASE_URL`: `https://rupkala-api.onrender.com`
- Click **"Deploy"**.

---

## 🐳 Method 4: Docker / Cloud VPS / Self-Hosted (DigitalOcean, AWS, Coolify)

Rupkala includes a production `Dockerfile`.

```bash
# 1. Build the Docker image
docker build -t rupkala:latest .

# 2. Run the container
docker run -d -p 5000:5000 -e GEMINI_API_KEY="your_api_key_here" --name rupkala_app rupkala:latest

# Rupkala is now accessible at http://localhost:5000
```

---

## ⚡ Method 5: Instant Live Demo via Cloudflare Tunnel / ngrok (Zero Config)

Want to instantly share your local running Rupkala instance with a client or team without uploading to GitHub?

### Using Cloudflare Quick Tunnels:
```bash
# In one terminal, start Rupkala:
npm run dev

# In another terminal:
npx cloudflared tunnel --url http://localhost:3000
```
*(This immediately generates a free, secure public HTTPS URL like `https://random-words.trycloudflare.com`)*

### Using ngrok:
```bash
npm run dev
npx ngrok http 3000
```

---

## ⚙️ Environment Variables Reference

| Variable | Required | Description | Default |
| :--- | :--- | :--- | :--- |
| `PORT` | No | Port on which Express server listens | `5000` |
| `NODE_ENV` | No | Node environment (`production` / `development`) | `development` |
| `GEMINI_API_KEY` | No | Gemini API Key for AI features (Catalogue, Voice, Chat) | *(Uses built-in offline heuristics if empty)* |
| `VITE_API_BASE_URL` | No | Backend URL if hosting frontend separately | Relative `/api/v1` |
