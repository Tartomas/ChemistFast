#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  dataInp<-reactive({
    
    formula<-input$text
    
    elements<-gsub('([[:upper:]])', ' \\1', formula)
    elements<-unlist(strsplit(elements, split = " "))[-1]
  
    if(length(elements)==0) return(NULL)
    
    if(length(elements)==1){
      
      numb<-gsub('([[:alpha:]])([0-9])','\\1 \\2',formula)
      numb<-unlist(strsplit(numb, split = " ",fixed=TRUE))
      elem1<-grep(paste0("^",numb[1],"$"),datos$Sym)
      
      if(length(elem1)==0){
        return(NULL)
        
      }else if(length(elem1)==1){
        numb<-gsub('([[:alpha:]])([0-9])','\\1 \\2',formula)
        numb<-unlist(strsplit(numb, split = " ",fixed=TRUE))
        ii<-grep('([0-9])',numb)
        if(length(ii)==0){
          result<-paste(datos$Sym[elem1],":",datos$AW[elem1])    
        }else{
          numb<-as.numeric(numb[ii])
          result<-paste(datos$Sym[elem1],":",datos$AW[elem1],"/ x",numb,":",datos$AW[elem1]*numb)  
        }
        
        return(result)
      }
    }else{
      
      numb<-gsub('([[:alpha:]])([0-9])','\\1 \\2',formula)
      numb<-gsub('([0-9])([[:alpha:]])','\\1 \\2',numb)
      numb<-unlist(strsplit(numb, split = " ",fixed=TRUE))
      
      mult<-grep('([0-9])',numb)
      elements<-gsub('([0-9])', "", elements)
      
      if(length(elements)!=length(mult)){
        
        if(length(mult)==0){
          numb<-rep(1,length(elements))
        }else{
          
          formPro<-numb
          numb<-gsub('([[:alpha:]])', "", numb)
          
          # suppressWarnings(numb<-na.omit(as.numeric(numb)))
          # numb<-gsub('([[:alpha:]])([0-9])','\\1 \\2',formula)
          
        #  browser()
          
          if(length(mult)<length(elements)){
            orden<-dim(length(mult))
           
            for(i in 1:length(mult)){
              aa<-grep(numb[mult[i]],formPro)  
              orden[[i]]<-as.numeric(numb[mult[i]])
            }
            unlist(orden)
            numb<-c(1,numb)
            numb<-c(numb,1)
            
            
            for(i in 1:length(mult)){
              
            }
           
            
          }else if(length(mult)==length(formPro)){
            numb<-c(1,numb)  
          }else if(length(mult)>length(formPro)){
            browser()
            numb<-c(numb)
          }
        }
        
      }else{
        numb<-gsub('([[:alpha:]])', "", numb)
        suppressWarnings(numb<-na.omit(as.numeric(numb)))
      }
        
      
      
      ii<-lapply(1:length(elements),function(e){
        oo<-grep(paste0("^",elements[[e]],"$"),datos$Sym)
        paste(datos$Sym[oo],":",datos$AW[oo],"/ x",numb[e],":",datos$AW[oo]*numb[e])
      })
    
      result<-unlist(ii)
      return(result)
    }
    
  })
  
  values <- reactiveValues(a=NA)
  
  observeEvent(input$text,{
    values$a<-dataInp()
  })
  
  output$table <- renderTable({
    
    
    if(is.null(values$a)) return()
    
    ELM<-unlist(strsplit(values$a, split = "/",fixed=TRUE))
    ELM<-unlist(strsplit(ELM, split = ":",fixed=TRUE))    
    nn<-2
    if(length(ELM)==2){nn<-1}
    #browser()
    ELM<-matrix(ELM,ncol = nn,byrow = TRUE)
    ELM<-as.data.frame(ELM)
    colnames(ELM)<-c("Element","AW")
    ELM
  })
  
  output$value <- renderPrint({

    formula<-input$text
    
    if(formula!=""){
      values$a
    }else{
      formula
    }
    
    })
  
  
})
