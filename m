Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AF23741;
	Thu, 30 May 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087043; cv=none; b=NIZQGkGCNePVmN3RZQj0HOGRuHPKEaxAY0x4FOcMfhUpZ3HD6IthNpT2Fjlhl3qMnFPmTqpC79jwmPudJttwqv52ks//tQ+cv9I8M4aIvqOFcU1jRUUNafEn4q31DCZmtvcDa1GVsE5ghEGwa6Hd7ykPWBO5Krp/mqOnphO3DMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087043; c=relaxed/simple;
	bh=yn/fdYmK8PBhu+ABX0prZnKWA3P66CT5Svzdiz0nc4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA4ErYO3FrlzrYVu/nq3Pzl3ySdkP2a4uU15p/XCClqcgrEm/HLjSixQuEHtOK9YuQ+Fbw+jk0nP2BfBVq5QxUEIJzYfFyXpj6D6RmpDWdRAAQCWVINeQlJZhucdd8RxdRHW/FvCqWSRivfSLPf0NfhRANm/PV9/czkv15bDeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOy4Yn0m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOy4Yn0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B7BC2BBFC;
	Thu, 30 May 2024 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717087042;
	bh=yn/fdYmK8PBhu+ABX0prZnKWA3P66CT5Svzdiz0nc4E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rOy4Yn0mcZbZiwb6wl8NQ+3quZ45J/4XqfNlIlEtIdQEVGDz1/KLnAJBj5fbBHtv/
	 sGoBY8/Pc7gVUN3XC7ghhjvQdvH5W5ZeMYz5f5QbKPVxwTsXNLTvTlQGb9zJ2q4g2p
	 xq7fUE0jzsmncvEet5XVnO4Ag+MlTZ/6kTjvqpErepo4gz1wc1HebABrn78oWSXDFy
	 nCQfrVU/a9/10y7EICUyK3ylKgA27WoPP7lQtFMFtUzw8tVQ3Cr0dQvHVtOnaO8UaG
	 x4Y7RImOb44aOxuuoO5DleDBdPnIaxo5SuOLz9k5wmLttutdy14ErA4C8u/a756+E/
	 DecZls107cLoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EB5BBCE075F; Thu, 30 May 2024 09:37:21 -0700 (PDT)
Date: Thu, 30 May 2024 09:37:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	rcu <rcu@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Joel Fernandes <joel@joelfernandes.org>, eeraj.upadhyay@kernel.org,
	John Ogness <john.ogness@linutronix.de>, broonie@kernel.org
Subject: Re: arm-linux-gnueabihf-ld:
 kernel/rcu/update.o:update.c:(.text+0x1cc4): more undefined references to
 `__bad_cmpxchg' follow
Message-ID: <5426b25f-9c25-4938-99e8-5cdea75e4d3b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
 <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
 <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>

On Thu, May 30, 2024 at 03:27:58PM +0200, Arnd Bergmann wrote:
> On Thu, May 30, 2024, at 14:26, Russell King (Oracle) wrote:
> > On Thu, May 30, 2024 at 05:50:52PM +0530, Naresh Kamboju wrote:
> >> The arm builds failed on Linux next with gcc-13 and clang-18.
> >> 
> >> Config: arm imx_v6_v7_defconfig - failed
> >> 
> >> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >> 
> >> Build log:
> >> -----
> >> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
> >> `rcu_trc_cmpxchg_need_qs':
> >> update.c:(.text+0x348): undefined reference to `__bad_cmpxchg'
> >> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
> >> `rcu_read_unlock_trace_special':
> >> update.c:(.text+0x41c): undefined reference to `__bad_cmpxchg'
> >> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
> >> `trc_read_check_handler':
> >> update.c:(.text+0x4b0): undefined reference to `__bad_cmpxchg'
> >> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `trc_inspect_reader':
> >> update.c:(.text+0x1518): undefined reference to `__bad_cmpxchg'
> >> arm-linux-gnueabihf-ld: update.c:(.text+0x1548): undefined reference
> >> to `__bad_cmpxchg'
> >> arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4):
> >> more undefined references to `__bad_cmpxchg' follow
> >> make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1
> >
> > You get a reference to __bad_cmpxchg() when someone uses cmpxchg() on
> > a datatype that there are no CPU instructions to perform the atomic
> > compare-and-exchange.
> >
> > As we support 8-bit, 16-bit and 32-bit, I would expect that we're now
> > seeing cmpxchg() being used on 64-bit values, which are unsupportable
> > on 32-bit Arm.
> 
> A 64-bit cmpxchg() would fail on most 32-bit architectures,
> other than armv6k+ and i686+. Since this one fails on
> an armv6 (non-6k) build, it's probably the added 8-bit
> cmpxchg() that Paul talked about using for RCU, though I
> don't see that in linux-next here.
> 
> I htink we need to use the emulated cmpxchg8() in
> __cmpxchg() for this case, just like we do on other
> architectures that only have word size atomics.

Thank you all for your testing and analysis!

I will fix this, and also pull the 8046f3005015 ("rcu-tasks: Remove
open-coded one-byte cmpxchg() emulation") commit out of my -next pile
in the meantime.

							Thanx, Paul
