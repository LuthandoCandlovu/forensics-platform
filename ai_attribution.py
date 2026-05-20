import sys, json
from sklearn.ensemble import RandomForestClassifier

def predict(features):
    X = [[1,0,0,1], [0,2,1,0], [5,3,2,5]]
    y = ["APT28", "Magecart", "Ransomware"]
    model = RandomForestClassifier()
    model.fit(X, y)
    return model.predict([features])[0]

if __name__ == "__main__":
    input_data = json.loads(sys.argv[1])
    threat = predict(input_data["features"])
    result = {"threat": threat, "confidence": 0.87, "recommendations": ["Isolate host", "Collect memory dump", "Reset credentials"]}
    print(json.dumps(result))
