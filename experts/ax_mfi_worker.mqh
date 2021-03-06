//+------------------------------------------------------------------+
//|                                                ax_mfi_worker.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property strict

enum t_mfiworkmode
{
 MFIWORKMODE_MFI,//только BW MFI
 MFIWORKMODE_AXMFI,//только AX MFI
 MFIWORKMODE_MFIANDAXMFI,//BW MFI и AX MFI
 MFIWORKMODE_MFIORAXMFI,//BW MFI или AX MFI
 MFIWORKMODE_AXMFI007,//индикатор AX007
 MFIWORKMODE_AXMFI009,//индикатор AX009 (AX007 smoothed)
};

enum t_mfi007value
{
 MFI007VALUE_NONE,
 MFI007VALUE_UP,
 MFI007VALUE_DOWN,
 MFI007VALUE_UPDOWN,
 MFI007VALUE_DOWNUP
};

class ax_mfi_worker
{
 private:
  t_mfiworkmode m_workmode;
  bool          m_use_abs;
  
 public:
  void init(t_mfiworkmode wm,bool use_abs);
  
  bool value(MqlRates& rates[],int shift,t_mfivalue indival);
  
  double get_MA_value(MqlRates& rates[],int begin_shift,int count,double& v);
  
 private:
  t_mfivalue get_bwmfival(MqlRates& rates[],int shift,double& v);
  t_mfivalue get_axmfival(MqlRates& rates[],int shift,double& v);
  t_mfivalue get_axmfi007val(MqlRates& rates[],int shift,double& v);
  t_mfivalue get_axmfi009val(MqlRates& rates[],int shift,double& v);
  
 public:
  double get_axmfi007val_inner(MqlRates& rates[],int shift);
  double get_axmfi009val_inner(MqlRates& rates[],int shift);
  t_mfi007value get_axmfi007_trademode(MqlRates& rates[],int shift);
  
 private:
  t_mfivalue get_val(double mfi,double prev_mfi,long v,long prev_v);
};

//+------------------------------------------------------------------+
void ax_mfi_worker::init(t_mfiworkmode wm,bool use_abs)
{
 this.m_workmode =wm;
 this.m_use_abs  =use_abs;
}

//+------------------------------------------------------------------+
bool ax_mfi_worker::value(MqlRates& rates[],int shift,t_mfivalue indival)
{
 double v=0;
 
 if(this.m_workmode==MFIWORKMODE_MFI)
  return this.get_bwmfival(rates,shift,v)==indival;
  
 if(this.m_workmode==MFIWORKMODE_AXMFI)
  return this.get_axmfival(rates,shift,v)==indival;
  
 if(this.m_workmode==MFIWORKMODE_MFIANDAXMFI)
  return this.get_bwmfival(rates,shift,v)==indival && this.get_axmfival(rates,shift,v)==indival;
  
 if(this.m_workmode==MFIWORKMODE_MFIORAXMFI)
  return this.get_bwmfival(rates,shift,v)==indival || this.get_axmfival(rates,shift,v)==indival;
  
 if(this.m_workmode==MFIWORKMODE_AXMFI007)
  return this.get_axmfi007val(rates,shift,v)==indival;
  
 if(this.m_workmode==MFIWORKMODE_AXMFI009)
  return this.get_axmfi009val(rates,shift,v)==indival;
  
 return false;
}

//+------------------------------------------------------------------+
double ax_mfi_worker::get_MA_value(MqlRates& rates[],int begin_shift,int count,double& v)
{
 if(this.m_workmode==MFIWORKMODE_AXMFI007)
  v=this.get_axmfi007val_inner(rates,begin_shift);
 else
 if(this.m_workmode==MFIWORKMODE_AXMFI009)
  v=this.get_axmfi009val_inner(rates,begin_shift);
 else
  v=0;//not implemented
  
 double sum=0;
 
 int end_shift=begin_shift+count;
 
 for(int i=begin_shift;i<end_shift;i++)
 {
  if(this.m_workmode==MFIWORKMODE_AXMFI007)
   sum+=this.get_axmfi007val_inner(rates,i);
  else
  if(this.m_workmode==MFIWORKMODE_AXMFI009)
   sum+=this.get_axmfi009val_inner(rates,i);
  else
   sum+=0;//not implemented
 }
  
 return sum/count;
}

//+------------------------------------------------------------------+
t_mfivalue ax_mfi_worker::get_bwmfival(MqlRates& rates[],int shift,double& v)
{
 double mfi      =(rates[shift].high-rates[shift].low)/rates[shift].tick_volume/_Point;
 double prev_mfi =(rates[shift+1].high-rates[shift+1].low)/rates[shift+1].tick_volume/_Point;
 
 v=mfi;
 
 return this.get_val(mfi,prev_mfi,rates[shift].tick_volume,rates[shift+1].tick_volume);
}

//+------------------------------------------------------------------+
t_mfivalue ax_mfi_worker::get_axmfival(MqlRates& rates[],int shift,double& v)
{
 double gator       =iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,shift);
 double prev_gator  =iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,shift+1);
 
 double median      =(rates[shift].high+rates[shift].low)/2;
 double prev_median =(rates[shift+1].high+rates[shift+1].low)/2;
 
 double mfi      =MathAbs(median-gator)/rates[shift].tick_volume/_Point;
 double prev_mfi =MathAbs(prev_median-prev_gator)/rates[shift+1].tick_volume/_Point;
 
 v=mfi;
 
 return this.get_val(mfi,prev_mfi,rates[shift].tick_volume,rates[shift+1].tick_volume);
}

