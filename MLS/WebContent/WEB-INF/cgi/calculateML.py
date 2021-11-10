#! /Library/Frameworks/Python.framework/Versions/3.8/bin/python3

import numpy as np
import matplotlib.pyplot as plt

print("content-type:text/html; charset=UTF-8\n")

print('Hello World!')

def make_circle(c, r):
    theta = np.linspace(0, 2 * np.pi, 256)
    x = r * np.cos(theta)
    y = r * np.sin(theta)    
    return np.vstack((x, y)).T + c

c = np.array([2, 3])
r = 1.5

circle = make_circle(c, r)

# circle 변수에서 20개 추출
idx = np.random.choice(len(circle), 15)
A = circle[idx]

# 가우시안 노이즈 추가
A = A + 0.09 * np.random.randn(A.shape[0], A.shape[1])

ones = np.ones((A.shape[0], 1))
A = np.concatenate((ones, A), axis = 1)
b = A[:,1] ** 2 + A[:,2] ** 2

c = np.linalg.inv(A.T.dot(A)).dot(A.T).dot(b)
# or you can do this just by using 
# np.linalg.lstsq(A, b, rcond=None)[0]

def return_circle(c):
    x_c = c[1] / 2
    y_c = c[2] / 2
    r = c[0] + x_c ** 2 + y_c ** 2
    
    return x_c, y_c, np.sqrt(r)

x_c, y_c, r_c = return_circle(c)
print(x_c, y_c, r_c)

fitted_circle = make_circle(np.array([x_c, y_c]), r_c)

plt.figure(figsize = (12,4))

# plt.figure(figsize = (4,4))
# plt.plot(circle[:,0], circle[:, 1], 'b-')
# plt.scatter(x = A[:,0], y = A[:, 1], color = 'r')
# plt.grid()
# plt.xlim(0,5)
# plt.ylim(0,5)
# plt.show()

plt.subplot(131)
plt.plot(circle[:,0], circle[:, 1], 'b-', label = 'original_circle')
plt.scatter(x = A[:,1], y = A[:, 2], color = 'r', label = 'sampled point')
plt.grid()
plt.xlim(0,5)
plt.ylim(0,5)

plt.subplot(132)
plt.plot(fitted_circle[:,0], fitted_circle[:, 1], 'y-', label = 'fitted_circle')
plt.scatter(x = A[:,1], y = A[:, 2], color = 'r', label = 'sampled point')
plt.grid()
plt.xlim(0,5)
plt.ylim(0,5)

plt.subplot(133)
plt.plot(circle[:,0], circle[:, 1], 'b-', label = 'original_circle')
plt.plot(fitted_circle[:,0], fitted_circle[:, 1], 'y-', label = 'fitted_circle')
plt.grid()
plt.legend()
plt.xlim(0,5)
plt.ylim(0,5)

plt.tight_layout()
plt.show()