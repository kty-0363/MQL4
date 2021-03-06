//+------------------------------------------------------------------+
//|                                                  ax_bar_type.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include "ax_point_worker.mqh"
#include "ax_array_worker.mqh"

//+------------------------------------------------------------------+
enum bar_types
{
 BARTYPE_NONE,
 BARTYPE_BEARISH,
 BARTYPE_BULLISH
};//struct bar_types

enum bar_close_type
{
 BARCLOSETYPE_HIGH,
 BARCLOSETYPE_MIDDLE,
 BARCLOSETYPE_LOW
};

enum ao_trend_mode
{
 AOTREND_UP,
 AOTREND_DOWN,
 AOTREND_HOR
};

enum trade_mode
{
 TRADEMODE_NONE,
 TRADEMODE_BUY,
 TRADEMODE_SELL
};

enum bar_reversal_type
{
 BARREVERSAL_NONE,
 BARREVERSAL_BULLISH,
 BARREVERSAL_BEARISH
};

enum ac_mode
{
 ACMODE_NONE,
 ACMODE_GREEN2,
 ACMODE_GREEN3,
 ACMODE_RED2,
 ACMODE_RED3,
 ACMODE_GREEN,
 ACMODE_RED,
 ACMODE_REDGREEN_NEGATIVE,
 ACMODE_GREENRED_POSITIVE
};

enum ac_sign_mode
{
 ACSIGNMODE_ZERO,
 ACSIGNMODE_POSITIVE,
 ACSIGNMODE_NEGATIVE
};

enum bar_position
{
 BARPOSITION_NONE,
 BARPOSITION_UNDERGATOR,
 BARPOSITION_ABOVEGATOR
};

enum bar_position_mode
{
 BARPOSITIONMODE_FULL,
 BARPOSITIONMODE_MEDIUM,
 BARPOSITIONMODE_MEDIUM3,
 BARPOSITIONMODE_MEDIUM2,
 BARPOSITIONMODE_PART,
 BARPOSITIONMODE_PART3,
 BARPOSITIONMODE_PART2
};

enum fibo_levels
{
//0.382;//0.236 0.382 0.500 0.618 0.764
 FIBO_100  =0,
 FIBO_764  =1,
 FIBO_618  =2,
 FIBO_500  =3,
 FIBO_382  =4,
 FIBO_236  =5
};

enum gator_mode
{
 GATORMODE_NONE,
 GATORMODE_NORMAL,
 GATORMODE_REVERSAL
};

enum rsi_mode
{
 RSIMODE_NONE,
 RSIMODE_UPPER,
 RSIMODE_MIDDLE_UPPER,
 RSIMODE_UPPER_MIDDLE,
 RSIMODE_LOWER,
 RSIMODE_MIDDLE_LOWER,
 RSIMODE_LOWER_MIDDLE
};

enum sl_mode
{
 SLMODE_NONE,
 SLMODE_CROSSGATOR_DOWNUP,
 SLMODE_CROSSGATOR_UPDOWN,
 SLMODE_LOCALEXT_MIN_ABOVEGATOR,
 SLMODE_LOCALEXT_MIN_UNDERGATOR,
 SLMODE_LOCALEXT_MAX_ABOVEGATOR,
 SLMODE_LOCALEXT_MAX_UNDERGATOR
};

enum adv_trade_mode
{
 ADVTRADEMODE_BUY,//BUY
 ADVTRADEMODE_SELL,//SELL
 ADVTRADEMODE_BOTH//BUY+SELL
};

enum macd_trade_mode
{
 MACDTRADEMODE_NONE,
 MACDTRADEMODE_BUY,
 MACDTRADEMODE_SELL
};

enum ma_trade_mode
{
 MATRADEMODE_NONE,
 MATRADEMODE_BUY,
 MATRADEMODE_SELL
};

enum ichimoku_cross_mode
{
 ICHIMOKUCROSSMODE_NONE,
 ICHIMOKUCROSSMODE_DOWNUP,
 ICHIMOKUCROSSMODE_UPDOWN
};

enum trix_cross_mode
{
 TRIXCROSSMODE_NONE,
 TRIXCROSSMODE_BUY,
 TRIXCROSSMODE_SELL
};

enum trix_color_change_mode
{
 TRIXCOLORCHANGEMODE_NONE,
 TRIXCOLORCHANGEMODE_REDTOGREEN,
 TRIXCOLORCHANGEMODE_GREENTORED,
};

enum trix_arrow_type
{
 TRIXARROWTYPE_NONE,
 TRIXARROWTYPE_UP,
 TRIXARROWTYPE_DOWN
};

enum order_sl_type
{
 ORDERSLTYPE_SINGLEBAR,
 ORDERSLTYPE_MINMAXBACKWARD,
 ORDERSLTYPE_LOCALEXTREMUM,
 ORDERSLTYPE_ATR,
 ORDERSLTYPE_VALUE
};

enum gator_formation
{
 GATORFORMATION_NONE,
 GATORFORMATION_CONVERGENCE,//схождение
 GATORFORMATION_DIVERGENCE,//расхождение
 GATORFORMATION_DIVERGENCEUP,//расхождение вверх
 GATORFORMATION_DIVERGENCEDOWN//расхождение вниз
};

enum gator_trans_formation
{
 GATORTRANSFORMATION_NONE,
 GATORTRANSFORMATION_CONVERGENCE_DIVERGENCEUP,//переход из флета на BULL
 GATORTRANSFORMATION_CONVERGENCE_DIVERGENCEDOWN,//переход из флета на BEAR
 GATORTRANSFORMATION_DIVERGENCEUP_CONVERGENCE,//переход с BULL во флет
 GATORTRANSFORMATION_DIVERGENCEDOWN_CONVERGENCE//переход с BEAR во флет
};

enum gator_formation_trend
{
 GATORFORMATIONTREND_NONE,
 GATORFORMATIONTREND_UP,
 GATORFORMATIONTREND_DOWN
};

enum order_level
{
 ORDERLEVEL_STOPLOSS,
 ORDERLEVEL_TAKEPROFIT
};

enum distance_t
{
 DISTANCE_GATORINVERTING,
 DISTANCE_LOCALEXTREMUM
};

enum gator_bar_cross_t
{
 GATORBARCROSS_NONE,
 GATORBARCROSS_JAWNONE,
 GATORBARCROSS_JAWBULL,
 GATORBARCROSS_JAWBEAR,
 GATORBARCROSS_LIPSTEETH
};

enum t_mfivalue
{
 MFIVALUE_NONE,
 MFIVALUE_GREEN,
 MFIVALUE_PINK,
 MFIVALUE_BLUE,
 MFIVALUE_BROWN
};

//-------------------------------------------------------
struct ax_order_settings
{
 const double      lot;
 const double      lot2;
 const int         slippage;
 string            comment;
 const int         expire_bar_count;
 double            profit_coef;
 const fibo_levels fibo;
 const int         try_count;
 double            profit;
 double            loss;
 
 ax_order_settings(double _lot,double _lot2,int _slippage,string _comment,int _expire_bar_count,double _profit_coef,fibo_levels _fibo,int _try_count):
  lot(_lot),
  lot2(_lot2),
  slippage(_slippage),
  comment(_comment),
  expire_bar_count(_expire_bar_count),
  profit_coef(_profit_coef),
  fibo(_fibo),
  try_count(_try_count),
  profit(0),
  loss(0) 
 {
 }
 
 ax_order_settings(double _lot,double _lot2,int _slippage,string _comment,int _expire_bar_count,double _profit_coef,fibo_levels _fibo,int _try_count,double _profit,double _loss):
  lot(_lot),
  lot2(_lot2),
  slippage(_slippage),
  comment(_comment),
  expire_bar_count(_expire_bar_count),
  profit_coef(_profit_coef),
  fibo(_fibo),
  try_count(_try_count),
  profit(_profit),
  loss(_loss)
 {
 }
};

//-------------------------------------------------------
struct ax_settings
{
 int                ma_period;        // период 
 int                ma_shift;         // сдвиг средней 
 ENUM_MA_METHOD     ma_method;        // метод усреднения 
 ENUM_APPLIED_PRICE ma_applied_price; // тип цены 
 int                atr_period;       //период индикатора ATR
 
 int                jaw_period;        // период для расчета челюстей 
 int                jaw_shift;         // смещение челюстей по горизонтали 
 int                teeth_period;      // период для расчета зубов 
 int                teeth_shift;       // смещение зубов по горизонтали 
 int                lips_period;       // период для расчета губ 
 int                lips_shift;        // смещение губ по горизонтали 
 
 double             sar_step;
 double             sar_max;
 
 int                dem_period;
 double             dem_upper_level;
 double             dem_lower_level;
 
 int                magic_distance;
 
 double             stoplevel;
 double             spread;
 double             trailing_stop;
 
 int                try_count;
 
 int                loss_profit_bars_wait_cnt;//сколько баров ждать, чтобы закрыть убыточный ордер
};

//-------------------------------------------------------
class ax_bar_utils
{
 public:
  ax_bar_utils();
 ~ax_bar_utils();
 
  static void do_settings(ax_settings& stgs);
 
  static int DrawArrow(int CodeArrow,color ColorArrow,int i,int TypeArrow);  

  static int DrawArrow2(int CodeArrow,color ColorArrow,int i,int TypeArrow);  
 
  static bar_types get_type(MqlRates& ready_bar, MqlRates& prev_bar);
                    
  static bar_types get_type2(MqlRates& ready_bar);
  
  static bar_types get_type3(MqlRates& rates[],bar_position_mode bpm);
  
  static bar_types get_type4(MqlRates& rates[]);
  
  static bar_types get_type5(MqlRates& rates[],int shift);
  
  static bar_types get_type6(MqlRates& rates[],int shift);
  
  static bar_types get_type_via_ac(MqlRates& rates[],bar_position_mode bpm,MqlRates& out_bar);
  
  static bar_types get_type_via_gator(MqlRates& rates[],bar_position bp,int shift);
  
  static bar_close_type get_bar_close_type(MqlRates& bar);
  
  static double get_avg_value(MqlRates& bar);
  
  static double get_typical_price(MqlRates& bar);
  
  static bool is_price_in_range(MqlRates& bar, double price);
  
  static bool is_out_of_gator(MqlRates& bar);
  
  static bool is_out_of_gator(MqlRates& bar, bar_types bt);
  
  static bool is_out_of_gator(ax_settings& stgs,MqlRates& rates[],int shift);

  static bool is_in_gator(MqlRates& bar,int shift);
  
  static bool get_bar_gator_position(MqlRates& rates[],bar_position bp,bar_position_mode bpm,int shift,int ma_method=MODE_SMMA);
  
  static bool get_bar_gator_position(MqlRates& bar,bar_position bp,bar_position_mode bpm,int shift,int ma_method=MODE_SMMA);
  
  static bool get_bar_gator_position2(MqlRates& rates[],bar_position bp,bar_position_mode bpm,int shift);
  
  static bar_position get_bar_gator_position3(MqlRates& rates[],int shift,bool check_minstoplevel);
  
  static bool get_bar_gator_position4(trade_mode tm,MqlRates& rates[],int bar_shift,int back_bar_shift);
  
  static bar_position get_bar_gator_position5(MqlRates& rates[],int shift); 
  
  static bool bar_doesnt_cross_gator_jaw(MqlRates& rates[],bar_position bp,int shift,int ma_method=MODE_SMMA);
  
  static bool special_bar_gator_position(ax_settings& stgs,MqlRates& rates[],int shift);
  
  static bool trend_rates(MqlRates& rates[],int shift);
  
  static double get_min(double v1,double v2,double v3);
  
  static double get_max(double v1,double v2,double v3);
  
  static bool is_equal(MqlRates& b1,MqlRates& b2);
  
  static int OpenOrder(MqlRates& b,bar_types bt,string& err_msg,datetime _exp=0);
  
  static int OpenOrder(MqlRates& b,trade_mode tm,string& err_msg,datetime _exp=0);
  
  static int OpenOrder2(MqlRates& b,trade_mode tm,string& err_msg,int _exp,double lot,string comment);
  
  static int OpenOrder3(MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,string& err_msg);

  static int OpenOrder3(MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,string& err_msg,order_data& order);
  
  static int OpenOrder3_StopLevel(ax_settings& stgs,MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,string& err_msg,order_data& order);
  
  static int OpenOrder4(trade_mode tm,ax_order_settings& order_set,double magic_value,string& err_msg);
  
  static int OpenOrder5(ax_settings& stgs,MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,string& err_msg,order_data& order,double tp_multiple=1);
  
  static int OpenOrderReverse(MqlRates& b,trade_mode tm,double lot,int slippage,string comment,int exp_bar_count,double profit_coef,string& err_msg);
  //static int OpenOrderReverse(double price,double sl,double tp,trade_mode tm,double lot,int slippage,string comment,int exp_bar_count,double profit_coef,string& err_msg);
  
  static int OpenOrder3_CloseOpenImmediate(MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,int close_ticket,string& err_msg,order_data& order);
  
  static int CloseAllOrders();
  
  static int CloseAllOrders(int op_type,int slippage);
  
  static int CloseAllOrders(int op_type,string comment,int slippage);
  
  static int CloseAllOrdersSAR();
  
  static int CloseAllOrdersSAR2(int slippage);
  
  static int CloseAllOrdersByProfit(int op_type,double profit,double loss,int slippage);
  
  static int CloseOrderByBarsAndProfit();
  
  static bool CloseOrder(ax_order_settings& stgs,int ticket,string& err_msg);
  
  static bool SetOrderSL(int ticket,MqlRates& b,ao_trend_mode ao_mode,datetime _exp=0);
  
  static bool SetOrderSL(int ticket,MqlRates& b,string& err_msg,datetime _exp=0);
  
  static bool SetOrderSLPipser(ax_settings& stgs,int ticket,string& err_msg);

  static bool SetOrderSLTP(int ticket,MqlRates& b,string& err_msg,datetime _exp=0);
  
  static int SetAllOrderSL(MqlRates& b,ao_trend_mode ao_mode);
  
  static int SetAllOrderSLbyFibo(MqlRates& b,double fibo_coef);
  
  static int SetAllOrderSLbyFibo2(MqlRates& b,double fibo_coef);
  
  static int SetAllOrderSLbyFibo3(int op_type,double v);
  
  static int SetAllOrderSLbyFrac(double frac_sl,int op_type);
  
  static int SetAllOrderSLbyValue(double sl_val,int op_type);
  
  static int SetAllOrderSLbyValue(sl_mode slm,double sl_val);
  
  static int SetAllOrderSLbyATR(MqlRates& bar,int op_type);
  
  static int SetAllOrderSLbyATR2(int op_type,double v);
  
  static int SetAllOrderSLbyATR3(MqlRates& bar,int op_type);
  
  static int RemoveAllOrders();
  
  static bool OrderExists(int op_type);
  
  static string err_msg();
  
  static bool gator_sleeps(double gator_sleep_coef);
  
  static bool gator_waked_up(double gator_wake_up_coef);
  
  static double get_gator_wake_coef();
  
  static void WriteFile(string msg);
  
  static void WriteFile(int handle,string msg);
  
  static void GetGatorStat(int handle,int shift);
  
  static double get_gator_wake_up_val();
  
  static double get_gator_sleep_val();
  
  static double rad_to_grad(double rad);
  
  static bool is_angulation(MqlRates& b,bar_types bt,double& angle);
  
  static bool is_bar_over_gator(MqlRates& b,int shift,double& avg_gator);
  
  static ac_mode get_ac_mode(int timeframe=PERIOD_CURRENT);
  
  static ac_mode get_ac_mode2();
  
  static ac_mode get_ac_mode3();
  
  static ac_mode get_ac_mode4();
  
  static ac_mode get_ac_mode5();
  
  static ac_mode get_ac_mode6(int timeframe=PERIOD_CURRENT);
  
  static ac_sign_mode get_ac_sign_mode(int timeframe=PERIOD_CURRENT);
  
  static ac_mode get_ac_mode_simple(int timeframe=PERIOD_CURRENT);
  
  static bar_reversal_type get_bar_reversal_type(MqlRates& ready_bar, MqlRates& prev_bar);
  
  static void get_dummy_bar(MqlRates& dummy_bar,trade_mode tm,int mode);
  
  static int get_more_period();
  
  static int get_less_period();
  
  static double get_local_extremum(MqlRates& rates[],trade_mode tm,int ma_method=MODE_SMMA,int start_shift=1);
  
  static double get_local_extremum(MqlRates& rates[],trade_mode tm,int& ext_shift,int ma_method=MODE_SMMA,int start_shift=1);
  
  static int find_order(ac_mode ac);
  
  static gator_mode get_gator_mode(ax_settings& stgs,int shift);
  
  static bar_types get_gator_bar_cross_mode(MqlRates& rates[],int gm,int shift);
  
  static fibo_levels get_next_fibo(fibo_levels current_fibo);
  
  static fibo_levels get_next_fibo(fibo_levels current_fibo,double& coef);
  
  static double get_fractal(MqlRates& rates[],int mode);
  
  static void SweepOrderArray();
  
  static rsi_mode get_rsi_mode(ax_settings& stgs,int shift);
  
  static rsi_mode get_rsi_mode2(ax_settings& stgs,int shift);
  
  static sl_mode get_sl_mode(MqlRates& rates[],double& sl_val);
  
  static bool inIchimokuCloud(double v);
  
  static double getPercentValueFromBarToExtrem(double bar_val,double extrem_val,double percent);
  
  static double get_sl_by_SAR(MqlRates& rates[],int op_type);
  
  static double get_sl_by_SAR2(MqlRates& rates[],int op_type);
  
  static bool __period();
  
  static bool volatile();
  
  static double get_max_lot();
  
  static void get_dummy_bar_reverse(MqlRates& direct_bar,double direct_lot,trade_mode tm,double profit_coef,MqlRates& reverse_bar,double& reverse_lot);
  //static void get_dummy_bar_reverse(MqlRates& direct_bar,double direct_lot,trade_mode tm,double profit_coef,double& price,double& sl,double& tp,double& reverse_lot);
  static macd_trade_mode get_tm_by_macd(int timeframe,int shift);
  
  static macd_trade_mode get_tm_by_macd2(int timeframe,int shift);
  //-------------------------------------------------------------------
  static bar_types get_bar_type_by_AC(MqlRates& rates[],MqlRates& out_bar,double& local_extremum);
  
  static bar_types get_bar_type_by_AC2(MqlRates& rates[],MqlRates& out_bar,double& local_extremum);
  
  static void trade(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg);
  
  static void trade2(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg);
  
  static void trade3(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg);
  
  static void trade4(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg);
  
  static void trade5_fractal(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg);
  
  static bool trade6_simple(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg,order_data& order,bool use_ichimoku,order_sl_type sl_type,int bars_count_back=3);
  
  static bool trade6_simple_stoplevel(ax_settings& stgs,MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg,order_data& order,bool use_ichimoku,order_sl_type sl_type,int bars_count_back=3);
  
  static bool trade7(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,bool use_ichimoku,string& err_msg);
  
  static ma_trade_mode get_ma_trade_mode();
  
  static bool find_previous_reverse_order(int op_type,ax_order_settings& order_set);
  
  static int get_delta_points();
  
  static ichimoku_cross_mode get_ichimoku_cross_mode(MqlRates& prev_rate,MqlRates& rate,double prev_val,double val);
  
  static ichimoku_cross_mode get_ichimoku_chikou_cross_mode(MqlRates& rates[]);
  
  static ichimoku_cross_mode get_ichimoku_chikou_kijun_cross_mode();
  
  static ichimoku_cross_mode get_ichimoku_chikou_ma_cross_mode();
  
  static bool ichimoku_reversed(MqlRates& rates[]);
  
  static double get_local_extremum_by_kijun(MqlRates& rates[],trade_mode tm);
  
  static double get_local_extremum_by_kijun2(MqlRates& rates[],trade_mode tm);
  
  static void get_sl_by_more_period_BW(MqlRates& ready_bar,MqlRates& bigger_bar);
  
  static double get_min_stop_level();
  
  static trix_cross_mode get_trix_cross_mode(int fast,int slow,int shift);
  
  static trix_color_change_mode get_trix_color_change_mode(int fast,int slow,int shift);
  
  static bool get_trix_arrow_type(int fast,int slow,int shift,trix_arrow_type tat,double& outval);
  
  static double get_order_sl(MqlRates& rates[],order_sl_type sl_type,trade_mode tm,int shift,int bars_count_back);
  
  static gator_formation get_gator_formation(int ma_method,int timeframe,int lips_shift,int teeth_shift,int jaw_shift,int comp_count);

  static gator_trans_formation get_gator_trans_formation(int ma_method,int lips_shift,int teeth_shift,int jaw_shift,int comp_count);
  
  static gator_formation_trend get_gator_formation_trend(int ma_method,int lips_shift,int teeth_shift,int jaw_shift,int comp_count);
  
  static double get_order_level(trade_mode tm,ax_order_settings& order_set,order_level ol,double magic_value);
  
  static bool gator_cross_distance(ax_settings& stgs,MqlRates& rates[],bar_position bp,distance_t dt,double& loc_ext);

  static bool current_wave(ax_settings& stgs,MqlRates& rates[],bar_position bp,int shift);
  
  static bool get_bar_ma_position(ax_settings& stgs,MqlRates& rates[],bar_position bp,int shift);
  static bool get_bar_ma_position(ax_settings& stgs,MqlRates& bar,bar_position bp,int shift);

  static bool ma_cross_distance(ax_settings& stgs,MqlRates& rates[],bar_position bp,distance_t dt);
  
  static double get_local_ma_extremum(ax_settings& stgs,MqlRates& rates[],trade_mode tm,int start_shift=1);
  static double get_local_ma_extremum(ax_settings& stgs,MqlRates& rates[],trade_mode tm,int& ext_shift,int start_shift=1);
  
  static gator_bar_cross_t get_gator_bar_cross(ax_settings& stgs,MqlRates& bar);
  
