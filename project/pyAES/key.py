import hashlib

def generate_key_from_matrix_file(file_path):
    # 读取矩阵文件的内容
    with open(file_path, 'rb') as file:
        matrix_data = file.read()

    # 计算SHA-256哈希值
    sha256_hash = hashlib.sha256(matrix_data).hexdigest()

    # 截取后128位作为密钥
    key = sha256_hash[-32:]

    return key

if __name__ == "__main__":
    matrix_file_path = 'gradient_matrix_data.txt'  # 替换为实际的矩阵文件路径

    generated_key = generate_key_from_matrix_file(matrix_file_path)

    print(f"Generated Key: {generated_key}")
