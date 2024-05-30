Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EF645BE7;
	Thu, 30 May 2024 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093302; cv=none; b=n7eQ2LYT1SXR1tXQ6lw69TDCZLBzJqkBLnE6tD1QZCPuqb+S010NU8iwFHEsMaZC003LRFed1FRRbJCpbceBvaXoN1XTzh8npC195kj58d1BzKzYeCYz7e5WtsAryi5Xuk7pqBjNBZtvpARZuxPY05h1v8PJy4OTjIhckd9Z6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093302; c=relaxed/simple;
	bh=6dQOO04MinyW9E4u0n2nsSoky25+ryVk4N7a+/FDhrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSnyWMGxtWo+Q+w0ykxKyMUQVgSrd/nzkDliBlvFi2i348+kUF2GouEE+3KQR5P++qZouPqBNtSc1yiwdyX6fg5tAefH8dpHYHCDRP7D04NmUjnWYeuEntwN0QRuB/AK5KRjrv9WAdc1YKDaO1Q3BD16F4V7+S+g//0oWbL1lJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHO0V89L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHO0V89L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4E2C2BBFC;
	Thu, 30 May 2024 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717093301;
	bh=6dQOO04MinyW9E4u0n2nsSoky25+ryVk4N7a+/FDhrA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CHO0V89LGzH5wFW93SZ9frknnlgZbTYyC0kuz5CuCNsartYushh+EUK85l3CaPFCL
	 dAFds4FTeTS8nUelvZkafpGbWA81+jL+KgGNItHPgnMrVPWzUzIhm56CCTxsklCzjW
	 IxooqP2t2iyr40g0K9VT5/H5NuDG1iIpjFB39QQZ89mnq1muVPnny3At9/7QBdZi/3
	 fOhBtN+aDuKiKZquVdjPScywGHppo3dkMLVcxFB0bpNa2MD8akLR00eGGZzaBbk4f2
	 uZ56gVc6LPAv6y9t2B6D9KpJ11jpwSRoxATs7txqITSvQ3mV9mF888ki5fpeFWfcai
	 Bsr5BdcOeYR7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D583ACE075F; Thu, 30 May 2024 11:21:40 -0700 (PDT)
Date: Thu, 30 May 2024 11:21:40 -0700
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
	John Ogness <john.ogness@linutronix.de>,
	Mark Brown <broonie@kernel.org>
Subject: Re: arm-linux-gnueabihf-ld:
 kernel/rcu/update.o:update.c:(.text+0x1cc4): more undefined references to
 `__bad_cmpxchg' follow
Message-ID: <2e2038d2-00b5-4f54-884f-d04d7165bbf5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
 <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
 <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>
 <5426b25f-9c25-4938-99e8-5cdea75e4d3b@paulmck-laptop>
 <214a33ac-d4fa-4d48-ad3c-ad8b00ae1a5e@paulmck-laptop>
 <38442e3d-1e43-4894-b126-b4258d331a32@app.fastmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38442e3d-1e43-4894-b126-b4258d331a32@app.fastmail.com>

On Thu, May 30, 2024 at 08:05:50PM +0200, Arnd Bergmann wrote:
> On Thu, May 30, 2024, at 19:24, Paul E. McKenney wrote:
> > On Thu, May 30, 2024 at 09:37:21AM -0700, Paul E. McKenney wrote:
> >> On Thu, May 30, 2024 at 03:27:58PM +0200, Arnd Bergmann wrote:
> 
> > And for an untested first attempt at a fix.
> >
> > What did I mess up this time?  ;-)
> >
> 
> I think only the comment:
> 
> > 
> >  	switch (size) {
> > -#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
> > +#ifdef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
> > +	case 1:
> > +		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> > +		break;
> > +#else
> 
> "min ARCH >= ARMv6K" now applies to the #else side, while the
> #if side is the early ARMv6 (pre-v6K).

Good catch!

I plan to fold the following into the original with attribution.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index fd9b99f4dca46..34674a4118755 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -162,11 +162,11 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	prefetchw((const void *)ptr);
 
 	switch (size) {
-#ifdef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
+#ifdef CONFIG_CPU_V6	/* min ARCH < ARMv6K */
 	case 1:
 		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
 		break;
-#else
+#else /* min ARCH >= ARMv6K */
 	case 1:
 		do {
 			asm volatile("@ __cmpxchg1\n"