  static double get_gator_val(ax_settings& stgs,int mode,int shift,bool normalize=false);  
  static double get_sar_val(ax_settings& stgs,int shift,bool normalize=false);
  static bool get_bwmfi_exist_color(MqlRates& rates[],int shift,int count,t_mfivalue mfi_color);
  
  static double get_ax_ind_008(ax_settings& stgs,MqlRates& rates[],int shift,double& _balance_price,int& _cnt);
  
  static double get_ax_ind_009(ax_settings& stgs,MqlRates& rates[],int shift);
  
  static double get_order_current_loss_to_stoploss(ax_order_settings& order_stgs,int ticket);
};//class ax_bar_utils

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ax_bar_utils::ax_bar_utils()
{
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ax_bar_utils::~ax_bar_utils()
{
}

//-------------------------------------------------------------------- 
static void ax_bar_utils::do_settings(ax_settings& stgs)
{
 stgs.ma_period        =13;
 stgs.ma_shift         =8;
 stgs.ma_method        =MODE_SMMA;
 stgs.ma_applied_price =PRICE_TYPICAL;//PRICE_MEDIAN;
 stgs.atr_period       =14;
 
 stgs.jaw_period       =13;
 stgs.jaw_shift        =8;
 stgs.teeth_period     =8;
 stgs.teeth_shift      =5;
 stgs.lips_period      =5;
 stgs.lips_shift       =3;
 
 stgs.sar_step         =0.02;
 stgs.sar_max          =0.2;
 
 stgs.dem_period       =14;
 stgs.dem_upper_level  =0.7;
 stgs.dem_lower_level  =0.3;
 
 stgs.magic_distance   =g_magic_distance;

 stgs.stoplevel        =MarketInfo(Symbol(),MODE_STOPLEVEL);
 stgs.spread           =MarketInfo(Symbol(),MODE_SPREAD);
 stgs.trailing_stop    =stgs.stoplevel;
 
 stgs.try_count        =3;
 stgs.loss_profit_bars_wait_cnt=3;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::DrawArrow(int CodeArrow,color ColorArrow,int i,int TypeArrow) 
{
 if(i<=0)
  return -1;
  
 string nm=DoubleToStr(Time[i],0); 
 //string nm=IntegerToString(GetTickCount()); 

 if(ObjectFind(nm)<0) 
 {
  if(TypeArrow==0) 
   ObjectCreate(nm,22,0,iTime(NULL,0,i),iHigh(NULL,0,i)+0.0004);// стрелка вверх над баром
  else 
   ObjectCreate(nm,22,0,iTime(NULL,0,i),iLow(NULL,0,i)-0.0001);// стрелка вниз под баром
 }
 
 ObjectSet(nm,OBJPROP_ARROWCODE,CodeArrow);
 ObjectSet(nm,OBJPROP_COLOR,ColorArrow);
 
 return 0;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::DrawArrow2(int CodeArrow,color ColorArrow,int i,int TypeArrow) 
{
 if(i<=0)
  return -1;
  
 string nm=IntegerToString(GetTickCount());
 
 if(ObjectFind(nm)>0)
  nm=nm+"1";

 if(ObjectFind(nm)<0) 
 {
  if(TypeArrow==0) 
   ObjectCreate(nm,22,0,iTime(NULL,0,i),iHigh(NULL,0,i)+0.0004);// стрелка вверх над баром
  else 
   ObjectCreate(nm,22,0,iTime(NULL,0,i),iLow(NULL,0,i)-0.0001);// стрелка вниз под баром
 }
 
 ObjectSet(nm,OBJPROP_ARROWCODE,CodeArrow);
 ObjectSet(nm,OBJPROP_COLOR,ColorArrow);
 
 return 0;
}

//-------------------------------------------------------------------- 
static bar_types ax_bar_utils::get_type(MqlRates& ready_bar, MqlRates& prev_bar)
{
  //bull
  if(ready_bar.low<prev_bar.low && ready_bar.close>ax_bar_utils::get_avg_value(ready_bar))
   return BARTYPE_BULLISH;
   
  //bear
  if(ready_bar.high>prev_bar.high && ready_bar.close<ax_bar_utils::get_avg_value(ready_bar))
   return BARTYPE_BEARISH;
   
  return BARTYPE_NONE;
}

//-------------------------------------------------------------------- 
static bar_types ax_bar_utils::get_type2(MqlRates& bar)
{
  //bull
  if(bar.close>ax_bar_utils::get_avg_value(bar))
   return BARTYPE_BULLISH;
   
  //bear
  if(bar.close<ax_bar_utils::get_avg_value(bar))
   return BARTYPE_BEARISH;
   
  return BARTYPE_NONE;
}

//-------------------------------------------------------------------- 
static bar_types ax_bar_utils::get_type3(MqlRates& rates[],bar_position_mode bpm)
{
 bar_types bt=ax_bar_utils::get_type(rates[1],rates[2]);
 
 if(bt==BARTYPE_NONE)
  return BARTYPE_NONE;
  
 if(bt==BARTYPE_BULLISH && ax_bar_utils::get_bar_gator_position(rates,BARPOSITION_UNDERGATOR,bpm,1))
  return BARTYPE_BULLISH;
  
 if(bt==BARTYPE_BEARISH && ax_bar_utils::get_bar_gator_position(rates,BARPOSITION_ABOVEGATOR,bpm,1))
  return BARTYPE_BEARISH;
  
 return BARTYPE_NONE;
}

//+------------------------------------------------------------------+
static bar_types ax_bar_utils::get_type4(MqlRates& rates[])
{
 //сначала проверяем по одному бару
 bar_types bt=ax_bar_utils::get_type(rates[1],rates[2]);
 
 if(bt!=BARTYPE_NONE)
  return bt;
 
 //проверим два последних
 MqlRates dummy_bar;
 dummy_bar.open   =rates[2].open;
 dummy_bar.close  =g_ready_bar.close;
 dummy_bar.low    =MathMin(rates[2].low,g_ready_bar.low);
 dummy_bar.high   =MathMax(rates[2].high,g_ready_bar.high);
  
 return ax_bar_utils::get_type(dummy_bar,rates[3]);
}

//-------------------------------------------------------------------- 
static bar_types ax_bar_utils::get_type5(MqlRates& rates[],int shift)
{
  //bull
  if(rates[shift].close>ax_bar_utils::get_avg_value(rates[shift]))
   return BARTYPE_BULLISH;
   
  //bear
  if(rates[shift].close<ax_bar_utils::get_avg_value(rates[shift]))
   return BARTYPE_BEARISH;
   
  return BARTYPE_NONE;
}

//+------------------------------------------------------------------+
static bar_types ax_bar_utils::get_type6(MqlRates& rates[],int shift)
{
 double tp  =ax_bar_utils::get_typical_price(rates[shift]);
 double avg =ax_bar_utils::get_avg_value(rates[shift]);
 
 if(tp>avg)//предположительно BULLISH
 {
  return (rates[shift+2].low>rates[shift+1].low && rates[shift+1].low>rates[shift].low)?BARTYPE_BULLISH:BARTYPE_NONE;
 }
 else
 if(tp<avg)//предположительно BEARISH
 {
  return (rates[shift+2].high<rates[shift+1].high && rates[shift+1].high<rates[shift].high)?BARTYPE_BEARISH:BARTYPE_NONE;
 }

 return BARTYPE_NONE; 
}

//-------------------------------------------------------------------- 
static bar_types ax_bar_utils::get_type_via_ac(MqlRates& rates[],bar_position_mode bpm,MqlRates& out_bar)
{
 out_bar.open  =rates[3].open;
 out_bar.close =rates[1].close;
 
 double v1=iAC(NULL,0,1);//-1
 double v2=iAC(NULL,0,2);//-2
 double v3=iAC(NULL,0,3);//-3
 double v4=iAC(NULL,0,4);//-4
 
 //BUY - определяем переход красное->зеленое (ниже нуля) - пик на графике AC
 if((v1<0&&v2<0&&v1>v2&&v2<v3&&v3<v4) || (v1<0&&v2<0&&v1>v2&&v2>v3&&v3<v4)|| (v1<0&&v1<0&&v1>v2&&v2>v3&&v3>v4))
 {
  out_bar.high  =rates[1].high;
  out_bar.low   =ax_bar_utils::get_min(rates[1].low,rates[2].low,rates[3].low);
  
  //if(ax_bar_utils::get_type(out_bar,rates[4])==BARTYPE_BULLISH && ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_UNDERGATOR,bpm,1))
  if(ax_bar_utils::get_type2(out_bar)==BARTYPE_BULLISH && ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_UNDERGATOR,bpm,1))
   return BARTYPE_BULLISH;
   
  return BARTYPE_NONE;
 }
 
 //SELL  - определяем переход зеленое->красное (выше нуля) - пик на графике AC
 if(v1>0&&v2>0&&v1<v2&&v2>v3&&v3>v4)
 {
  out_bar.high  =ax_bar_utils::get_max(rates[1].high,rates[2].high,rates[3].high);
  out_bar.low   =rates[1].low;
  
  //if(ax_bar_utils::get_type(out_bar,rates[4])==BARTYPE_BEARISH && ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_ABOVEGATOR,bpm,1))
  if(ax_bar_utils::get_type2(out_bar)==BARTYPE_BEARISH && ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_ABOVEGATOR,bpm,1))
   return BARTYPE_BEARISH;
   
  return BARTYPE_NONE;
 }
  
 return BARTYPE_NONE;
}

//-------------------------------------------------------------------- 
static bar_types ax_bar_utils::get_type_via_gator(MqlRates& rates[],bar_position bp,int shift)
{
 MqlRates cur   =rates[shift];
 MqlRates prev  =rates[shift+1];
 
 if((bp==BARPOSITION_UNDERGATOR && cur.low>prev.low) || (bp==BARPOSITION_ABOVEGATOR && cur.high<prev.high))
  return BARTYPE_NONE;
  
 bar_close_type bct=ax_bar_utils::get_bar_close_type(cur);
 
 if(bct==BARCLOSETYPE_LOW)
  return BARTYPE_BEARISH;
    
 if(bct==BARCLOSETYPE_HIGH)
  return BARTYPE_BULLISH;

 return BARTYPE_NONE;
}

//-------------------------------------------------------------------- 
static bar_close_type ax_bar_utils::get_bar_close_type(MqlRates& bar)
{
 double third=NormalizeDouble((bar.high-bar.low)/3,Digits);
 
 if(bar.close<(bar.low+third))
  return BARCLOSETYPE_LOW;
  
 if(bar.close>(bar.high-third))
  return BARCLOSETYPE_HIGH;
  
 return BARCLOSETYPE_MIDDLE;
}

//-------------------------------------------------------------------- 
static double ax_bar_utils::get_avg_value(MqlRates& bar)
{
 return NormalizeDouble((bar.high+bar.low)/2,Digits);
}

//-------------------------------------------------------------------- 
static double ax_bar_utils::get_typical_price(MqlRates& bar)
{
 return NormalizeDouble((bar.high+bar.low+bar.close)/3,Digits);
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::is_price_in_range(MqlRates& bar, double price)
{
 return bar.high>=price&&bar.low<=price;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::is_out_of_gator(MqlRates& bar)
{
 //получаем значение Алигатора
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,1),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,1),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,1),Digits);
 
 return (bar.high<ax_bar_utils::get_min(lips,teeth,jaw)) || (bar.low>ax_bar_utils::get_max(lips,teeth,jaw)); 
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::is_in_gator(MqlRates& bar,int shift)
{
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,shift),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,shift),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,shift),Digits);
 
 double max=ax_bar_utils::get_max(lips,teeth,jaw);
 double min=ax_bar_utils::get_min(lips,teeth,jaw);
 
 return bar.low>=min && bar.high<=max;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::is_out_of_gator(ax_settings& stgs,MqlRates& rates[],int shift)
{
 //получаем значение Алигатора
 double lips  =ax_bar_utils::get_gator_val(stgs,MODE_GATORLIPS,shift);
 double teeth =ax_bar_utils::get_gator_val(stgs,MODE_GATORTEETH,shift);
 double jaw   =ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,shift);
 
 return (rates[shift].high<ax_bar_utils::get_min(lips,teeth,jaw)) || (rates[shift].low>ax_bar_utils::get_max(lips,teeth,jaw)); 
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::get_bar_gator_position(MqlRates& rates[],bar_position bp,bar_position_mode bpm,int shift,int ma_method)
{
 MqlRates bar=rates[shift];
 
 return ax_bar_utils::get_bar_gator_position(bar,bp,bpm,shift,ma_method);
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::get_bar_gator_position(MqlRates& bar,bar_position bp,bar_position_mode bpm,int shift,int ma_method)
{
 //получаем значение Алигатора
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORLIPS,shift),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORTEETH,shift),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORJAW,shift),Digits);
 
 double max=ax_bar_utils::get_max(lips,teeth,jaw);
 double min=ax_bar_utils::get_min(lips,teeth,jaw);
 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 if(bp==BARPOSITION_UNDERGATOR)
 {
  switch(bpm)
  {
   //case BARPOSITIONMODE_FULL: return bar.high<(min-minstoplevel*Point);
   case BARPOSITIONMODE_FULL: return bar.high<min;
   case BARPOSITIONMODE_MEDIUM: return ax_bar_utils::get_avg_value(bar)<min && bar.high<max;
   case BARPOSITIONMODE_MEDIUM3: return ax_bar_utils::get_avg_value(bar)<min && bar.high<max;
   case BARPOSITIONMODE_MEDIUM2: return ax_bar_utils::get_avg_value(bar)<min;
   case BARPOSITIONMODE_PART: return bar.low<min && bar.high<max;
   case BARPOSITIONMODE_PART3: return bar.low<min && bar.high<max;
   case BARPOSITIONMODE_PART2: return bar.low<min;
  }  
 }
 
 if(bp==BARPOSITION_ABOVEGATOR)
 {
  switch(bpm)
  {
   //case BARPOSITIONMODE_FULL: return bar.low>(max+minstoplevel*Point);
   case BARPOSITIONMODE_FULL: return bar.low>max;
   case BARPOSITIONMODE_MEDIUM: return ax_bar_utils::get_avg_value(bar)>max && bar.low>min;
   case BARPOSITIONMODE_MEDIUM3: return ax_bar_utils::get_avg_value(bar)>max && bar.low>min;
   case BARPOSITIONMODE_MEDIUM2: return ax_bar_utils::get_avg_value(bar)>max;
   case BARPOSITIONMODE_PART: return bar.high>max && bar.low>min;
   case BARPOSITIONMODE_PART3: return bar.high>max && bar.low>min;
   case BARPOSITIONMODE_PART2: return bar.high>max;
  }  
 }
 
 return false;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::get_bar_gator_position2(MqlRates& rates[],bar_position bp,bar_position_mode bpm,int shift)
{
 //получаем значение Алигатора
 //double lips_val=iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORLIPS,shift);
 //double teeth_val=iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORTEETH,shift);
 double gator=iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORTEETH,shift);
 //double jaw_val=iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORJAW,shift);
 //double gator=iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORJAW,shift);
 
 MqlRates bar=rates[shift];
 
 if(bp==BARPOSITION_UNDERGATOR)
 {
  switch(bpm)
  {
   case BARPOSITIONMODE_FULL: return bar.high<gator;
   case BARPOSITIONMODE_MEDIUM3: return ax_bar_utils::get_avg_value(bar)<gator;
   case BARPOSITIONMODE_MEDIUM2: return ax_bar_utils::get_avg_value(bar)<gator;
   case BARPOSITIONMODE_PART3: return bar.low<gator;;
   case BARPOSITIONMODE_PART2: return bar.low<gator;
  }  
 }
 
 if(bp==BARPOSITION_ABOVEGATOR)
 {
  switch(bpm)
  {
   case BARPOSITIONMODE_FULL: return bar.low>gator;
   case BARPOSITIONMODE_MEDIUM3: return ax_bar_utils::get_avg_value(bar)>gator;
   case BARPOSITIONMODE_MEDIUM2: return ax_bar_utils::get_avg_value(bar)>gator;
   case BARPOSITIONMODE_PART3: return bar.high>gator;
   case BARPOSITIONMODE_PART2: return bar.high>gator;
  }  
 }
 
 return false;
}

//-------------------------------------------------------------------- 
static bar_position ax_bar_utils::get_bar_gator_position3(MqlRates& rates[],int shift,bool check_minstoplevel)
{
 //получаем значение Алигатора
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORLIPS,shift),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORTEETH,shift),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORJAW,shift),Digits);
 
 double max=ax_bar_utils::get_max(lips,teeth,jaw);
 double min=ax_bar_utils::get_min(lips,teeth,jaw);
 
 if(rates[shift].high+(check_minstoplevel?ax_bar_utils::get_min_stop_level():0)<min)
  return BARPOSITION_UNDERGATOR;
  
 if(rates[shift].low-(check_minstoplevel?ax_bar_utils::get_min_stop_level():0)>max)
  return BARPOSITION_ABOVEGATOR;
 
 return BARPOSITION_NONE;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::get_bar_gator_position4(trade_mode tm,MqlRates& rates[],int bar_shift,int back_bar_shift)
{
 double lips;
 double teeth;
 double jaw;
 
 double max;
 double min;
 
 if(tm==TRADEMODE_BUY)
 {
  if(ax_bar_utils::get_bar_gator_position3(rates,bar_shift,false)!=BARPOSITION_UNDERGATOR)
   return false;
   
  for(int i=bar_shift+1;i<=back_bar_shift;i++)
  {
   lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORLIPS,i),Digits);
   teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORTEETH,i),Digits);
   jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORJAW,i),Digits);
 
   max=ax_bar_utils::get_max(lips,teeth,jaw);
   min=ax_bar_utils::get_min(lips,teeth,jaw);
   
   if(rates[i].low>=max)
    return false;
  }
  
  return true;
 }//if TRADEMODE_BUY
 
 //TRADEMODE_SELL
 if(ax_bar_utils::get_bar_gator_position3(rates,bar_shift,false)!=BARPOSITION_ABOVEGATOR)
  return false;
  
 for(int i=bar_shift+1;i<=back_bar_shift;i++)
 {
  lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORLIPS,i),Digits);
  teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORTEETH,i),Digits);
  jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_EMA,PRICE_MEDIAN,MODE_GATORJAW,i),Digits);
 
  max=ax_bar_utils::get_max(lips,teeth,jaw);
  min=ax_bar_utils::get_min(lips,teeth,jaw);
   
  if(rates[i].high<=min)
   return false;
 }
  
 return true;
}

//-------------------------------------------------------------------- 
static bar_position ax_bar_utils::get_bar_gator_position5(MqlRates& rates[],int shift)
{
 //получаем значение Алигатора
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,shift),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,shift),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,shift),Digits);
 
 double max=ax_bar_utils::get_max(lips,teeth,jaw);
 double min=ax_bar_utils::get_min(lips,teeth,jaw);
 
 double bar_height=rates[shift].high-rates[shift].low;
 
 if(rates[shift].high<(min-bar_height))
  return BARPOSITION_UNDERGATOR;
  
 if(rates[shift].low>(max+bar_height))
  return BARPOSITION_ABOVEGATOR;
 
 return BARPOSITION_NONE;
}

//-------------------------------------------------------------------- 
//returns true  when bar does not cross gator jaw
//        false when bar cross gator jaw
static bool ax_bar_utils::bar_doesnt_cross_gator_jaw(MqlRates& rates[],bar_position bp,int shift,int ma_method)
{
 double jaw=NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORJAW,shift),Digits);
 
 if(bp==BARPOSITION_UNDERGATOR && rates[shift].high<jaw)
  return true;

 if(bp==BARPOSITION_ABOVEGATOR && rates[shift].low>jaw)
  return true;
 
 return false;
}

//--------------------------------------------------------------------
//true - if typical price between lips and jaw, but bar doesnt cross jaw
static bool ax_bar_utils::special_bar_gator_position(ax_settings& stgs,MqlRates& rates[],int shift)
{
 double tc=ax_bar_utils::get_typical_price(rates[shift]);
 
 double lips  =ax_bar_utils::get_gator_val(stgs,MODE_GATORLIPS,shift);
 double jaw   =ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,shift);
 
 if(rates[shift].low<jaw && jaw<rates[shift].high)
  return false;
  
 return (lips<tc && tc<jaw) || (lips>tc && tc>jaw);
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::trend_rates(MqlRates& rates[],int shift)
{
 if(rates[shift+1].high>rates[shift].high && rates[shift+1].low<rates[shift].low)
  return false;
  
 if(rates[shift+1].high<rates[shift].high && rates[shift+1].low>rates[shift].low)
  return false;
  
 return true;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::is_out_of_gator(MqlRates& bar, bar_types bt)
{
 //получаем значение Алигатора
 double lips_val=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,1);
 double teeth_val=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,1);
 double jaw_val=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,1);
  
 if(bt==BARTYPE_BEARISH)
 {
  double gator_val=ax_bar_utils::get_max(lips_val,teeth_val,jaw_val);
  
  //return bar.low>gator_val;
  return bar.low>(gator_val+(bar.high-bar.low)*g_gator_bar_diff);
 }
 
 if(bt==BARTYPE_BULLISH)
 {
  double gator_val=ax_bar_utils::get_min(lips_val,teeth_val,jaw_val);
  
  //return bar.high<gator_val;
  return bar.high<(gator_val-(bar.high-bar.low)*g_gator_bar_diff);
 }
 
 return false;
}

//-------------------------------------------------------------------- 
static double ax_bar_utils::get_min(double v1,double v2,double v3)
{
 return MathMin(v1,MathMin(v2,v3));
}

