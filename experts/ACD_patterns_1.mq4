//+------------------------------------------------------------------+
//|                                               ACD_patterns_1.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

MqlRates g_ready_bar;

input double g_lot=0.01;//лот
input int magic_number = 1488; //магик
input int g_slippage = 3;//проскальзывание
input int expiration_bar = 3;//экспирация
input int g_delta_points_sl=1; //дельта стоп-лосса
input int g_delta_points_p=1; //дельта отложености  
input int tp= 0; //фиксированая прибыль 
input bool use_trand = true; //трендоориентированость
//input bool reverse = true; //учитывать разворотный бар
//input int secret= 2; //;) 
//input int ma_period= 1; //;)

double upper_fractal;   
double lower_fractal;


enum trand_mode
{
 UP,
 DOWN,
 BROKEN,
 NONE
};


trand_mode acd_trand();
bool is_equal(MqlRates& b1,MqlRates& b2);


int OnInit()
  {
  
     MqlRates rates[];
     ArrayCopyRates(rates,NULL,0);
     g_ready_bar=rates[1];  
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  
    MqlRates rates[];
    ArrayCopyRates(rates,NULL,0);
    
   trand_mode tmp = acd_trand();
   trand_mode main_trand = NONE;
      
   if(tmp==DOWN && use_trand)
      main_trand = DOWN;
   if(tmp==UP && use_trand)
      main_trand = UP; 
    
    if(!is_equal(g_ready_bar,rates[1]))
    {
      g_ready_bar=rates[1];
      
      double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
      
      bool iHui = patterns();
      
      double sl_buy= 0; 
      double sl_sell= 0;
      double price_buy= 0;
      double price_sell= 0;
      double tp_sell = 0;
      double tp_buy = 0;
      double sl_sell_mod = 0;   
      double sl_buy_mod = 0;
   
      int ticket=-1;
      int close_ticket = -1;
      int mod_ticket = -1;
      
      bool new_fracUP = false;   
      bool new_fracLOW = false;
     
      datetime expiration = 0;  
       
      if(expiration_bar!=0)
         expiration=TimeCurrent()+expiration_bar*PeriodSeconds(Period());
         
      price_buy  = MathMax(NormalizeDouble(Ask+minstoplevel*Point,Digits),NormalizeDouble(High[1]+g_delta_points_p*Point,Digits));
      price_sell = MathMin(NormalizeDouble(Bid-minstoplevel*Point,Digits),NormalizeDouble(Low[1]-g_delta_points_p*Point,Digits));
      sl_buy = MathMin(NormalizeDouble(MarketInfo(Symbol(),MODE_BID)-minstoplevel*Point,Digits),NormalizeDouble(Low[1] - g_delta_points_sl*Point,Digits));
      sl_sell= MathMax(NormalizeDouble(High[1] + g_delta_points_sl*Point,Digits),NormalizeDouble(MarketInfo(Symbol(),MODE_ASK)+minstoplevel*Point,Digits)); 
      
      if (tp != 0)
      {
         tp_sell=NormalizeDouble(price_sell - tp*Point,Digits);
         tp_buy=NormalizeDouble(price_buy + tp*Point,Digits);         
      }
      
      
      for(int n=1; n<(Bars);n++)
         if((iFractals(NULL,0,MODE_UPPER,n)!=NULL))
         {
            if(upper_fractal==iFractals(NULL,0,MODE_UPPER,n))
               break;
            upper_fractal = iFractals(NULL,0,MODE_UPPER,n); 
            new_fracUP = true;    
            break;
         }
            
        
      for(int n=1; n<(Bars);n++)
         if(iFractals(NULL,0,MODE_LOWER,n)!=NULL)
         {
            if(lower_fractal==iFractals(NULL,0,MODE_LOWER,n))
               break;
            lower_fractal = iFractals(NULL,0,MODE_LOWER,n);
            new_fracLOW = true;
            break;
         }
      for (int i=0; i<OrdersTotal(); i++)       
         if(OrderSelect(i,SELECT_BY_POS)==true)            
         {
            if((OrderType() == OP_SELL)&&new_fracUP)
                     mod_ticket = OrderModify(OrderTicket(),OrderOpenPrice(), NormalizeDouble((OrderStopLoss()+upper_fractal)/2,Digits),OrderTakeProfit(),0,Blue); 
            if((OrderType() == OP_BUY)&&new_fracLOW)
                     mod_ticket = OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble((OrderStopLoss()+lower_fractal)/2,Digits) ,OrderTakeProfit(),0,Red);             
         }        
      
      if ((main_trand == UP)) // бычий тренд!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      {      
         if(OrdersTotal()==0)
         {
            ticket = OrderSend(Symbol(),OP_BUYSTOP,g_lot,price_buy,g_slippage,sl_buy,tp_buy,"Bull",magic_number,expiration,clrGreen);
               //ticket=OrderSend(Symbol(),OP_BUY,g_lot,Bid,g_slippage,sl_buy,tp_buy,"Bull",magic_number,expiration,clrGreen);            
         }
         else
         {
            for (int i=0; i<OrdersTotal(); i++)
            {
               if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
                  continue;
               switch (OrderType())
                  {
                     case OP_SELL:   
                     {
                        close_ticket = OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(MarketInfo(Symbol(),MODE_ASK),Digits), g_slippage, Blue);
                        ticket = OrderSend(Symbol(),OP_BUYSTOP,g_lot,price_buy,g_slippage,sl_buy,tp_buy,"Bull",magic_number,expiration,clrGreen);
                         //  ticket=OrderSend(Symbol(),OP_BUY,g_lot,Bid,g_slippage,sl_buy,tp_buy,"Bull",magic_number,expiration,clrGreen);   
                     }
                     case OP_SELLSTOP: 
                     {
                        close_ticket = OrderDelete(OrderTicket(),Blue);
                        ticket = OrderSend(Symbol(),OP_BUYSTOP,g_lot,price_buy,g_slippage,sl_buy,tp_buy,"Bull",magic_number,expiration,clrGreen);
                           //ticket=OrderSend(Symbol(),OP_BUY,g_lot,Bid,g_slippage,sl_buy,tp_buy,"Bull",magic_number,expiration,clrGreen);
                     }                     
                  }
            }
         }
      }

         
      if ((main_trand == DOWN)) // медвежий тренд !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      {
         if(OrdersTotal()==0)
         {
            ticket = OrderSend(Symbol(),OP_SELLSTOP,g_lot,price_sell,g_slippage,sl_sell,tp_sell,"Bear",magic_number,expiration,clrRed);
             //  ticket=OrderSend(Symbol(),OP_SELL,g_lot,Ask,g_slippage,sl_sell,tp_sell,"Bear",magic_number,expiration,clrRed);            
         }
         else
         {
            for (int i=0; i<OrdersTotal(); i++)
            {
               if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
                  continue;
               switch (OrderType())
                  {
                     case OP_BUY:   
                     {
                        close_ticket = OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(MarketInfo(Symbol(),MODE_BID),Digits), g_slippage, Red);
                        ticket = OrderSend(Symbol(),OP_SELLSTOP,g_lot,price_sell,g_slippage,sl_sell,tp_sell,"Bear",magic_number,expiration,clrRed);
                           //ticket=OrderSend(Symbol(),OP_SELL,g_lot,Ask,g_slippage,sl_sell,tp_sell,"Bear",magic_number,expiration,clrRed);   
                     }
                     case OP_BUYSTOP: 
                     {
                        close_ticket = OrderDelete(OrderTicket(),Red);
                        ticket = OrderSend(Symbol(),OP_SELLSTOP,g_lot,price_sell,g_slippage,sl_sell,tp_sell,"Bear",magic_number,expiration,clrRed);
                        //   ticket=OrderSend(Symbol(),OP_SELL,g_lot,Ask,g_slippage,sl_sell,tp_sell,"Bear",magic_number,expiration,clrRed);
                     }                     
                  }
            }
         }
      }
      
      double price = price_buy;
      double sl = sl_buy;
      string type;
      switch (OrderType())
      {
         case OP_BUY     :   type = "BUY";
         case OP_BUYSTOP :   type = "BUYSTOP";
         case OP_SELL    :   type = "SELL";
         case OP_SELLSTOP:   type = "SELLSTOP";
      }
      
      if(ticket<0)
      {
         int err=GetLastError();  
         string err_msg= type+ ":" + "\n"
         " open price:"+DoubleToString( NormalizeDouble(price, Digits))+"\n"+ 
         " sl buy:"+DoubleToString(sl_buy)+"\n"+
         " sl sell:"+DoubleToString(sl_sell)+"\n";
         //Print(err_msg);
      } 
      
    }

