Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3455896;
	Thu, 30 May 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111856; cv=none; b=XdOJ9KYS8yTI8Eb9E7RLXv4rtGAXSunVDH93isAQ7CXeX8VoNvbf1vi9bsX/+qmwmBftRv20d14e31I515LI1yxNibSOAVlyybtwHAjcEcYjoNj8XNktgzwzNcD4QIJY06ybS5fKuuGC95aGTLMhvk8TjRFKLntcZLMZFjjbwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111856; c=relaxed/simple;
	bh=Zw6cDfQf5VbvhXG1V2J4XmsCsJdE0FaVJA1swU9GMUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozk0bMx6BrbV7rilFaQmL3D4DT2qWMkUtjxuUXHzwwPjOtB63ET4fvb1ASPbyCCpa3Ba/htwFXWUJJcDw8Olbueytq/RWAWa6xkXJmBLe5uSm0DA8wjSbBIPBzJYRODpHQq1kOVEj0ASCo5zEU8ZdEcR3vspzxHFpFonwq4TtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xpi48WWg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xpi48WWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584DFC2BBFC;
	Thu, 30 May 2024 23:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717111856;
	bh=Zw6cDfQf5VbvhXG1V2J4XmsCsJdE0FaVJA1swU9GMUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xpi48WWg2RTfz2qnKxQ7nYoSBACvnHLuLZ0koxoO8Mb1bETvD9q2ztwSqnSQuuEU6
	 oJfAUxDBwMs3l48E1dmLGy1CYvEIr8b4jAkYYGavX0UvIUE95cOjQcbZbZIFhfY4ai
	 GpnzX3bfCNqy8gi9Rfclz2sI9b0bEGwJkLsQ3+/WvDtPqsPIJxnr2TBEz3Kq10lsQM
	 fykm+SGT5dX5qnGftk3X0kGMNZl6QAk2qjZ3yNbolLub9q5W8qobBFJFjjnZ5nsMss
	 Eanj4GhuRJVaoyLFD1djnSKu5R8Lr8+oDkoAFZGTBgdC+zsWjRNt/KClIuXeF8SbfN
	 w2ZP0n+6Bv+Hw==
Date: Thu, 30 May 2024 16:30:53 -0700
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
Message-ID: <20240530233053.GA1601862@thelio-3990X>
References: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
 <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
 <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>
 <5426b25f-9c25-4938-99e8-5cdea75e4d3b@paulmck-laptop>
 <214a33ac-d4fa-4d48-ad3c-ad8b00ae1a5e@paulmck-laptop>
 <20240530215153.GA466604@thelio-3990X>
 <583e2476-50c5-4f9c-85af-f4489a53083b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <583e2476-50c5-4f9c-85af-f4489a53083b@paulmck-laptop>

On Thu, May 30, 2024 at 03:05:21PM -0700, Paul E. McKenney wrote:
> On Thu, May 30, 2024 at 02:52:48PM -0700, Nathan Chancellor wrote:
> > On Thu, May 30, 2024 at 10:24:05AM -0700, Paul E. McKenney wrote:
> > > And for an untested first attempt at a fix.
> > > 
> > > What did I mess up this time?  ;-)
> > 
> > An include for cmpxchg-emu.h ;)
> > 
> >   In file included from arch/arm/include/asm/atomic.h:16,
> >                    from include/linux/atomic.h:7,
> >                    from include/asm-generic/bitops/lock.h:5,
> >                    from arch/arm/include/asm/bitops.h:245,
> >                    from include/linux/bitops.h:63,
> >                    from include/linux/log2.h:12,
> >                    from kernel/bounds.c:13:
> >   arch/arm/include/asm/cmpxchg.h: In function '__cmpxchg':
> >   arch/arm/include/asm/cmpxchg.h:167:26: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
> >     167 |                 oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> >         |                          ^~~~~~~~~~~~~~
> >   cc1: some warnings being treated as errors
> 
> Good catch, and thank you for testing this!  Does the updated version
> shown below do better?

Yes, that matches what I tested locally before I replied initially.

Thanks for the quick fix!

Cheers,
Nathan

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 74e3470afacaa9d2f37db4773a5fef887ac4ef56
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu May 30 10:11:31 2024 -0700
> 
>     ARM: Emulate one-byte cmpxchg
>     
>     Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on ARM systems
>     with ARCH < ARMv6K.
>     
>     [ paulmck: Apply Arnd Bergmann and Nathan Chancellor feedback. ]
>     
>     Reported-by: Mark Brown <broonie@kernel.org>
>     Closes: https://lore.kernel.org/all/54798f68-48f7-4c65-9cba-47c0bf175143@sirena.org.uk/
>     Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>     Closes: https://lore.kernel.org/all/CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com/
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
>     Cc: Arnd Bergmann <arnd@arndb.de>
>     Cc: Andrew Davis <afd@ti.com>
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: Linus Walleij <linus.walleij@linaro.org>
>     Cc: Eric DeVolder <eric.devolder@oracle.com>
>     Cc: Rob Herring <robh@kernel.org>
>     Cc: <linux-arm-kernel@lists.infradead.org>
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ee5115252aac4..a867a7d967aa5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -34,6 +34,7 @@ config ARM
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
> +	select ARCH_NEED_CMPXCHG_1_EMU if CPU_V6
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_SUPPORTS_CFI_CLANG
>  	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> index 44667bdb4707a..a428e06fe94ee 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -5,6 +5,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/prefetch.h>
>  #include <asm/barrier.h>
> +#include <linux/cmpxchg-emu.h>
>  
>  #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
>  /*
> @@ -162,7 +163,11 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>  	prefetchw((const void *)ptr);
>  
>  	switch (size) {
> -#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
> +#ifdef CONFIG_CPU_V6	/* min ARCH < ARMv6K */
> +	case 1:
> +		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> +		break;
> +#else /* min ARCH >= ARMv6K */
>  	case 1:
>  		do {
>  			asm volatile("@ __cmpxchg1\n"
