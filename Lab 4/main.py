#!/Users/nicholasc/Documents/School/Waterloo\ CE\ \(2019-2024\)/Year\ 4\ \(2022\ :\ 2023\)/Term\ 3B\ \(Fall\ 2022\)/ECE356\ -\ Database\ Systems/Labs/Lab\ 4/venv/bin/python3
from sklearn import tree
import matplotlib.pyplot as plt
import random
import csv

FILE_NAME = "./Task_A.csv"

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
        values = [int(i) for i in values]

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
        values = [int(i) for i in values]

        X.append(values[0:len(values)-1])
        Y.append(values[-1])

    ans = clf.predict(X)

    test = 0
    for i in range(len(ans)):
        if ans[i] == Y[i]:
            test += 1
    print(test / len(ans))


def main():
    data = read_csv(FILE_NAME)

    clf = build_decision_tree(data[0:int(0.8*len(data))])
    predict_from_tree(clf, data[int(0.8*len(data)):])

main()
