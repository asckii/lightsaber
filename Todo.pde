/*
- use english in the comments
- correct brosse motif
- fuse brosse motifs, jpen and standard
- externalise the drawing section on the brushes
- improve the stroke feature
- bigger button in the menu on 2 columns
- more option on the menu (colors, brush parameters)
- menu on top
- ajouter la pression, la transparence dans le stroke
- stopper le playing des stokes, arréter le stroke
- empécher les clics pendant le playing
- reprendre le playing au moment ou on l'a arrété
- nettoyage code remplacer strokestep dans draw ok

- bug de replay, ne joue pas l'intégralité de la liste de stroke
- nouvelle variable pour gérer le mirroir
 int xop1=strokeStep.getX();
            int yop1=strokeStep.getY();
            int xopp1=strokeStep.getpX();
            int yopp1=strokeStep.getpY();
            float op1Pressure=strokeStep.getPressure();
            int op1Transparency=strokeStep.getTransparency();
            boolean op1Mirrored=strokeStep.getIsMirrored();
            boolean op1Iscleared=strokeStep.getIsCleared();
              brush.setPreviousPoints(xopp1,yopp1);
         drawBrushStroke(brush,xop1,yop1,xopp1,yopp1,op1Pressure,op1Transparency,op1Mirrored,op1Iscleared);
         

*/
