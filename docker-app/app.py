from flask import Flask, render_template, request, redirect, url_for, flash

app = Flask(__name__)
# Sample data for demonstration
messages = []

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/projects')
def projects():
    return render_template('projects.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/submit_contact', methods=['POST'])
def submit_contact():
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        subject = request.form.get('subject')
        message = request.form.get('message')
        
        # In a real application, you would save this to a database
        # For this demo, we'll just store it in memory
        messages.append({
            'name': name,
            'email': email,
            'subject': subject,
            'message': message
        })
        
        # Return to contact page with a success message
        return render_template('contact.html', message="Thank you for your message! I'll get back to you soon.")

@app.route('/api/health')
def health_check():
    """API endpoint for health checks"""
    return {"status": "healthy", "version": "1.0.0"}

@app.route('/api/info')
def server_info():
    """API endpoint for server information"""
    import platform
    import os
    
    return {
        "hostname": platform.node(),
        "platform": platform.platform(),
        "python_version": platform.python_version(),
        "flask_env": os.environ.get('FLASK_ENV', 'production')
    }

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
