import matplotlib.pyplot as plt

with open("log_noise.txt") as f:
    lines = f.readlines()
    x = []
    y = []
    for line in lines:
        x.append(line.split()[0])
        y.append(line.split()[1])

plt.plot(x,y)
plt.show()
