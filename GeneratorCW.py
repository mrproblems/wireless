import numpy as np
import wave
import matplotlib.pyplot as plt

# sampling frequency
sf = 48000
# signal time
totalTime = 6
# signal frequency
freq = 20000

# generate CW signal
totalPoint = sf * totalTime
t = np.arange(totalPoint) / sf
audioData = (65536 / 2 - 1) * np.cos(2 * np.pi * freq * t)
audioData = audioData.astype(np.short)

# save audio file
file = wave.open("CW20000.wav", "wb")
file.setnchannels(2)
file.setsampwidth(2)
file.setframerate(sf)
file.writeframes(audioData.tobytes())
file.close()

# plot the generated waveform
# this may cost over 20 seconds
plt.figure(1)
plt.plot(t, audioData)
plt.show()
