Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC52E822;
	Sat,  7 Dec 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733596748; cv=none; b=SvakRMaNIwjBFouvuRSPduDFBYlOOlSb/T84h5OPWPDTFwwwAmhqEj4E3rKD3xcILeuGxjhxkPoFz/96j9bNnP1X0Of+A0A1pwaUHhdO97gNwGbqGbWinQhpVPF3nL2aODclmMbTtwV0ceQeRYc62lGzocynJSgKfIQbkCGMETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733596748; c=relaxed/simple;
	bh=Ad0D5/guKHs3cpPcdMz8BBRgGxrCrw3SHzV4mWfzLdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iV+6PNgWdDY5NKph99wQs8fr5Ni9jsnfAqV8biQFhY/sN8f02nPlNo7TzAL80tBS49ONrbINQ6yfljayA6qFFZuGJHuHq4aoyDwQej3oeXuMTFdcVgJCFdTEKn+ydbK4FdHjtqlfknYh+o9NlcVPUO6lQRrszwXTIjF5u6x4BiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=mHYgf1Vh; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="mHYgf1Vh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DJbSXwsIT+xzRz387aVojwumIhezINfmDJXaO/sBMfc=; t=1733596745; x=1734201545; 
	b=mHYgf1VhhMjYJzd9sqWfZcPyqwMqyK2LjuIYSOvGQ/wRW6VFyH5e2z0h+qLCv93dJKKkfc6OEUG
	yJVzae/5jB7C0AZM/VwXcM8iRc4py6MZ6GFzskgumxnkAj7xNK6JCGzMggGj9xm9x2XVuBMTLsvCV
	d2rlHoViw9KlxprvFvb3JyiLz1YGlKlwgvC/aULHL9jmCWpcf81E57yfFYXIOGsfwEAE2LP3kF+4g
	JxUoOEErQjMjXPruLKTbsxTlu45r8WjWrTte+fUxtwudKa63eBKBqIk0TwBAIElOj9VVUfzP1atpt
	DzW6/luHHZ4h7laOQExPsaF/2f7nnMSFKMlQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tJzhg-00000000DXl-20fc; Sat, 07 Dec 2024 19:38:56 +0100
Received: from p57bd9274.dip0.t-ipconnect.de ([87.189.146.116] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tJzhg-00000003QqU-14Nx; Sat, 07 Dec 2024 19:38:56 +0100
Message-ID: <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Date: Sat, 07 Dec 2024 19:38:55 +0100
In-Reply-To: <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
References: 
	<CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
	 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop>
	 <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
	 <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop>
	 <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
	 <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
	 <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
	 <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
	 <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
	 <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
	 <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
	 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Magnus,

On Sat, 2024-12-07 at 18:33 +0100, Magnus Lindholm wrote:
> Just a short update:
>=20
> Regarding the SCSI module unload problem, building vanilla kernel-6.12.3:
>=20
> alpha-linux-gcc (Gentoo 14.2.1_p20241026 p3): does NOT work
> alpha-linux-gcc (GCC) 8.5.0: Works!!
> alpha-linux-gcc (GCC) 9.5.0: Works!!

Interesting. Have you verified that this diagnosis is 100% reproducible?

I'm asking since since I have now performed some compiler tests with older
GCC versions and the SMP bug [1] is not always reproducible for me.

Changing the GCC version does not make any difference.

> Regarding the network interface rename/rcu_expedited() problem I've
> tried gcc-8.5.0, gcc-9.5.0 and Gentoo 14.2.1_p20241026 p3 same
> results for all three versions, even though the fix is similar, using
> different compiler versions does not fix the issue.

What about here? Is that 100% reproducible? And did you try bisecting this?

Adrian

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D213143

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