//-------------------------------------------------------------------- 
static double ax_bar_utils::get_max(double v1,double v2,double v3)
{
 return MathMax(v1,MathMax(v2,v3));
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::is_equal(MqlRates& b1,MqlRates& b2)
{
 return b1.time==b2.time;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::OpenOrder(MqlRates& b,bar_types bt,string& err_msg,datetime _exp)
{
 datetime expiration=0;
 
 if(_exp!=0)
  expiration=TimeCurrent()+g_reversal_bar_cnt_wait*PeriodSeconds(Period());
 
 err_msg="";
 //--- получим минимальное значение Stop level 
 //double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double price =0;
 double sl    =0;
 double tp    =0;
 
 int ticket=-1;
 
 if(bt==BARTYPE_BULLISH)//покупаем
 {
  price =NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits);
  sl    =NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits);
  tp    =NormalizeDouble(b.high+g_profit_coef*(b.high-b.low),Digits);
  ticket=OrderSend(Symbol(),OP_BUYSTOP,g_lot,price,g_slippage,sl,tp,"AX Order Buy",g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(bt==BARTYPE_BEARISH)//продаем
 {
  price =NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits);
  sl    =NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits);
  tp    =NormalizeDouble(b.low-g_profit_coef*(b.high-b.low),Digits);
  ticket=OrderSend(Symbol(),OP_SELLSTOP,g_lot,price,g_slippage,sl,tp,"AX Order Sell",g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(ticket<0)
 {
  int err=GetLastError();
  
  err_msg=IntegerToString(err)+":"+ErrorDescription(err)+"\n"+
          "Price:"+DoubleToString(price)+"\n"+
          "Loss:"+DoubleToString(sl)+"\n"+
          "Profit:"+DoubleToString(tp);
 }
 
 return ticket;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::OpenOrder(MqlRates& b,trade_mode tm,string& err_msg,datetime _exp=0)
{
 datetime expiration=_exp;
 
 /*if(_exp!=0)
  expiration=TimeCurrent()+g_bar_cnt_wait*PeriodSeconds(Period());*/
 
 err_msg="";
 //--- получим минимальное значение Stop level 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double price =0;
 double sl    =0;
 double tp    =0;
 int ticket   =-1;
 
 if(tm==TRADEMODE_BUY)//покупаем
 {
  price =Ask;
  sl    =MathMin(NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
  //tp    =NormalizeDouble(b.high+g_profit_coef*(b.high-b.low),Digits);
  //sl=NormalizeDouble(Bid-minstoplevel*Point,Digits);
  ticket=OrderSend(Symbol(),OP_BUY,g_lot,price,g_slippage,sl,tp,"AX Order Buy",g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(tm==TRADEMODE_SELL)//продаем
 {
  price =Bid;
  sl    =MathMax(NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));
  //tp    =NormalizeDouble(b.low-g_profit_coef*(b.high-b.low),Digits);
  //sl=NormalizeDouble(Ask-minstoplevel*Point,Digits);
  ticket=OrderSend(Symbol(),OP_SELL,g_lot,price,g_slippage,sl,tp,"AX Order Sell",g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(ticket<0)
 {
  int err=GetLastError();
  
  err_msg=IntegerToString(err)+":"+ErrorDescription(err)+"\n"+
          "Price:"+DoubleToString(price)+"\n"+
          "Stop Loss:"+DoubleToString(sl)+"\n"+
          "Take Profit:"+DoubleToString(tp);
 }
 
 return ticket;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::OpenOrder2(MqlRates& b,trade_mode tm,string& err_msg,int _exp,double lot,string comment)
{
 datetime expiration=0;
 
 if(_exp!=0)
  expiration=TimeCurrent()+g_reversal_bar_cnt_wait*PeriodSeconds(Period())+1;
 
 err_msg="";
 //--- получим минимальное значение Stop level 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double price   =0;
 double sl      =0;
 double tp      =0;
 int ticket     =-1;
 
 if(tm==TRADEMODE_BUY)//покупаем
 {
  price   =MathMax(NormalizeDouble(Ask+minstoplevel*Point,Digits),NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits));
  sl      =MathMin(NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
  tp      =g_set_tp?NormalizeDouble(MathMax(b.high,price)+g_profit_coef*(b.high-b.low),Digits):0;
  ticket  =OrderSend(Symbol(),OP_BUYSTOP,lot,price,g_slippage,sl,tp,comment,g_order_count++,expiration,clrWhiteSmoke);
  
  /*double tmp=price;
  price  =sl;
  sl     =tmp;
  tp     =NormalizeDouble(b.low-g_profit_coef*(b.high-b.low),Digits);
  ticket =OrderSend(Symbol(),OP_SELLSTOP,g_lots,price,g_slippage,sl,tp,"AX Order Sell",g_order_count++,expiration,clrWhiteSmoke);*/
 }
 
 if(tm==TRADEMODE_SELL)//продаем
 {
  price  =MathMin(NormalizeDouble(Bid-minstoplevel*Point,Digits),NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits));
  sl     =MathMax(NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));
  tp     =g_set_tp?NormalizeDouble(MathMin(b.low,price)-g_profit_coef*(b.high-b.low),Digits):0;
  ticket =OrderSend(Symbol(),OP_SELLSTOP,lot,price,g_slippage,sl,tp,comment,g_order_count++,expiration,clrWhiteSmoke);
  
  /*double tmp  =price;
  price  =sl;
  sl     =tmp;
  tp     =NormalizeDouble(b.high+g_profit_coef*(b.high-b.low),Digits);  
  ticket =OrderSend(Symbol(),OP_BUYSTOP,g_lots,price,g_slippage,sl,tp,"AX Order Buy",g_order_count++,expiration,clrWhiteSmoke);*/
 }
 
 if(ticket<0)
 {
  int err=GetLastError();
  
  err_msg=IntegerToString(err)+":"+ErrorDescription(err)+"\n"+
          "Price:"+DoubleToString(price)+"\n"+
          "Stop Loss:"+DoubleToString(sl)+"\n"+
          "Take Profit:"+DoubleToString(tp);
 }
 
 return ticket;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::OpenOrder3(MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,string& err_msg)
{
 order_data order;
 return ax_bar_utils::OpenOrder3(b,tm,order_stgs,err_msg,order);
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::OpenOrder3(MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,string& err_msg,order_data& order)
{
 err_msg="";
 
 datetime expiration=(order_stgs.expire_bar_count==0)?0:TimeCurrent()+order_stgs.expire_bar_count*PeriodSeconds(Period())+1;
 //datetime expiration=0;
 
 //--- получим минимальное значение Stop level 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double price   =0;
 double sl      =0;
 double tp      =0;
 string comment ="";
 int ticket     =-1;
 
 //RefreshRates();
 
 if(tm==TRADEMODE_BUY)//покупаем
 {
  price   =NormalizeDouble(MathMax(b.high,Ask)+minstoplevel*Point,Digits);
  //price   =MathMax(NormalizeDouble(Ask+(minstoplevel+ax_bar_utils::get_delta_points())*Point,Digits),NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits));
  sl      =NormalizeDouble(MathMin(b.low,price)-minstoplevel*Point,Digits);
  //sl      =MathMin(NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(price-(minstoplevel+ax_bar_utils::get_delta_points())*Point,Digits));
  tp      =(order_stgs.profit_coef==0)?order_stgs.profit:NormalizeDouble(price+order_stgs.profit_coef*(price-sl),Digits);
  comment =order_stgs.comment==""?DoubleToString(sl):order_stgs.comment;
  ticket  =OrderSend(Symbol(),OP_BUYSTOP,order_stgs.lot,price,order_stgs.slippage,sl,tp,comment,g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(tm==TRADEMODE_SELL)//продаем
 {
  price   =NormalizeDouble(MathMin(b.low,Bid)-minstoplevel*Point,Digits);
  //price   =MathMin(NormalizeDouble(Bid-minstoplevel*Point,Digits),NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits));
  sl      =NormalizeDouble(MathMax(b.high,price)+minstoplevel*Point,Digits);
  //sl      =MathMax(NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(price+(minstoplevel+ax_bar_utils::get_delta_points())*Point,Digits));
  tp      =(order_stgs.profit_coef==0)?order_stgs.profit:NormalizeDouble(price-order_stgs.profit_coef*(sl-price),Digits);
  comment =order_stgs.comment==""?DoubleToString(sl):order_stgs.comment;
  ticket  =OrderSend(Symbol(),OP_SELLSTOP,order_stgs.lot,price,order_stgs.slippage,sl,tp,comment,g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(ticket>0)
 {
  order.symbol   =Symbol();
  order.period   =Period();
  order.ticket   =ticket;
  order.sl       =sl;
  order.tp       =tp;
  order.comment  =comment;
  order.lot2_set =false;
 }
 else
 {
  int err=GetLastError();
  
  err_msg="("+IntegerToString(err)+")"+ErrorDescription(err)+" "+
          Symbol()+" "+
          "lot="+DoubleToString(order_stgs.lot,2)+" "+
          "price="+DoubleToString(price,Digits)+" "+
          "slippage="+IntegerToString(order_stgs.slippage)+" "+
          "sl="+DoubleToString(sl,Digits)+" "+
          "tp="+DoubleToString(tp,Digits)+" "+
          "comment="+order_stgs.comment+" "+
          "exp="+IntegerToString(expiration);
 }
 
 return ticket;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::OpenOrder3_StopLevel(ax_settings& stgs,MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,string& err_msg,order_data& order)
{
 err_msg="";
 
 datetime expiration=(order_stgs.expire_bar_count==0)?0:TimeCurrent()+order_stgs.expire_bar_count*PeriodSeconds(Period())+1;
 //datetime expiration=0;
 
 double price   =0;
 double sl      =0;
 double tp      =0;
 string comment ="";
 int ticket     =-1;
 
 //RefreshRates();
 
 if(tm==TRADEMODE_BUY)//покупаем
 {
  price   =NormalizeDouble(MathMax(b.high+ax_bar_utils::get_delta_points()*_Point,Ask+stgs.stoplevel*_Point),Digits);
  //sl      =NormalizeDouble(MathMin(price-(stgs.stoplevel+ax_bar_utils::get_delta_points())*_Point,b.low-ax_bar_utils::get_delta_points()*_Point),Digits);
  sl      =NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*_Point,Digits);
  tp      =(order_stgs.profit_coef==0)?order_stgs.profit:NormalizeDouble(price+order_stgs.profit_coef*(price-sl),Digits);
  comment =order_stgs.comment==""?DoubleToString(sl):order_stgs.comment;
  ticket  =OrderSend(Symbol(),OP_BUYSTOP,order_stgs.lot,price,order_stgs.slippage,sl,tp,comment,g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(tm==TRADEMODE_SELL)//продаем
 {
  price   =NormalizeDouble(MathMin(b.low-ax_bar_utils::get_delta_points()*_Point,Bid-stgs.stoplevel*_Point),Digits);
  //sl      =NormalizeDouble(MathMax(price+(stgs.stoplevel+ax_bar_utils::get_delta_points())*_Point,b.high+ax_bar_utils::get_delta_points()*_Point),Digits);
  sl      =NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*_Point,Digits);
  tp      =(order_stgs.profit_coef==0)?order_stgs.profit:NormalizeDouble(price-order_stgs.profit_coef*(sl-price),Digits);
  comment =order_stgs.comment==""?DoubleToString(sl):order_stgs.comment;
  ticket  =OrderSend(Symbol(),OP_SELLSTOP,order_stgs.lot,price,order_stgs.slippage,sl,tp,comment,g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(ticket>0)
 {
  order.symbol   =Symbol();
  order.period   =Period();
  order.ticket   =ticket;
  order.sl       =sl;
  order.tp       =tp;
  order.comment  =comment;
  order.lot2_set =false;
 }
 else
 {
  int err=GetLastError();
  
  err_msg="("+IntegerToString(err)+")"+ErrorDescription(err)+" "+
          Symbol()+" "+
          "lot="+DoubleToString(order_stgs.lot,2)+" "+
          "price="+DoubleToString(price,Digits)+" "+
          "slippage="+IntegerToString(order_stgs.slippage)+" "+
          "sl="+DoubleToString(sl,Digits)+" "+
          "tp="+DoubleToString(tp,Digits)+" "+
          "comment="+order_stgs.comment+" "+
          "exp="+IntegerToString(expiration);
 }
 
 return ticket;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::OpenOrder4(trade_mode tm,ax_order_settings& order_set,double magic_value,string& err_msg)
{
 err_msg="";
 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double sl  =0;
 double tp  =0;
 int ticket =-1;
 
 RefreshRates();
 
 if(tm==TRADEMODE_BUY)//покупаем
 {
  tp       =MathMax(ax_bar_utils::get_order_level(tm,order_set,ORDERLEVEL_TAKEPROFIT,magic_value),Ask+minstoplevel*Point);
  sl       =MathMin(ax_bar_utils::get_order_level(tm,order_set,ORDERLEVEL_STOPLOSS,magic_value),Bid-minstoplevel*Point);
  ticket   =OrderSend(Symbol(),OP_BUY,order_set.lot,Ask,order_set.slippage,sl,tp,order_set.comment,g_order_count++,0,clrWhiteSmoke);
 }
 
 if(tm==TRADEMODE_SELL)//продаем
 {
  tp       =MathMin(ax_bar_utils::get_order_level(tm,order_set,ORDERLEVEL_TAKEPROFIT,magic_value),Bid-minstoplevel*Point);
  sl       =MathMax(ax_bar_utils::get_order_level(tm,order_set,ORDERLEVEL_STOPLOSS,magic_value),Ask+minstoplevel*Point);
  ticket   =OrderSend(Symbol(),OP_SELL,order_set.lot,Bid,order_set.slippage,sl,tp,order_set.comment,g_order_count++,0,clrWhiteSmoke);
 }
 
 if(ticket<0)
 {
  int err=GetLastError();
  
  err_msg="error:("+IntegerToString(err)+")"+ErrorDescription(err)+"\n"+
          "open price:"+DoubleToString(tm==TRADEMODE_BUY?Ask:Bid)+"\n"+
          "sl:"+DoubleToString(sl)+"\n"+
          "tp:"+DoubleToString(tp);
 }
 
 return ticket;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::OpenOrder5(ax_settings& stgs,MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,string& err_msg,order_data& order,double tp_multiple)
{
 for(int i=0;i<stgs.try_count;i++)
 { 
  err_msg="";
 
  double sl  =0;
  double tp  =0;
  int ticket =-1;
 
  RefreshRates();
  
  if(tm==TRADEMODE_BUY)//покупаем
  {
   tp       =Ask+(stgs.stoplevel*tp_multiple+(tp_multiple==1?stgs.spread:0))*_Point;
   sl       =MathMin(Bid-stgs.stoplevel*_Point,b.low-ax_bar_utils::get_delta_points()*_Point);
   ticket   =OrderSend(Symbol(),OP_BUY,order_stgs.lot,Ask,order_stgs.slippage,sl,tp,order_stgs.comment,g_order_count++,0,clrWhiteSmoke);
  }
 
  if(tm==TRADEMODE_SELL)//продаем
  {
   tp       =Bid-(stgs.stoplevel*tp_multiple+(tp_multiple==1?stgs.spread:0))*_Point;
   sl       =MathMax(Ask+stgs.stoplevel*_Point,b.high+ax_bar_utils::get_delta_points()*_Point);
   ticket   =OrderSend(Symbol(),OP_SELL,order_stgs.lot,Bid,order_stgs.slippage,sl,tp,order_stgs.comment,g_order_count++,0,clrWhiteSmoke);
  }
  
  if(ticket>0)
   return ticket;
  else
  {
   int err=GetLastError();
  
   err_msg="error:("+IntegerToString(err)+")"+ErrorDescription(err)+"\n"+
           "open price:"+DoubleToString(tm==TRADEMODE_BUY?Ask:Bid)+"\n"+
           "sl:"+DoubleToString(sl)+"\n"+
           "tp:"+DoubleToString(tp);
  }
 }
 
 return -1;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::OpenOrderReverse(MqlRates& b,trade_mode tm,double lot,int slippage,string comment,int exp_bar_count,double profit_coef,string& err_msg)
//static int ax_bar_utils::OpenOrderReverse(double price,double sl,double tp,trade_mode tm,double lot,int slippage,string comment,int exp_bar_count,double profit_coef,string& err_msg)
{
 err_msg="";
 
 datetime expiration=(exp_bar_count==0)?0:TimeCurrent()+exp_bar_count*PeriodSeconds(Period())+1;
 
 //--- получим минимальное значение Stop level 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double price   =0;
 double sl      =0;
 double tp      =0;
 int ticket     =-1;
 
 if(tm==TRADEMODE_BUY)//покупаем
 {
  price   =MathMax(NormalizeDouble(Ask+(minstoplevel+ax_bar_utils::get_delta_points())*Point,Digits),NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits));
  sl      =MathMin(NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(price-(minstoplevel+ax_bar_utils::get_delta_points())*Point,Digits));
  tp      =(profit_coef==0)?0:NormalizeDouble(price+MathMax(profit_coef*(b.high-b.low),(minstoplevel+ax_bar_utils::get_delta_points())*Point),Digits);
  ticket  =OrderSend(Symbol(),OP_BUYSTOP,lot,price,slippage,sl,tp,comment,g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(tm==TRADEMODE_SELL)//продаем
 {
  price  =MathMin(NormalizeDouble(Bid-(minstoplevel+ax_bar_utils::get_delta_points())*Point,Digits),NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits));
  sl     =MathMax(NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(price+(minstoplevel+ax_bar_utils::get_delta_points())*Point,Digits));
  tp     =(profit_coef==0)?0:NormalizeDouble(price-MathMax(profit_coef*(b.high-b.low),(minstoplevel+ax_bar_utils::get_delta_points())*Point),Digits);
  ticket =OrderSend(Symbol(),OP_SELLSTOP,lot,price,slippage,sl,tp,comment,g_order_count++,expiration,clrWhiteSmoke);
 }
 
 if(ticket<0)
 {
  int err=GetLastError();
  
  err_msg="error:("+IntegerToString(err)+")"+ErrorDescription(err)+"\n"+
          "open price:"+DoubleToString(price)+"\n"+
          "sl:"+DoubleToString(sl)+"\n"+
          "tp:"+DoubleToString(tp)+"\n"+
          //"minstoplevel:"+DoubleToString(minstoplevel)+"\n"+
          "Ask:"+DoubleToString(Ask)+"\n"+
          "Bid:"+DoubleToString(Bid);
 }
 
 return ticket;
}

//-------------------------------------------------------------------- 
//закрывает один ордер и открывает другой (immediate) со своим лотом и в том же направлении
static int ax_bar_utils::OpenOrder3_CloseOpenImmediate(MqlRates& b,trade_mode tm,ax_order_settings& order_stgs,int close_ticket,string& err_msg,order_data& order)
{
 err_msg="";
 
 //пытаемся закрыть
 //if(!ax_bar_utils::CloseOrder(order_stgs,close_ticket,err_msg))
 // return -1;
  
 //--- получим минимальное значение Stop level 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double price   =0;
 double sl      =0;
 double tp      =0;
 string comment ="";
 int ticket     =-1;
 
 RefreshRates();
 
 if(tm==TRADEMODE_BUY)//покупаем
 {
  price   =Ask;
  sl      =NormalizeDouble(MathMin(b.low,price)-minstoplevel*Point,Digits);
  tp      =(order_stgs.profit_coef==0)?order_stgs.profit:NormalizeDouble(MathMax(b.high,price)+order_stgs.profit_coef*(b.high-b.low),Digits);
  comment =order_stgs.comment==""?DoubleToString(sl):order_stgs.comment;
  ticket  =OrderSend(Symbol(),OP_BUY,order_stgs.lot2,price,order_stgs.slippage,sl,tp,comment,g_order_count++,0,clrWhiteSmoke);
 }
 
 if(tm==TRADEMODE_SELL)//продаем
 {
  price   =Bid;
  sl      =NormalizeDouble(MathMax(b.high,price)+minstoplevel*Point,Digits);
  tp      =(order_stgs.profit_coef==0)?order_stgs.profit:NormalizeDouble(MathMin(b.low,price)-order_stgs.profit_coef*(b.high-b.low),Digits);
  comment =order_stgs.comment==""?DoubleToString(sl):order_stgs.comment;
  ticket  =OrderSend(Symbol(),OP_SELL,order_stgs.lot,price,order_stgs.slippage,sl,tp,comment,g_order_count++,0,clrWhiteSmoke);
 }
 
 if(ticket>0)
 {
  order.symbol   =Symbol();
  order.period   =Period();
  order.ticket   =ticket;
  order.sl       =sl;
  order.tp       =tp;
  order.comment  =comment;
  order.lot2_set =true;
 }
 else
 {
  int err=GetLastError();
  
  err_msg="("+IntegerToString(err)+")"+ErrorDescription(err)+" "+
          Symbol()+" "+
          "lot="+DoubleToString(order_stgs.lot2,2)+" "+
          "price="+DoubleToString(price,Digits)+" "+
          "slippage="+IntegerToString(order_stgs.slippage)+" "+
          "sl="+DoubleToString(sl,Digits)+" "+
          "tp="+DoubleToString(tp,Digits)+" "+
          "comment="+order_stgs.comment;
 }
 
 return ticket;
}

//-------------------------------------------------------------------- 
//возвращает количество оставшихся открытых
static int ax_bar_utils::CloseAllOrders()
{
 int cnt=OrdersTotal();
 
 int close_success=0;
 int close_failed=0;
 
 for(int i=cnt-1;i>=0;i--)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
    
  if(OrderSymbol()!=Symbol())
   continue;
   
  int order_type=OrderType();
  
  if(order_type==OP_BUY)
  {
   if(OrderClose(OrderTicket(),OrderLots(),Bid,g_slippage))
    close_success++;
   else
    close_failed++;
  }
  
  if(order_type==OP_SELL)
  {
   if(OrderClose(OrderTicket(),OrderLots(),Ask,g_slippage))
    close_success++;
   else
    close_failed++;
  }
 } 
 
 cnt=OrdersTotal();
 
 return (cnt-close_success)<0?0:(cnt-close_success);
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::CloseAllOrders(int op_type,int slippage)
{
 int cnt=OrdersTotal();
 
 int close_success=0;
 int close_failed=0;
 
 for(int i=cnt-1;i>=0;i--)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  int order_type=OrderType();
  
  if(order_type==op_type && op_type==OP_BUY/* && OrderProfit()<=0*/)
  {
   if(OrderClose(OrderTicket(),OrderLots(),Bid,slippage))
    close_success++;
   else
    close_failed++;
  }
  
  if(order_type==op_type && op_type==OP_SELL/* && OrderProfit()<=0*/)
  {
   if(OrderClose(OrderTicket(),OrderLots(),Ask,slippage))
    close_success++;
   else
    close_failed++;
  }
 } 
 
 cnt=OrdersTotal();
 
 return (cnt-close_success)<0?0:(cnt-close_success);
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::CloseAllOrders(int op_type,string comment,int slippage)
{
 int cnt=OrdersTotal();
 
 int close_success=0;
 int close_failed=0;
 
 for(int i=cnt-1;i>=0;i--)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  int order_type       =OrderType();  
  string order_comment =OrderComment();
  
  if(order_type==op_type && op_type==OP_BUY && order_comment==comment)
  {
   if(OrderClose(OrderTicket(),OrderLots(),Bid,slippage))
    close_success++;
   else
    close_failed++;
  }
  
  if(order_type==op_type && op_type==OP_SELL && order_comment==comment)
  {
   if(OrderClose(OrderTicket(),OrderLots(),Ask,slippage))
    close_success++;
   else
    close_failed++;
  }
 } 
 
 cnt=OrdersTotal();
 
 return (cnt-close_success)<0?0:(cnt-close_success);
}

//--------------------------------------------------------------------
static int ax_bar_utils::CloseAllOrdersSAR()
{
 int new_period=ax_bar_utils::get_more_period();
 
 MqlRates mqlrates[];
 
 ArrayCopyRates(mqlrates,NULL,new_period);
 
 int cnt=OrdersTotal();

 int close_success=0;
 int close_failed=0;
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  int order_type=OrderType();
  
  if(order_type==OP_BUY && OrderComment()=="SL.NE.CR" && mqlrates[1].time>OrderOpenTime() && mqlrates[1].high<=iSAR(NULL,new_period,0.02,0.2,1) && mqlrates[2].low>=iSAR(NULL,new_period,0.02,0.2,2))
  {    
   if(OrderClose(OrderTicket(),OrderLots(),Bid,g_slippage))
    close_success++;
   else
    close_failed++;
  }
   
  if(order_type==OP_SELL && OrderComment()=="SL.NE.CR" && mqlrates[1].time>OrderOpenTime() && mqlrates[1].low>=iSAR(NULL,new_period,0.02,0.2,1) && mqlrates[2].high<=iSAR(NULL,new_period,0.02,0.2,2))
  {
   if(OrderClose(OrderTicket(),OrderLots(),Ask,g_slippage))
    close_success++;
   else
    close_failed++;
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-close_success)<0?0:(cnt-close_success); 
}

//--------------------------------------------------------------------
static int ax_bar_utils::CloseAllOrdersSAR2(int slippage)
{
 int new_period=ax_bar_utils::get_more_period();
 
 MqlRates mqlrates[];
 
 ArrayCopyRates(mqlrates,NULL,new_period);
 
 int cnt=OrdersTotal();

 int close_success=0;
 int close_failed=0;
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
  
  if(OrderTakeProfit()!=0)
   continue;
   
  int order_type=OrderType();
  
  if(order_type==OP_BUY && mqlrates[1].time>OrderOpenTime() && mqlrates[1].high<=iSAR(NULL,new_period,0.02,0.2,1) && mqlrates[2].low>=iSAR(NULL,new_period,0.02,0.2,2))
  {    
   if(OrderClose(OrderTicket(),OrderLots(),Bid,slippage))
    close_success++;
   else
    close_failed++;
  }
   
  if(order_type==OP_SELL && mqlrates[1].time>OrderOpenTime() && mqlrates[1].low>=iSAR(NULL,new_period,0.02,0.2,1) && mqlrates[2].high<=iSAR(NULL,new_period,0.02,0.2,2))
  {
   if(OrderClose(OrderTicket(),OrderLots(),Ask,slippage))
    close_success++;
   else
    close_failed++;
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-close_success)<0?0:(cnt-close_success); 
}

//--------------------------------------------------------------------
static int ax_bar_utils::CloseAllOrdersByProfit(int op_type,double profit,double loss,int slippage)
{
 int cnt=OrdersTotal();

 int close_success=0;
 int close_failed=0;
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  int order_type=OrderType();
  
  if(order_type==op_type && op_type==OP_BUY)
  {
   double p=OrderProfit();
   
   if(p>=profit/* || p<=loss*/)
   {
    if(OrderClose(OrderTicket(),OrderLots(),Bid,slippage))
     close_success++;
    else
     close_failed++;
   }
  }
   
  if(order_type==op_type && op_type==OP_SELL)
  {
   double p=OrderProfit();
   
   if(p>=profit/* || p<=loss*/)
   {
    if(OrderClose(OrderTicket(),OrderLots(),Ask,slippage))
     close_success++;
    else
     close_failed++;
   }
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-close_success)<0?0:(cnt-close_success); 
}

//--------------------------------------------------------------------
static int ax_bar_utils::CloseOrderByBarsAndProfit()
{
 int bars_wait=4;

 int cnt=OrdersTotal();

 int close_success=0;
 int close_failed=0;
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(TimeCurrent()>(OrderOpenTime()+bars_wait*PeriodSeconds(Period())) && OrderProfit()<0)
  {
   int order_type=OrderType();
   
   if(order_type==OP_BUY)
   {
    if(OrderClose(OrderTicket(),OrderLots(),Bid,g_slippage))
     close_success++;
    else
     close_failed++;
   }
   
   if(order_type==OP_SELL)
   {
    if(OrderClose(OrderTicket(),OrderLots(),Ask,g_slippage))
     close_success++;
    else
     close_failed++;
   }
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-close_success)<0?0:(cnt-close_success); 
}

//--------------------------------------------------------------------
static bool ax_bar_utils::CloseOrder(ax_order_settings& stgs,int ticket,string& err_msg)
{
 err_msg="";
 
 if(OrderSelect(ticket,SELECT_BY_TICKET) && OrderCloseTime()==0)
 {
  double price  =(OrderType()==OP_BUY)?Bid:Ask;
  bool   retval =OrderClose(OrderTicket(),OrderLots(),price,stgs.slippage);

  if(!retval)
  {
   int err=GetLastError();
  
   err_msg="("+IntegerToString(err)+") "+ErrorDescription(err)+" "+Symbol()+" "+
           "lot="+DoubleToString(OrderLots(),2)+" "+
           "price="+DoubleToString(price,Digits);
  }
  
  return retval;
 }
 
 err_msg="OrdeSelect(ticket="+IntegerToString(ticket)+") not found";
 
 return false;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::SetOrderSL(int ticket,MqlRates& b,ao_trend_mode ao_mode,datetime _exp=0)
{
 if(!(ticket>0&&OrderSelect(ticket,SELECT_BY_TICKET)))
  return false;
  
 bool retval=false;
 
 double sl=OrderStopLoss();
 
 if(ao_mode==AOTREND_UP)
 {
  sl    =MathMin(NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits),Bid);
  retval=OrderModify(OrderTicket(),OrderOpenPrice(),sl,OrderTakeProfit(),_exp);
 }
 
 if(ao_mode==AOTREND_DOWN)
 {
  sl    =MathMax(NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits),Ask);
  retval=OrderModify(OrderTicket(),OrderOpenPrice(),sl,OrderTakeProfit(),_exp);
 }
 
 return retval;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::SetOrderSL(int ticket,MqlRates& b,string& err_msg,datetime _exp=0)
{
 err_msg="";
 
 if(ticket<0)
  return true;
  
 if(!OrderSelect(ticket,SELECT_BY_TICKET))
 {
  //g_ticket=-1;//похоже, что ордер уже закрылся по stoploss
  return false;
 }
  
 bool retval=false;
 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double sl=0;
 
 int order_type=OrderType();
 
 if(order_type==OP_BUY)
 {
  sl=NormalizeDouble(MathMin(b.low,Bid)/*-minstoplevel*Point*/,Digits);
 
  //sl=MathMin(NormalizeDouble(b.low,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
  //sl=MathMin(NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
  retval =OrderModify(OrderTicket(),OrderOpenPrice(),sl,OrderTakeProfit(),_exp);
 }
 
 if(order_type==OP_SELL)
 {
  sl      =NormalizeDouble(MathMax(b.high,Ask)/*+minstoplevel*Point*/,Digits);
  //sl    =MathMax(NormalizeDouble(b.high,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));
  //sl    =MathMax(NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));
  retval =OrderModify(OrderTicket(),OrderOpenPrice(),sl,OrderTakeProfit(),_exp);
 }
 
 int err=GetLastError();
 
 if(err!=0)
  err_msg="("+IntegerToString(err)+") "+ErrorDescription(err)+" "+Symbol()+" sl="+DoubleToString(sl,Digits);
 
 return retval;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::SetOrderSLPipser(ax_settings& stgs,int ticket,string& err_msg)
{
 err_msg="";
 
 if(!OrderSelect(ticket,SELECT_BY_TICKET))//ордер уже закрылся(не найден)
  return false;
  
 bool retval=false;
 
 double sl =0;
 double tp =0;
 
 if(OrderType()==OP_BUY)
 {
  sl     =NormalizeDouble(Bid-stgs.stoplevel*Point,Digits);
  tp     =NormalizeDouble(Ask+iATR(NULL,0,stgs.atr_period,1),Digits);
  
  if(sl>OrderStopLoss())
   retval =OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,0);
 }
 else
 if(OrderType()==OP_SELL)
 {
  sl     =NormalizeDouble(Ask+stgs.stoplevel*Point,Digits);
  tp     =NormalizeDouble(Bid-iATR(NULL,0,stgs.atr_period,1),Digits);
  
  if(sl<OrderStopLoss())
   retval =OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,0);
 }
 
 int err=GetLastError();
 
 if(err!=0)
  err_msg="("+IntegerToString(err)+") "+ErrorDescription(err)+" "+Symbol()+" sl="+DoubleToString(sl,Digits);
 
 return retval;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::SetOrderSLTP(int ticket,MqlRates& b,string& err_msg,datetime _exp=0)
{
 err_msg="";
 
 if(ticket<0)
  return true;
  
 if(!OrderSelect(ticket,SELECT_BY_TICKET))
  return false;
  
 bool retval=false;
 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double sl=0;
 double tp=0;
 
 int order_type=OrderType();
 
 if(order_type==OP_BUY)
 {
  sl     =NormalizeDouble(MathMin(b.low,Bid)-(minstoplevel+ax_bar_utils::get_delta_points())*Point,Digits);
  tp     =NormalizeDouble(MathMax(b.high,Ask+minstoplevel*Point),Digits);
  retval =OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,_exp);
 }
 
 if(order_type==OP_SELL)
 {
  sl     =NormalizeDouble(MathMax(b.high,Ask)+(minstoplevel+ax_bar_utils::get_delta_points())*Point,Digits);
  tp     =NormalizeDouble(MathMin(b.low,Bid-minstoplevel*Point),Digits);
  retval =OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,_exp);
 }
 
 int err=GetLastError();
  
 err_msg="("+IntegerToString(err)+")"+ErrorDescription(err)+" "+
         Symbol()+" "+
         "sl="+DoubleToString(sl,Digits)+" "+
         "tp="+DoubleToString(tp,Digits);
 
 return retval;
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::SetAllOrderSL(MqlRates& b,ao_trend_mode ao_mode)
{
 if(ao_mode==AOTREND_HOR)
  return 0;
  
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_success=0;
 
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  int order_type=OrderType();

  if(ao_mode==AOTREND_DOWN && order_type==OP_BUY)
  {
   //double sl=MathMin(NormalizeDouble(b.low,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
   double sl=MathMin(NormalizeDouble(b.low-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
   
   if(OrderModify(OrderTicket(),OrderOpenPrice(),MathMax(sl,OrderStopLoss()),OrderTakeProfit(),OrderExpiration()))
    modify_success++;
  }
  
  if(ao_mode==AOTREND_UP && order_type==OP_SELL)
  {
   //double sl=MathMax(NormalizeDouble(b.high,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));
   double sl=MathMax(NormalizeDouble(b.high+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));

   if(OrderModify(OrderTicket(),OrderOpenPrice(),MathMin(sl,OrderStopLoss()),OrderTakeProfit(),OrderExpiration()))
    modify_success++;
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-modify_success)<0?0:(cnt-modify_success);//сколько осталось не модифицированных
}

//-------------------------------------------------------------------- 
static int ax_bar_utils::SetAllOrderSLbyFibo(MqlRates& b,double fibo_coef)
{
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_success=0;
 
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  //if(OrderComment()=="SL.NE.CR")
  // continue;
   
  int order_type=OrderType();

  if(order_type==OP_BUY)
  {
   double order_low=g_buy_loc_min;//NormalizeDouble(StringToDouble(OrderComment()),Digits);
   
   double diff=g_buy_max-order_low;
   
   if(diff>0)//Текущая цена выше стартовой точки
   {
    diff-=diff*fibo_coef;
    //double sl=MathMin(NormalizeDouble(b.low,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
    double sl=MathMin(NormalizeDouble(order_low+diff,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
   
    if(OrderModify(OrderTicket(),OrderOpenPrice(),MathMax(sl,OrderStopLoss()),OrderTakeProfit(),OrderExpiration()))
     modify_success++;
   }
  }
  
  if(order_type==OP_SELL)
  {
   double order_high=g_sell_loc_max;//NormalizeDouble(StringToDouble(OrderComment()),Digits);
   
   double diff=order_high-g_sell_min;
   
   if(diff>0)//текущая цена ниже стартовой точки
   {
    diff-=diff*fibo_coef;
    //double sl=MathMax(NormalizeDouble(b.high,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));
    double sl=MathMax(NormalizeDouble(order_high-diff,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));

    if(OrderModify(OrderTicket(),OrderOpenPrice(),MathMin(sl,OrderStopLoss()),OrderTakeProfit(),OrderExpiration()))
     modify_success++;
   }
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-modify_success)<0?0:(cnt-modify_success);//сколько осталось не модифицированных
}

//--------------------------------------------------------------------
static int ax_bar_utils::SetAllOrderSLbyFibo2(MqlRates& b,double fibo_coef)
{
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_success=0;
 
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  int order_type=OrderType();

  if(order_type==OP_BUY/* && 
     ax_bar_utils::get_bar_gator_position(b,BARPOSITION_ABOVEGATOR,BARPOSITIONMODE_FULL) &&
     ax_bar_utils::get_gator_mode()==GATORMODE_NORMAL*/)
  {
   string order_comment=OrderComment();
   
   double order_low=order_comment==""?g_buy_loc_min:NormalizeDouble(StringToDouble(order_comment),Digits);
   
   double diff=g_buy_max-order_low;
   
   if(diff>0)//Текущая цена выше стартовой точки
   {
    diff-=diff*fibo_coef;
    //double sl=MathMin(NormalizeDouble(b.low,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
    double sl=MathMin(NormalizeDouble(order_low+diff-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));

    if(sl>OrderStopLoss())   
     if(OrderModify(OrderTicket(),OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
      modify_success++;
   }
  }
  
  if(order_type==OP_SELL/* &&
     ax_bar_utils::get_bar_gator_position(b,BARPOSITION_UNDERGATOR,BARPOSITIONMODE_FULL) &&
     ax_bar_utils::get_gator_mode()==GATORMODE_REVERSAL*/)
  {
   string order_comment=OrderComment();
   
   double order_high=order_comment==""?g_sell_loc_max:NormalizeDouble(StringToDouble(order_comment),Digits);
   
   double diff=order_high-g_sell_min;
   
   if(diff>0)//текущая цена ниже стартовой точки
   {
    diff-=diff*fibo_coef;
    //double sl=MathMax(NormalizeDouble(b.high,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));
    double sl=MathMax(NormalizeDouble(order_high-diff+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));

    if(sl<OrderStopLoss())   
     if(OrderModify(OrderTicket(),OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
      modify_success++;
   }
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-modify_success)<0?0:(cnt-modify_success);//сколько осталось не модифицированных
}

//--------------------------------------------------------------------
static int ax_bar_utils::SetAllOrderSLbyFibo3(int op_type,double v)
{
 ax_bar_utils::WriteFile("=== SetAllOrderSLbyFibo3 (start)===");
 
 ax_bar_utils::WriteFile("op_type="+(op_type==OP_BUY?"OP_BUY":"OP_SELL")+" v="+DoubleToString(v));
 
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_failed=0;
 
 int cnt=OrdersTotal();
 
 ax_bar_utils::WriteFile("OrdersTotal="+IntegerToString(cnt));
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderSymbol()!=Symbol())
   continue;
   
  int order_type =OrderType();
  
  int ticket     =OrderTicket();
  
  ax_bar_utils::WriteFile("OrderType="+IntegerToString(order_type)+
                          " OrderTicket="+IntegerToString(ticket)+
                          " axGetOrderByRSI="+DoubleToString(axGetOrderByRSI(Symbol(),ticket)));
  
  if(order_type==op_type && op_type==OP_BUY/* && v>axGetOrderByRSI(Symbol(),ticket)*/)
  {
   double order_low =axGetOrderSL(Symbol(),ticket);
   
   double diff      =v-order_low;
   
   if(diff>0)//Текущая цена выше стартовой точки
   {
    double fibo=g_fibo_coefs[axGetOrderFiboLevel(Symbol(),ticket)];
    
    diff-=diff*fibo;

    double sl=MathMin(NormalizeDouble(order_low+diff-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
    
    ax_bar_utils::WriteFile("sl="+DoubleToString(sl)+" OrderStopLoss="+DoubleToString(OrderStopLoss()));

    if(sl>OrderStopLoss())
    {
     if(OrderModify(ticket,OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
     {
      axSetOrderFiboLevel(Symbol(),ticket,ax_bar_utils::get_next_fibo((fibo_levels)axGetOrderFiboLevel(Symbol(),ticket)));
    
      axSetOrderByRSI(Symbol(),ticket,v);
     }
     else
     {
      modify_failed++;      
      ax_bar_utils::WriteFile(ax_bar_utils::err_msg());
     }
    }
   }
  }
  
  if(order_type==op_type && op_type==OP_SELL/* && v<axGetOrderByRSI(Symbol(),ticket)*/)
  {
   double order_high =axGetOrderSL(Symbol(),ticket);
   
   double diff       =order_high-v;
   
   if(diff>0)//текущая цена ниже стартовой точки
   {
    double fibo=g_fibo_coefs[axGetOrderFiboLevel(Symbol(),ticket)];
    
    diff-=diff*fibo;

    double sl=MathMax(NormalizeDouble(order_high-diff+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));

    ax_bar_utils::WriteFile("sl="+DoubleToString(sl)+" OrderStopLoss="+DoubleToString(OrderStopLoss()));
    
    if(sl<OrderStopLoss())
    {
     if(OrderModify(ticket,OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
     {
      axSetOrderFiboLevel(Symbol(),ticket,ax_bar_utils::get_next_fibo((fibo_levels)axGetOrderFiboLevel(Symbol(),ticket)));
    
      axSetOrderByRSI(Symbol(),ticket,v);
     }
     else
     {
      modify_failed++;  
      ax_bar_utils::WriteFile(ax_bar_utils::err_msg());
     }
    }
   }
  }
 }//for
 
 ax_bar_utils::WriteFile("=== SetAllOrderSLbyFibo3 (finish)===");
 
 return modify_failed;//сколько было модификаций с ошибками
}

//--------------------------------------------------------------------
static int ax_bar_utils::SetAllOrderSLbyFrac(double frac_sl,int op_type)
{
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_success=0;
 
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  int order_type=OrderType();

  if(order_type==op_type/* && //OP_BUY
     ax_bar_utils::get_bar_gator_position(b,BARPOSITION_ABOVEGATOR,BARPOSITIONMODE_FULL) &&
     ax_bar_utils::get_gator_mode()==GATORMODE_NORMAL*/)
  {
   double sl=MathMin(NormalizeDouble(frac_sl-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
   
   if(sl>OrderStopLoss())
    if(OrderModify(OrderTicket(),OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
      modify_success++;
  }
  
  if(order_type==op_type/* && //OP_SELL
     ax_bar_utils::get_bar_gator_position(b,BARPOSITION_UNDERGATOR,BARPOSITIONMODE_FULL) &&
     ax_bar_utils::get_gator_mode()==GATORMODE_REVERSAL*/)
  {
   double sl=MathMax(NormalizeDouble(frac_sl+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));

   if(sl<OrderStopLoss())
    if(OrderModify(OrderTicket(),OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
     modify_success++;
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-modify_success)<0?0:(cnt-modify_success);//сколько осталось не модифицированных
}

//--------------------------------------------------------------------
static int ax_bar_utils::SetAllOrderSLbyValue(double sl_val,int op_type)
{
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_success=0;
 
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderTakeProfit()!=0)
   continue;
   
  int order_type=OrderType();
  
  string comment=OrderComment();

  if(order_type==op_type && op_type==OP_BUY)
  {
   double sl=MathMin(NormalizeDouble(sl_val-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Bid-(minstoplevel+1)*Point,Digits));
   double tp=comment=="DIRECT"?0:OrderTakeProfit();
   
   //if(sl<OrderOpenPrice())
   // sl=OrderOpenPrice();
   
   if(sl>OrderStopLoss() && OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,OrderExpiration()))
    modify_success++;
  }
  
  if(order_type==op_type && op_type==OP_SELL)
  {
   double sl=MathMax(NormalizeDouble(sl_val+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Ask+(minstoplevel+1)*Point,Digits));
   double tp=comment=="DIRECT"?0:OrderTakeProfit();

   //if(sl>OrderOpenPrice())
   // sl=OrderOpenPrice();
    
   if(sl<OrderStopLoss() && OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,OrderExpiration()))
    modify_success++;
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-modify_success)<0?0:(cnt-modify_success);//сколько осталось не модифицированных
}

//--------------------------------------------------------------------
static int ax_bar_utils::SetAllOrderSLbyValue(sl_mode slm,double sl_val)
{
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_success=0;
 
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderTakeProfit()!=0)
   continue;
   
  int order_type=OrderType();
  
  string comment=OrderComment();

  if(order_type==OP_BUY)
  {
   if((comment=="DIRECT" && (slm==SLMODE_CROSSGATOR_DOWNUP||slm==SLMODE_LOCALEXT_MIN_ABOVEGATOR)) || (comment=="REVERSE" && slm==SLMODE_LOCALEXT_MIN_UNDERGATOR))
   {
    double sl=MathMin(NormalizeDouble(sl_val-ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Bid-(minstoplevel+1)*Point,Digits));
   
    if(sl>OrderStopLoss() && OrderModify(OrderTicket(),OrderOpenPrice(),sl,0,OrderExpiration()))
     modify_success++;
   }
  }
  
  if(order_type==OP_SELL)
  {
   if((comment=="DIRECT" && (slm==SLMODE_CROSSGATOR_UPDOWN||slm==SLMODE_LOCALEXT_MAX_ABOVEGATOR)) || (comment=="REVERSE" && slm==SLMODE_LOCALEXT_MAX_UNDERGATOR))
   {
    double sl=MathMax(NormalizeDouble(sl_val+ax_bar_utils::get_delta_points()*Point,Digits),NormalizeDouble(Ask+(minstoplevel+1)*Point,Digits));

    if(sl<OrderStopLoss() && OrderModify(OrderTicket(),OrderOpenPrice(),sl,0,OrderExpiration()))
     modify_success++;
   }
  }
 }
 
 cnt=OrdersTotal();
 
 return (cnt-modify_success)<0?0:(cnt-modify_success);//сколько осталось не модифицированных
}

//--------------------------------------------------------------------
static int ax_bar_utils::SetAllOrderSLbyATR(MqlRates& bar,int op_type)
{
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_failed=0;
 
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderSymbol()!=Symbol())
   continue;
   
  int order_type =OrderType();
  
  int ticket     =OrderTicket();
  
  if(order_type==op_type && op_type==OP_BUY)
  {
   double sl=MathMin(bar.low-2.618*NormalizeDouble(iATR(Symbol(),0,14,1),Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
   
   if(sl>axGetOrderSL(Symbol(),ticket))//не должен быть меньше стартового
   { 
    if(!OrderModify(ticket,OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
     modify_failed++;
   }
  }
  
  if(order_type==op_type && op_type==OP_SELL)
  {
   double sl=MathMax(bar.high+2.618*NormalizeDouble(iATR(Symbol(),0,14,1),Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));

   if(sl<axGetOrderSL(Symbol(),ticket))//не должен быть больше стартового
   { 
    if(!OrderModify(ticket,OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
     modify_failed++;
   }
  }
 }//for
 
 return modify_failed;//сколько было модификаций с ошибками
}

//--------------------------------------------------------------------
static int ax_bar_utils::SetAllOrderSLbyATR2(int op_type,double v)
{
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_failed=0;
 
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderSymbol()!=Symbol())
   continue;
   
  int order_type =OrderType();
  
  int ticket     =OrderTicket();
  
  if(order_type==op_type && op_type==OP_BUY)
  {
   double sl=MathMin(NormalizeDouble(v,Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
   
   if(sl>axGetOrderSL(Symbol(),ticket))//не должен быть меньше стартового
   { 
    if(!OrderModify(ticket,OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
     modify_failed++;
   }
  }
  
  if(order_type==op_type && op_type==OP_SELL)
  {
   double sl=MathMax(NormalizeDouble(v,Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));

   if(sl<axGetOrderSL(Symbol(),ticket))//не должен быть больше стартового
   { 
    if(!OrderModify(ticket,OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
     modify_failed++;
   }
  }
 }//for
 
 return modify_failed;//сколько было модификаций с ошибками
}

//--------------------------------------------------------------------
static int ax_bar_utils::SetAllOrderSLbyATR3(MqlRates& bar,int op_type)
{
 double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 int modify_failed=0;
 
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderSymbol()!=Symbol())
   continue;
   
  if(OrderProfit()<=0)//меняем SL у тех ордеров, которые уже что-то имеют в плюсе
   continue;
   
  int order_type =OrderType();
  
  int ticket     =OrderTicket();
  
  if(order_type==op_type && op_type==OP_BUY)
  {
   double sl=MathMin(bar.low-2.618*NormalizeDouble(iATR(Symbol(),0,14,1),Digits),NormalizeDouble(Bid-minstoplevel*Point,Digits));
   
   if(sl>axGetOrderSL(Symbol(),ticket))//не должен быть меньше стартового
   { 
    if(!OrderModify(ticket,OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
     modify_failed++;
   }
  }
  
  if(order_type==op_type && op_type==OP_SELL)
  {
   double sl=MathMax(bar.high+2.618*NormalizeDouble(iATR(Symbol(),0,14,1),Digits),NormalizeDouble(Ask+minstoplevel*Point,Digits));

   if(sl<axGetOrderSL(Symbol(),ticket))//не должен быть больше стартового
   { 
    if(!OrderModify(ticket,OrderOpenPrice(),sl,OrderTakeProfit(),OrderExpiration()))
     modify_failed++;
   }
  }
 }//for
 
 return modify_failed;//сколько было модификаций с ошибками
}

//--------------------------------------------------------------------
static int ax_bar_utils::RemoveAllOrders()
{
 int remove_success=0;
 
 int cnt=OrdersTotal();
 
 Comment("CNT:"+IntegerToString(cnt));
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderDelete(OrderTicket()))
   remove_success++;
 }
 
 return remove_success;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::OrderExists(int op_type)
{
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderType()==op_type)
   return true;
 }
 
 return false;
}

//-------------------------------------------------------------------- 
static string ax_bar_utils::err_msg()
{
 int err=GetLastError();
 
 return err==ERR_NO_ERROR?"":"("+IntegerToString(err)+")"+ErrorDescription(err);
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::gator_sleeps(double gator_sleep_coef)
{
 //получаем значение Алигатора
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,1),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,1),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,1),Digits);
 
 double max_val =ax_bar_utils::get_max(lips,teeth,jaw);
 double min_val =ax_bar_utils::get_min(lips,teeth,jaw);
 
 return max_val/min_val<gator_sleep_coef;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::gator_waked_up(double gator_wake_up_coef)
{
 //получаем значение Алигатора
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,1),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,1),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,1),Digits);
 
 double max_val =ax_bar_utils::get_max(lips,teeth,jaw);
 double min_val =ax_bar_utils::get_min(lips,teeth,jaw);
 
 return max_val/min_val>gator_wake_up_coef;
}

//-------------------------------------------------------------------- 
static double ax_bar_utils::get_gator_wake_coef()
{
 /*
 EURUSD
 GBPUSD
 USDJPY
 USDCHF
 AUDUSD
 NZDUSD
 USDCAD
 CL
 BRN
 XAUUSD
 PL
 NQ
 YM
 NKD 
 */
 string s=Symbol();
 
 StringToUpper(s);
 
 if(s=="EURUSD")
  return 1.0001;
  
 if(s=="GBPUSD")
  return 1.0009;
  
 if(s=="USDJPY")
  return 1.0017;

 if(s=="USDCHF")
  return 1.0045;
  
 if(s=="AUDUSD")
  return 1.0005;
  
 if(s=="NZDUSD")
  return 1.0037;
  
 if(s=="USDCAD")
  return 1.0024;
  
 if(s=="CL")
  return 1.0024;
  
 if(s=="BRN")
  return 1.0012;
  
 if(s=="XAUUSD")
  return 1.0002;
  
 if(s=="PL")
  return 1.0035;
  
 if(s=="NQ")
  return 1.0045;
  
 if(s=="YM")
  return 1.0023;
  
 if(s=="NKD")
  return 1.0034;

 return 1.0001;
}

//-------------------------------------------------------------------- 
static void ax_bar_utils::WriteFile(string msg)
{
 if(g_logging)
 { 
  string s=TimeToString(TimeCurrent())+":"+msg;
  
  if(IsTesting())
   Print(s);
  else
  {
   FileWrite(g_handle,s);
   FileFlush(g_handle);
  }
 }
}

//-------------------------------------------------------------------- 
static void ax_bar_utils::WriteFile(int handle,string msg)
{
 FileWrite(handle,TimeToString(TimeCurrent())+":"+msg);
 //FileWrite(handle,msg); 
 FileFlush(handle);
}

//-------------------------------------------------------------------- 
static void ax_bar_utils::GetGatorStat(int handle,int shift)
{
 MqlRates mqlrates[];

 ArrayCopyRates(mqlrates,Symbol(),Period());
 
 for(int s=0;s<shift;s++)
 {
  double lips=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,s);
  double teeth=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,s);
  double jaw=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,s);
  
  double max_val=ax_bar_utils::get_max(lips,teeth,jaw);
  double min_val=ax_bar_utils::get_min(lips,teeth,jaw);
  
  string msg=DoubleToString(max_val/min_val,12);
 
  MqlRates bar=mqlrates[s]; 
  
  msg+=CharToString(9)+TimeToString(bar.time);
  
  ax_bar_utils::WriteFile(handle,msg);
 }
}

//-------------------------------------------------------------------- 
static double ax_bar_utils::get_gator_wake_up_val()
{
 switch(Period())
 {
  case PERIOD_M1:  return 1.00006;
  case PERIOD_M5:  return 1.001;
  case PERIOD_M15: return 1.001;
  case PERIOD_M30: return 1.001;
  case PERIOD_H1:  return 1.002;
  default: return 1.003;
/*  case PERIOD_M1: return 1.0006;
  case PERIOD_M5: return 1.00065;
  case PERIOD_M15: return 1.001;
  case PERIOD_M30: return 1.002;
  default: return 1.003;*/
/*  case PERIOD_H1:
  case PERIOD_H4:
  case PERIOD_D1:
  case PERIOD_W1:
  case PERIOD_MN1:*/
 } 
}

//-------------------------------------------------------------------- 
static double ax_bar_utils::get_gator_sleep_val()
{
 switch(Period())
 {
  case PERIOD_M1:  return 1.000006;
  case PERIOD_M5:  return 1.0001;
  case PERIOD_M15: return 1.00009;
  case PERIOD_M30: return 1.0002;//return 1.0007;
  case PERIOD_H1:  return 1.0007;
  default: return 1.0003; 
 }
}

//-------------------------------------------------------------------- 
static double ax_bar_utils::rad_to_grad(double rad)
{
 const double pi=3.1415926535;

 return rad*180/pi;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::is_angulation(MqlRates& b,bar_types bt,double& angle)
{
 angle=0;
 
 if(bt==BARTYPE_NONE)
  return false;
  
 //пытаемся определить точку пересечения гатор с каким-то баром назад
 MqlRates bars[];
 
 int bars_count=ArrayCopyRates(bars,NULL,0);
 
 double bar_val=(bt==BARTYPE_BULLISH)?b.high:b.low;
 
 for(int i=1;i<bars_count;i++)
 {
  double avg_gator;//среднее значение гатора в точке пересечения с графиком (точка 0)
  
  if(ax_bar_utils::is_bar_over_gator(bars[i],i,avg_gator))//график пересек график
  {
   double teeth=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,1);
   double jaw=iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,1);
   
   double teeth_jaw_val=(teeth+jaw)/2;
   
   double y1=MathAbs(avg_gator-bar_val)*MathPow(10,Digits);
   double y2=MathAbs(avg_gator-teeth_jaw_val)*MathPow(10,Digits);
   
   datetime cur_time=TimeCurrent();
   datetime past_time=bars[i].time;
   
   int secs=(int)(cur_time-past_time);
   
   double x1=secs;
   double x2=secs;  
   
   double cos_fi=MathAbs(x1*x2+y1*y2)/(MathSqrt(x1*x1+y1*y1)*MathSqrt(x2*x2+y2*y2));
   
   angle=ax_bar_utils::rad_to_grad(MathArccos(cos_fi));
   
   //фильтруем значение angle
   
   return true;
  }
 }
 
 return false;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::is_bar_over_gator(MqlRates& b,int shift,double& avg_gator)
{
 avg_gator=0;
 
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,shift),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,shift),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,shift),Digits);
 
 double max =ax_bar_utils::get_max(lips,teeth,jaw);
 double min =ax_bar_utils::get_min(lips,teeth,jaw);

 if(max<=b.high && min>=b.low)
 {
  avg_gator=(max+min)/2;
  return true;
 }
 
 return false;
}

//-------------------------------------------------------------------- 
static ac_mode ax_bar_utils::get_ac_mode(int timeframe)
{
 double v1=iAC(NULL,timeframe,1);//-1
 double v2=iAC(NULL,timeframe,2);//-2
 double v3=iAC(NULL,timeframe,3);//-3
 double v4=iAC(NULL,timeframe,4);//-4
 
 if(v1>0&&v2>0&&v1>v2&&v2>v3)
  return ACMODE_GREEN2;
  
 if(v1<0&&v2<0&&v1<v2&&v2<v3)
  return ACMODE_RED2;
  
 if(v1<0&&v2<0&&v3<0&&v1>v2&&v2>v3&&v3>v4)
  return ACMODE_GREEN3;
  
 if(v1>0&&v2>0&&v3>0&&v1<v2&&v2<v3&&v3<v4)
  return ACMODE_RED3;

 return ACMODE_NONE;  
}

//-------------------------------------------------------------------- 
static ac_mode ax_bar_utils::get_ac_mode2()
{
 double v1=iAC(NULL,0,1);//-1
 double v2=iAC(NULL,0,2);//-2
 double v3=iAC(NULL,0,3);//-3
 double v4=iAC(NULL,0,4);//-4
 
 if(v1>0&&v2>0&&v1>v2&&v2>v3)
  return ACMODE_GREEN2;
  
 if(v1<0&&v2<0&&v1<v2&&v2<v3)
  return ACMODE_RED2;
  
 if(v1>0&&v2<0&&v3<0&&v1>v2&&v2>v3&&v3>v4)
  return ACMODE_GREEN3;
  
 if(v1<0&&v2>0&&v3>0&&v1<v2&&v2<v3&&v3<v4)
  return ACMODE_RED3;

 return ACMODE_NONE;  
}

//-------------------------------------------------------------------- 
static ac_mode ax_bar_utils::get_ac_mode3()
{
 double v1=iAC(NULL,0,1);//-1
 double v2=iAC(NULL,0,2);//-2
 double v3=iAC(NULL,0,3);//-3
 double v4=iAC(NULL,0,4);//-4
 
 if(v1>0&&v2>0&&v1>v2&&v2>v3&&v3<0)
  return ACMODE_GREEN2;
  
 if(v1<0&&v2<0&&v1<v2&&v2<v3&&v3>0)
  return ACMODE_RED2;
  
 if(v1<0&&v2<0&&v3<0&&v1>v2&&v2>v3&&v3<v4)
  return ACMODE_GREEN3;
  
 if(v1>0&&v2>0&&v3>0&&v1<v2&&v2<v3&&v3>v4)
  return ACMODE_RED3;

 return ACMODE_NONE;  
}

//-------------------------------------------------------------------- 
static ac_mode ax_bar_utils::get_ac_mode4()
{
 double v1=iAC(NULL,0,1);//-1
 double v2=iAC(NULL,0,2);//-2
 double v3=iAC(NULL,0,3);//-3
 double v4=iAC(NULL,0,4);//-4
 double v5=iAC(NULL,0,5);//-5
 
 if(v1>0&&v2>0&&v1>v2&&v2>v3&&v3<0)
  return ax_bar_utils::__period()?ACMODE_GREEN2:ACMODE_NONE;
  
 if(v1<0&&v2<0&&v1<v2&&v2<v3&&v3>0)
  return ax_bar_utils::__period()?ACMODE_RED2:ACMODE_NONE;
 
 if(ax_bar_utils::__period()) 
 {
 if(v1<0&&v2<0&&v3<0&&v1>v2&&v2>v3&&v3>v4&&v4<v5)
  return ACMODE_GREEN3;
  
 if(v1>0&&v2>0&&v3>0&&v1<v2&&v2<v3&&v3<v4&&v4>v5)
  return ACMODE_RED3;
 }
 else
 {
 if(v1<0&&v2<0&&v3<0&&v1>v2&&v2>v3&&v3<v4)
  return ACMODE_GREEN3;
  
 if(v1>0&&v2>0&&v3>0&&v1<v2&&v2<v3&&v3>v4)
  return ACMODE_RED3;
 }

 return ACMODE_NONE;  
}

//-------------------------------------------------------------------- 
static ac_mode ax_bar_utils::get_ac_mode5()
{
 double v1=iAC(NULL,0,1);//-1
 double v2=iAC(NULL,0,2);//-2
 double v3=iAC(NULL,0,3);//-3
 double v4=iAC(NULL,0,4);//-4
 
 /*if(v1>0&&v2>0&&v1>v2&&v2>v3&&v3<0)
  return ax_bar_utils::__period()?ACMODE_GREEN2:ACMODE_NONE;
  
 if(v1<0&&v2<0&&v1<v2&&v2<v3&&v3>0)
  return ax_bar_utils::__period()?ACMODE_RED2:ACMODE_NONE;*/
 
 if((v1<0&&v2<0&&v1>v2&&v2>v3&&v3<v4) || (v1<0&&v2<0&&v3<0&&v1>v2&&v2>v3&&v3>v4))
  return ACMODE_GREEN3;
  
 if((v1>0&&v2>0&&v1<v2&&v2<v3&&v3>v4) || (v1>0&&v2>0&&v3>0&&v1<v2&&v2<v3&&v3<v4))
  return ACMODE_RED3;

 return ACMODE_NONE;  
}

//-------------------------------------------------------------------- 
static ac_mode ax_bar_utils::get_ac_mode6(int timeframe)
{
 double v1=iAC(NULL,timeframe,1);//-1
 double v2=iAC(NULL,timeframe,2);//-2
 double v3=iAC(NULL,timeframe,3);//-3
 //double v4=iAC(NULL,0,4);//-4
 
 if(v1<0&&v2<0&&v1>v2&&v2<v3)
  return ACMODE_REDGREEN_NEGATIVE;
  
 if(v1>0&&v2>0&&v1<v2&&v2>v3)
  return ACMODE_GREENRED_POSITIVE;
  
 return ACMODE_NONE;  
}

//-------------------------------------------------------------------- 
static ac_sign_mode ax_bar_utils::get_ac_sign_mode(int timeframe)
{
 double v=iAC(NULL,timeframe,1);//-1
 
 if(v==0)
  return ACSIGNMODE_ZERO;
  
 return (v>0)?ACSIGNMODE_POSITIVE:ACSIGNMODE_NEGATIVE;
}

//-------------------------------------------------------------------- 
static ac_mode ax_bar_utils::get_ac_mode_simple(int timeframe)
{
 double v1=iAC(NULL,timeframe,1);//-1
 double v2=iAC(NULL,timeframe,2);//-2
 
 if(v1>v2)
  return ACMODE_GREEN;
  
 if(v1<v2)
  return ACMODE_RED;
  
 return ACMODE_NONE;
}

//-------------------------------------------------------------------- 
static bar_reversal_type ax_bar_utils::get_bar_reversal_type(MqlRates& ready_bar, MqlRates& prev_bar)
{
 bar_types bt=ax_bar_utils::get_type(ready_bar,prev_bar);
 
 if(bt==BARTYPE_NONE)
  return BARREVERSAL_NONE;
 
 if(bt==BARTYPE_BULLISH&&ax_bar_utils::is_out_of_gator(ready_bar,bt))
  return BARREVERSAL_BULLISH;
  
 if(bt==BARTYPE_BEARISH&&ax_bar_utils::is_out_of_gator(ready_bar,bt))
  return BARREVERSAL_BEARISH;

 return BARREVERSAL_NONE;
}

//--------------------------------------------------------------------
static void ax_bar_utils::get_dummy_bar(MqlRates& dummy_bar,trade_mode tm,int mode)
{
 MqlRates rates[];
 
 ArrayCopyRates(rates,NULL,0);
 
 if(tm==TRADEMODE_BUY)
 {
  dummy_bar.high =rates[1].high;
//  dummy_bar.low  =MathMin(ax_bar_utils::get_min(rates[1].low,rates[2].low,rates[3].low),MathMin(rates[4].low,rates[5].low));
  dummy_bar.low  =(mode==3)?MathMin(ax_bar_utils::get_min(rates[1].low,rates[2].low,rates[3].low),MathMin(rates[4].low,rates[5].low)):
//  dummy_bar.low  =(mode==3)?rates[1].low:
//                            MathMin(rates[1].low,rates[2].low);
                            ax_bar_utils::get_min(rates[1].low,rates[2].low,rates[3].low);
//                            rates[1].low;
 }
 else
 {
//  dummy_bar.high =MathMax(ax_bar_utils::get_max(rates[1].high,rates[2].high,rates[3].high),MathMax(rates[4].high,rates[5].high));
  dummy_bar.high =(mode==3)?MathMax(ax_bar_utils::get_max(rates[1].high,rates[2].high,rates[3].high),MathMax(rates[4].high,rates[5].high)):
//  dummy_bar.high =(mode==3)?rates[1].high:
//                            MathMax(rates[1].high,rates[2].high);
                            ax_bar_utils::get_max(rates[1].high,rates[2].high,rates[3].high);
//                            rates[1].high;
  dummy_bar.low  =rates[1].low;
 }
 //dummy_bar.open=ax_bar_utils::get_min(rates[1].open,rates[2].open,rates[3].open);//эти значения нас не интересуют
 //dummy_bar.close=ax_bar_utils::get_max(rates[1].close,rates[2].close,rates[3].close);//эти значения нас не интересуют
 dummy_bar.open=0;//эти значения нас не интересуют
 dummy_bar.close=0;//эти значения нас не интересуют
}

//--------------------------------------------------------------------
static int ax_bar_utils::get_more_period()
{
 switch(Period())
 {
  /*
  case PERIOD_M1: return PERIOD_M5;
  case PERIOD_M5: return PERIOD_M15;
  case PERIOD_M15: return PERIOD_M30;
  case PERIOD_H1: return PERIOD_H4;
  case PERIOD_D1: return PERIOD_W1;
  */
  ///*  
  case PERIOD_M1: return PERIOD_M5;
  case PERIOD_M5: return PERIOD_M15;
  case PERIOD_M15: return PERIOD_H1;
  case PERIOD_H1: return PERIOD_H4;
  case PERIOD_D1: return PERIOD_W1;
  //*/
 }
 
 return Period();
}

//--------------------------------------------------------------------
static int ax_bar_utils::get_less_period()
{
 switch(Period())
 {
  case PERIOD_M1: return PERIOD_M1;
  case PERIOD_M5: return PERIOD_M1;
  case PERIOD_M15: return PERIOD_M5;
  case PERIOD_H1: return PERIOD_M15;
  case PERIOD_D1: return PERIOD_H4;
 }
 
 return Period();
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_local_extremum(MqlRates& rates[],trade_mode tm,int ma_method,int start_shift)
{
 int ext_shift; 
 return ax_bar_utils::get_local_extremum(rates,tm,ext_shift,ma_method,start_shift);
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_local_extremum(MqlRates& rates[],trade_mode tm,int& ext_shift,int ma_method,int start_shift)
{
 ext_shift=-1;
 
 double loc_ext=(tm==TRADEMODE_BUY)?rates[start_shift].low:rates[start_shift].high;
 
 double gator;
 
 bool f=false;
 
 for(int i=start_shift;;i++)
 {
  if(tm==TRADEMODE_BUY)
  {
   gator=NormalizeDouble(ax_bar_utils::get_min(iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORLIPS,i),
                                               iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORTEETH,i),
                                               iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORJAW,i)),Digits);   
   if(rates[i].low<gator && rates[i].high<gator)
    f=true;
    
   if(rates[i].low>gator && f)
    break;
    
   if(rates[i].low<loc_ext)
   {
    loc_ext=rates[i].low;
    ext_shift=i;
   }
  }
  
  if(tm==TRADEMODE_SELL)
  {
   gator=NormalizeDouble(ax_bar_utils::get_max(iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORLIPS,i),
                                               iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORTEETH,i),
                                               iAlligator(NULL,0,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORJAW,i)),Digits);   
   if(rates[i].high>gator && rates[i].low>gator)
    f=true;
    
   if(rates[i].high<gator && f)
    break;
    
   if(rates[i].high>loc_ext)
   {
    loc_ext=rates[i].high;
    ext_shift=i;
   }
  }
 }
 
 return loc_ext;
}

//--------------------------------------------------------------------
static int ax_bar_utils::find_order(ac_mode ac)
{
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderComment()==EnumToString(ac))
   return OrderTicket();
 }
 
 return -1;
}

//--------------------------------------------------------------------
static gator_mode ax_bar_utils::get_gator_mode(ax_settings& stgs,int shift)
{
 double lips  =ax_bar_utils::get_gator_val(stgs,MODE_GATORLIPS,1);
 double teeth =ax_bar_utils::get_gator_val(stgs,MODE_GATORTEETH,1);
 double jaw   =ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,1);
 
 if(lips>teeth && teeth>jaw)
  return GATORMODE_NORMAL;
  
 if(lips<teeth && teeth<jaw)
  return GATORMODE_REVERSAL;
  
 return GATORMODE_NONE;
}

//--------------------------------------------------------------------
static bar_types ax_bar_utils::get_gator_bar_cross_mode(MqlRates& rates[],int gm,int shift)
{
 double gator_val=0;
 
 if(gm==MODE_GATORLIPS)
  gator_val=NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,shift),Digits);
  
 if(gm==MODE_GATORTEETH)
  gator_val=NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,shift),Digits);
  
 if(gm==MODE_GATORJAW)
  gator_val=NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,shift),Digits);
 
 MqlRates bar=rates[shift];
 
 if(!(bar.high>gator_val && bar.low<gator_val))//gator не пересекает
  return BARTYPE_NONE;
  
 return ax_bar_utils::get_type2(bar);
}

//--------------------------------------------------------------------
static fibo_levels ax_bar_utils::get_next_fibo(fibo_levels current_fibo)
{
 switch(current_fibo)
 {
  case FIBO_100: return FIBO_618;
  case FIBO_618: return FIBO_500;
  case FIBO_500: return FIBO_382;
  case FIBO_382: return FIBO_236;  
 }
 
 return FIBO_236;
}

//--------------------------------------------------------------------
static fibo_levels ax_bar_utils::get_next_fibo(fibo_levels current_fibo,double& coef)
{
 switch(current_fibo)
 {
  case FIBO_100: coef=g_fibo_coefs[FIBO_100]; return FIBO_618;
  case FIBO_618: coef=g_fibo_coefs[FIBO_618]; return FIBO_500;
  case FIBO_500: coef=g_fibo_coefs[FIBO_500]; return FIBO_382;
  case FIBO_382: coef=g_fibo_coefs[FIBO_382]; return FIBO_236;  
 }
 
 coef=g_fibo_coefs[FIBO_236];
 
 return FIBO_236;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_fractal(MqlRates& rates[],int mode)
{
 int shift=3;
 
 double frac=iFractals(NULL,0,mode,shift);
 
 if(frac==0)
  return 0;
  
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,shift),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,shift),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,shift),Digits);
 
 if(mode==MODE_UPPER)
 {
  if(rates[1].high<rates[2].high && rates[2].high<rates[3].high && frac>ax_bar_utils::get_max(lips,teeth,jaw))
   return frac;
 }
 else
 if(mode==MODE_LOWER)
 {
  if(rates[1].low>rates[2].low && rates[2].low>rates[3].low && frac<ax_bar_utils::get_min(lips,teeth,jaw))
   return frac;
 }
 
 return 0;
}

//--------------------------------------------------------------------
static void ax_bar_utils::SweepOrderArray()
{
 int cnt=OrdersTotal();
 
 for(int i=0;i<cnt;i++)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
   continue;
   
  axRemoveOrder(Symbol(),OrderTicket());
 }
}

//--------------------------------------------------------------------
static rsi_mode ax_bar_utils::get_rsi_mode(ax_settings& stgs,int shift)
{
 double iVal     =iDeMarker(NULL,0,stgs.dem_period,shift);
 double iPrevVal =iDeMarker(NULL,0,stgs.dem_period,shift+1);
 
 if(iPrevVal<=stgs.dem_upper_level && iVal>stgs.dem_upper_level)
  return RSIMODE_MIDDLE_UPPER;
  
 if(iPrevVal>stgs.dem_upper_level && iVal<=stgs.dem_upper_level)
  return RSIMODE_UPPER_MIDDLE;
 
 if(iVal>stgs.dem_upper_level)
  return RSIMODE_UPPER;
  
 if(iPrevVal>=stgs.dem_lower_level && iVal<stgs.dem_lower_level)
  return RSIMODE_MIDDLE_LOWER;
  
 if(iPrevVal<stgs.dem_lower_level && iVal>=stgs.dem_lower_level)
  return RSIMODE_LOWER_MIDDLE;

 if(iVal<stgs.dem_lower_level)
  return RSIMODE_LOWER;
 /*
 double upper_level=0.7;
 double lower_level=0.3;
 
 double rsi=iRSI(NULL,0,g_rsi_period,PRICE_CLOSE,1)/100;
 double prev_rsi=iRSI(NULL,0,g_rsi_period,PRICE_CLOSE,2)/100;
 
 double dem=iDeMarker(NULL,0,g_demark_period,1);
 double prev_dem=iDeMarker(NULL,0,g_demark_period,2);
 
 double iVal=MathMax(rsi,dem);
 double iPrevVal=MathMax(prev_rsi,prev_dem);
 
 if(iPrevVal<=upper_level && iVal>upper_level)
  return RSIMODE_MIDDLE_UPPER;
  
 if(iPrevVal>upper_level && iVal<=upper_level)
  return RSIMODE_UPPER_MIDDLE;
 
 if(iVal>upper_level)
  return RSIMODE_UPPER;
  
 iVal=MathMin(rsi,dem);
 iPrevVal=MathMin(prev_rsi,prev_dem);
 
 if(iPrevVal>=lower_level && iVal<lower_level)
  return RSIMODE_MIDDLE_LOWER;
  
 if(iPrevVal<lower_level && iVal>=lower_level)
  return RSIMODE_LOWER_MIDDLE;

 if(iVal<lower_level)
  return RSIMODE_LOWER;
 */
 /*
 if((prev_rsi<=upper_level && rsi>upper_level) || (prev_dem<=upper_level && dem>upper_level))
  return RSIMODE_MIDDLE_UPPER;
 
 if((prev_rsi>upper_level && rsi<=upper_level) || (prev_dem>upper_level && dem<=upper_level))
  return RSIMODE_UPPER_MIDDLE;
 
 if((prev_rsi>=lower_level && rsi<lower_level) || (prev_dem>=lower_level && dem<lower_level))
  return RSIMODE_MIDDLE_LOWER;
  
 if((prev_rsi<lower_level && rsi>=lower_level) || (prev_dem<lower_level && dem>=lower_level))
  return RSIMODE_LOWER_MIDDLE;
 
 if(rsi>upper_level || dem>upper_level)
  return RSIMODE_UPPER;
  
 if(rsi<lower_level || dem<lower_level)
  return RSIMODE_LOWER;
 */
 
 return RSIMODE_NONE;
}

//--------------------------------------------------------------------
static rsi_mode ax_bar_utils::get_rsi_mode2(ax_settings& stgs,int shift)
{
 double rsi_level=0.5;

 double iVal=iDeMarker(NULL,0,stgs.dem_period,shift);
 
 if(iVal>rsi_level)
  return RSIMODE_UPPER;
  
 if(iVal<rsi_level)
  return RSIMODE_LOWER;
  
 return RSIMODE_NONE;
}

//--------------------------------------------------------------------
static sl_mode ax_bar_utils::get_sl_mode(MqlRates& rates[],double& sl_val)
{
 sl_val=0;
 
 MqlRates ready_bar=rates[1];
 
 double lips  =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,1),Digits);
 double teeth =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,1),Digits);
 double jaw   =NormalizeDouble(iAlligator(NULL,0,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,1),Digits);
 
 if(ready_bar.low<=teeth && teeth<=ready_bar.high)
 {
  sl_val=teeth;
  return lips<jaw?SLMODE_CROSSGATOR_DOWNUP:SLMODE_CROSSGATOR_UPDOWN;
 }
 
 if(rates[3].low>=rates[2].low && rates[2].low<=rates[1].low)
 {
  sl_val=rates[2].low;
  return rates[2].low>jaw?SLMODE_LOCALEXT_MIN_ABOVEGATOR:SLMODE_LOCALEXT_MIN_UNDERGATOR;
 }
 
 if(rates[3].high<=rates[2].high && rates[2].high>=rates[1].high)
 {
  sl_val=rates[2].high;
  return rates[2].high>jaw?SLMODE_LOCALEXT_MAX_ABOVEGATOR:SLMODE_LOCALEXT_MAX_UNDERGATOR;
 }
 
 return SLMODE_NONE;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::inIchimokuCloud(double v)
{
 double senkou_a=iIchimoku(NULL,0,9,26,52,MODE_SENKOUSPANA,1);
 double senkou_b=iIchimoku(NULL,0,9,26,52,MODE_SENKOUSPANB,1);
 
 double max_span=MathMax(senkou_a,senkou_b);
 double min_span=MathMin(senkou_a,senkou_b);
 
 return min_span<=v && v<=max_span;
}

//--------------------------------------------------------------------
static double ax_bar_utils::getPercentValueFromBarToExtrem(double bar_val,double extrem_val,double percent)
{
 double percent_diff=MathAbs(extrem_val-bar_val)*percent;
 
 return bar_val>extrem_val?bar_val-percent_diff:bar_val+percent_diff;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_sl_by_SAR(MqlRates& rates[],int op_type)
{
 double sar1=NormalizeDouble(iSAR(NULL,0,0.02,0.2,1),Digits);
 double sar2=NormalizeDouble(iSAR(NULL,0,0.02,0.2,2),Digits);
 
 if(op_type==OP_BUY)//sar1<sar2
  return (sar1<rates[1].low && sar2>rates[2].high)?rates[1].low:0;
  
 if(op_type==OP_SELL)
  return (sar1>rates[1].high && sar2<rates[2].low)?rates[1].high:0;
  
 return 0;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_sl_by_SAR2(MqlRates& rates[],int op_type)
{
 double sar1=NormalizeDouble(iSAR(NULL,0,0.02,0.2,1),Digits);
 double sar2=NormalizeDouble(iSAR(NULL,0,0.02,0.2,2),Digits);
 
 if(op_type==OP_BUY)
  return (sar1>rates[1].high && sar2<rates[2].low)?rates[1].low:0;
  
 if(op_type==OP_SELL)
  return (sar1<rates[1].low && sar2>rates[2].high)?rates[1].high:0;
  
 return 0;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::__period()
{
 switch(Period())
 {
 case PERIOD_M1:  return false;
 case PERIOD_M5:  return false;
 case PERIOD_M15: return false;
 case PERIOD_M30: return true;
 case PERIOD_H1:  return true;
 case PERIOD_H4:  return true;
 case PERIOD_D1:  return true;
 case PERIOD_W1:  return true;
 case PERIOD_MN1: return true;
 }
 
 return false;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::volatile()
{
 bool asia    =Hour()>=4 && Hour()<12;
 bool europe  =Hour()>=10 && Hour()<19; 
 bool america =Hour()>=17 && Hour()<2;
 
 return true;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_max_lot()
{
 //MarketInfo(Symbol(),MODE_MAXLOT)const int standard_lot=100000;
 
 return 0.02;
}

//--------------------------------------------------------------------
static void ax_bar_utils::get_dummy_bar_reverse(MqlRates& direct_bar,double direct_lot,trade_mode tm,double profit_coef,MqlRates& reverse_bar,double& reverse_lot)
//static void ax_bar_utils::get_dummy_bar_reverse(MqlRates& direct_bar,double direct_lot,trade_mode tm,double profit_coef,double& price,double& sl,double& tp,double& reverse_lot)
{
 reverse_lot=ax_bar_utils::get_max_lot();
 
// double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
 
 double coef=reverse_lot/direct_lot;
 
 //open и close нас не интересует
 reverse_bar.open  =0;
 reverse_bar.close =0;
 
 //price   =0;
 //sl      =0;
 //tp      =0;
 
 if(tm==TRADEMODE_SELL)//обратный для прямого BUY
 {
  //double diff=(direct_bar.high-direct_bar.low)/coef;
  
  //tp     =direct_bar.low-ax_bar_utils::get_delta_points()*Point;
  //price  =MathMin(NormalizeDouble(Bid-minstoplevel*Point,Digits),NormalizeDouble(tp+MathMax(diff,minstoplevel*Point),Digits));
  //sl     =NormalizeDouble(price+MathMax(diff/profit_coef,minstoplevel*Point),Digits);
  
  reverse_bar.low  =direct_bar.low;
  reverse_bar.high =NormalizeDouble(direct_bar.low+(direct_bar.high-direct_bar.low)/coef/profit_coef,Digits);
 }
 
 if(tm==TRADEMODE_BUY)//обратный для SELL
 {
 }
}

//--------------------------------------------------------------------
static macd_trade_mode ax_bar_utils::get_tm_by_macd(int timeframe,int shift)
{
 ///*
 int fast_ema_period =5; // период быстрой средней 
 int slow_ema_period =34;// период медленной средней 
 int signal_period   =5; // период сигнальной линии 
 //*/
 /*
 int fast_ema_period =20; // период быстрой средней 
 int slow_ema_period =88;// период медленной средней 
 int signal_period   =5; // период сигнальной линии 
 */
 
 double main_val   =iMACD(NULL,timeframe,fast_ema_period,slow_ema_period,signal_period,PRICE_CLOSE,MODE_MAIN,shift);
 double signal_val =iMACD(NULL,timeframe,fast_ema_period,slow_ema_period,signal_period,PRICE_CLOSE,MODE_SIGNAL,shift);
 
 if(main_val<0 && main_val>signal_val)
  return MACDTRADEMODE_BUY;
  
 if(main_val>0 && main_val<signal_val)
  return MACDTRADEMODE_SELL;
  
 return MACDTRADEMODE_NONE;
}

//--------------------------------------------------------------------
static macd_trade_mode ax_bar_utils::get_tm_by_macd2(int timeframe,int shift)
{
 ///*
 int fast_ema_period =5; // период быстрой средней 
 int slow_ema_period =34;// период медленной средней 
 int signal_period   =5; // период сигнальной линии 
 //*/
 /*
 int fast_ema_period =20; // период быстрой средней 
 int slow_ema_period =88;// период медленной средней 
 int signal_period   =5; // период сигнальной линии 
 */
 
 double main_val   =iMACD(NULL,timeframe,fast_ema_period,slow_ema_period,signal_period,PRICE_CLOSE,MODE_MAIN,shift);
 double signal_val =iMACD(NULL,timeframe,fast_ema_period,slow_ema_period,signal_period,PRICE_CLOSE,MODE_SIGNAL,shift);
 
 if(/*main_val<0 && */main_val>signal_val)
  return MACDTRADEMODE_BUY;
  
 if(/*main_val>0 && */main_val<signal_val)
  return MACDTRADEMODE_SELL;
  
 return MACDTRADEMODE_NONE;
}

//--------------------------------------------------------------------
static bar_types ax_bar_utils::get_bar_type_by_AC(MqlRates& rates[],MqlRates& out_bar,double& local_extremum)
{
 local_extremum=0;
 
 out_bar.open  =rates[3].open;
 out_bar.close =rates[1].close;
 
 double v1=iAC(NULL,0,1);//-1
 double v2=iAC(NULL,0,2);//-2
 double v3=iAC(NULL,0,3);//-3
 double v4=iAC(NULL,0,4);//-4
 
 //BUY - определяем переход красное->зеленое (ниже нуля) - пик на графике AC
 if((v1<0&&v1>v2&&v2<v3&&v3<v4) || (v1<0&&v1>v2&&v2>v3&&v3<v4) || (v1<0&&v1>v2&&v2>v3&&v3>v4))//-rrg rgg ggg
 {
  out_bar.high  =rates[1].high;
  out_bar.low   =ax_bar_utils::get_min(rates[1].low,rates[2].low,rates[3].low);
  
  if(ax_bar_utils::get_type2(out_bar)==BARTYPE_BULLISH)
  {
   if(ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_UNDERGATOR,BARPOSITIONMODE_FULL,1) && !ax_bar_utils::is_in_gator(rates[1],1))
   {
    local_extremum=ax_bar_utils::get_local_extremum(rates,TRADEMODE_BUY);
    return BARTYPE_BULLISH;
   }
   
   if((ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_UNDERGATOR,BARPOSITIONMODE_MEDIUM,1) ||
       ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_UNDERGATOR,BARPOSITIONMODE_PART,1)) && !ax_bar_utils::is_in_gator(rates[1],1))
   {
    local_extremum=out_bar.low;
    return BARTYPE_BULLISH;
   }
  }
   
  return BARTYPE_NONE;
 }
 
 if(v1>0&&v2>0&&v1>v2&&v2>v3)//+gg
 {
  out_bar.high  =rates[1].high;
  out_bar.low   =ax_bar_utils::get_local_extremum(rates,TRADEMODE_BUY);
  
  if(ax_bar_utils::get_type2(out_bar)==BARTYPE_BULLISH)
  {
   if(ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_UNDERGATOR,BARPOSITIONMODE_PART,1) && !ax_bar_utils::is_in_gator(rates[1],1))
   {
    local_extremum=out_bar.low;
    return BARTYPE_BULLISH;
   }
  }
   
  return BARTYPE_NONE;
 }
 
 ////////////////////////////////////////////////////////////////////////////////////
 //SELL
 if((v1>0&&v1<v2&&v2>v3&&v3>v4) || (v1>0&&v1<v2&&v2<v3&&v3>v4) || (v1>0&&v1<v2&&v2<v3&&v3<v4))//+ggr grr rrr
 {
  out_bar.high  =ax_bar_utils::get_max(rates[1].high,rates[2].high,rates[3].high);
  out_bar.low   =rates[1].low;
  
  if(ax_bar_utils::get_type2(out_bar)==BARTYPE_BEARISH)
  {
   if(ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_ABOVEGATOR,BARPOSITIONMODE_FULL,1) && !ax_bar_utils::is_in_gator(rates[1],1))
   {
    local_extremum=ax_bar_utils::get_local_extremum(rates,TRADEMODE_SELL);
    return BARTYPE_BEARISH;
   }

   if((ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_ABOVEGATOR,BARPOSITIONMODE_MEDIUM,1) ||
       ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_ABOVEGATOR,BARPOSITIONMODE_PART,1)) && !ax_bar_utils::is_in_gator(rates[1],1))
   {
    local_extremum=out_bar.high;
    return BARTYPE_BEARISH;
   }
  }
   
  return BARTYPE_NONE;
 }
 
 if(v1<0&&v2<0&&v1<v2&&v2<v3)//-rr
 {
  out_bar.high  =ax_bar_utils::get_local_extremum(rates,TRADEMODE_SELL);
  out_bar.low   =rates[1].low;
  
  if(ax_bar_utils::get_type2(out_bar)==BARTYPE_BEARISH)
  {
   if(ax_bar_utils::get_bar_gator_position(out_bar,BARPOSITION_ABOVEGATOR,BARPOSITIONMODE_PART,1) && !ax_bar_utils::is_in_gator(rates[1],1))
   {
    local_extremum=out_bar.high;
    return BARTYPE_BEARISH;
   }
  }
   
  return BARTYPE_NONE;
 }
  
 return BARTYPE_NONE;
}

