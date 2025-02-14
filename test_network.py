import requests

try:
    response = requests.get("http://www.google.com", timeout=5)
    print("Internet is accessible:", response.status_code)
except requests.exceptions.RequestException as e:
    print("Network access is blocked:", e)

