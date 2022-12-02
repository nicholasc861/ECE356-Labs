#!/Users/nicholasc/Documents/School/Waterloo\ CE\ \(2019-2024\)/Year\ 4\ \(2022\ :\ 2023\)/Term\ 3B\ \(Fall\ 2022\)/ECE356\ -\ Database\ Systems/Labs/Lab\ 4/venv/bin/python3
from sklearn import tree
from sklearn.metrics import confusion_matrix
import matplotlib.pyplot as plt
import random
import csv
import math

FILE_NAME = "./Task_A.csv"
TRAINING_DATA_PERCENTAGE = 0.8

def read_csv(file_name):
    f = open(file_name)
    
    # Parse CSV to list of dictionaries
    rows = csv.DictReader(f)
    return list(rows)

def build_decision_tree(data):
    X = []
    Y = []

    for row in data:
        values = list(row.values())[1:]
        values = [float(i) for i in values]

        X.append(values[0:len(values)-1])
        Y.append(values[-1])

    clf = tree.DecisionTreeClassifier()
    clf = clf.fit(X, Y)
    return clf

def predict_from_tree(clf, data):
    X = []
    Y = []

    for row in data:
        values = list(row.values())[1:]
        values = [float(i) for i in values]

        X.append(values[0:len(values)-1])
        Y.append(values[-1])

    return clf.predict(X)

    # test = 0
    # test1 = 0
    # test2 = 0
    # for i in range(len(ans)):
    #     if ans[i] == Y[i]:
    #         test += 1
    #     if ans[i] == 1:
    #         test1 += 1
    #     if Y[i] == 1:
    #         test2 += 1

    # print(test / len(ans))
    # print(test1)
    # print(test2)


def main():
    data = read_csv(FILE_NAME)
    training_indexes = random.sample(range(len(data)), math.floor(int(len(data))*TRAINING_DATA_PERCENTAGE))
    
    training_data = []
    testing_data = data.copy()
    for i in training_indexes:
        testing_data.remove(data[i])
        training_data.append(data[i])

    clf = build_decision_tree(training_data)
    predicted_ans = predict_from_tree(clf, testing_data)

    actually_nominated_players = [int(i["nominated"]) for i in testing_data]
    tn, fp, fn, tp = confusion_matrix(actually_nominated_players,predicted_ans).ravel()

    print(f"True Negatives: \t{tn}")
    print(f"False Positives: \t{fp}")
    print(f"False Negatives: \t{fn}")
    print(f"True Positives: \t{tp}")
    print(f"True Positive Rate: \t{tp/(tp+fn)}")
    print(f"False Negative Rate: \t{fn/(tp+fn)}")

main()
