Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5577603F;
	Mon, 27 Jan 2025 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737978979; cv=none; b=QV83+kYfBpcvg5mhbGjmoti3j/8UWk1OWqMCEURhPOZZo6wLQbPJCm+fQg/AlqI5zkJAnQpiWSTq8hMzcNKcrHxZr+cQwQejfLu6LCrx+HmzEjR8Jh34UlGpnjNcnP0FOoqnMC65Lh0Y5kCHfTDInWC+2Vkp+KJEYjR//4S0+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737978979; c=relaxed/simple;
	bh=1wi9Ig758KGtlnN9mAOzoBH/tSbhBIYVaA7UzS+I/T8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQxuCVbcS5DVFXo/QtxtU7Pzuvu4wMmB0Tz4f5OKm/bbsGX9NkYr4MRBxwVsGcGaamkJAEJuUtO4vX5DY+YB7La1YnohhN0cFijIc063KApLaJ6ObgCOF+A+ZwfIKG4HEPuT3GT2xt+AmXgxVJNDBWfSzHhE9g/Opbf8INU57Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=QkXr7Utc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="QkXr7Utc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AeHZr9lb2YGAuEV+Usz5T3oJRjswBRVc3wjjVA2umVU=; t=1737978976; x=1738583776; 
	b=QkXr7UtcXUSQIIMGAb6wAGWxl1EUKc94cbYSOMb2knZ8Iog4VeahjUqKT0B1tMmguY72AxoHjlr
	S41tMkCTYInfDe6KRxrT9xd53PsLNGYHaTdmoTSH31P1Zap8U7Egy1nV7WRPo/V3QCGnoM4jWaNEK
	w8++lf3S2L5MQ2pnsEy40XCMDJpwlMO/6ra//3gXyY3LBcFk2dYNwr7qJqIrNMr44uiW+wmoSgV0l
	QoZfFb4tQS3h9A1hh5xgKy2H1qYDq9Vmed6KcTdrsS2h7XhZ5nvPPGqhuQl54i44OBs9TiTuxtKK1
	ZzbA1f1HTe/vGlqiGf64k0OFQX3LSPImxQOw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tcNiv-00000001kr0-2tdE; Mon, 27 Jan 2025 12:56:13 +0100
Received: from p5dc55cec.dip0.t-ipconnect.de ([93.197.92.236] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tcNiv-00000002o2g-1skd; Mon, 27 Jan 2025 12:56:13 +0100
Message-ID: <7cb0424e327d8492c192e99f4276569b4de5ae80.camel@physik.fu-berlin.de>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ivan Kokshaysky <ink@unseen.parts>, Magnus Lindholm <linmag7@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Paul E. McKenney"	
 <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>,
 rcu@vger.kernel.org, 	linux-alpha@vger.kernel.org
Date: Mon, 27 Jan 2025 12:56:12 +0100
In-Reply-To: <Z5dykQAAMSo6r8oS@minute>
References: <Z5UAFAD6xCSpKJYw@minute>
	 <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>
	 <Z5Uit9F7xF0ZlMk2@minute>
	 <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk>
	 <alpine.DEB.2.21.2501251839440.27203@angie.orcam.me.uk>
	 <Z5U__sztq2P2UKWk@minute>
	 <alpine.DEB.2.21.2501252129060.27203@angie.orcam.me.uk>
	 <Z5Vtl8PzOY66bp9K@minute> <Z5Y__QtiySs8UeTK@minute>
	 <CA+=Fv5QOxs4mp0CEiyhFQJNxunye1aJMXDSzZ5U04QeQEYzt+A@mail.gmail.com>
	 <Z5dykQAAMSo6r8oS@minute>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ivan,

On Mon, 2025-01-27 at 12:48 +0100, Ivan Kokshaysky wrote:
> On Sun, Jan 26, 2025 at 08:15:41PM +0100, Magnus Lindholm wrote:
> > I've applied the patches provided by Ivan, so far both systems are
> > running fine, compiling kernels and such to provide some load.
>=20
> Thanks, Magnus! I'm going to submit this patchset in a couple of days.

Can we also get a fix for the SET_PERSONALITY() issue?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
