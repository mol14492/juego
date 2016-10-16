from PIL import Image
## FUNCION PARA DEFINIR R,G,B
def colores(r,g,b):
    R = int(round((r*7.0)/255.0))
    G = int(round((g*7.0)/255.0))
    B = int(round((r*3.0)/255.0))
    return(R<<5)+(B<<3)+G
## ABRIMOS LA IMAGEN
datos ='\n'
nombre = 'final'
imagen = Image.open(nombre+'.jpg')
pixel = imagen.load()
## CICLO PARA RECORRER LA IMAGEN
datos+= '.data'+'\n'
datos+= '.align'+'\n'+'\n'
datos+= '.global finalHeight '+'\n'
datos+= 'finalHeight:.word '+str(imagen.size[1])+'\n'
datos+= '.global finalWidth '+'\n'
datos+= 'finalWidth:.word '+str(imagen.size[0])+'\n'
datos+= '.global '+nombre+'\n''\n'
datos+= nombre+':\n'



for j in range(imagen.size[1]):
    list_=[]
    for i in range(imagen.size[0]):
        if len(pixel[i,j])==3:
            r,g,b=pixel[i,j]
        elif len(pixel[i,j])==4:
            r,g,b,a=pixel[i,j]
        else:
            print"ERROR AL RECORRER LA IMAGEN"
            break
        RGB = colores(r,g,b)
        list_.append(RGB)
    datos +='     .byte '+','.join([str(a)for a in list_])+'\n'
print "Se esta generando tu matriz..."
print "..."
print "..."
print "..."
print "..."
print "..."
print "..."
open(nombre+'.s','w').write(datos)
print "Se ha guardado tu matriz!"+nombre
