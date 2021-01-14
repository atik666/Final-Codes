import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from scipy.stats import skew

# Importing the dataset
dataset = pd.read_excel(r'C:\Users\DELL\Desktop\Reg\reg.xlsx')
dataset = dataset.iloc[:,:].values

# Encoding
encodedDataset = np.array(pd.concat([pd.get_dummies(dataset[:, 0]), 
                                pd.get_dummies(dataset[:, 1]),
                         pd.DataFrame(dataset[:, 2:])], axis = 1))

# Avoid dummy trap
encodedDataset = encodedDataset[:, 1:]
encodedDataset = np.delete(encodedDataset, 4, 1)

encodedDataset[:, [8, 4]] = encodedDataset[:, [4, 8]] 

# Data partitioning
X = encodedDataset[:, :-1]
y = encodedDataset[:, -1]

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size = 0.3, random_state = 0)

# Regression model
from sklearn.linear_model import LinearRegression
regressor = LinearRegression(normalize=True)
regressor.fit(X_train, y_train)

y_pred = regressor.predict(X_test)

from sklearn.metrics import mean_squared_error as mse
error = mse(y_test, y_pred)*100
print(error)

'''
import statsmodels.api as sm
X = np.append(arr = np.ones((len(X),1)).astype(int), values = X, axis=1)

X_opt = X[:,:].astype(np.float64)

regressor_OLS = sm.OLS(y , X_opt).fit()

print(regressor_OLS.summary())'''