//---
   
  }
//+------------------------------------------------------------------+
trand_mode acd_trand()
{

   double acd_pivot_poit = iCustom(NULL,0,"ACD","00:30","00:30",true,true,false,0,0);
   /*double acd_range_top = iCustom(NULL,0,"ACD","00:30","00:30",true,true,false,1,0);
   double acd_range_bottom = iCustom(NULL,0,"ACD","00:30","00:30",true,true,false,2,0);
   double acd_day_high = iCustom(NULL,0,"ACD","00:30","00:30",true,true,false,3,0);
   double acd_day_low = iCustom(NULL,0,"ACD","00:30","00:30",true,true,false,4,0);
  */ 
   if(Ask > acd_pivot_poit)
      return UP;
   if(Bid < acd_pivot_poit)
      return DOWN;
   
   //Comment(acd_line_1 + " " +acd_line_2 + " " +acd_line_3 + " " +acd_line_4 + " " +acd_line_5 + " " +acd_line_6 + " " +acd_line_7);
   
   return NONE;
}


bool is_equal(MqlRates& b1,MqlRates& b2)
{
 return b1.time==b2.time;
}

bool patterns()
{
   double patt1,patt2,patt3,patt4,patt5,patt6,patt7;

   for(int j=0;j < 100;j++)
   {
               if(iCustom(NULL,0,"CPIv1.5",0,j)!=NULL)
         patt1 = iCustom(NULL,0,"CPIv1.5",0,j);
               if(iCustom(NULL,0,"CPIv1.5",1,j)!=NULL)
         patt2 = iCustom(NULL,0,"CPIv1.5",1,j);
               if(iCustom(NULL,0,"CPIv1.5",2,j)!=NULL)
         patt3 = iCustom(NULL,0,"CPIv1.5",2,j);
               if(iCustom(NULL,0,"CPIv1.5",3,j)!=NULL)
         patt4 = iCustom(NULL,0,"CPIv1.5",3,j);
               if(iCustom(NULL,0,"CPIv1.5",4,j)!=NULL)
         patt5 = iCustom(NULL,0,"CPIv1.5",4,j);
               if(iCustom(NULL,0,"CPIv1.5",5,j)!=NULL)
         patt6 = iCustom(NULL,0,"CPIv1.5",5,j);
               if(iCustom(NULL,0,"CPIv1.5",6,j)!=NULL)
         patt7 = iCustom(NULL,0,"CPIv1.5",6,j);        

   }
   /*
   double patt2 = iCustom(NULL,0,"CPIv1.5","00:30","00:30",true,true,false,1,0);
   double patt3 = iCustom(NULL,0,"CPIv1.5","00:30","00:30",true,true,false,2,0);
   double patt4 = iCustom(NULL,0,"CPIv1.5","00:30","00:30",true,true,false,3,0);
   double patt5 = iCustom(NULL,0,"CPIv1.5","00:30","00:30",true,true,false,4,0);
   double patt6 = iCustom(NULL,0,"CPIv1.5","00:30","00:30",true,true,false,4,0);
   double patt7 = iCustom(NULL,0,"CPIv1.5","00:30","00:30",true,true,false,4,0);
   /*
   if(Ask > acd_pivot_poit)
      return UP;
   if(Bid < acd_pivot_poit)
      return DOWN;*/
      if((patt1!=0)&&(patt2!=0)&&(patt3!=0)&&(patt4!=0)&&(patt5!=0)&&(patt6!=0)&&(patt7!=0))
         Comment(patt1 + " " +patt2 + " " +patt3 + " " +patt4 + " " +patt5 + " " +patt6 + " " +patt7);
      
   return false;
}