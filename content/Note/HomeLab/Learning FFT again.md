```
require(ggplot2)

freq <- 200  #sample frequency in Hz 
duration <- 8 # length of signal in seconds

#arbitrary sine wave 
x <- seq(-4*pi,4*pi, length.out = freq*duration)
y <- sin(4*pi*x) + sin(6*pi*x) + sin(8*pi*x)


fourier <- fft(y)

#frequency "amounts" and associated frequencies

magnitudeFFT <- abs(fft(y))
freqvec <- 1:length(magnitudeFFT)/duration
#and put this into a data.frame

df <- data.frame(freq = freqvec, ammount = magnitudeFFT)
df <- df[(1:as.integer(0.5*freq*duration)),]
df.disc <- data.frame(freq = 1:100)

cum.amo <- numeric(100)
for (i in 1:100){
  cum.amo[i] <- sum(df$ammount[c(3*i-2,3*i-1,3*i)])
}

df.disc$ammount <- cum.amo

df.disc$freq <- as.factor(df$freq[0:100])

ggplot(df.disc[1:200,], aes(x=freq, y=ammount)) + geom_bar(stat = "identity")




```