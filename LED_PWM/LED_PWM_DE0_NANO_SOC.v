/*******************************************************************************
 * @dosya    PWM Sinyal Üretim Uygulaması
 * @yazar    Erkan ÇİL
 * @sürüm    V0.0.2
 * @tarih    18-Ağustos-2016
 * @özet     DE0_NANO_SOC PWM LED Uygulaması 
 * 
 * Bu örnek uygulamada, DE0_NANO_SOC kartını ile PWM Sinyalleri 
 * üretilecek, bu sinyaller ile LED'in parlaklığı kontrol edilecektir. 
 ******************************************************************************
 *
 * Bu program özgür yazılımdır: Özgür Yazılım Vakfı tarafından yayımlanan GNU 
 * Genel Kamu Lisansı’nın sürüm 3 ya da (isteğinize bağlı olarak) daha sonraki
 * sürümlerinin hükümleri altında yeniden dağıtabilir ve/veya değiştirebilirsiniz.
 *
 ******************************************************************************/
module LED_PWM_DE0_NANO_SOC(
// LED PWM DE0_NANO_SOC MODÜLÜ TANIMI
//-------------Giriş Portları-----------------------------
	input saatDarbesi,	//saatDarbesi giriş olarak tanımlanmıştır
	input FPGA_CLK2_50,
	input FPGA_CLK3_50,
//-------------Çıkış Portları Veri Tipleri------------------ 
// Çıkış portları bellek elemanı(reg-yazmaç) veya bir tel olabilir
	output reg		     [7:0]		LED
);
//-------------Parametre Tanımlamaları-------------------- 
parameter N=28;
//-------------Çıkış Portları Veri Tipleri------------------ 
// Çıkış portları bellek elemanı(reg-yazmaç) veya bir tel olabilir
reg [N-1:0] sayac; //28 bit sayac değişkeni tanımlaması
reg [30:0] sayac2; //31 bit sayac2 değişkeni tanımlaması
//------------Kod Burada Başlamaktadır------------------------- 
// Ana döngü bloğu
// Bu sayaç yükselen kenar tetiklemeli olduğundan,
// Bu bloğu saatin yükselen kenarına göre tetikleyeceğiz.
always @(posedge saatDarbesi) 
begin
	sayac<=sayac+1;
end

always @(posedge saatDarbesi) 
begin
	sayac2<=sayac2+1;
end
// PWM sinyalinin aşağı ve yukarı eğiminin koşullu operatörün kullanılması ile üretilmesi
wire [6:0] PWM_Giris = sayac[N-1] ? sayac[N-1:N-7] : ~sayac[N-1:N-7];    
reg [6:0] PWM;		//reg tipinde PWM 7 bitlik değişken vektörünün tanımlanması
always @(posedge saatDarbesi) 
	begin
	PWM <= PWM[5:0]+PWM_Giris; 
	//PWM değişkeni ile PWM giriş değerinin toplanıp gene PWM değişkenine aktarılması
	begin
	case(sayac2[30:28])		//sayac2 göre 0'dan, 7'ye PWM çıkışının aktarılması	
	 0: LED[0] <= PWM[6]; 	//PWM sinyalinin  0. LED çıkışına tanımlanması
	 1: LED[1] <= PWM[6]; 	//PWM sinyalinin  1. LED çıkışına tanımlanması
	 2: LED[2] <= PWM[6]; 	//PWM sinyalinin  2. LED çıkışına tanımlanması
	 3: LED[3] <= PWM[6]; 	//PWM sinyalinin  3. LED çıkışına tanımlanması
	 4: LED[4] <= PWM[6]; 	//PWM sinyalinin  4. LED çıkışına tanımlanması
	 5: LED[5] <= PWM[6]; 	//PWM sinyalinin  5. LED çıkışına tanımlanması
	 6: LED[6] <= PWM[6]; 	//PWM sinyalinin  6. LED çıkışına tanımlanması
	 7: LED[7] <= PWM[6]; 	//PWM sinyalinin  7. LED çıkışına tanımlanması
	 endcase
	end
end
endmodule

