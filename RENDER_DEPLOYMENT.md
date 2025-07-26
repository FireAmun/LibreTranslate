# LibreTranslate Render Deployment

This repository is configured for easy deployment to [Render](https://render.com/).

## Quick Deploy

1. **Fork this repository** or push it to your GitHub account
2. **Connect to Render**:
   - Go to [Render Dashboard](https://dashboard.render.com/)
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
3. **Configure the service**:
   - Render will automatically detect the `render.yaml` configuration
   - Or manually set:
     - **Build Command**: `chmod +x build.sh && ./build.sh`
     - **Start Command**: `chmod +x start.sh && ./start.sh`
     - **Environment**: Python 3.11

## Configuration

### Environment Variables

You can customize the deployment by setting these environment variables in Render:

| Variable | Default | Description |
|----------|---------|-------------|
| `LT_LOAD_ONLY` | `en,es,fr,de,it,pt,ru,zh` | Comma-separated language codes to load |
| `LT_CHAR_LIMIT` | `5000` | Maximum characters per translation |
| `LT_REQ_LIMIT` | `100` | Requests per minute per client |
| `LT_API_KEYS` | `false` | Enable API key authentication |
| `LT_DEBUG` | `false` | Enable debug mode |
| `LT_DISABLE_WEB_UI` | `false` | Disable the web interface |

### Plans

- **Free Plan**: Limited to 512MB RAM, may struggle with multiple language models
- **Starter Plan**: Recommended minimum (512MB+ RAM)
- **Standard/Pro Plans**: Better performance for production use

### Language Models

By default, the deployment loads common language models (`en,es,fr,de,it,pt,ru,zh`). You can:

1. **Reduce models** for faster startup and lower memory usage:
   ```
   LT_LOAD_ONLY=en,es,fr
   ```

2. **Load all models** (requires more RAM):
   ```
   LT_LOAD_ONLY=
   ```

## API Usage

Once deployed, your LibreTranslate API will be available at:
```
https://your-service-name.onrender.com
```

### Example API calls:

```bash
# Translate text
curl -X POST "https://your-service-name.onrender.com/translate" \
  -H "Content-Type: application/json" \
  -d '{"q":"Hello world","source":"en","target":"es"}'

# Get available languages
curl "https://your-service-name.onrender.com/languages"

# Health check
curl "https://your-service-name.onrender.com/"
```

## Performance Tips

1. **Choose appropriate language models**: Only load languages you need
2. **Use caching**: Enable Redis for better performance (requires separate Redis service)
3. **Monitor usage**: Use Render's metrics to track performance
4. **Scale up**: Upgrade to a higher plan if you experience memory issues

## Troubleshooting

### Common Issues:

1. **Build timeout**: Reduce language models or upgrade plan
2. **Memory issues**: Upgrade plan or reduce loaded languages
3. **Slow startup**: Normal for first deployment as models download

### Logs:
Check Render logs for detailed error messages:
- Go to your service dashboard
- Click "Logs" tab
- Look for errors during build or runtime

## Local Development

To test locally:

```bash
# Install dependencies
pip install -r requirements.txt

# Start the server
python main.py --host 0.0.0.0 --port 5000
```

## Support

- [LibreTranslate Documentation](https://docs.libretranslate.com/)
- [Render Documentation](https://render.com/docs)
- [GitHub Issues](https://github.com/LibreTranslate/LibreTranslate/issues)
