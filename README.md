# README

Repo Cloning and File Viewer:

This is a Ruby on Rails web application that allows users to clone a public GitHub repository and explore its contents directly in the browser. Users can browse the repository’s directory structure and click individual files to view their full contents.

The application is designed for learning purposes and demonstrates server-side Git usage, filesystem traversal, and dynamic client-side rendering.


Technologies Used:
-Ruby on Rails
-Git (via system commands)
-JavaScript / jQuery
-jsTree
-HTML / ERB

How It Works:
-The user enters a public GitHub repository URL (HTTPS, ending in .git).
-The server clones the repository into the Rails tmp/ directory.
-The application recursively builds a directory tree from the cloned repository.
-The tree is rendered in the browser using jsTree.
-When a file is selected, its contents are securely read on the server and displayed in the UI.

Setup and Running the Application - 
Prerequisites:
-Ruby
-Rails
-Git installed and available in your system PATH

How to use it:
-Start the Rails server.
-Navigate to http://localhost:3000.
-Enter a public GitHub repository URL (for example):
    https://github.com/user/repository.git
-Browse the repository and click files to view their contents.

Important Note:
-Only HTTPS GitHub URLs ending in .git are accepted!

Future Improvements:
-Caching cloned repositories
-File type filtering and search
-Support for private repositories using authentication

Author:
Dimas Monte :)
(Readme written with assistance of ChatGPT 5)