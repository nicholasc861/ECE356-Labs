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
    "ccp_alpha": 0.00012412,
    "max_depth": 5,
    "min_samples_leaf": 19,
    "min_samples_split": 2,
}

# TASK B Hyperparameters
TASK_B_PARAMS = {
    "ccp_alpha": 0.0009532,
    "min_samples_leaf": 7,
    "min_samples_split": 6,
    "max_depth": 6,
}
def plot_metric(x_train, y_train, x_test, y_test):
    max_depth = list(range(1,28))
    test_acc= []
    train_acc = []
    test_f1 = []
    train_f1 = []
    test_prec = []
    train_prec = []
    test_recall = []
    train_recall = []

    for i in range(1, 28):
   
        clf = tree.DecisionTreeClassifier(max_depth=i)

        clf = clf.fit(x_train, y_train)

        test_pred = clf.predict(x_test)
        train_pred = clf.predict(x_train)

        test_acc.append(accuracy_score(y_test, test_pred))
        train_acc.append(accuracy_score(y_train, train_pred))
        test_f1.append(f1_score(y_test, test_pred))
        train_f1.append(f1_score(y_train, train_pred))
        test_prec.append(precision_score(y_test, test_pred))
        train_prec.append(precision_score(y_train, train_pred))
        test_recall.append(recall_score(y_test, test_pred))
        train_recall.append(recall_score(y_train, train_pred))

    figure, axis = plt.subplots(2, 2)

    axis[0,0].plot(max_depth, test_acc, label="test_acc")
    axis[0,0].plot(max_depth, train_acc, label="train_acc")
    axis[0,0].set(ylabel="accuracy", xlabel="max_depth")
    axis[0,0].grid()
    axis[0,0].legend()

    axis[0,1].plot(max_depth, test_f1, label="test_f1")
    axis[0,1].plot(max_depth, train_f1, label="train_f1")
    axis[0,1].set(ylabel="f1_score", xlabel="max_depth")
    axis[0,1].grid()
    axis[0,1].legend()

    axis[1,1].plot(max_depth, test_prec, label="test_prec")
    axis[1,1].plot(max_depth, train_prec, label="train_prec")
    axis[1,1].set(ylabel="precision", xlabel="max_depth")
    axis[1,1].grid()
    axis[1,1].legend()

    axis[1,0].plot(max_depth, test_recall, label="test_recall")
    axis[1,0].plot(max_depth, train_recall, label="train_recall")
    axis[1,0].set(ylabel="recall", xlabel="max_depth")
    axis[1,0].grid()
    axis[1,0].legend()
    
    plt.show()


def find_best_params(clf, x_train, y_train, ccps):
    test_params = {
        "ccp_alpha": ccps[4:int(len(ccps)/2)],
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
    return (list(rows), rows.fieldnames)

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


    data, features = read_csv(file_name)
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



        predicted_ans = predict_from_tree(clf, x_test)
        predicted_train = predict_from_tree(clf, x_train)

        train_tn, train_fp, train_fn, train_tp = confusion_matrix(y_train, predicted_train).ravel()

        tn, fp, fn, tp = confusion_matrix(y_test, predicted_ans).ravel()

        tp_rate += tp/(tp+fn)
        fn_rate += fn/(tp+fn)
        accuracy = accuracy_score(y_test,predicted_ans)
        recall = recall_score(y_test,predicted_ans)
        precision = precision_score(y_test,predicted_ans)
        f1 = f1_score(y_test, predicted_ans)

        # ccps = clf.cost_complexity_pruning_path(x_train, y_train)

        # Check for best hyperparameters
        # find_best_params(clf, x_train, y_train, ccps.ccp_alphas)

        # Check for best depth
        # plot_metric(x_train,y_train,x_test,y_test)

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

        fig = plt.figure(figsize=(25,20))
        _ = tree.plot_tree(clf, feature_names=features[1:-1], class_names=['YES', 'NO'])
        fig.savefig(f"decisiontree{j+1}.png")
    
    print("Average Metrics:")
    print(f"True Positive Rate: \t{tp_rate/5}")
    print(f"False Negative Rate: \t{fn_rate/5}")
    print(f"Accuracy: \t{total_acc/5}")
    print(f"Recall: \t{total_recall/5}")    
    print(f"Precision: \t{total_prec/5}")
    print(f"F1 Score: \t{total_f1/5}")



main()
