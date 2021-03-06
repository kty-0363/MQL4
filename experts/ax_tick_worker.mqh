//+------------------------------------------------------------------+
//|                                               ax_tick_worker.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+
enum t_tickbar
{
 TICKBAR_NONE,
 TICKBAR_UP,
 TICKBAR_DOWN,
 TICKBAR_NEUTRAL
};

enum t_tickbarpair
{
 TICKBARPAIR_NONE, 
 TICKBARPAIR_NONENEUTRAL, //для SINGLEMODE
 TICKBARPAIR_NONEUP,      //для SINGLEMODE
 TICKBARPAIR_NONEDOWN,    //для SINGLEMODE
 TICKBARPAIR_DOWNUP,
 TICKBARPAIR_DOWNDOWN,
 TICKBARPAIR_UPDOWN,
 TICKBARPAIR_UPUP,
 TICKBARPAIR_NEUTRALUP,
 TICKBARPAIR_NEUTRALDOWN,
 TICKBARPAIR_UPNEUTRAL,
 TICKBARPAIR_DOWNNEUTRAL
};

enum t_tickworkmode
{
 TICKWORKMODE_SINGLE,
 TICKWORKMODE_PAIR
};

enum t_tickworkglobalmode
{
 TICKWORKGLOBALMODE_CUSTOM,        //разворотный бар (custom)
 TICKWORKGLOBALMODE_CUSTOMSIMPLE,  //разворотный бар (custom упрощенный вариант)
 TICKWORKGLOBALMODE_BW,            //разворотный бар по Б.Вильямсу
 TICKWORKGLOBALMODE_BWCUSTOM       //разворотный бар (custom) или по Б.Вильямсу
};

class ax_tick_worker
{
 private:
  int                  m_period;
  bool                 m_bar_switched;
  double               m_prev_tick;
  double               m_sum_up;
  double               m_sum_down;
  int                  m_tick_count_up;
  int                  m_tick_count_down;
  double               m_sum_up_tmp;
  double               m_sum_down_tmp;
  int                  m_tick_count_up_tmp;
  int                  m_tick_count_down_tmp;
  int                  m_weight_idx;
  MqlRates             m_ready_bar;
  double               m_min_level;
  double               m_max_level;  
  t_tickbar            m_prev_tickbar;
  t_tickbar            m_cur_tickbar;
  t_tickworkglobalmode m_globalmode;
  
 public:
  void          init(t_tickworkglobalmode globalmode,int period,double min_level,double max_level);
  t_tickbarpair get_tickbarpair(t_tickworkmode twm);
  t_tickbarpair get_tickbarpair(t_tickworkmode twm,double& sum_up,double& sum_down);
  
 private:
  void   process_tick(bool& retval);  
  double sum_up();
  double sum_down();
  int    tick_up();
  int    tick_down();
  
  bool   is_bull_bar();
  bool   is_bear_bar();
  bool   is_neutral_bar();
};//ax_tick_worker

//+------------------------------------------------------------------+
void ax_tick_worker::init(t_tickworkglobalmode globalmode,int period,double min_level,double max_level)
{
 this.m_globalmode          =globalmode;
 this.m_period              =period;
 this.m_bar_switched        =false;
 this.m_prev_tick           =DBL_MIN;
 this.m_sum_up              =0;
 this.m_sum_down            =0;
 this.m_tick_count_up       =0;
 this.m_tick_count_down     =0;
 this.m_sum_up_tmp          =0;
 this.m_sum_down_tmp        =0;
 this.m_tick_count_up_tmp   =0;
 this.m_tick_count_down_tmp =0;
 this.m_weight_idx          =0;
 this.m_min_level           =min_level;
 this.m_max_level           =max_level;
 this.m_prev_tickbar        =TICKBAR_NONE;
 this.m_cur_tickbar         =TICKBAR_NONE;
 
 MqlRates rates[];
 ArrayCopyRates(rates,NULL,period);

 this.m_ready_bar=rates[1]; 
}

