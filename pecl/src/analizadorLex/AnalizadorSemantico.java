package analizadorLex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AnalizadorSemantico {
	
	private HashMap<String, Variable> listaVariables;
	private ArrayList<String> listaErroresSemanticos;

	public AnalizadorSemantico() {
		this.listaVariables = new HashMap<String, Variable>();
		this.listaErroresSemanticos = new ArrayList<String>();
	}
	
	public void insertarVariables(String tipo, String[] vars){
		for(int i = 0; i<vars.length; i++){                        
            Variable v = new Variable(tipo, "", 0, 0);
            if(this.listaVariables.containsKey(vars[i])){
    			this.listaErroresSemanticos.add("Error Semantico (declaracion repetida): "+vars[i]);
    		}else{
    			this.listaVariables.put(vars[i],v);
    		}
        }
		
	}
	
	public String exp(String op, String exp1, String exp2){
		String[] var1 = exp1.split(",");
		String[] var2 = exp2.split(",");
		if(op.equals("Suma") || op.equals("Resta") || op.equals("Mult") || op.equals("Div")){
			if(var1[0].equals(var2[0]) && var1[0].equals("Integer")){
				getTipoValorVar(var1[1]);
				getTipoValorVar(var2[1]);
				return "Integer, Expr ("+op+"; "+var1[1]+"; "+var2[1]+")";
			} else {
				this.listaErroresSemanticos.add("Error Semantico (no Integer): ("+var1[1]+"; "+var2[1]+")");
				return "noInteger, Expr ("+op+"; "+var1[1]+"; "+var2[1]+")";
			}
		}else {
			if(op.equals("Mayor") || op.equals("Menor") || op.equals("Mayor_Igual") || op.equals("Menor_Igual")){
				if(var1[0].equals(var2[0]) && var1[0].equals("Integer")){
					getTipoValorVar(var1[1]);
					getTipoValorVar(var2[1]);
					return "Boolean, Expr ("+op+"; "+var1[1]+"; "+var2[1]+")";
				} else {
					this.listaErroresSemanticos.add("Error Semantico (no Boolean): ("+var1[1]+"; "+var2[1]+")");
					return "noBoolean, Expr ("+op+"; "+var1[1]+"; "+var2[1]+")";
				}
			}else if(op.equals("Distinto") || op.equals("Igual") || op.equals("And") || op.equals("Or")){
				if(var1[0].equals(var2[0])){
					getTipoValorVar(var1[1]);
					getTipoValorVar(var2[1]);
					return "Boolean, Expr ("+op+"; "+var1[1]+"; "+var2[1]+")";
				} else {
					this.listaErroresSemanticos.add("Error Semantico (no Boolean): ("+var1[1]+"; "+var2[1]+")");
					return "noBoolean, Expr ("+op+"; "+var1[1]+"; "+var2[1]+")";
				}
			}else {
				if(var1[0].equals(var2[0]) && var1[0].equals("Boolean")){
					return "Boolean, Expr ("+op+"; "+var1[1]+"; "+var2[1]+")";
				} else {
					this.listaErroresSemanticos.add("Error Semantico (no Boolean): ("+var1[1]+"; "+var2[1]+")");
					return "noBoolean, Expr ("+op+"; "+var1[1]+"; "+var2[1]+")";
				}
			}
		}
		
		
	}
	
	public String getTipoVar(String id){
		if(! this.listaVariables.containsKey(id)){
			this.listaErroresSemanticos.add("Error Semantico (variable no declarada): "+id);
			return "noInteger,"+id;
		}else{
			return this.listaVariables.get(id).getTipo()+","+id;
		}
	}
	
	public void getTipoValorVar(String id){
		Pattern pat = Pattern.compile("^ide\\([\\w-]+\\)$");
	    Matcher mat = pat.matcher(id);
	    if(mat.find()){
			if(this.listaVariables.get(id).getValor().equals(""))
				this.listaErroresSemanticos.add("Error Semantico (llamada a variable no inivializada): "+id);
	    }
	}
	
	public String asign(String id, String exp1){
		String[] var1 = exp1.split(",");
		String exp2 = getTipoVar(id);
		String[] var2 = exp2.split(",");
		if(var1[0].equals(var2[0])){
			this.listaVariables.get(var2[1]).setValor(exp1);
			return "Asign ("+var2[1]+"; "+var1[1]+")";
			
		}else {
			this.listaErroresSemanticos.add("Error Semantico (asignacion): ("+var2[1]+"; "+var1[1]+") -> "+var1[0]);
			return "Asign ("+var2[1]+"; "+var1[1]+")";
		}
	}
	
	public String condic(String exp1){
		String[] var1 = exp1.split(",");
		if(var1[0].equals("Boolean")){
			return "Condic ("+var1[1]+")";
		}else {
			this.listaErroresSemanticos.add("Error Semantico (condicion): ("+var1[1]+") -> "+var1[0]);
			return "Condic ("+var1[1]+")";
		}
	}
	
	public String read(String exp1){
		String[] var1 = exp1.split(",");
		if(var1[0].equals("Integer")){
			return "Read ("+var1[1]+")";
		}else {
			this.listaErroresSemanticos.add("Error Semantico (read): ("+var1[1]+") -> "+var1[0]);
			return "Read ("+var1[1]+")";
		}
	}
	
	public String write(String exp1){
		String[] var1 = exp1.split(",");
		if(var1[0].equals("Integer") || var1[0].equals("Boolean")){
			return "Write ("+var1[1]+")";
		}else {
			this.listaErroresSemanticos.add("Error Semantico (write): ("+var1[1]+") -> "+var1[0]);
			return "Write ("+var1[1]+")";
		}
	}
	
	public void imprimirErroresSemanticos() {
		System.err.println("Errores Semanticos: \n------------------- ");
		for(String t: this.listaErroresSemanticos){
			System.err.println("\t-->"+t);
		}
		System.err.println("\n");
	}
}
