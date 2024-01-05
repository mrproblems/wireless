import numpy as np
import matplotlib.pyplot as plt

# 读取 PCM 格式的音频文件
file_path = 'data/test520231229203123.pcm'
audio_data = np.fromfile(file_path, dtype=np.int16)  # 读取音频数据

# 设定 FFT 的参数
fft_length = 2048
time_slots = len(audio_data) // fft_length
fs = 48000

# 初始化存储梯度特征的矩阵
gradient_matrix = np.zeros((time_slots - 1, fft_length))

# 计算频域信号和梯度
for t in range(1, time_slots):
    start_index_t = (t - 1) * fft_length
    end_index_t = t * fft_length
    prev_start_index_t = (t - 2) * fft_length

    if end_index_t < len(audio_data) and prev_start_index_t >= 0:
        # 计算当前时间段和前一个时间段的频域信号
        signal_fft_t = np.fft.fft(audio_data[start_index_t:end_index_t])
        prev_signal_fft_t = np.fft.fft(audio_data[prev_start_index_t:prev_start_index_t + fft_length])

        # 计算梯度
        gradient_matrix[t - 1] = np.abs(signal_fft_t - prev_signal_fft_t)

# 生成时间轴
time_axis = np.arange(0, len(gradient_matrix)) * (fft_length / fs)

# 生成频率轴
bin_width_hz = fs / fft_length
frequency_axis_khz = np.arange(0, fft_length) * (bin_width_hz / 1000)

# 找到感兴趣的频率范围
index_min = np.argmin(np.abs(frequency_axis_khz - 15))
index_max = np.argmin(np.abs(frequency_axis_khz - 35))

# 裁剪图像
cropped_image = gradient_matrix[:, index_min:index_max]
cropped_frequency_axis = frequency_axis_khz[index_min:index_max]

# 绘制热图
plt.figure()
plt.imshow(cropped_image.T, aspect='auto', extent=[0, np.max(time_axis), np.max(cropped_frequency_axis), np.min(cropped_frequency_axis)])
plt.title('Doppler Profiles of Acoustic Signals')
plt.xlabel('Time (Seconds)')
plt.ylabel('Frequency (kHz)')
plt.colorbar()  # 显示颜色条

plt.savefig('output/Doppler_Profiles.png')  # 保存为 PNG 格式文件，也可以根据需要更改为其他格式