//+------------------------------------------------------------------+
t_tickbarpair ax_tick_worker::get_tickbarpair(t_tickworkmode twm)
{
 double sum_up;
 double sum_down;
 
 return this.get_tickbarpair(twm,sum_up,sum_down);
}//get_tickbarpair

//+------------------------------------------------------------------+
t_tickbarpair ax_tick_worker::get_tickbarpair(t_tickworkmode twm,double& sum_up,double& sum_down)
{
 sum_up   =INT_MIN;
 sum_down =INT_MIN;
 
 bool data_ready;
 ax_tick_worker::process_tick(data_ready);
 
 if(data_ready)
 {
  sum_up   =this.sum_up();
  sum_down =this.sum_down();
  
  if(twm==TICKWORKMODE_SINGLE)
  {
   if(this.m_cur_tickbar==TICKBAR_NEUTRAL)
    return TICKBARPAIR_NONENEUTRAL;
    
   if(this.m_cur_tickbar==TICKBAR_UP)
    return TICKBARPAIR_NONEUP;
    
   if(this.m_cur_tickbar==TICKBAR_DOWN)
    return TICKBARPAIR_NONEDOWN;
  }
  
  if(twm==TICKWORKMODE_PAIR)
  {
   if(this.m_prev_tickbar==TICKBAR_NEUTRAL && this.m_cur_tickbar==TICKBAR_UP)
    return TICKBARPAIR_NEUTRALUP;
   else
   if(this.m_prev_tickbar==TICKBAR_NEUTRAL && this.m_cur_tickbar==TICKBAR_DOWN)
    return TICKBARPAIR_NEUTRALDOWN;
   else
   if(this.m_prev_tickbar==TICKBAR_DOWN && this.m_cur_tickbar==TICKBAR_UP)
    return TICKBARPAIR_DOWNUP;
   else
   if(this.m_prev_tickbar==TICKBAR_DOWN && this.m_cur_tickbar==TICKBAR_NEUTRAL)
    return TICKBARPAIR_DOWNNEUTRAL;
   else
   if(this.m_prev_tickbar==TICKBAR_DOWN && this.m_cur_tickbar==TICKBAR_DOWN)
    return TICKBARPAIR_DOWNDOWN;
   else
   if(this.m_prev_tickbar==TICKBAR_UP && this.m_cur_tickbar==TICKBAR_DOWN)
    return TICKBARPAIR_UPDOWN;
   else
   if(this.m_prev_tickbar==TICKBAR_UP && this.m_cur_tickbar==TICKBAR_NEUTRAL)
    return TICKBARPAIR_UPNEUTRAL;
   else
   if(this.m_prev_tickbar==TICKBAR_UP && this.m_cur_tickbar==TICKBAR_UP)
    return TICKBARPAIR_UPUP;
  }
 }//if data ready
 
 return TICKBARPAIR_NONE;
}//get_tickbarpair

//+------------------------------------------------------------------+
void ax_tick_worker::process_tick(bool& retval)
{
 retval=false;
 
 MqlRates rates[];
 ArrayCopyRates(rates,NULL,this.m_period);
 
 if(this.m_bar_switched)
 {
  if(rates[0].close>this.m_prev_tick)
  {
   this.m_sum_up        +=((++this.m_weight_idx)*(rates[0].close-this.m_prev_tick));
   this.m_tick_count_up ++;
   this.m_prev_tick     =rates[0].close;
  }
  else
  if(rates[0].close<this.m_prev_tick)
  {
   this.m_sum_down        +=((++this.m_weight_idx)*(this.m_prev_tick-rates[0].close));
   this.m_tick_count_down ++;
   this.m_prev_tick       =rates[0].close;
  }
 }//switched
 
 if(this.m_ready_bar.time!=rates[1].time)//подошел следующий бар
 {
  this.m_ready_bar=rates[1];
  
  if(this.m_bar_switched)
  {
   this.m_sum_up_tmp          =this.m_sum_up;
   this.m_sum_down_tmp        =this.m_sum_down;
   this.m_tick_count_up_tmp   =this.m_tick_count_up;
   this.m_tick_count_down_tmp =this.m_tick_count_down;
   
   this.m_sum_up          =0;
   this.m_sum_down        =0;
   this.m_tick_count_up   =0;
   this.m_tick_count_down =0;
   this.m_weight_idx      =0;
   
   this.m_prev_tickbar=this.m_cur_tickbar;
   
   if(this.is_bull_bar())
    this.m_cur_tickbar=TICKBAR_UP;
   else
   if(this.is_bear_bar())
    this.m_cur_tickbar=TICKBAR_DOWN;
   else
   if(this.is_neutral_bar())
    this.m_cur_tickbar=TICKBAR_NEUTRAL;
   else
    this.m_cur_tickbar=TICKBAR_NONE;
   
   retval                 =true;
  }

  this.m_prev_tick=rates[0].close;
  
  this.m_bar_switched=true;
 }//подошел следующий бар
}//process_tick

