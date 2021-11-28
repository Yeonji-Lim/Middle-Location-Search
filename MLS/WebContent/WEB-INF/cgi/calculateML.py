#!/usr/local/bin/python3

print("content-type:text/html; charset=UTF-8\n")

import cgi  # python을 cgi로 사용
import numpy as np # 원적합 계산을 위함

# data from client
form = cgi.FieldStorage()
latlng = form["latlng"].value

# 임의의 좌표 추가, ndarray 형식 변환
data = [[1,1], [3, -1], [0, 4], [5, 6]]
A = np.array(data)

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
# print(x_c, y_c, r_c)

"""
# 원적합 확인 

def make_circle(c, r):
    theta = np.linspace(0, 2 * np.pi, 256)
    x = r * np.cos(theta)
    y = r * np.sin(theta)    
    return np.vstack((x, y)).T + c

import matplotlib.pyplot as plt

fitted_circle = make_circle(np.array([x_c, y_c]), r_c)

plt.figure(figsize = (4,4))

plt.subplot(132)
plt.plot(fitted_circle[:,0], fitted_circle[:, 1], 'y-', label = 'fitted_circle')
plt.scatter(x = A[:,1], y = A[:, 2], color = 'r', label = 'sampled point')
plt.grid()
plt.xlim(0,20)
plt.ylim(0,20)

plt.show()
"""

print('''
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="hiden_form" action="./calculateML" method="POST">
        <input type="hidden" name="x" value="{x}"/>
        <input type="hidden" name="y" value="{y}"/>
        <input type="hidden" name="r" value="{r}"/>
        <input type="submit" />
    </form>
	<script>
		document.hiden_form.submit();
	</script>
</body>
</html>
'''.format(x=x_c, y=y_c, r=r_c))
