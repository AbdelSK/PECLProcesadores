package analizadorLex;

public class Simbolo {
	//M�todos de los atributos de la clase
    public String token;
    public String tipo;
    public int linea;
    public int columna;
    
	Simbolo (String token, String tipo, int linea, int columna){
        //String del token reconocido
        this.token = new String(token);
        //Tipo de componente l�xico encontrado
        this.tipo = tipo;
        //N�mero de linea
        this.linea = linea;
        //Columna donde empieza el primer car�cter del token
        this.columna = columna;
    }
    
    //Metodo que devuelve los datos necesarios que escribiremos en un archive de salida
    public String toString() {
        return tipo;
    }
}
