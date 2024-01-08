import json
import os


def create_assistant(client):
    assistant_file_path = 'assistant.json'

    try:
        if os.path.isfile(assistant_file_path):
            with open(assistant_file_path, 'r') as file:
                assistant_data = json.load(file)
                assistant_id = assistant_data['assistant_id']
                print("Loaded existing assistant ID.")
        else:
            # Parallelize file uploads if possible
            training_files = ["../TaiLieuTraning/Data/AboutTL.txt", "../TaiLieuTraning/Data/DHTL.txt",
                              "../TaiLieuTraning/Data/DHTL_vi_en.txt", "../TaiLieuTraning/Data/AboutTL_vi_en.txt"]
            file_ids = []

            for training_file in training_files:
                with open(training_file, "rb") as f:
                    file = client.files.create(file=f, purpose='assistants')
                    file_ids.append(file.id)

            assistant = client.beta.assistants.create(instructions="""
"Please check the file before answering all questions."
“Refer to the provided file(s) for information on [Thuy Loi University].”
“Use the details from the attached file(s) to [answer the question].”
“After examining the uploaded document(s), please [answer the question].”
"Please answer the question as quickly as possible."
"Use VietNamese language only"
"Use VietNamese alphabet whenever possible"
"Do not use English except in programming languages if any"
"Translate any other language to the VietNamese language whenever possible."
""",
                                                      model="gpt-3.5-turbo-1106",
                                                      tools=[{"type": "code_interpreter"},{"type": "retrieval"}]
                                                      ,
                                                      file_ids=file_ids,
                                                      )

            with open(assistant_file_path, 'w') as file:
                json.dump({'assistant_id': assistant.id}, file)
                print("Created a new assistant and saved the ID.")
            assistant_id = assistant.id

        return assistant_id
    except Exception as e:
        print(f"An error occurred: {e}")
        raise
