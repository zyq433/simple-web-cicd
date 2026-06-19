FROM python:3.12-alpine

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 8080

ENV FLASK_ENV=production
CMD ["python", "app.py"]
# 使用 Python 3.11 轻量版作为基础镜像
FROM python:3.11-slim

# 设置容器内的工作目录
WORKDIR /app

# 先复制依赖文件（利用 Docker 缓存，加快构建速度）
COPY requirements.txt .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目所有文件到容器内
COPY . .

# 暴露应用端口（与 app.py 中的 port=8080 对应）
EXPOSE 8080

# 启动命令
CMD ["python", "app.py"]