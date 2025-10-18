# NewsRec - Personalized News Aggregator

A full-stack web application that provides personalized news recommendations based on user preferences. Built with Flask (Python) backend and React frontend, deployed on Render's free tier.

## Features

- 🔐 User authentication (registration/login with JWT)
- 📰 Fetch latest news from NewsAPI.org
- ❤️ Like articles to build your preference profile
- 🤖 AI-powered personalized recommendations using TF-IDF and cosine similarity
- 📱 Responsive React frontend with modern UI
- 🔄 Automated news fetching every 6 hours
- 🚀 Production-ready deployment on Render

## Tech Stack

### Backend
- **Framework**: Flask 2.3.3
- **Database**: PostgreSQL with SQLAlchemy ORM
- **Authentication**: Flask-JWT-Extended
- **CORS**: Flask-CORS
- **ML/NLP**: scikit-learn (TF-IDF vectorization)
- **Deployment**: Gunicorn

### Frontend
- **Framework**: React 18 with Vite
- **Routing**: React Router DOM
- **HTTP Client**: Axios
- **State Management**: React Context API
- **Styling**: CSS with responsive design

### Infrastructure
- **Database**: PostgreSQL (Render free tier)
- **Hosting**: Render (free tier)
- **CI/CD**: Automated deployment via render.yaml
- **Cron Jobs**: News fetching automation

## Project Structure

```
NewsRec-Project/
├── backend/                 # Flask backend
│   ├── app/
│   │   ├── api/            # API routes
│   │   ├── models/         # Database models
│   │   ├── services/       # Business logic
│   │   ├── __init__.py     # Flask app factory
│   │   ├── config.py       # Configuration
│   │   └── extensions.py   # Flask extensions
│   ├── migrations/         # Database migrations
│   ├── run.py             # Local development entry point
│   ├── requirements.txt   # Python dependencies
│   ├── build.sh           # Render build script
│   └── .env.example       # Environment variables template
├── frontend/              # React frontend
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── services/      # API services
│   │   ├── context/       # React context
│   │   ├── App.jsx        # Main app component
│   │   ├── main.jsx       # Entry point
│   │   └── index.css      # Global styles
│   ├── public/            # Static assets
│   ├── package.json       # Node.js dependencies
│   └── vite.config.js     # Vite configuration
└── render.yaml            # Render deployment configuration
```

## Getting Started

### Local Development

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd NewsRec-Project
   ```

2. **Backend Setup**
   ```bash
   cd backend
   
   # Create virtual environment
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   
   # Install dependencies
   pip install -r requirements.txt
   
   # Set up environment variables
   cp .env.example .env
   # Edit .env with your configuration
   
   # Initialize database
   flask db init
   flask db migrate -m "Initial migration"
   flask db upgrade
   
   # Run the development server
   python run.py
   ```

3. **Frontend Setup**
   ```bash
   cd frontend
   
   # Install dependencies
   npm install
   
   # Run the development server
   npm run dev
   ```

### Environment Variables

Create a `.env` file in the backend directory with:

```env
# Database
DATABASE_URL=postgresql://username:password@localhost:5432/newsrec_db

# JWT Configuration
JWT_SECRET_KEY=your-super-secret-jwt-key

# News API (Get from https://newsapi.org/)
NEWS_API_KEY=your-news-api-key

# Flask Configuration
FLASK_ENV=development
FLASK_DEBUG=True
```

### Deployment on Render

1. **Connect Repository**
   - Fork this repository to your GitHub account
   - Connect your GitHub account to Render

2. **Deploy**
   - The `render.yaml` file automatically configures all services
   - Add your `NEWS_API_KEY` in the Render dashboard for the backend service
   - Deployment will start automatically on push to main branch

3. **Services Created**
   - `newsrec-api`: Flask backend (Python web service)
   - `newsrec-web`: React frontend (Static site)
   - `newsrec-db`: PostgreSQL database
   - `news-fetcher`: Cron job for news updates

## API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login

### News
- `GET /api/news/feed` - Get paginated news articles
- `POST /api/news/like/:id` - Like an article (protected)
- `POST /api/internal/fetch-news-job` - Internal cron job endpoint

### Recommendations
- `GET /api/recommendations` - Get personalized recommendations (protected)

## Recommendation Algorithm

The recommendation system uses:

1. **TF-IDF Vectorization**: Converts article text into numerical vectors
2. **User Profiling**: Averages vectors of liked articles to create user profile
3. **Cosine Similarity**: Compares user profile with all articles
4. **Ranking**: Returns top 10 most similar articles

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is open source and available under the MIT License.

## Support

For issues and questions:
1. Check the documentation
2. Search existing issues
3. Create a new issue with detailed description

## Future Enhancements

- [ ] Advanced recommendation algorithms (collaborative filtering)
- [ ] Article categories and filtering
- [ ] User preferences dashboard
- [ ] Social features (share articles)
- [ ] Mobile app (React Native)
- [ ] Real-time notifications
- [ ] Advanced search functionality
- [ ] Article bookmarking
- [ ] Reading history tracking
- [ ] Multi-language support