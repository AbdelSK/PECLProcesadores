package analizadorLex;

public class Simbolo {
	//Métodos de los atributos de la clase
    public String token;
    public String tipo;
    public int linea;
    public int columna;
    
	Simbolo (String token, String tipo, int linea, int columna){
        //String del token reconocido
        this.token = new String(token);
        //Tipo de componente léxico encontrado
        this.tipo = tipo;
        //Número de linea
        this.linea = linea;
        //Columna donde empieza el primer carácter del token
        this.columna = columna;
    }
    
    //Metodo que devuelve los datos necesarios que escribiremos en un archive de salida
    public String toString() {
        return tipo;
    }
}
