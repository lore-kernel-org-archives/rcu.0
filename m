Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3501FD7B6;
	Fri,  6 Dec 2024 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504770; cv=none; b=E3PDkIQpr0Y6PmvO2jwuYlZlTLAVDirYsVmMVvZDpSVr7Cb17WbLgZq7X2r1EGpeUWGtg0SKGY0JaJof8rCXswLgLE+2nSWn4rofFkf0x5PbGpAN8SqrieALDNihmGDbWN4MvMeRHEKcdO3WCbavwVAVF5BDDN9+GdktL8ZZymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504770; c=relaxed/simple;
	bh=bo2QnQmVRlacr0skYOVAwb0eBgfV83Qly0i/jIZlkg0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxze9ODJtRsb7knYaqN2z6x2UgqX370ds2upVcBri3/N2YdR06Yp2AouEvb+UXDWc8M3mLXRz6aIMRCuIYzTYbkNBGqQxqxM7oykkxEEwJIZfCu+lRvnpKo6nS68pHWHtPzlLZ0L1rfgM9GZTzDpGbIXWbrqcCfFoE8yQ6NL7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=U0fh2ldY; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="U0fh2ldY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tMKYKnpQ8akscdypwAXM1qka29LoIdAXHgDMR8jNBsA=; t=1733504765; x=1734109565; 
	b=U0fh2ldYxOLaZsoKRTUbmpL0m/mPPLeVB08pujP80iYSjYfE6XXsQT4vdTYaQZAVlh4NOZBj8J3
	x90MapDQy/4UMmXMpYD4G1BTfYVDHRBEBVWBkku42Oy/PIX2xNoXiPIL92TOPu+V1YK2E1599zoMa
	lv99SAMzxI6H5ikM/tZRHcDefdmmQ6tR1CaBXXyyUZYtWFAh52OuGR8mDGcyaN3hp/PC53kVEXDFy
	rDpfFoeQpegC6UGVTIE4+4e/dSis/IP3VFBxpXEn/+SpCY7WBt6Zx6Ghwl1iKIevbg1J3bpxg0YRw
	4h14yOBlqppfH/Uwfapytnx4rjT2JkLwrEbQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tJbmA-00000003OZO-1twF; Fri, 06 Dec 2024 18:05:58 +0100
Received: from p5dc55455.dip0.t-ipconnect.de ([93.197.84.85] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tJbmA-00000003d90-0yjq; Fri, 06 Dec 2024 18:05:58 +0100
Message-ID: <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Date: Fri, 06 Dec 2024 18:05:57 +0100
In-Reply-To: <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
References: 
	<CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
	 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop>
	 <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
	 <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop>
	 <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
	 <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
	 <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
	 <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
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

On Fri, 2024-12-06 at 16:39 +0100, Magnus Lindholm wrote:
> It looks like the variable used as loop counter is the value put on the s=
tack
> overwriting the return value for scsi_host_dev_release. When adding
> a reference to the address of this variable or when it is declared
> volatile, stack
> corruption does NOT occur.
>=20
> When examining the disassembly of the code generated from kernel/rcu/tree=
.o
> the most significant difference I can see is that in the case of a
> corrupted stack
> the frame pointer register $fp is used to hold a reference to the loop
> count variable
> but in the case with no stack corruption a regular "saved register" is
> used for the
> reference. Is it possible that the frame pointer is somehow altered
> during the execution
> of the code? not really sure how linux/alpha/gcc treats the frame pointer=
. I've
> tried altering -fomit-frame-pointer/-f-no-omit-frame-pointer but so
> far not getting
> anywhere with that...

Could this maybe a compiler bug? What about building the kernel with an old=
er GCC version from [1]?

Adrian

> [1] https://mirrors.edge.kernel.org/pub/tools/crosstool/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