//--------------------------------------------------------------------
static bar_types ax_bar_utils::get_bar_type_by_AC2(MqlRates& rates[],MqlRates& out_bar,double& local_extremum)
{
 //ТОЛЬКО по 3
 local_extremum=0;
 
 out_bar.open  =rates[3].open;
 out_bar.close =rates[1].close;
 
 double v1=iAC(NULL,0,1);//-1
 double v2=iAC(NULL,0,2);//-2
 double v3=iAC(NULL,0,3);//-3
 double v4=iAC(NULL,0,4);//-4
 
 //BUY
 if(v1<0&&v1>v2&&v2>v3&&v3>v4)//-ggg
 {
  out_bar.high  =rates[1].high;
  out_bar.low   =ax_bar_utils::get_min(rates[1].low,rates[2].low,rates[3].low);
  
  if(ax_bar_utils::get_type2(out_bar)==BARTYPE_BULLISH && ax_bar_utils::get_bar_gator_position(rates[1],BARPOSITION_UNDERGATOR,BARPOSITIONMODE_FULL,1))
  {
   //local_extremum=ax_bar_utils::get_local_extremum(rates,TRADEMODE_BUY);
   local_extremum=out_bar.low;
   
   return BARTYPE_BULLISH;
  }
   
  return BARTYPE_NONE;
 }

 ////////////////////////////////////////////////////////////////////////////////////
 //SELL
 if(v1>0&&v1<v2&&v2<v3&&v3<v4)//+rrr
 {
  out_bar.high  =ax_bar_utils::get_max(rates[1].high,rates[2].high,rates[3].high);
  out_bar.low   =rates[1].low;
  
  if(ax_bar_utils::get_type2(out_bar)==BARTYPE_BEARISH && ax_bar_utils::get_bar_gator_position(rates[1],BARPOSITION_ABOVEGATOR,BARPOSITIONMODE_FULL,1))
  {
   //local_extremum=ax_bar_utils::get_local_extremum(rates,TRADEMODE_SELL);
   local_extremum=out_bar.high;
   
   return BARTYPE_BEARISH;
  }
 }
  
 return BARTYPE_NONE;
}

