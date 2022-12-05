#!/Users/nicholasc/Documents/School/Waterloo\ CE\ \(2019-2024\)/Year\ 4\ \(2022\ :\ 2023\)/Term\ 3B\ \(Fall\ 2022\)/ECE356\ -\ Database\ Systems/Labs/Lab\ 4/venv/bin/python3
from sklearn import tree
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.metrics import confusion_matrix, accuracy_score, precision_score, recall_score, f1_score
import matplotlib.pyplot as plt
import sys
import csv

FILE_NAME_A = "./Task_A.csv"
FILE_NAME_B = "./Task_B.csv"
TRAINING_DATA_PERCENTAGE = 0.8

# TASK A Hyperparameters
TASK_A_PARAMS = {
    "ccp_alpha": 0.00025363,
    "class_weight": {0: 0.25, 1: 0.55},
    "min_samples_leaf": 0.010,
    "max_depth": 20
}

# TASK B Hyperparameters
TASK_B_PARAMS = {
    "ccp_alpha": 0.0023,
    "min_samples_leaf": 0.005,
    "max_depth": 6,
}

def find_best_params(clf, x_train, y_train):
    test_params = {
        "class_weight": ["balanced", None],
        "min_samples_leaf": range(2, 20),
        "min_samples_split": range(2, 20),
        "max_depth": range(1, 30)
    }

    grid = GridSearchCV(clf, param_grid=test_params, n_jobs=-1)
    grid.fit(x_train, y_train)
    print(grid.best_params_)
    print(grid.best_score_)



def read_csv(file_name):
    f = open(file_name)
    
    # Parse CSV to list of dictionaries
    rows = csv.DictReader(f)
    return list(rows)

def build_decision_tree(x_train, y_train, params):
    clf = tree.DecisionTreeClassifier(**params)
    clf = clf.fit(x_train, y_train)

    return clf

def predict_from_tree(clf, x_test):
    return clf.predict(x_test)

def main():
    if len(sys.argv) < 2:
        print("Please enter taska or taskb to run the predictor.")
        return

    if sys.argv[1] == "taska":
        file_name = FILE_NAME_A
        params = TASK_A_PARAMS
    elif sys.argv[1] == "taskb":
        file_name = FILE_NAME_B
        params = TASK_B_PARAMS
    else:
        print("Please enter taska or taskb to run the predictor.")


    data = read_csv(file_name)
    tp_rate, fn_rate, total_acc, total_recall, total_prec, total_f1 = 0, 0, 0, 0, 0, 0

    for j in range(0, 5):
        X = []
        Y = []

        for row in data:
            values = list(row.values())[1:]
            values = [float(i) for i in values]

            X.append(values[0:len(values)-1])
            Y.append(values[-1])


        x_train, x_test, y_train, y_test = train_test_split(X, Y, test_size=0.2)

        clf = build_decision_tree(x_train, y_train, params)

        # Check for best hyperparameters
        # find_best_params(clf, x_train, y_train)

        predicted_ans = predict_from_tree(clf, x_test)
        predicted_train = predict_from_tree(clf, x_train)
        print(clf.get_depth())

        train_tn, train_fp, train_fn, train_tp = confusion_matrix(y_train, predicted_train).ravel()

        tn, fp, fn, tp = confusion_matrix(y_test, predicted_ans).ravel()

        tp_rate += tp/(tp+fn)
        fn_rate += fn/(tp+fn)
        accuracy = accuracy_score(y_test,predicted_ans)
        recall = recall_score(y_test,predicted_ans)
        precision = precision_score(y_test,predicted_ans)
        f1 = f1_score(y_test, predicted_ans)

        # print(clf.cost_complexity_pruning_path(x_train, y_train))

        total_acc += accuracy
        total_recall += recall
        total_prec += precision
        total_f1 += f1

        print(f"Run \t{j}")
        print(f"Training Dataset")
        print(f"True Negatives: \t{train_tn}")
        print(f"False Positives: \t{train_fp}")
        print(f"False Negatives: \t{train_fn}")
        print(f"True Positives: \t{train_tp}")
        print(f"True Positive Rate: \t{train_tp/(train_tp+train_fn)}")
        print(f"False Negative Rate: \t{train_fn/(train_tp+train_fn)}")
        print(f"Accuracy: \t{accuracy_score(y_train, predicted_train)}")
        print(f"Recall: \t{recall_score(y_train, predicted_train)}")    
        print(f"Precision: \t{precision_score(y_train, predicted_train)}")
        print(f"F1 Score: \t{f1_score(y_train, predicted_train)}")
        print("\n")
        print(f"Testing Dataset")
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
