
# Task Scheduler

A full-featured task management backend built with **NestJS**, **TypeORM**, **MySQL**, and **Socket.IO** for real-time updates. This backend supports user roles, task management, and real-time synchronization across all connected clients.

## 🌟 Features

- User authentication and role-based access (admin, user)
- Interactive task management:
  - Create, update, delete tasks
  - Assign tasks to users
  - Task ordering and column ordering (drag & drop)
  - Every user sees updates instantly as other users make changes
- Advanced filtering by assignee, date, status, etc.
- Real-time notifications for task changes using Socket.IO
- Fully interactive dashboard
- Data seeding and migrations for initial setup
- Dockerized setup for easy deployment

## 🌐 Live Demo

You can see a production-ready demo here: [Task Scheduler Demo](https://task-scheduler.rebit.ai/)

## 👤 Example Users

- **Admin**
  - username: `admin_john`
  - password: `admin123`
- **User**
  - username: `bob_smith`
  - password: `user123`

## 🖼 Screenshots

![Dashboard Screenshot](https://rebit.ai/assets/screenshot-dashboard.png)
![Users Page Screenshot](https://rebit.ai/assets/screenshot-users.png)

## 🚀 Quick Start with Docker

Clone the repository:

```bash
git clone https://github.com/leonidSahakyan/task-scheduler.git
cd task-scheduler
```

Build and start containers (only first time):

```bash
docker-compose up --build
```

Next time, you can just run:

```bash
docker-compose up
```

- Backend available at: [http://localhost:3000](http://localhost:3000)  
- Frontend available at: [http://localhost:5173](http://localhost:5173)  

## 🛠 Manual Setup

### 1. Backend Setup

Clone the repository:

```bash
git clone https://github.com/leonidSahakyan/task-scheduler.git
cd task-scheduler/backend
```

Install dependencies:

```bash
npm install
```

Update `.env` with your settings:

```env
DB_HOST=localhost
DB_PORT=3306
DB_USER=task_scheduler
DB_PASS=justPass
DB_NAME=task_scheduler

PORT=3000
FRONTEND_ORIGIN=http://localhost:5173
JWT_SECRET=your_jwt_secret
```

#### Database Options (choose one)

1. **Using Migrations & Seeders**
```bash
npm run migration:run:dev
npm run seed:dev
```

2. **Using MySQL Dump**

💾 Optional: Use `dump.sql` from the `mysql-init/` folder to prefill the database.

```bash
mysql -u root -p task_scheduler < mysql-init/dump.sql
```

Start backend:

```bash
npm run start:dev
```

Backend will be available at: [http://localhost:3000](http://localhost:3000)  

### 2. Frontend Setup

```bash
cd frontend
npm install
npm run dev
```

Frontend will run at: [http://localhost:5173](http://localhost:5173)

## 🗂 Project Structure (Short)

```
task-scheduler/
├─ backend/
│  ├─ src/
│  ├─ migrations/
│  ├─ seeders/
│  └─ ...
├─ frontend/
│  ├─ src/
│  ├─ public/
│  └─ ...
├─ mysql-init/
│  └─ dump.sql
├─ docker-compose.yml
├─ README.md
└─ postman-collection.json (Postman collection)
```

> **Note:** `postman-collection.json` in the root folder includes all API endpoints ready for Postman import.