//--------------------------------------------------------------------
static void ax_bar_utils::trade(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg)
{
 err_msg="";
 
 string msg="";
 
 MqlRates dummy_bar;
 
 double local_extremum;
  
 //bar_types bt=ax_bar_utils::get_bar_type_by_AC2(rates,dummy_bar,local_extremum);
 bar_types bt=ax_bar_utils::get_bar_type_by_AC(rates,dummy_bar,local_extremum);
 
 if(ax_bar_utils::inIchimokuCloud(dummy_bar.high) || ax_bar_utils::inIchimokuCloud(dummy_bar.low))
  return;
 
 if(tm==TRADEMODE_BUY && bt==BARTYPE_BULLISH/* && !ax_bar_utils::find_previous_reverse_order(OP_SELL,order_set)*/)
 {
  dummy_bar.low=local_extremum;
  
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  {
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,local_extremum,order_set.fibo,1,dummy_bar.high);
  else
   err_msg="[BUYSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_BUY
 else
 if(tm==TRADEMODE_SELL && bt==BARTYPE_BEARISH/* && !ax_bar_utils::find_previous_reverse_order(OP_BUY,order_set)*/)
 {
  dummy_bar.high=local_extremum;
   
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,local_extremum,order_set.fibo,1,dummy_bar.low);
  else
   err_msg="[SELLSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_SELL
}

//--------------------------------------------------------------------
static void ax_bar_utils::trade2(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg)
{
 err_msg="";
 
 string msg="";
 
 MqlRates dummy_bar=rates[1];
 
 //if(ax_bar_utils::inIchimokuCloud(dummy_bar.high) || ax_bar_utils::inIchimokuCloud(dummy_bar.low))
 // return;
 
 //if(tm==TRADEMODE_BUY/* && !ax_bar_utils::inIchimokuCloud(dummy_bar.high)*/)
 //if(tm==TRADEMODE_BUY/* && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BULLISH*/ && ax_bar_utils::get_bar_gator_position(dummy_bar,BARPOSITION_UNDERGATOR,BARPOSITIONMODE_FULL,1))
 if(tm==TRADEMODE_BUY && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BULLISH && ax_bar_utils::ichimoku_reversed(rates))
 { 
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,dummy_bar.low,order_set.fibo,1,dummy_bar.high);
  else
   err_msg="[BUYSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_BUY
 else
 //if(tm==TRADEMODE_SELL/* && !ax_bar_utils::inIchimokuCloud(dummy_bar.low)*/)
 //if(tm==TRADEMODE_SELL/* && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BEARISH*/ && ax_bar_utils::get_bar_gator_position(dummy_bar,BARPOSITION_ABOVEGATOR,BARPOSITIONMODE_FULL,1))
 if(tm==TRADEMODE_SELL && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BEARISH && ax_bar_utils::ichimoku_reversed(rates))
 {
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,dummy_bar.high,order_set.fibo,1,dummy_bar.low);
  else
   err_msg="[SELLSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_SELL
}

//--------------------------------------------------------------------
static void ax_bar_utils::trade3(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg)
{
 err_msg="";
 
 string msg="";
 
 MqlRates dummy_bar=rates[1];
 
// if(ax_bar_utils::inIchimokuCloud(dummy_bar.high) || ax_bar_utils::inIchimokuCloud(dummy_bar.low))
 // return;
 
 if(tm==TRADEMODE_BUY/* && !ax_bar_utils::inIchimokuCloud(dummy_bar.high)*/)
 //if(tm==TRADEMODE_BUY/* && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BULLISH*/ && ax_bar_utils::get_bar_gator_position(dummy_bar,BARPOSITION_UNDERGATOR,BARPOSITIONMODE_FULL,1))
 //if(tm==TRADEMODE_BUY/* && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BULLISH && ax_bar_utils::ichimoku_reversed(rates)*/)
 //if(tm==TRADEMODE_BUY && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BULLISH/* && ax_bar_utils::ichimoku_reversed(rates)*/)
 //if(tm==TRADEMODE_BUY/* && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BULLISH*/ && ax_bar_utils::ichimoku_reversed(rates))
 //if(tm==TRADEMODE_BUY && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BULLISH && ax_bar_utils::ichimoku_reversed(rates))
 {
  dummy_bar.low=ax_bar_utils::get_local_extremum_by_kijun2(rates,tm);
  
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,dummy_bar.low,order_set.fibo,1,dummy_bar.high);
  else
   err_msg="[BUYSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_BUY
 else
 if(tm==TRADEMODE_SELL/* && !ax_bar_utils::inIchimokuCloud(dummy_bar.low)*/)
 //if(tm==TRADEMODE_SELL/* && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BEARISH*/ && ax_bar_utils::get_bar_gator_position(dummy_bar,BARPOSITION_ABOVEGATOR,BARPOSITIONMODE_FULL,1))
 //if(tm==TRADEMODE_SELL/* && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BEARISH && ax_bar_utils::ichimoku_reversed(rates)*/)
 //if(tm==TRADEMODE_SELL && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BEARISH/* && ax_bar_utils::ichimoku_reversed(rates)*/)
 //if(tm==TRADEMODE_SELL/* && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BEARISH*/ && ax_bar_utils::ichimoku_reversed(rates))
 //if(tm==TRADEMODE_SELL && ax_bar_utils::get_type2(dummy_bar)==BARTYPE_BEARISH && ax_bar_utils::ichimoku_reversed(rates))
 {
  dummy_bar.high=ax_bar_utils::get_local_extremum_by_kijun2(rates,tm);
  
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,dummy_bar.high,order_set.fibo,1,dummy_bar.low);
  else
   err_msg="[SELLSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_SELL
}

//--------------------------------------------------------------------
static void ax_bar_utils::trade4(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg)
{
 err_msg="";
 
 string msg="";
 
 MqlRates dummy_bar=rates[1];
 
// if(ax_bar_utils::inIchimokuCloud(dummy_bar.high) || ax_bar_utils::inIchimokuCloud(dummy_bar.low))
 // return;
 
 if(tm==TRADEMODE_BUY)
 {
  dummy_bar.low=ax_bar_utils::get_local_extremum(rates,tm);
  
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,dummy_bar.low,order_set.fibo,1,dummy_bar.high);
  else
   err_msg="[BUYSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_BUY
 else
 if(tm==TRADEMODE_SELL)
 {
  dummy_bar.high=ax_bar_utils::get_local_extremum(rates,tm);
  
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,dummy_bar.high,order_set.fibo,1,dummy_bar.low);
  else
   err_msg="[SELLSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_SELL
}

//--------------------------------------------------------------------
static void ax_bar_utils::trade5_fractal(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg)
{
 err_msg="";
 
 string msg="";
 
 //if(ax_bar_utils::inIchimokuCloud(rates[1].high) || ax_bar_utils::inIchimokuCloud(rates[1].low))
 // return;
 
 MqlRates dummy_bar;
 //dummy_bar.high =ax_bar_utils::get_max(rates[1].high,rates[2].high,rates[3].high);
 //dummy_bar.low  =ax_bar_utils::get_min(rates[1].low,rates[2].low,rates[3].low);
 dummy_bar.high =rates[1].high;
 dummy_bar.low  =rates[1].low;
 
 MqlRates dummy_bigger_bar;
 
 ax_bar_utils::get_sl_by_more_period_BW(rates[1],dummy_bigger_bar);
 
 if(tm==TRADEMODE_BUY)
 {
  dummy_bar.high =rates[3].high;
  //dummy_bar.low  =MathMin(dummy_bigger_bar.low,ax_bar_utils::get_min(rates[1].low,rates[2].low,rates[3].low));
  
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,dummy_bar.low,order_set.fibo,1,dummy_bar.high);
  else
   err_msg="[BUYSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_BUY
 else
 if(tm==TRADEMODE_SELL)
 {
  //dummy_bar.high =MathMax(dummy_bigger_bar.high,ax_bar_utils::get_max(rates[1].high,rates[2].high,rates[3].high));
  dummy_bar.low  =rates[3].low;
  
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
   axAddOrder(Symbol(),ticket,dummy_bar.high,order_set.fibo,1,dummy_bar.low);
  else
   err_msg="[SELLSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_SELL
}

//--------------------------------------------------------------------
static bool ax_bar_utils::trade6_simple(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg,order_data& order,bool use_ichimoku,order_sl_type sl_type,int bars_count_back)
{
 err_msg="";
 
 string msg="";
 
 bool retval=false;
 
 if(use_ichimoku)
 {
  if((tm==TRADEMODE_BUY && ax_bar_utils::inIchimokuCloud(rates[1].high)) || (tm==TRADEMODE_SELL && ax_bar_utils::inIchimokuCloud(rates[1].low)))
   return retval;
 }
 
 MqlRates dummy_bar;
 //MqlRates dummy_bigger_bar;
 
 //ax_bar_utils::get_sl_by_more_period_BW(rates[1],dummy_bigger_bar);
 
 if(tm==TRADEMODE_BUY)
 {
  dummy_bar.high =rates[1].high;
  dummy_bar.low  =ax_bar_utils::get_order_sl(rates,sl_type,tm,1,bars_count_back);
  
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg,order);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
  {
   //axAddOrder(Symbol(),ticket,dummy_bar.low,order_set.fibo,1,dummy_bar.high);
   retval=true;
  }
  else
   err_msg="[BUYSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_BUY
 else
 if(tm==TRADEMODE_SELL)
 {
  dummy_bar.high =ax_bar_utils::get_order_sl(rates,sl_type,tm,1,bars_count_back);
  dummy_bar.low  =rates[1].low;
  
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3(dummy_bar,tm,order_set,msg,order);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
  {
   //axAddOrder(Symbol(),ticket,dummy_bar.high,order_set.fibo,1,dummy_bar.low);
   retval=true;
  }
  else
   err_msg="[SELLSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_SELL
 
 return retval;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::trade6_simple_stoplevel(ax_settings& stgs,MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,string& err_msg,order_data& order,bool use_ichimoku,order_sl_type sl_type,int bars_count_back)
{
 err_msg="";
 
 string msg="";
 
 bool retval=false;
 
 if(use_ichimoku)
 {
  if((tm==TRADEMODE_BUY && ax_bar_utils::inIchimokuCloud(rates[1].high)) || (tm==TRADEMODE_SELL && ax_bar_utils::inIchimokuCloud(rates[1].low)))
   return retval;
 }
 
 if(tm==TRADEMODE_BUY)
 {
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3_StopLevel(stgs,rates[1],tm,order_set,msg,order);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
  {
   //axAddOrder(Symbol(),ticket,dummy_bar.low,order_set.fibo,1,dummy_bar.high);
   retval=true;
  }
  else
   err_msg="[BUYSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_BUY
 else
 if(tm==TRADEMODE_SELL)
 {
  int ticket=-1;
  
  for(int try_count=0;try_count<order_set.try_count;try_count++)
  { 
   ticket=ax_bar_utils::OpenOrder3_StopLevel(stgs,rates[1],tm,order_set,msg,order);
   
   if(ticket>0)
    break;
  }

  if(ticket>0)
  {
   //axAddOrder(Symbol(),ticket,dummy_bar.high,order_set.fibo,1,dummy_bar.low);
   retval=true;
  }
  else
   err_msg="[SELLSTOP "+order_set.comment+"]:"+msg;
 }//TRADEMODE_SELL
 
 return retval;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::trade7(MqlRates& rates[],trade_mode tm,ax_order_settings& order_set,bool use_ichimoku,string& err_msg)
{
 err_msg="";
 
 string msg="";
 
 bool retval=false;
 
 if(use_ichimoku)
 {
  if((tm==TRADEMODE_BUY && ax_bar_utils::inIchimokuCloud(rates[1].high)) || (tm==TRADEMODE_SELL && ax_bar_utils::inIchimokuCloud(rates[1].low)))
   return retval;
 }
 
 if(tm==TRADEMODE_BUY)
 {
  int ticket=ax_bar_utils::OpenOrder4(tm,order_set,iATR(NULL,0,14,1),msg);

  if(ticket>0)
   retval=true;
  else
   err_msg="[BUY "+order_set.comment+"]:"+msg;
 }//TRADEMODE_BUY
 else
 if(tm==TRADEMODE_SELL)
 {
  int ticket=ax_bar_utils::OpenOrder4(tm,order_set,iATR(NULL,0,14,1),msg);

  if(ticket>0)
   retval=true;
  else
   err_msg="[SELL "+order_set.comment+"]:"+msg;
 }//TRADEMODE_SELL
 
 return retval;
}

//--------------------------------------------------------------------
static ma_trade_mode ax_bar_utils::get_ma_trade_mode()
{
 int ma_period=13;
 
 if(Period()==PERIOD_M15)
  ma_period=500;
  
 if(Period()==PERIOD_H1)
  ma_period=1000;
  
 double v1=iMA(NULL,0,ma_period,0,MODE_EMA,PRICE_CLOSE,1);
 double v2=iMA(NULL,0,ma_period,0,MODE_EMA,PRICE_CLOSE,2);
 
 if(v1>v2)
  return MATRADEMODE_BUY;
  
 if(v1<v2)
  return MATRADEMODE_SELL;
  
 return MATRADEMODE_NONE;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::find_previous_reverse_order(int op_type,ax_order_settings& order_set)
{
 int cnt=OrdersTotal();
 
 int close_success=0;
 int close_failed=0;
 
 bool profitable=false;
 
 for(int i=cnt-1;i>=0;i--)
 {
  if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   continue;
   
  if(OrderSymbol()!=Symbol())
   continue;
   
  int order_type=OrderType();
  
  if(order_type==op_type && op_type==OP_BUY)
  {
   if(OrderProfit()>0)
    profitable=true;
   else
   {
    for(int try_count=0;try_count<order_set.try_count;try_count++)
    {
     if(OrderClose(OrderTicket(),OrderLots(),Bid,order_set.slippage))
      break;
    }
   }
  }
  
  if(order_type==op_type && op_type==OP_SELL)
  {
   if(OrderProfit()>0)
    profitable=true;
   else
   {
    for(int try_count=0;try_count<order_set.try_count;try_count++)
    {
     if(OrderClose(OrderTicket(),OrderLots(),Ask,order_set.slippage))
      break;
    }
   }
  }
 } 
 
 return profitable;
}

//--------------------------------------------------------------------
static int ax_bar_utils::get_delta_points()
{
 //return StringLen(Symbol())>5?g_delta_points:g_delta_points/10;
 return g_delta_points;
}

//--------------------------------------------------------------------
static ichimoku_cross_mode ax_bar_utils::get_ichimoku_cross_mode(MqlRates& prev_rate,MqlRates& rate,double prev_val,double val)
{
 if(prev_val>prev_rate.high && val>rate.high)
  return ICHIMOKUCROSSMODE_NONE;
  
 if(prev_val<prev_rate.low && val<rate.low)
  return ICHIMOKUCROSSMODE_NONE;
 
 //здесь что-то да пересекается
 if(val>prev_val)
  return ICHIMOKUCROSSMODE_DOWNUP;
  
 if(val<prev_val)
  return ICHIMOKUCROSSMODE_UPDOWN;
  
 return ICHIMOKUCROSSMODE_NONE;
}

//--------------------------------------------------------------------
static ichimoku_cross_mode ax_bar_utils::get_ichimoku_chikou_cross_mode(MqlRates& rates[])
{
 const int i      =27;
 const int prev_i =28;
 
 double chikou      =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_CHIKOUSPAN,i),Digits);
 double prev_chikou =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_CHIKOUSPAN,prev_i),Digits);
 
 return ax_bar_utils::get_ichimoku_cross_mode(rates[prev_i],rates[i],prev_chikou,chikou);
}

//--------------------------------------------------------------------
static ichimoku_cross_mode ax_bar_utils::get_ichimoku_chikou_kijun_cross_mode()
{
 const int i      =27;
 const int prev_i =28;
 
 double chikou      =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_CHIKOUSPAN,i),Digits);
 double prev_chikou =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_CHIKOUSPAN,prev_i),Digits);
 
 double kijun       =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_KIJUNSEN,i),Digits);
 double prev_kijun  =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_KIJUNSEN,prev_i),Digits);
 
 if(prev_chikou>prev_kijun && chikou>kijun)
  return ICHIMOKUCROSSMODE_NONE;
  
 if(prev_chikou<prev_kijun && chikou<kijun)
  return ICHIMOKUCROSSMODE_NONE;
  
 if(prev_chikou<chikou)
  return ICHIMOKUCROSSMODE_DOWNUP;
  
 if(prev_chikou>chikou)
  return ICHIMOKUCROSSMODE_UPDOWN;
  
 return ICHIMOKUCROSSMODE_NONE;
}

