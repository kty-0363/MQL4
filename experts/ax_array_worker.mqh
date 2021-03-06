//+------------------------------------------------------------------+
//|                                              ax_array_worker.mqh |
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
//+------------------------------------------------------------------+
#define __ARRAY_SIZE 200

struct order_data
{
 string symbol;
 int    period;
 int    ticket;
 double sl;
 double tp;
 string comment;
 int    bar_count;
 bool   lot2_set;
};

class ax_array_worker
{
 private:
  order_data m_array[__ARRAY_SIZE];
  int m_count;
  
  order_data m_tmp_order_data;
  
 public:
  ax_array_worker();
 ~ax_array_worker();

  int count();
  
  bool order_exists(string symbol,int period,int ticket);
 
  void add(string symbol,int period,int ticket,double sl,double tp,string comment,bool lot2_set);
  void add(const order_data& order);
  
  int    get_ticket(int i);
  double get_sl(string symbol,int period,int ticket);
  double get_tp(string symbol,int period,int ticket);
  string get_comment(string symbol,int period,int ticket);
  int    get_bars_count(string symbol,int period,int ticket);
  bool   get_lot2_set(string symbol,int period,int ticket);
  
  void set_sl(string symbol,int period,int ticket,double value);
  void set_tp(string symbol,int period,int ticket,double value);
  void set_comment(string symbol,int period,int ticket,string value);
  void inc_bars_count(string symbol,int period,int ticket);
  void set_lot2_set(string symbol,int period,int ticket,bool value);
  
  void sweep(string symbol,int period);
  
  string print(string symbol,int period);
  
 private:  
  void reset_tmp();
  void fill_tmp(string symbol,int period,int ticket);
};

//--------------------------------------------------------------------
ax_array_worker::ax_array_worker()
{
 this.m_count=0;
}

//--------------------------------------------------------------------
ax_array_worker::~ax_array_worker()
{
 this.m_count=0;
}

//--------------------------------------------------------------------
int ax_array_worker::count()
{
 return this.m_count;
}

//--------------------------------------------------------------------
bool ax_array_worker::order_exists(string symbol,int period,int ticket)
{
 //проверяем наличие
 for(int i=0;i!=this.m_count;i++)
 {
  if(this.m_array[i].symbol==symbol && this.m_array[i].period==period && this.m_array[i].ticket==ticket)
   return true;
 }
 
 return false;
}

//--------------------------------------------------------------------
void ax_array_worker::add(string symbol,int period,int ticket,double sl,double tp,string comment,bool lot2_set)
{
 //перед добавлением приводим в актуальное состояние
 this.sweep(symbol,period);
 
 //проверяем наличие
 if(this.order_exists(symbol,period,ticket))
  return;
 
 //добавляем
 this.m_array[this.m_count].symbol    =symbol;
 this.m_array[this.m_count].period    =period;
 this.m_array[this.m_count].ticket    =ticket;
 this.m_array[this.m_count].sl        =sl;
 this.m_array[this.m_count].tp        =tp;
 this.m_array[this.m_count].comment   =comment;
 this.m_array[this.m_count].bar_count =0;
 this.m_array[this.m_count].lot2_set  =lot2_set;
 
 this.m_count++;
}

//--------------------------------------------------------------------
void ax_array_worker::add(const order_data& order)
{
 this.add(order.symbol,order.period,order.ticket,order.sl,order.tp,order.comment,order.lot2_set);
}

//--------------------------------------------------------------------
int ax_array_worker::get_ticket(int i)
{
 return i<this.m_count?this.m_array[i].ticket:-1;
}

//--------------------------------------------------------------------
double ax_array_worker::get_sl(string symbol,int period,int ticket)
{
 this.fill_tmp(symbol,period,ticket);
 return this.m_tmp_order_data.sl;
}

//--------------------------------------------------------------------
double ax_array_worker::get_tp(string symbol,int period,int ticket)
{
 this.fill_tmp(symbol,period,ticket);
 return this.m_tmp_order_data.tp;
}

//--------------------------------------------------------------------
string ax_array_worker::get_comment(string symbol,int period,int ticket)
{
 this.fill_tmp(symbol,period,ticket);
 return this.m_tmp_order_data.comment;
}

//--------------------------------------------------------------------
int ax_array_worker::get_bars_count(string symbol,int period,int ticket)
{
 this.fill_tmp(symbol,period,ticket);
 return this.m_tmp_order_data.bar_count;
}

//--------------------------------------------------------------------
bool ax_array_worker::get_lot2_set(string symbol,int period,int ticket)
{
 this.fill_tmp(symbol,period,ticket);
 return this.m_tmp_order_data.lot2_set;
}

//--------------------------------------------------------------------
void ax_array_worker::set_sl(string symbol,int period,int ticket,double value)
{
 for(int i=0;i!=this.m_count;i++)
 {
  if(this.m_array[i].symbol==symbol && this.m_array[i].period==period && this.m_array[i].ticket==ticket)
  {
   this.m_array[i].sl=value;
   return;
  }
 }
}

//--------------------------------------------------------------------
void ax_array_worker::set_tp(string symbol,int period,int ticket,double value)
{
 for(int i=0;i!=this.m_count;i++)
 {
  if(this.m_array[i].symbol==symbol && this.m_array[i].period==period && this.m_array[i].ticket==ticket)
  {
   this.m_array[i].tp=value;
   return;
  }
 }
}

