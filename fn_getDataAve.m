function data_ave = fn_getDataAve(N,data)

len = length(data);
sr_data = zeros(1,N);  % crude register to hold last Nave data values
sr_tail = 1;
sr_size = 0;

i_data = 1;
i_ave = 1;
while i_data<=N % load shift reg (output first half and last)
    sr_data(sr_tail) = data(i_data);
    i_data = i_data + 1;
    sr_size = min(sr_size+1,N);
    sr_tail = mod(sr_tail,N) + 1;  % mod counts 0:3, sr_head 1:4
    if sr_size<N/2 || sr_size==N   % first half do ave on size<N, last reg full
        sr_sum = sum(sr_data);
        data_ave(i_ave,1) = sr_sum/sr_size;
        i_ave = i_ave + 1;    
    end
end

while i_data<=len  % calc ave (centre of reg)
    sr_data(sr_tail) = data(i_data);
    i_data = i_data + 1;
    sr_size = min(sr_size+1,N);
    sr_tail = mod(sr_tail,N) + 1;  % mod counts 0:3, sr_head 1:4

    sr_sum = sum(sr_data);
    data_ave(i_ave,1) = sr_sum/sr_size;
    i_ave = i_ave + 1;    
end

for i=1:N-1   % empty shift reg except last (output last half)
    sr_data(sr_tail) = 0;
    sr_size = sr_size - 1;
    sr_tail = mod(sr_tail,N) + 1;  % mod counts 0:3, sr_head 1:4
    if sr_size<=N/2  
        sr_sum = sum(sr_data);
        data_ave(i_ave,1) = sr_sum/sr_size;
        i_ave = i_ave + 1;
    end
end