//--------------------------------------------------------------------
static ichimoku_cross_mode ax_bar_utils::get_ichimoku_chikou_ma_cross_mode()
{
 const int i      =27;
 const int prev_i =28;
 
 double chikou      =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_CHIKOUSPAN,i),Digits);
 double prev_chikou =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_CHIKOUSPAN,prev_i),Digits);
  
 double ma          =NormalizeDouble(iMA(NULL,0,14,0,MODE_LWMA,PRICE_WEIGHTED,i),Digits);
 double prev_ma     =NormalizeDouble(iMA(NULL,0,14,0,MODE_LWMA,PRICE_WEIGHTED,prev_i),Digits);
 
 if(prev_chikou>=prev_ma && chikou>=ma)
  return ICHIMOKUCROSSMODE_NONE;
  
 if(prev_chikou<=prev_ma && chikou<=ma)
  return ICHIMOKUCROSSMODE_NONE;
  
 if(prev_chikou<chikou)
  return ICHIMOKUCROSSMODE_DOWNUP;
  
 if(prev_chikou>chikou)
  return ICHIMOKUCROSSMODE_UPDOWN;
  
 return ICHIMOKUCROSSMODE_NONE;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::ichimoku_reversed(MqlRates& rates[])
{
 const int point_current  =1;
 const int point_previous =27;
 
 double kijun_current  =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_KIJUNSEN,point_current),Digits);
 double kijun_previous =NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_KIJUNSEN,point_previous),Digits);
 
 if(kijun_previous>rates[point_previous].high && kijun_current>rates[point_current].high)
  return false;
  
 if(kijun_previous<rates[point_previous].low && kijun_current<rates[point_current].low)
  return false;
 
 return true; 
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_local_extremum_by_kijun(MqlRates& rates[],trade_mode tm)
{
 double loc_ext=(tm==TRADEMODE_BUY)?rates[1].low:rates[1].high;
 
 double kijun;
 
 bool extremum_area_entry=false;
 
 double rate_val;
 
 for(int i=2;;i++)
 {
  if(tm==TRADEMODE_BUY)
  {
   rate_val=rates[i].low;
   
   kijun=NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_KIJUNSEN,i),Digits);
   
   if(rate_val>kijun && extremum_area_entry)
    break;
    
   if(rate_val<kijun)
    extremum_area_entry=true;
    
   if(rate_val<loc_ext)
    loc_ext=rate_val;
  }
  
  if(tm==TRADEMODE_SELL)
  {
   rate_val=rates[i].high;
   
   kijun=NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_KIJUNSEN,i),Digits);
   
   if(rate_val<kijun && extremum_area_entry)
    break;
    
   if(rate_val>kijun)
    extremum_area_entry=true;
    
   if(rate_val>loc_ext)
    loc_ext=rate_val;
  }
 }
 
 return loc_ext;
}
  