//+------------------------------------------------------------------+
t_mfivalue ax_mfi_worker::get_axmfi007val(MqlRates& rates[],int shift,double& v)
{
 double ax007      =this.get_axmfi007val_inner(rates,shift);
 double prev_ax007 =this.get_axmfi007val_inner(rates,shift+1);
 
 v=ax007;
 
 return this.get_val(ax007,prev_ax007,rates[shift].tick_volume,rates[shift+1].tick_volume);
}

//+------------------------------------------------------------------+
t_mfivalue ax_mfi_worker::get_axmfi009val(MqlRates& rates[],int shift,double& v)
{
 double ax009      =this.get_axmfi009val_inner(rates,shift);
 double prev_ax009 =this.get_axmfi009val_inner(rates,shift+1);
 
 v=ax009;
 
 return this.get_val(ax009,prev_ax009,rates[shift].tick_volume,rates[shift+1].tick_volume);
}

//+------------------------------------------------------------------+
double ax_mfi_worker::get_axmfi007val_inner(MqlRates& rates[],int shift)
{
 double jaw=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,/*PRICE_MEDIAN*/PRICE_TYPICAL,MODE_GATORJAW,shift);
 
 double typical_price=(rates[shift].high+rates[shift].low+rates[shift].close)/3;
 
 double to_gator_distance=this.m_use_abs?MathAbs(typical_price-jaw):(typical_price-jaw);
 
 double bw_mfi=rates[shift].tick_volume==0?0:(rates[shift].high-rates[shift].low)/rates[shift].tick_volume;
 
 return bw_mfi==0?0:to_gator_distance/bw_mfi;
}

//+------------------------------------------------------------------+
double ax_mfi_worker::get_axmfi009val_inner(MqlRates& rates[],int shift)
{
 double balance_price=0;
 
 //находим точку баланса
 int balance_i=shift;
 
 for(int i=shift;i<5000;i++)
 {
  double jaw=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,/*PRICE_MEDIAN*/PRICE_TYPICAL,MODE_GATORJAW,i);
  
  if(rates[i].low<=jaw && jaw<=rates[i].high)
  {
   balance_price =jaw;
   balance_i     =i;
   break;
  }
 }//for
 
 double sum=0;
 int cnt=0;
 int sum_cnt=0;
 //собираем сумму отклонений
 for(int i=balance_i;i>=shift;i--)
 {
  double typical_price=(rates[i].high+rates[i].low+rates[i].close)/3;
 
  //double jaw=ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,i);
  double jaw=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,/*PRICE_MEDIAN*/PRICE_TYPICAL,MODE_GATORJAW,i);
  
  double to_balance_distance=/*MathAbs*/(typical_price-/*balance_price*/jaw);
 
  double bw_mfi=(rates[i].high-rates[i].low)/rates[i].tick_volume;
 
  //sum+=(bw_mfi==0)?0:to_balance_distance/bw_mfi;
  
  cnt++;
  
  sum+=(bw_mfi==0)?0:(to_balance_distance/bw_mfi)*cnt;
  
  sum_cnt+=cnt;
 }
 
 return sum_cnt==0?0:sum/sum_cnt;
}

//+------------------------------------------------------------------+
t_mfi007value ax_mfi_worker::get_axmfi007_trademode(MqlRates& rates[],int shift)
{
 double tp_1=ax_bar_utils::get_typical_price(rates[shift]);
 double tp_2=ax_bar_utils::get_typical_price(rates[shift+1]);
 //double tp_3=ax_bar_utils::get_typical_price(rates[shift+2]);
 /*
 double mfi_1=g_mfi_worker.get_axmfi009val_inner(rates,shift);
 double mfi_2=g_mfi_worker.get_axmfi009val_inner(rates,shift+1);
 double mfi_3=g_mfi_worker.get_axmfi009val_inner(rates,shift+3);
 */
 double mfi_1=this.get_axmfi007val_inner(rates,shift);
 double mfi_2=this.get_axmfi007val_inner(rates,shift+1);
 double mfi_3=g_mfi_worker.get_axmfi007val_inner(rates,shift+2);
 
 //определяем формации "перелома" тренда - это вершины на i007
 if((mfi_3<mfi_2 && mfi_2>mfi_1)/*||(mfi_3>mfi_2 && mfi_2<mfi_1)*/)
 {
  //направление определяем по двум последним ценам
  if(tp_2<tp_1)
   return MFI007VALUE_UP;
   
  if(tp_2>tp_1)
   return MFI007VALUE_DOWN;
 }
 
 return MFI007VALUE_NONE;
#ifdef 0
 if(tp_3<tp_2 && tp_2<tp_1)//цена возрастает
 {
   //if(/*mfi_3<mfi_2 && */mfi_2<mfi_1)//i007 растет - тренд остается прежним
    return MFI007VALUE_UP;
   //else
   // return MFI007VALUE_UPDOWN;
 }
 else
 if(tp_3>tp_2 && tp_2>tp_1)//цена падает
 {
  //if(/*mfi_3<mfi_2 && */mfi_2<mfi_1)//i007 растет - тренд остается прежним
   return MFI007VALUE_DOWN;
  //else
  // return MFI007VALUE_DOWNUP;
 }
 
 return MFI007VALUE_NONE;
#endif
}

//+------------------------------------------------------------------+
t_mfivalue ax_mfi_worker::get_val(double mfi,double prev_mfi,long v,long prev_v)
{
 if(mfi>prev_mfi && v>prev_v)
  return MFIVALUE_GREEN;
  
 if(mfi<prev_mfi && v>prev_v)
  return MFIVALUE_PINK;
  
 if(mfi>prev_mfi && v<prev_v)
  return MFIVALUE_BLUE;
  
 return MFIVALUE_BROWN;
}

//+------------------------------------------------------------------+
