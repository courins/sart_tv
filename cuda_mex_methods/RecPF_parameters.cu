/*
	cuda implementation of RecPF algorithm based on matlab function version

	[U,Out] = RecPF(m,n,aTV,aL1,picks,B,TVtype,opts,PsiT,Psi,URange,uOrg) - deklaracja funkcji w Matlabie

	poni�ej przyk�adowe wywo�anie funkcji RecPF w matlabie ze skryptu sart_tv
	[UU,Out_RecPF] = RecPF(nn,nn,aTV,aL1,picks,B,2,opts,PsiT,Psi,range(U(:)),U);

	U - macierz
	U(:) - wektor, dodaje kolejno kolumny macierzy U
	range - dla wektora, zwraca r�nice mi�dzy najbardziej skrajnymi warto�ciami (najmniejsz� i najwi�ksz�)
			innymi s�owy, zwraca najwi�ksz� r�nic� mi�dzy dowolnymi dwoma elementami

	opis parametr�w:
	czy parametr jest skalarem, wektorem, macierz�, typ danych itp.

	m - nn - warto�� typu int
	n - nn - warto�� typu int
	aTV - sta�a double 
	aL1 - sta�a double
	picks - wektor zawieraj�cy indeksy, patrz: picks = find(abs(FB)>thresh);
	B - B = FB(picks); - tworzy wektor B z warto�ciami z macierzy FB odpowiadaj�cymi indeksom picks
	TVtype -- 2 (isotropic) or 1 (anisotropic) (w przyk�adzie warto�� 2)
	opts
	Psit - chyba funkcja
	Psi - chyba funkcja
	URange  - range(U(:))
	uOrg -- (optional) true image - macierz

	-----w sart_tv: ----------
	fb = FB(:);
	U = reshape(xx,nn,nn); 
    FB = fft2(U)/nn;%sqrt(n);
	thresh = var(abs(fb))*median(abs(fb(2:end)))*max(10+k,10+K);%(K-k+1);
    picks = find(abs(FB)>thresh);
	B = FB(picks);
	----------------------------

	tresh - ta warto�� jest obliczana w spos�b do�� skomplikowany
	
	picks, B oraz U, kt�re s� argumentami w wywo�aniu RecPF
	B = FB(picks); - tworzy wektor B z warto�ciami z macierzy FB odpowiadaj�cymi indeksom picks
*/

/*
algorytm do obliczania Denom2 = abs(psf2otf([prd,-prd],[m,n])).^2 + abs(psf2otf([prd;-prd],[m,n])).^2; 

abs(psf2otf([prd,-prd],[m,n])).^2 = abs(fft([prd,-prd], n)).^2 (gdzie fft daje tylko wiersz, kt�ry nale�y powieli�)
abs(psf2otf([prd;-prd],[m,n])).^2 = abs(fft([prd;-prd], m)).^2 (gdzie fft daje tylko kolumn�, kt�r� nale�y powieli�)

*/


