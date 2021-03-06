#library(mvtnorm)

plot.item = function(est, item,numboot,alpha,envel=FALSE){
  
  gg = function(a,d, cp,  theta){
    exp(cp)/(1+exp(cp))+ (1-(exp(cp)/(1+exp(cp))))*(1 + exp(-D*(a*theta+ d)))^(-1)
  }
  
  nitems = nrow(est$zita)
  x = seq(from = -6,to = 6,by = .1)
  y = sapply(X = x,FUN = gg,a = est$zita[item,1],d = est$zita[item,2],cp = qlogis(est$zita[item,3]))  
  plot(x,y,xlim=c(-6,6),ylim=c(0,1),type="l",main=paste("Curva característica para el item",
                                                        item,sep=" "),
       xlab = expression(theta),ylab = expression(P(theta)))
  if(envel == TRUE){
    inf = diag(c(est$hess[item,item],est$hess[nitems + item,nitems + item],est$hess[2 * nitems + item,2 * nitems + item]))
    inf[1,2] = inf[2,1] = est$hess[item,nitems + item]
    inf[1,3] = inf[3,1] = est$hess[item,2 * nitems + item]
    inf[2,3] = inf[3,2] = est$hess[nitems + item,2 * nitems + item]
    inf = solve(inf) 
    mean = est$zita[item,]
    boot = rmvnorm(n = numboot,mean = mean,sigma = inf,method = "chol")
    boot[,3] = ifelse(boot[,3] >= 1,1 - 1e-6,boot[,3])
    boot[,3] = ifelse(boot[,3] <= 0,sqrt(2.2e-16),boot[,3])
    boot[,1] = ifelse(boot[,1] <= 0,sqrt(2.2e-16),boot[,1])
    trace = rep(0,nrow(boot))
    envelop = matrix(0,nrow = length(x),ncol = 2)
    for(i in 1:length(x)){
      for(j in 1:length(trace)){
        trace[j] = gg(a = boot[j,1],d = boot[j,2],cp = qlogis(boot[j,3]),theta = x[i])
      }
      trace = sort(trace)
      lower <- trace[floor(length(trace) * alpha / 2)]
      upper <- trace[ceiling(length(trace) * (1 - alpha / 2))]
      envelop[i,] = c(lower,upper)    
    }
      
    lines(x,envelop[,1],col="red",lty=2)
    lines(x,envelop[,2],col="red",lty=2)
  }
}

