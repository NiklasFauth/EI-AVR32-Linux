// Warteschleife
void delay( void ) {
  int i = 10000;
  while( i-- ) {
    asm( "nop" ); //no operation
  }
}
// Hauptteil
int main( void ) {
int * address_gper;
int * address_oder;
int * address_ovr;
//Adresse GPER-Register
address_gper = 0xFFFF1100;
// Adresse ODER-Register
address_oder = 0xFFFF1140;
// Adresse OVR-Register
address_ovr = 0xFFFF1150;
// Aktiviere Pin PB05
*address_gper = 0x20;
// Setze Pin als Ausgang
*address_oder = 0x20;
// Endlosschleife
while( 1 ) {
  // Setze Pin auf High Pegel
  *address_ovr = 0x20;
  delay();
  // Setze Pin auf Low Pegel
  *address_ovr = 0x0;
  delay();
  }
}