//+------------------------------------------------------------------+
double ax_tick_worker::sum_up()
{
 return this.m_sum_up_tmp;
}

//+------------------------------------------------------------------+
double ax_tick_worker::sum_down()
{
 return this.m_sum_down_tmp;
}

//+------------------------------------------------------------------+
int ax_tick_worker::tick_up()
{
 return this.m_tick_count_up_tmp;
}

//+------------------------------------------------------------------+
int ax_tick_worker::tick_down()
{
 return this.m_tick_count_down_tmp;
}

//+------------------------------------------------------------------+
bool ax_tick_worker::is_bull_bar()
{
 if(this.m_globalmode==TICKWORKGLOBALMODE_CUSTOM)
  return (this.sum_up()/(this.sum_down()==0?DBL_MIN:this.sum_down()))>this.m_max_level;
 
 if(this.m_globalmode==TICKWORKGLOBALMODE_CUSTOMSIMPLE) 
  return this.sum_up()>this.sum_down();
 
 if(this.m_globalmode==TICKWORKGLOBALMODE_BW)
  return this.m_ready_bar.close>NormalizeDouble((this.m_ready_bar.high-this.m_ready_bar.low)/2+this.m_ready_bar.low,Digits);
 
 //TICKWORKGLOBALMODE_BWCUSTOM
 return (this.sum_up()/(this.sum_down()==0?DBL_MIN:this.sum_down()))>this.m_max_level ||
         this.sum_up()>this.sum_down() ||
         this.m_ready_bar.close>NormalizeDouble((this.m_ready_bar.high-this.m_ready_bar.low)/2+this.m_ready_bar.low,Digits);
}

//+------------------------------------------------------------------+
bool ax_tick_worker::is_bear_bar()
{
 if(this.m_globalmode==TICKWORKGLOBALMODE_CUSTOM)
  return (this.sum_up()/(this.sum_down()==0?DBL_MIN:this.sum_down()))<this.m_min_level;

 if(this.m_globalmode==TICKWORKGLOBALMODE_CUSTOMSIMPLE) 
  return this.sum_up()<this.sum_down();
  
 if(this.m_globalmode==TICKWORKGLOBALMODE_BW)
  return this.m_ready_bar.close<NormalizeDouble((this.m_ready_bar.high-this.m_ready_bar.low)/2+this.m_ready_bar.low,Digits);
  
 //TICKWORKGLOBALMODE_BWCUSTOM
 return (this.sum_up()/(this.sum_down()==0?DBL_MIN:this.sum_down()))<this.m_min_level ||
         this.sum_up()<this.sum_down() ||
         this.m_ready_bar.close<NormalizeDouble((this.m_ready_bar.high-this.m_ready_bar.low)/2+this.m_ready_bar.low,Digits);
}

//+------------------------------------------------------------------+
bool ax_tick_worker::is_neutral_bar()
{
 return !(this.is_bull_bar() || this.is_bear_bar());
}

//+------------------------------------------------------------------+
