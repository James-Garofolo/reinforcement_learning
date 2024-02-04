import numpy as np

"""t = 42
n = np.array([11, 10, 7, 14])
s = np.array([3, 4, 3, 10])

print(np.round(s/n, 4), np.round(np.sqrt((2*np.log(t))/n), 4), np.round(s/n, 4)+np.round(np.sqrt((2*np.log(t))/n), 4))"""

"""p11 = 0.99
p10 = 0.005
p_1 = 0.002

print((p11*p11*p_1)/(p11*p11*p_1 + p10*p10*(1-p_1)))"""

s = np.array([7.2, 6.9, 7.1, 6.8, 7, 7.1, 6.9, 6.9])

var = ((1/(100**2))+s.size)**(-1)
mu = var*(np.sum(s))
print(var, mu)