//--------------------------------------------------------------------
static double ax_bar_utils::get_local_extremum_by_kijun2(MqlRates& rates[],trade_mode tm)
{
 double loc_ext=(tm==TRADEMODE_BUY)?rates[1].low:rates[1].high;
 
 double kijun=NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_KIJUNSEN,1),Digits);
 
 //если текущий бар при покупке выше кижуна, то вместо экстремума используем low этого бара
 if(tm==TRADEMODE_BUY)
 {
  if(loc_ext>kijun)
   return loc_ext;
 }
 
 if(tm==TRADEMODE_SELL)
 {
  if(loc_ext<kijun)
   return loc_ext;
 }
 
 //иначе ищем локальный экстремум
 bool extremum_area_entry=false;
 
 double rate_val;
 
 for(int i=2;;i++)
 {
  if(tm==TRADEMODE_BUY)
  {
   rate_val=rates[i].low;
   
   kijun=NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_KIJUNSEN,i),Digits);
   
   if(rate_val>kijun && extremum_area_entry)
    break;
    
   if(rate_val<kijun)
    extremum_area_entry=true;
    
   if(rate_val<loc_ext)
    loc_ext=rate_val;
  }
  
  if(tm==TRADEMODE_SELL)
  {
   rate_val=rates[i].high;
   
   kijun=NormalizeDouble(iIchimoku(NULL,0,9,26,52,MODE_KIJUNSEN,i),Digits);
   
   if(rate_val<kijun && extremum_area_entry)
    break;
    
   if(rate_val>kijun)
    extremum_area_entry=true;
    
   if(rate_val>loc_ext)
    loc_ext=rate_val;
  }
 }
 
 return loc_ext;
}