//--------------------------------------------------------------------
void ax_array_worker::set_comment(string symbol,int period,int ticket,string value)
{
 for(int i=0;i!=this.m_count;i++)
 {
  if(this.m_array[i].symbol==symbol && this.m_array[i].period==period && this.m_array[i].ticket==ticket)
  {
   this.m_array[i].comment=value;
   return;
  }
 }
}

//--------------------------------------------------------------------
void ax_array_worker::inc_bars_count(string symbol,int period,int ticket)
{
 for(int i=0;i!=this.m_count;i++)
 {
  if(this.m_array[i].symbol==symbol && this.m_array[i].period==period && this.m_array[i].ticket==ticket)
  {
   this.m_array[i].bar_count++;
   return;
  }
 }
}

//--------------------------------------------------------------------
void ax_array_worker::set_lot2_set(string symbol,int period,int ticket,bool value)
{
 for(int i=0;i!=this.m_count;i++)
 {
  if(this.m_array[i].symbol==symbol && this.m_array[i].period==period && this.m_array[i].ticket==ticket)
  {
   this.m_array[i].lot2_set=value;
   return;
  }
 }
}

//--------------------------------------------------------------------
void ax_array_worker::sweep(string symbol,int period)
{
 order_data tmp_array[__ARRAY_SIZE];

 int count_actual=0;
 
 for(int i=0;i!=this.m_count;i++)
 {
  if(this.m_array[i].symbol==symbol && this.m_array[i].period==period)
  {
   //если ордер еще живой, копируем его во временный массив
   if(OrderSelect(this.m_array[i].ticket,SELECT_BY_TICKET) && OrderCloseTime()==0)
   {
    tmp_array[count_actual].symbol    =this.m_array[i].symbol;
    tmp_array[count_actual].period    =this.m_array[i].period;
    tmp_array[count_actual].ticket    =this.m_array[i].ticket;
    tmp_array[count_actual].sl        =this.m_array[i].sl;
    tmp_array[count_actual].tp        =this.m_array[i].tp;
    tmp_array[count_actual].comment   =this.m_array[i].comment;
    tmp_array[count_actual].bar_count =this.m_array[i].bar_count;
    tmp_array[count_actual].lot2_set  =this.m_array[i].lot2_set;
    count_actual++;
   }
  }
 }
 
 //перетаскиваем из временного в постоянный
 for(int i=0;i!=count_actual;i++)
 {
  this.m_array[i].symbol    =tmp_array[i].symbol;
  this.m_array[i].period    =tmp_array[i].period;
  this.m_array[i].ticket    =tmp_array[i].ticket;
  this.m_array[i].sl        =tmp_array[i].sl;
  this.m_array[i].tp        =tmp_array[i].tp;
  this.m_array[i].comment   =tmp_array[i].comment;
  this.m_array[i].bar_count =tmp_array[i].bar_count;
  this.m_array[i].lot2_set  =tmp_array[i].lot2_set;
 }
 
 //остатки в m_array затирать смысла нет
 this.m_count=count_actual;
}

//--------------------------------------------------------------------
string ax_array_worker::print(string symbol,int period)
{
 string tmp="";
 
 for(int i=0;i!=this.m_count;i++)
 {
  if(this.m_array[i].symbol==symbol && this.m_array[i].period==period)
  {
   if(tmp!="")
    tmp+="\n";
   
   tmp+="TICKET="+IntegerToString(this.m_array[i].ticket)+" SL="+DoubleToString(this.m_array[i].sl)+" TP="+DoubleToString(this.m_array[i].tp);
  }
 }
 
 return tmp;
}

//--------------------------------------------------------------------
void ax_array_worker::reset_tmp()
{
 this.m_tmp_order_data.symbol    ="";
 this.m_tmp_order_data.period    =-1;
 this.m_tmp_order_data.ticket    =-1;
 this.m_tmp_order_data.sl        =-1;
 this.m_tmp_order_data.tp        =-1;
 this.m_tmp_order_data.comment   ="";
 this.m_tmp_order_data.bar_count =0;
 this.m_tmp_order_data.lot2_set  =false;
}

//--------------------------------------------------------------------
void ax_array_worker::fill_tmp(string symbol,int period,int ticket)
{
 this.reset_tmp();
 
 for(int i=0;i!=this.m_count;i++)
 {
  if(this.m_array[i].symbol==symbol && this.m_array[i].period==period && this.m_array[i].ticket==ticket)
  {
   this.m_tmp_order_data.symbol    =symbol;
   this.m_tmp_order_data.period    =period;
   this.m_tmp_order_data.ticket    =ticket;
   this.m_tmp_order_data.sl        =this.m_array[i].sl;
   this.m_tmp_order_data.tp        =this.m_array[i].tp;
   this.m_tmp_order_data.comment   =this.m_array[i].comment;
   this.m_tmp_order_data.bar_count =this.m_array[i].bar_count;
   this.m_tmp_order_data.lot2_set  =this.m_array[i].lot2_set;
  }
 }
}

//--------------------------------------------------------------------
