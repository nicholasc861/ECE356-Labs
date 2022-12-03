#!/Users/nicholasc/Documents/School/Waterloo\ CE\ \(2019-2024\)/Year\ 4\ \(2022\ :\ 2023\)/Term\ 3B\ \(Fall\ 2022\)/ECE356\ -\ Database\ Systems/Labs/Lab\ 4/venv/bin/python3
from sklearn import tree
from sklearn.metrics import confusion_matrix, accuracy_score, precision_score, recall_score, f1_score
import matplotlib.pyplot as plt
import random
import csv
import math

FILE_NAME = "./Task_B.csv"
TRAINING_DATA_PERCENTAGE = 0.8

# TASK A Hyperparameters
TASK_A_CLASS_WEIGHT = {0: 0.38, 1: 0.62}
TASK_A_MIN_LEAF=75
TASK_A_MAX_DEPTH=30

# TASK B Hyperparameters
TASK_B_CLASS_WEIGHT = {0: 0.45, 1: 0.55}
TASK_B_MIN_LEAF=15
TASK_B_MAX_DEPTH=30


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

    clf = tree.DecisionTreeClassifier(min_samples_leaf=TASK_B_MIN_LEAF, max_depth=TASK_B_MAX_DEPTH, class_weight=TASK_B_CLASS_WEIGHT)
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

def main():
    data = read_csv(FILE_NAME)
    tp_rate, fn_rate, total_acc, total_recall, total_prec, total_f1 = 0, 0, 0, 0, 0, 0

    for j in range(0, 5):
        training_indexes = random.sample(range(len(data)), math.floor(int(len(data))*TRAINING_DATA_PERCENTAGE))
        
        training_data = []
        testing_data = data.copy()
        for i in training_indexes:
            testing_data.remove(data[i])
            training_data.append(data[i])

        clf = build_decision_tree(training_data, )
        predicted_ans = predict_from_tree(clf, testing_data)


        actually_nominated_players = [int(i["class"]) for i in testing_data]
        tn, fp, fn, tp = confusion_matrix(actually_nominated_players,predicted_ans).ravel()

        tp_rate += tp/(tp+fn)
        fn_rate += fn/(tp+fn)
        accuracy = accuracy_score(actually_nominated_players,predicted_ans)
        recall = recall_score(actually_nominated_players,predicted_ans)
        precision = precision_score(actually_nominated_players,predicted_ans)
        f1 = f1_score(actually_nominated_players, predicted_ans)

        total_acc += accuracy
        total_recall += recall
        total_prec += precision
        total_f1 += f1

        print(f"Run \t{j}")
        print(f"True Negatives: \t{tn}")
        print(f"False Positives: \t{fp}")
        print(f"False Negatives: \t{fn}")
        print(f"True Positives: \t{tp}")
        print(f"True Positive Rate: \t{tp/(tp+fn)}")
        print(f"False Negative Rate: \t{fn/(tp+fn)}")
        print(f"Accuracy: \t{accuracy}")
        print(f"Recall: \t{recall}")    
        print(f"Precision: \t{precision}")
        print(f"F1 Score: \t{f1}")
        print("\n")
    
    print("Average Metrics:")
    print(f"True Positive Rate: \t{tp_rate/5}")
    print(f"False Negative Rate: \t{fn_rate/5}")
    print(f"Accuracy: \t{total_acc/5}")
    print(f"Recall: \t{total_recall/5}")    
    print(f"Precision: \t{total_prec/5}")
    print(f"F1 Score: \t{total_f1/5}")



main()
