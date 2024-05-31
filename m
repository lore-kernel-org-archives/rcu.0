Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A2156242;
	Fri, 31 May 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172845; cv=none; b=kNM38VIcOz/WpwEcIANKTWaWCRRtDQJp8neDldJUFgB28/zy3oH/N2u1oJFxbgfRvdIJzO0kvFX9hOOxtM9xSKItnp7VoS0bzsUaC6ZLZDx2q17mmDYFMCXIKbsMyPmHrGHPF4UhzefHg+HRNMQsz5GrYbnLHQ5YLcv1dTV4CdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172845; c=relaxed/simple;
	bh=ecoXL1wsIA5fkWzBdr7jqwtQqJae5/Uq3EHoVq/zF/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXYDNj/p64fUM5ruFGlT5kv93SPJ9CZbLy7MDB3ONgoN0C87N9DMXDCiACPOc7Bs3OrOWL4/v4i2JsaHkoL6iVlf+gT7o7sEcl5T/L+DVq8gmd2hJtbWmzaXfm+/f1JBNrlV5yuXoTtG5GNSN0f7f5E40CABp7TEicUrSGi13fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O86N8HRJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O86N8HRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A75C2BD10;
	Fri, 31 May 2024 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717172844;
	bh=ecoXL1wsIA5fkWzBdr7jqwtQqJae5/Uq3EHoVq/zF/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O86N8HRJi3gbSo3LXmBnxmhaLtb156SpOuFp1h94f/jsMv9ej/5cIKlQOjOUarIbj
	 +q/PwtGot6kFXj9G9jwICkfniMPu3ouHLLNKaI7erpuxfRaJ0eLTc95F+8vMo0ywXn
	 p3Jj8HYdAhK8pwwEslShZ4nBYzOc4NfN1fgIfjLQ9q0bhvJL7pZzAPCSc9JYQJ4Pci
	 x1YOSVzNCgihHsnQxVgVTjfFUYyuCaQJo8Eg42YCrIv5ozNy9molyFEDD9n0Ox4yiq
	 pwMQB6M/krDrusYRsrlyl1/DvbtGzVn4IH3epmMVAyQY51feXBntaT9Klov8l9EzqQ
	 z0f4S7OgZxZKw==
Date: Fri, 31 May 2024 09:27:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	rcu <rcu@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Joel Fernandes <joel@joelfernandes.org>, neeraj.upadhyay@kernel.org,
	John Ogness <john.ogness@linutronix.de>, broonie@kernel.org
Subject: Re: arm-linux-gnueabihf-ld:
 kernel/rcu/update.o:update.c:(.text+0x1cc4): more undefined references to
 `__bad_cmpxchg' follow
Message-ID: <20240531162722.GA1457604@thelio-3990X>
References: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
 <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
 <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>
 <5426b25f-9c25-4938-99e8-5cdea75e4d3b@paulmck-laptop>
 <214a33ac-d4fa-4d48-ad3c-ad8b00ae1a5e@paulmck-laptop>
 <20240530215153.GA466604@thelio-3990X>
 <583e2476-50c5-4f9c-85af-f4489a53083b@paulmck-laptop>
 <20240530233053.GA1601862@thelio-3990X>
 <3ce74da3-0b21-439b-af72-e80bfe0e9f02@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce74da3-0b21-439b-af72-e80bfe0e9f02@paulmck-laptop>

On Thu, May 30, 2024 at 05:35:44PM -0700, Paul E. McKenney wrote:
> On Thu, May 30, 2024 at 04:30:53PM -0700, Nathan Chancellor wrote:
> > On Thu, May 30, 2024 at 03:05:21PM -0700, Paul E. McKenney wrote:
> > > On Thu, May 30, 2024 at 02:52:48PM -0700, Nathan Chancellor wrote:
> > > > On Thu, May 30, 2024 at 10:24:05AM -0700, Paul E. McKenney wrote:
> > > > > And for an untested first attempt at a fix.
> > > > > 
> > > > > What did I mess up this time?  ;-)
> > > > 
> > > > An include for cmpxchg-emu.h ;)
> > > > 
> > > >   In file included from arch/arm/include/asm/atomic.h:16,
> > > >                    from include/linux/atomic.h:7,
> > > >                    from include/asm-generic/bitops/lock.h:5,
> > > >                    from arch/arm/include/asm/bitops.h:245,
> > > >                    from include/linux/bitops.h:63,
> > > >                    from include/linux/log2.h:12,
> > > >                    from kernel/bounds.c:13:
> > > >   arch/arm/include/asm/cmpxchg.h: In function '__cmpxchg':
> > > >   arch/arm/include/asm/cmpxchg.h:167:26: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
> > > >     167 |                 oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> > > >         |                          ^~~~~~~~~~~~~~
> > > >   cc1: some warnings being treated as errors
> > > 
> > > Good catch, and thank you for testing this!  Does the updated version
> > > shown below do better?
> > 
> > Yes, that matches what I tested locally before I replied initially.
> 
> Very good!  May I please add your Tested-by?

Sure thing.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> > > ------------------------------------------------------------------------
> > > 
> > > commit 74e3470afacaa9d2f37db4773a5fef887ac4ef56
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Thu May 30 10:11:31 2024 -0700
> > > 
> > >     ARM: Emulate one-byte cmpxchg
> > >     
> > >     Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on ARM systems
> > >     with ARCH < ARMv6K.
> > >     
> > >     [ paulmck: Apply Arnd Bergmann and Nathan Chancellor feedback. ]
> > >     
> > >     Reported-by: Mark Brown <broonie@kernel.org>
> > >     Closes: https://lore.kernel.org/all/54798f68-48f7-4c65-9cba-47c0bf175143@sirena.org.uk/
> > >     Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >     Closes: https://lore.kernel.org/all/CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com/
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >     Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> > >     Cc: Arnd Bergmann <arnd@arndb.de>
> > >     Cc: Andrew Davis <afd@ti.com>
> > >     Cc: Andrew Morton <akpm@linux-foundation.org>
> > >     Cc: Linus Walleij <linus.walleij@linaro.org>
> > >     Cc: Eric DeVolder <eric.devolder@oracle.com>
> > >     Cc: Rob Herring <robh@kernel.org>
> > >     Cc: <linux-arm-kernel@lists.infradead.org>
> > > 
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index ee5115252aac4..a867a7d967aa5 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -34,6 +34,7 @@ config ARM
> > >  	select ARCH_MIGHT_HAVE_PC_PARPORT
> > >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> > >  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
> > > +	select ARCH_NEED_CMPXCHG_1_EMU if CPU_V6
> > >  	select ARCH_SUPPORTS_ATOMIC_RMW
> > >  	select ARCH_SUPPORTS_CFI_CLANG
> > >  	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
> > > diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> > > index 44667bdb4707a..a428e06fe94ee 100644
> > > --- a/arch/arm/include/asm/cmpxchg.h
> > > +++ b/arch/arm/include/asm/cmpxchg.h
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/irqflags.h>
> > >  #include <linux/prefetch.h>
> > >  #include <asm/barrier.h>
> > > +#include <linux/cmpxchg-emu.h>
> > >  
> > >  #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
> > >  /*
> > > @@ -162,7 +163,11 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> > >  	prefetchw((const void *)ptr);
> > >  
> > >  	switch (size) {
> > > -#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
> > > +#ifdef CONFIG_CPU_V6	/* min ARCH < ARMv6K */
> > > +	case 1:
> > > +		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> > > +		break;
> > > +#else /* min ARCH >= ARMv6K */
> > >  	case 1:
> > >  		do {
> > >  			asm volatile("@ __cmpxchg1\n"
