function [sig] = pcmread_stereo(url)
fileId = fopen(url,'r');
sig = fread(fileId,inf,'int16');
fclose(fileId);
sig = [sig(1:2:end), sig(2:2:end)];
end