//--------------------------------------------------------------------  
static void ax_bar_utils::get_sl_by_more_period_BW(MqlRates& ready_bar,MqlRates& bigger_bar)
{
 //получаем бары большего периода
 MqlRates rates[];
 ArrayCopyRates(rates,NULL,ax_bar_utils::get_more_period());
 
 if(ready_bar.time>=rates[0].time)
  bigger_bar=rates[1];
  
 bigger_bar=rates[2];
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_min_stop_level()
{
 return NormalizeDouble((MarketInfo(Symbol(),MODE_STOPLEVEL)+ax_bar_utils::get_delta_points())*Point,Digits);
}

//--------------------------------------------------------------------
static trix_cross_mode ax_bar_utils::get_trix_cross_mode(int fast,int slow,int shift)
{
 //6 fast
 //7 slow
 double fast_cur  =iCustom(NULL,0,"THV4Trix.ex4",fast,slow,6,shift);
 double fast_prev =iCustom(NULL,0,"THV4Trix.ex4",fast,slow,6,shift+1);
 
 double slow_cur  =iCustom(NULL,0,"THV4Trix.ex4",fast,slow,7,shift);
 double slow_prev =iCustom(NULL,0,"THV4Trix.ex4",fast,slow,7,shift+1);
 
 if(fast_prev>slow_prev && fast_cur>slow_cur)
  return TRIXCROSSMODE_NONE;
  
 if(fast_prev<slow_prev && fast_cur<slow_cur)
  return TRIXCROSSMODE_NONE;
 
 if(fast_cur>fast_prev)
  return TRIXCROSSMODE_BUY;
  
 if(fast_cur<fast_prev)
  return TRIXCROSSMODE_SELL;
  
 return TRIXCROSSMODE_NONE;
}

//--------------------------------------------------------------------
static trix_color_change_mode ax_bar_utils::get_trix_color_change_mode(int fast,int slow,int shift)
{
 //6 fast
 double v1=iCustom(NULL,0,"THV4Trix.ex4",fast,slow,6,shift);
 double v2=iCustom(NULL,0,"THV4Trix.ex4",fast,slow,6,shift+1);
 double v3=iCustom(NULL,0,"THV4Trix.ex4",fast,slow,6,shift+2);
 
 if(v1>v2&&v2<v3)
  return TRIXCOLORCHANGEMODE_REDTOGREEN;
  
 if(v1<v2&&v2>v3)
  return TRIXCOLORCHANGEMODE_GREENTORED;
  
 return TRIXCOLORCHANGEMODE_NONE;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::get_trix_arrow_type(int fast,int slow,int shift,trix_arrow_type tat,double& outval)
{
 outval=INT_MAX;
 
 if(tat==TRIXARROWTYPE_UP)
  outval=iCustom(NULL,0,"THV4Trix.ex4",fast,slow,4,shift);
  
 if(tat==TRIXARROWTYPE_DOWN)
  outval=iCustom(NULL,0,"THV4Trix.ex4",fast,slow,5,shift);
  
 return outval!=INT_MAX;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_order_sl(MqlRates& rates[],order_sl_type sl_type,trade_mode tm,int shift,int bars_count_back)
{
 if(sl_type==ORDERSLTYPE_SINGLEBAR)
  return (tm==TRADEMODE_BUY)?rates[shift].low:(tm==TRADEMODE_SELL?rates[shift].high:0);
  
 if(sl_type==ORDERSLTYPE_MINMAXBACKWARD)
 {
  double minmax=(tm==TRADEMODE_BUY)?rates[shift].low:(tm==TRADEMODE_SELL?rates[shift].high:0);
  
  for(int i=shift+1;i<=bars_count_back;i++)
  {
   if(tm==TRADEMODE_BUY)
   {
    if(rates[i].low<minmax)
     minmax=rates[i].low;
   }
   else
   {
    if(rates[i].high>minmax)
     minmax=rates[i].high;
   }//if
  }//for
  
  return minmax;
 }//if
 
 if(sl_type==ORDERSLTYPE_LOCALEXTREMUM)
  return ax_bar_utils::get_local_extremum(rates,tm);
  
 if(sl_type==ORDERSLTYPE_ATR)
 {
  if(tm==TRADEMODE_BUY)
   return rates[shift].low-NormalizeDouble(iATR(NULL,0,14,1),Digits);
   
  if(tm==TRADEMODE_SELL)
   return rates[shift].high+NormalizeDouble(iATR(NULL,0,14,1),Digits);   
 }
 
 if(sl_type==ORDERSLTYPE_VALUE)
 {
  if(tm==TRADEMODE_BUY)
   return axGetATRArrayMinPrice(Symbol())-axGetATRArrayMinPriceATR(Symbol());
   
  if(tm==TRADEMODE_SELL)
   return axGetATRArrayMaxPrice(Symbol())+axGetATRArrayMaxPriceATR(Symbol());
 }
 
 return 0;
}

//--------------------------------------------------------------------
static gator_formation ax_bar_utils::get_gator_formation(int ma_method,int timeframe,int lips_shift,int teeth_shift,int jaw_shift,int comp_count)
{
 int divergence_up   =0;
 int divergence_down =0;
 
 double prev_diff=0;
 
 for(int i=0;i<comp_count+1;i++)
 {
  double lips       =iAlligator(NULL,timeframe,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORLIPS,lips_shift+i);
  double teeth      =iAlligator(NULL,timeframe,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORTEETH,teeth_shift+i);
  double jaw        =iAlligator(NULL,timeframe,13,8,8,5,5,3,ma_method,PRICE_MEDIAN,MODE_GATORJAW,jaw_shift+i);
  
  double diff=0;
  
  if(lips>teeth && teeth>jaw)
   diff=lips-jaw;
  else
  if(lips<teeth && teeth<jaw)
   diff=jaw-lips;
  
  if(i==0)//первый проход
  {
   prev_diff=diff;
   continue;
  }
  
  if(prev_diff>diff)
  {
   if(lips>teeth && teeth>jaw)
    divergence_up++;
   else
   if(lips<teeth && teeth<jaw)
    divergence_down++;
  }
 }
 
 if(divergence_up==comp_count)
  return GATORFORMATION_DIVERGENCEUP;
  
 if(divergence_down==comp_count)
  return GATORFORMATION_DIVERGENCEDOWN;
  
 return GATORFORMATION_CONVERGENCE;
}

//--------------------------------------------------------------------
static gator_trans_formation ax_bar_utils::get_gator_trans_formation(int ma_method,int lips_shift,int teeth_shift,int jaw_shift,int comp_count)
{
 gator_formation gf_cur  =ax_bar_utils::get_gator_formation(ma_method,ax_bar_utils::get_more_period(),lips_shift,teeth_shift,jaw_shift,3);
 gator_formation gf_prev =ax_bar_utils::get_gator_formation(ma_method,ax_bar_utils::get_more_period(),lips_shift+1,teeth_shift+1,jaw_shift+1,3);

 if(gf_prev==GATORFORMATION_CONVERGENCE)
 {
  if(gf_cur==GATORFORMATION_DIVERGENCEUP)
   return GATORTRANSFORMATION_CONVERGENCE_DIVERGENCEUP;
   
  if(gf_cur==GATORFORMATION_DIVERGENCEDOWN)
   return GATORTRANSFORMATION_CONVERGENCE_DIVERGENCEDOWN;
 }
 
 if(gf_prev==GATORFORMATION_DIVERGENCEUP && gf_cur==GATORFORMATION_CONVERGENCE)
  return GATORTRANSFORMATION_DIVERGENCEUP_CONVERGENCE;
  
 if(gf_prev==GATORFORMATION_DIVERGENCEDOWN && gf_cur==GATORFORMATION_CONVERGENCE)
  return GATORTRANSFORMATION_DIVERGENCEDOWN_CONVERGENCE;
  
 return GATORTRANSFORMATION_NONE;
}

//--------------------------------------------------------------------
static gator_formation_trend ax_bar_utils::get_gator_formation_trend(int ma_method,int lips_shift,int teeth_shift,int jaw_shift,int comp_count)
{
 gator_formation gf           =ax_bar_utils::get_gator_formation(ma_method,Period(),lips_shift,teeth_shift,jaw_shift,comp_count);
 gator_formation gf_more      =ax_bar_utils::get_gator_formation(ma_method,ax_bar_utils::get_more_period(),lips_shift,teeth_shift,jaw_shift,comp_count);

 if(gf==GATORFORMATION_DIVERGENCEUP || gf_more==GATORFORMATION_DIVERGENCEUP)
 //if(gf_more==GATORFORMATION_DIVERGENCEUP)
  return GATORFORMATIONTREND_UP;
 else
 if(gf==GATORFORMATION_DIVERGENCEDOWN || gf_more==GATORFORMATION_DIVERGENCEDOWN)
 //if(gf_more==GATORFORMATION_DIVERGENCEDOWN)
  return GATORFORMATIONTREND_DOWN;
 else
 if(gf==GATORFORMATION_CONVERGENCE || gf_more==GATORFORMATION_CONVERGENCE)
 //if(gf_more==GATORFORMATION_CONVERGENCE)
  return GATORFORMATIONTREND_NONE;
   
 return GATORFORMATIONTREND_NONE;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_order_level(trade_mode tm,ax_order_settings& order_set,order_level ol,double magic_value)
{
 ax_point_worker pw(order_set.lot);
 
 double cost_loss   =pw.get_cost(magic_value);
 double cost_profit =pw.get_cost(magic_value)*MathAbs(order_set.profit/order_set.loss);
 
 if(cost_profit>MathAbs(order_set.profit))
  cost_profit=MathAbs(order_set.profit);
  
 if(cost_loss>MathAbs(order_set.loss))
  cost_loss=MathAbs(order_set.loss);

 double retval=0;
 
 if(ol==ORDERLEVEL_TAKEPROFIT)
 {
  double diff=pw.get_points(cost_profit);
  
  if(tm==TRADEMODE_BUY)
   retval=Ask+diff;
  else
  if(tm==TRADEMODE_SELL)
   retval=Bid-diff;
 }
 else
 if(ol==ORDERLEVEL_STOPLOSS)
 {
  double diff=pw.get_points(cost_loss);
  
  if(tm==TRADEMODE_BUY)
   retval=Ask-diff;
  else
  if(tm==TRADEMODE_SELL)
   retval=Bid+diff;
 }
 
 return NormalizeDouble(retval,Digits);
}

//--------------------------------------------------------------------
static bool ax_bar_utils::gator_cross_distance(ax_settings& stgs,MqlRates& rates[],bar_position bp,distance_t dt,double& loc_ext)
{
 loc_ext=0;
 
 if(dt==DISTANCE_GATORINVERTING)
 {
  for(int i=1;i<=(stgs.magic_distance+1);i++)
  {
   if(!ax_bar_utils::current_wave(stgs,rates,bp,i))
    return false;
  }
 
  return true;
 }//if
 
 //DISTANCE_LOCALEXTREMUM
 int ext_shift;
 
 trade_mode tm=(bp==BARPOSITION_UNDERGATOR)?TRADEMODE_SELL:TRADEMODE_BUY;
 
 loc_ext=ax_bar_utils::get_local_extremum(rates,tm,ext_shift,MODE_SMMA,1);
 
 return ext_shift>(stgs.magic_distance+1);
}

//--------------------------------------------------------------------
static bool ax_bar_utils::current_wave(ax_settings& stgs,MqlRates& rates[],bar_position bp,int shift)
{
 double lips =ax_bar_utils::get_gator_val(stgs,MODE_GATORLIPS,1);
 double jaw  =ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,1);

 MqlRates bar=rates[shift];
 
 //if(bp==BARPOSITION_UNDERGATOR && lips<teeth && teeth<jaw/*GATORMODE_REVERSAL*/&& bar.low<jaw)
 if(bp==BARPOSITION_UNDERGATOR && lips<jaw/*GATORMODE_REVERSAL*/&& bar.low<jaw)
 {
  return true;
 }
 else
 //if(bp==BARPOSITION_ABOVEGATOR && lips>teeth && teeth>jaw/*GATORMODE_NORMAL*/&& bar.high>jaw)
 if(bp==BARPOSITION_ABOVEGATOR && lips>jaw/*GATORMODE_NORMAL*/&& bar.high>jaw)
 {
  return true;
 }
 
 return false;
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::get_bar_ma_position(ax_settings& stgs,MqlRates& rates[],bar_position bp,int shift)
{
 return ax_bar_utils::get_bar_ma_position(stgs,rates[shift],bp,shift);
}

//-------------------------------------------------------------------- 
static bool ax_bar_utils::get_bar_ma_position(ax_settings& stgs,MqlRates& bar,bar_position bp,int shift)
{
 double ma=NormalizeDouble(iMA(NULL,0,stgs.ma_period,stgs.ma_shift,stgs.ma_method,stgs.ma_applied_price,shift),Digits);
 
 if(bp==BARPOSITION_UNDERGATOR)
 {
  return bar.high<ma;
 }
 
 if(bp==BARPOSITION_ABOVEGATOR)
 {
  return bar.low>ma;
 }
 
 return false;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::ma_cross_distance(ax_settings& stgs,MqlRates& rates[],bar_position bp,distance_t dt)
{
 if(dt==DISTANCE_GATORINVERTING)
 {
  for(int i=1;i<=(stgs.magic_distance+1);i++)
  {
   if(!ax_bar_utils::current_wave(stgs,rates,bp,i))
    return false;
  }
 
  return true;
 }//if
 
 //DISTANCE_LOCALEXTREMUM
 int ext_shift;
 
 trade_mode tm=(bp==BARPOSITION_UNDERGATOR)?TRADEMODE_SELL:TRADEMODE_BUY;
 
 ax_bar_utils::get_local_ma_extremum(stgs,rates,tm,ext_shift,1);
 
 return ext_shift>(stgs.magic_distance+1);
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_local_ma_extremum(ax_settings& stgs,MqlRates& rates[],trade_mode tm,int start_shift)
{
 int ext_shift; 
 return ax_bar_utils::get_local_ma_extremum(stgs,rates,tm,ext_shift,start_shift);
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_local_ma_extremum(ax_settings& stgs,MqlRates& rates[],trade_mode tm,int& ext_shift,int start_shift)
{
 ext_shift=-1;
 
 double loc_ext=(tm==TRADEMODE_BUY)?rates[start_shift].low:rates[start_shift].high;
 
 double ma;
 
 bool f=false;
 
 for(int i=start_shift;;i++)
 {
  ma=NormalizeDouble(iMA(NULL,0,stgs.ma_period,stgs.ma_shift,stgs.ma_method,stgs.ma_applied_price,i),Digits);
  
  if(tm==TRADEMODE_BUY)
  {
   if(rates[i].low<ma && rates[i].high<ma)
    f=true;
    
   if(rates[i].low>ma && f)
    break;
    
   if(rates[i].low<loc_ext)
   {
    loc_ext=rates[i].low;
    ext_shift=i;
   }
  }//if
  
  if(tm==TRADEMODE_SELL)
  {
   if(rates[i].high>ma && rates[i].low>ma)
    f=true;
    
   if(rates[i].high<ma && f)
    break;
    
   if(rates[i].high>loc_ext)
   {
    loc_ext=rates[i].high;
    ext_shift=i;
   }
  }//if
 }//for
 
 return loc_ext;
}

//--------------------------------------------------------------------
static gator_bar_cross_t ax_bar_utils::get_gator_bar_cross(ax_settings& stgs,MqlRates& bar)
{
 double jaw=ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,1);
 
 //спускаемся от jaw до lips - по значимости
 if(bar.high>jaw && jaw>bar.low)
 {
  //определим тип бара (ТОЛЬКО в случае пересечения с jaw, при пересечении с lips,teeth )
  if(bar.close>ax_bar_utils::get_avg_value(bar))
   return GATORBARCROSS_JAWBULL;

  if(bar.close<ax_bar_utils::get_avg_value(bar))
   return GATORBARCROSS_JAWBEAR;

  return GATORBARCROSS_JAWNONE;
 }

 double lips  =ax_bar_utils::get_gator_val(stgs,MODE_GATORLIPS,1);
 double teeth =ax_bar_utils::get_gator_val(stgs,MODE_GATORTEETH,1);
  
 if((bar.high>teeth && teeth>bar.low) || (bar.high>lips && lips>bar.low))
  return GATORBARCROSS_LIPSTEETH;
  
 return GATORBARCROSS_NONE;
}//get_gator_bar_cross

//--------------------------------------------------------------------
static double ax_bar_utils::get_gator_val(ax_settings& stgs,int mode,int shift,bool normalize)
{
 double v=iAlligator(NULL,
                     0,
                     stgs.jaw_period,
                     stgs.jaw_shift,
                     stgs.teeth_period,
                     stgs.teeth_shift,
                     stgs.lips_period,
                     stgs.lips_shift,
                     stgs.ma_method,
                     stgs.ma_applied_price,
                     mode,
                     shift);
 return normalize?NormalizeDouble(v,Digits):v;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_sar_val(ax_settings& stgs,int shift,bool normalize)
{
 double v=iSAR(NULL,0,stgs.sar_step,stgs.sar_max,shift);
 return normalize?NormalizeDouble(v,Digits):v;
}

//--------------------------------------------------------------------
static bool ax_bar_utils::get_bwmfi_exist_color(MqlRates& rates[],int shift,int count,t_mfivalue mfi_color)
{
 ax_mfi_worker mfi_worker;
 mfi_worker.init(MFIWORKMODE_MFI,false);
 
 for(int i=shift;i<shift+count;i++)
 {
  if(mfi_worker.value(rates,i,mfi_color))
   return true;
 }
 
 return false;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_ax_ind_008(ax_settings& stgs,MqlRates& rates[],int shift,double& _balance_price,int& _cnt)
{
 double balance_price=0;
 
 //находим точку баланса
 int balance_i=shift;
 
 for(int i=shift;;i++)
 {
  double jaw=ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,i);
  
  if(rates[i].low<=jaw && jaw<=rates[i].high)//точка равновесия достигнута
  {
   balance_price =jaw;
   balance_i     =i;
   break;
  }
 }//for
 
#ifdef 0
 double sum=0;
 int cnt=0;
 
 //собираем сумму отклонений
 for(int i=balance_i;i>=shift;i--)
 {
  double typical_price=(rates[i].high+rates[i].low+rates[i].close)/3;
 
  double to_balance_distance=/*MathAbs*/(typical_price-balance_price);
 
  double bw_mfi=(rates[i].high-rates[i].low)/rates[i].tick_volume;
 
  sum+=(bw_mfi==0)?0:to_balance_distance/bw_mfi;
  
  cnt++;
 }
#endif
  
 _balance_price=balance_price;
 
// _cnt=cnt;
 
 double typical_price=(rates[shift].high+rates[shift].low+rates[shift].close)/3;
 
 double to_balance_distance=/*MathAbs*/(typical_price-balance_price);
 
 double bw_mfi=(rates[shift].high-rates[shift].low)/rates[shift].tick_volume;
 
 return (bw_mfi==0)?0:to_balance_distance/bw_mfi;
// return cnt==0?0:sum/cnt;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_ax_ind_009(ax_settings& stgs,MqlRates& rates[],int shift)
{
 bool above_jaw=ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,shift);
 
 double balance_price=0;
 
 //находим точку баланса
 int balance_i=shift;
 
 for(int i=shift;i<5000;i++)
 {
  double jaw=ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,i);
  
  if(above_jaw)
  {
   if(rates[i].high<jaw)//точка равновесия достигнута
   {
    balance_price =jaw;
    balance_i     =i;
    break;
   }
  }
  else
  {
   if(jaw<rates[i].low)//точка равновесия достигнута
   {
    balance_price =jaw;
    balance_i     =i;
    break;
   }
  }
 }//for
 
 double sum=0;
 int cnt=0;
 int sum_cnt=0;
 //собираем сумму отклонений
 for(int i=balance_i;i>=shift;i--)
 {
  double typical_price=(rates[i].high+rates[i].low+rates[i].close)/3;
 
  double jaw=ax_bar_utils::get_gator_val(stgs,MODE_GATORJAW,i);
  
  double to_balance_distance=MathAbs(typical_price-/*balance_price*/jaw);
 
  double bw_mfi=(rates[i].high-rates[i].low)/rates[i].tick_volume;
 
  //sum+=(bw_mfi==0)?0:to_balance_distance/bw_mfi;
  
  cnt++;
  
  sum+=(bw_mfi==0)?0:(to_balance_distance/bw_mfi)*cnt;
  
  sum_cnt+=cnt;
 }
 
 return sum_cnt==0?0:sum/sum_cnt;
}

//--------------------------------------------------------------------
static double ax_bar_utils::get_order_current_loss_to_stoploss(ax_order_settings& order_stgs,int ticket)
{
 if(!OrderSelect(ticket,SELECT_BY_TICKET))
  return -1;
  
 double current_loss=OrderProfit();
 
 if(current_loss>=0)
  return 0;

 if(OrderType()==OP_BUY)
  return (OrderOpenPrice()-Bid)/(OrderOpenPrice()-OrderStopLoss());
 
 if(OrderType()==OP_SELL)
  return (Ask-OrderOpenPrice())/(OrderStopLoss()-OrderOpenPrice());
  
 return 0;
}

//--------------------------------------------------------------------
