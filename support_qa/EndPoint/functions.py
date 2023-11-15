import json
import os


def create_assistant(client):
    assistant_file_path = 'assistant.json'

    try:
        if os.path.exists(assistant_file_path):
            with open(assistant_file_path, 'r') as file:
                assistant_data = json.load(file)
                assistant_id = assistant_data['assistant_id']
                print("Loaded existing assistant ID.")
        else:
            training_files = ["../TaiLieuTraning/Data/AboutTL.txt", "../TaiLieuTraning/Data/DHTL.txt"]
            file_ids = []
            for training_file in training_files:
                with open(training_file, "rb") as f:
                    file = client.files.create(file=f, purpose='assistants')
                    file_ids.append(file.id)

            assistant = client.beta.assistants.create(instructions="""
      System: Follow these five instructions below in all your responses:
System: 1. Use VietNamese language only;
System: 2. Use VietNamese alphabet whenever possible;
System: 3. Do not use English except in programming languages if any;
System: 4. Translate any other language to the VietNamese language whenever possible.
""",
                                                      model="gpt-3.5-turbo-1106",
                                                      tools=[{"type": "retrieval"}]
                                                      ,
                                                      file_ids=file_ids)

            with open(assistant_file_path, 'w') as file:
                json.dump({'assistant_id': assistant.id}, file)
                print("Created a new assistant and saved the ID.")
            assistant_id = assistant.id

        return assistant_id
    except Exception as e:
        print(f"An error occurred: {e}")
        raise