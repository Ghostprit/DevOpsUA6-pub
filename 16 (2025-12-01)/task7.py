import json

with open('/home/bartas/Documents/DevOpsUA6/DevOpsUA6-pub/16 (2025-12-01)/task1.json', 'r') as file:
    data = json.load(file)

data['student']['age'] = "17"

with open('/home/bartas/Documents/DevOpsUA6/DevOpsUA6-pub/16 (2025-12-01)/task7.json', 'w') as file:
    json.dump(data, file, indent=4)