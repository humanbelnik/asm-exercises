import matplotlib.pyplot as plt

# Чтение данных из файла
with open('data.txt', 'r') as file:
    lines = file.readlines()

# Разделение данных на столбцы
x = []
y1 = []
y2 = []
for line in lines:
    values = line.split()
    x.append(float(values[0]))
    y1.append(float(values[1]))
    y2.append(float(values[2]))

# Построение графика
plt.plot(x, y1, label='SSE')
plt.plot(x, y2, label='Casual')

# Добавление заголовков и меток осей
plt.title('Matrix Dot Product: SSE-powered VS conventional')
plt.xlabel('Matrix size')
plt.ylabel('Time nsec')

# Добавление легенды
plt.legend()

# Отображение графика
plt.show()