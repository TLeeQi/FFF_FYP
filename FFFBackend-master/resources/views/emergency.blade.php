<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emergency Alert</title>
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
</head>
<body>
    <div class="container mt-5">
        <h1>Emergency Alert</h1>
        <p>User ID: {{ $userId }}</p>
        <p>An emergency has been triggered. Please contact the authorities immediately.</p>
        <button onclick="callPolice()">Call Police</button>
    </div>

    <script>
        function callPolice() {
            alert('Calling the police...');
            // Implement actual call logic if needed
        }
    </script>
</body>
</html>