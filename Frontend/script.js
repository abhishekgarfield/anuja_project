document.addEventListener("DOMContentLoaded", () => {
  const shortenForm = document.getElementById("shortenForm");
  const longUrlInput = document.getElementById("longUrl");
  const shortUrlOutput = document.getElementById("shortUrl");

  shortenForm.addEventListener("submit", async (event) => {
    event.preventDefault();
    const longUrl = longUrlInput.value;
    const token = localStorage.getItem("apiToken");

    try {
      const response = await axios.post(
        "http://localhost:3000/shorten",
        { url: { original_url: longUrl } },
        { headers: { Authorization: `Bearer ${token}` } }
      );

      if (response.data.short_url) {
        shortUrlOutput.innerHTML = `Short URL: <a href="${response.data.short_url}" target="_blank">${response.data.short_url}</a>`;
      } else {
        shortUrlOutput.textContent = "Failed to shorten URL";
      }
    } catch (error) {
      console.error("Error:", error);
      shortUrlOutput.textContent = "Error shortening the URL";
    }
  });

  const clientForm = document.getElementById("clientForm");
  const clientNameInput = document.getElementById("clientName");
  const clientResponseOutput = document.getElementById("clientResponse");

  clientForm.addEventListener("submit", async (event) => {
    event.preventDefault();
    const clientName = clientNameInput.value;

    try {
      const response = await axios.post(
        "http://localhost:3000/api_tokens",
        null,
        {
          params: { client_name: clientName },
        }
      );

      const { token, expires_at } = response.data;

      if (token && expires_at) {
        localStorage.setItem("apiToken", token);
        clientResponseOutput.innerHTML = `
          Your token is: <strong>${token}</strong><br>
          It will expire on: <strong>${expires_at}</strong><br><br>
          You can also check it by running the following command:<br><br>
          <pre><code>
curl -X POST http://localhost:3000/api/v1/urls \\
  -H "Authorization: Bearer ${token}" \\
  -d "original_url=https://example.com/very/long/url"
          </code></pre>
        `;
      } else {
        clientResponseOutput.textContent = "Failed to generate token";
      }
    } catch (error) {
      console.error("Error:", error);
      clientResponseOutput.textContent = "Error generating the token";
    }
  });
});
