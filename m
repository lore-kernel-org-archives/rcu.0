Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B64E1CA;
	Sat,  7 Dec 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733575358; cv=none; b=aGjlSJ/kRLk3B1mtY5N+fnZ+IxKisTq1HONqzDjNxXWAmT8M/sg9mnGBXemAml/vL2CyN5MRqPA1Zipip3Nw/mi2wLdJClBYoZ5gAfPfJB17uviE7D6nO2/TdUlvCDpMOPq3K0tdZ0imZORisU7JC8q0feHIzH5MkzWaPQmqq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733575358; c=relaxed/simple;
	bh=Vahu2A5IQ5U2nMMtg5c0eFneoPNUsOuq/uX8oVc198E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4qinHrjKjb54YBZs1l6w5C3sJU6XsN5GyDkK44veG0OY7YpwY8tqcSnV4Kbqe1mctYcLYkTBRzXHdtQ7TZi0bQhdbnp2TbFAAT32wEbDKEBeifv9pgKUwyq/DiKUSyrk2UT4TN3pOUl0usHIZQ9CMCqfGLsW0ePEcnOy6hFTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GbcngHe0; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GbcngHe0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GWXs5nsci6RSZyu7C2tDFw2UjBQjPKoN09mgU3dfNOA=; t=1733575355; x=1734180155; 
	b=GbcngHe0YSrIpBCcWfd8pSMoD+XOl3vzpOZw4jcwL5f9hbne7tzihHpDTargVDubWKT20QCvkwg
	Z5yAXkWpISL8/5NKYrRqK2mPNmCf/PENIXXogiOWQJRLrYsc/pgxY4LVx6k27qoKyWDnCQFDyz9iW
	mveEdf8HnSR3TxduRSAnTp1E5JtJE6FNiZ6XI/Gb2K1MYhJfdBnSRDYTe+KcuPqvvlDSov9aAz6p3
	Rx+mnkWzA+F1A3Ev17yh05iBhkexREqePIKAMyYQGFH5eN9ctYBVJ03W6681/cqT+7tcFyMdPUba9
	0XK+6mAA2Db2Ztlpukt2pp7xdPy8Q6kEIgmA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tJu5m-00000003Ink-0CjI; Sat, 07 Dec 2024 13:39:26 +0100
Received: from p57bd9274.dip0.t-ipconnect.de ([87.189.146.116] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tJu5l-00000002Nrf-3NGF; Sat, 07 Dec 2024 13:39:25 +0100
Message-ID: <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Date: Sat, 07 Dec 2024 13:39:25 +0100
In-Reply-To: <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
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

On Sat, 2024-12-07 at 13:33 +0100, Magnus Lindholm wrote:
>=20
> I'll try to dig up an older build environment and see what happens.

I would suggest to just cross-compile the kernel from x86_64 using the
pre-compiled toolchains from kernel.org that I linked to.

> Still if it is a compiler bug,
> I wonder what makes RCU/kernel code trigger this and not other code?

Well, compiler bugs can trigger the most unusual symptoms and issues, so
I wouldn't be too surprised.

> I also notices that the interface-renaming rcu problem which occurs in
> a different part of the
> RCU code, when "fixing" according to the patch supplied previously in
> this thread, the code
> I hit the bug again if I revert from using CFLAGS=3D-02 to just using
> CFLAGS=3D-0. So kernel
> optimization flags can trigger this bug it seems.

Which would even make the compiler more likely to be the suspect.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
