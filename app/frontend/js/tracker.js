// tracker.js

// Function to send visitor data to the server
function sendVisitorData(visitorData) {
    fetch('http://localhost:8000/api/track/', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(visitorData),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log('Visitor data sent:', data);
      })
      .catch((error) => {
        console.error('Error sending visitor data:', error);
      });
  }

  // Track visitor data and send it to the server
  const visitorData = {
    page: 'portfolio',
    timestamp: new Date().toISOString(),
  };

  sendVisitorData(visitorData);
