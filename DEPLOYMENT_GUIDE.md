# NewsRec Deployment Guide

This guide provides step-by-step instructions for deploying NewsRec on Render's free tier.

## Prerequisites

1. **NewsAPI.org Account**
   - Sign up at [https://newsapi.org/](https://newsapi.org/)
   - Get your free API key

2. **GitHub Account**
   - Required for connecting to Render

3. **Render Account**
   - Sign up at [https://render.com/](https://render.com/)

## Deployment Steps

### 1. Fork the Repository

1. Fork this repository to your GitHub account
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/NewsRec-Project.git
   cd NewsRec-Project
   ```

### 2. Connect to Render

1. Log in to your Render dashboard
2. Click "New" → "Blueprint"
3. Connect your GitHub account
4. Select your NewsRec-Project repository
5. Render will automatically detect the `render.yaml` file

### 3. Configure Environment Variables

1. **News API Key**
   - Go to your Render dashboard
   - Select the `newsrec-api` service
   - Go to "Environment" tab
   - Add environment variable:
     - Key: `NEWS_API_KEY`
     - Value: Your NewsAPI.org API key

2. **Other Variables** (Auto-generated)
   - `JWT_SECRET_KEY`: Render will generate this automatically
   - `DATABASE_URL`: Will be linked from the database service
   - `PYTHON_VERSION`: Set to 3.11.5

### 4. Deploy

1. Click "Apply" in the Render dashboard
2. Render will deploy all services:
   - PostgreSQL database
   - Flask backend API
   - React frontend
   - Cron job for news fetching

3. **Monitor Deployment**
   - Check the deployment logs for each service
   - The database migration will run automatically
   - Services will be available at:
     - Frontend: `https://newsrec-web.onrender.com`
     - Backend API: `https://newsrec-api.onrender.com`

### 5. Initial Setup

1. **Test the Application**
   - Visit the frontend URL
   - Register a new account
   - Browse and like some articles
   - Check the recommendations page

2. **Verify Cron Job**
   - The news fetcher runs every 6 hours
   - Check the cron job logs in Render dashboard
   - Articles should appear automatically

## Troubleshooting

### Common Issues

1. **Database Connection Errors**
   - Ensure `DATABASE_URL` is properly set
   - Check database service status in Render
   - Verify migrations ran successfully

2. **News API Issues**
   - Confirm `NEWS_API_KEY` is correctly added
   - Check NewsAPI.org account limits
   - Verify API key has proper permissions

3. **Frontend Not Loading**
   - Check frontend build logs
   - Ensure API URL is correctly configured
   - Verify CORS settings

4. **Authentication Issues**
   - Check JWT secret key generation
   - Verify token expiration settings
   - Ensure frontend is sending auth headers

### Debug Commands

**Backend Logs:**
```bash
# View logs in Render dashboard or use Render CLI
render logs newsrec-api
```

**Database Access:**
```bash
# Use Render's database connection feature
# Available in the database service dashboard
```

**Manual News Fetching:**
```bash
# Trigger news fetching manually
curl -X POST https://newsrec-api.onrender.com/api/internal/fetch-news-job
```

## Performance Optimization

### Free Tier Limitations

- **Web Services**: 512MB RAM, 100GB bandwidth/month
- **Databases**: 256MB RAM, 1GB storage
- **Cron Jobs**: 512MB RAM, runs every hour max

### Optimization Tips

1. **Database**
   - Use connection pooling
   - Add indexes for frequently queried columns
   - Implement pagination for large datasets

2. **API**
   - Implement caching for news articles
   - Use lazy loading for recommendations
   - Optimize TF-IDF vector calculations

3. **Frontend**
   - Enable compression
   - Implement lazy loading for images
   - Use React.memo for component optimization

## Security Considerations

1. **Environment Variables**
   - Never commit `.env` files
   - Use Render's environment variable management
   - Rotate API keys regularly

2. **Authentication**
   - JWT tokens expire after 24 hours
   - Implement refresh token mechanism for production
   - Use HTTPS for all communications

3. **Database**
   - Use PostgreSQL connection pooling
   - Implement input validation
   - Use parameterized queries

## Monitoring

1. **Render Dashboard**
   - Monitor service health
   - Check resource usage
   - Review deployment logs

2. **Application Monitoring**
   - Track API response times
   - Monitor error rates
   - Check recommendation accuracy

3. **External Services**
   - Monitor NewsAPI.org usage
   - Check for API changes
   - Track rate limits

## Scaling

### When to Scale

- News fetching exceeds free tier limits
- User base grows significantly
- Recommendation processing becomes slow
- Database size approaches limits

### Scaling Options

1. **Upgrade Render Plan**
   - Increase RAM and CPU
   - Add more storage
   - Enable custom domains

2. **Optimize Architecture**
   - Add Redis for caching
   - Implement background job processing
   - Use CDN for static assets

3. **Advanced Features**
   - Implement real-time updates
   - Add analytics dashboard
   - Enable multi-region deployment

## Support

For deployment issues:
1. Check Render documentation
2. Review application logs
3. Test locally first
4. Create GitHub issues for bugs

For NewsAPI issues:
1. Check NewsAPI documentation
2. Verify API key permissions
3. Monitor usage limits
4. Contact NewsAPI support if needed

## Conclusion

This deployment guide should help you successfully deploy NewsRec on Render's free tier. The application is designed to work within free tier limitations while providing a robust news aggregation and recommendation service.

Remember to:
- Monitor your usage regularly
- Keep dependencies updated
- Follow security best practices
- Optimize for performance within constraints