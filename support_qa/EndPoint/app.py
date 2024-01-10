import os
from time import sleep

import openai
from dotenv import load_dotenv
from flask import Flask, request, jsonify
from flask_cors import CORS
from openai import OpenAI
from packaging import version

import functions

load_dotenv()

# Check OpenAI version is correct
required_version = version.parse("1.1.1")
current_version = version.parse(openai.__version__)
OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')
if current_version < required_version:
    raise ValueError(f"Error: OpenAI version {openai.__version__}"
                     " is less than the required version 1.1.1")
else:
    print("OpenAI version is compatible.")

# Start Flask app
app = Flask(__name__)
CORS(app)

# Init client
client = OpenAI(
    api_key=OPENAI_API_KEY)

# Create new assistant or load existing
assistant_id = functions.create_assistant(client)


# Start conversation thread
@app.route('/start', methods=['GET'])
def start_conversation():
    print("Starting a new conversation...")  # Debugging line
    thread = client.beta.threads.create()
    print(f"New thread created with ID: {thread.id}")  # Debugging line
    return jsonify({"thread_id": thread.id})


# Generate response
@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.json
        thread_id = data.get('thread_id')
        user_input = data.get('message', '')

        if not thread_id:
            print("Error: Missing thread_id")  # Debugging line
            return jsonify({"error": "Missing thread_id"}), 400

        print(f"Received message: {user_input} for thread ID: {thread_id}"
              )  # Debugging line

        # Add the user's message to the thread
        client.beta.threads.messages.create(thread_id=thread_id,
                                            role="user",
                                            content=user_input)

        # Run the Assistant asynchronously
        run = client.beta.threads.runs.create(thread_id=thread_id,
                                              assistant_id=assistant_id)

        # Poll for completion
        run_status = None
        while run_status is None or run_status.status != 'completed':
            sleep(1)
            run_status = client.beta.threads.runs.retrieve(thread_id=thread_id, run_id=run.id)

        # Retrieve and return the latest message from the assistant
        messages = client.beta.threads.messages.list(thread_id=thread_id)
        response = messages.data[0].content[0].text.value

        print(f"Assistant response: {response}")  # Debugging line
        return jsonify({"response": response})
    except Exception as e:
        print(f"An error occurred: {e}")
        return jsonify({"error": "Internal server error"}), 500


# Run server
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
