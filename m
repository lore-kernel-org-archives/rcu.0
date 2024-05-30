Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405A2B9A6;
	Thu, 30 May 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717106722; cv=none; b=CqwCrxVl2jXW2Y5VasPvmWTLKc46Xplq7NE3z2Gcusunq2W45jx2rzetOvk0XPPn3bJyPP/wp4U826sMkppNE6zatk6V7M0CqpQ+0eWoAadIUC370lDWVlfkhGt1UQAE8sv6vyPmy2cGXnGRc+zHKBvcmVYhi9sJUv8IBHp3HmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717106722; c=relaxed/simple;
	bh=KDgY8Hpq/UXiSRV1+dA+4sdL0f8z7YBjBjWwd0a8uro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5jUDLe0RyGIbitbdsS0qDAphGy4vTcAxxMOfqz5KnYJgg0PO9nQTaLxD46Bt8gFnGoIVgou809JuqQeWDL1IECR/89YKwZWpMBAHf8pQyVQapjafleTsqirbdf2fotwEAxZnz+jopbOlCRGH98S3R1ZuySbmqkSafpIPTqM6cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3xVIumn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3xVIumn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297E9C2BBFC;
	Thu, 30 May 2024 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717106722;
	bh=KDgY8Hpq/UXiSRV1+dA+4sdL0f8z7YBjBjWwd0a8uro=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C3xVIumnBhsoMWLjyGWXXvcKfL1mfgKG0C6UL36chiyQDZMo3QFT8Bgc4y88MCubO
	 bM/Za1pod0ioX8JEjSdo9at4Q8Tlp/MMI6ctteYcluqWxoGYnayZ6kJl1Xrlt3CiQ8
	 U6ngPNNUXyK178piD6hXVbDMwvn0UO3qXMQGbyNyWzpHAXto/UfEgZnseMmP0Uuogr
	 JkaeqEjufl582CEDXTWWhe01On8/1Vs8J1quI5GyL5FgPp0+8HFG7w06lX6uxdp/FP
	 vCf1BjsIudlSp4qPr/sH1cZxVByHhr20ddQCPmyJd5Qcocvf+Ca+x/oJZBFtb8dmCq
	 /5VOHCOqZWgHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50F6CCE095C; Thu, 30 May 2024 15:05:21 -0700 (PDT)
Date: Thu, 30 May 2024 15:05:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
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
Message-ID: <583e2476-50c5-4f9c-85af-f4489a53083b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
 <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
 <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>
 <5426b25f-9c25-4938-99e8-5cdea75e4d3b@paulmck-laptop>
 <214a33ac-d4fa-4d48-ad3c-ad8b00ae1a5e@paulmck-laptop>
 <20240530215153.GA466604@thelio-3990X>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530215153.GA466604@thelio-3990X>

On Thu, May 30, 2024 at 02:52:48PM -0700, Nathan Chancellor wrote:
> On Thu, May 30, 2024 at 10:24:05AM -0700, Paul E. McKenney wrote:
> > And for an untested first attempt at a fix.
> > 
> > What did I mess up this time?  ;-)
> 
> An include for cmpxchg-emu.h ;)
> 
>   In file included from arch/arm/include/asm/atomic.h:16,
>                    from include/linux/atomic.h:7,
>                    from include/asm-generic/bitops/lock.h:5,
>                    from arch/arm/include/asm/bitops.h:245,
>                    from include/linux/bitops.h:63,
>                    from include/linux/log2.h:12,
>                    from kernel/bounds.c:13:
>   arch/arm/include/asm/cmpxchg.h: In function '__cmpxchg':
>   arch/arm/include/asm/cmpxchg.h:167:26: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
>     167 |                 oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
>         |                          ^~~~~~~~~~~~~~
>   cc1: some warnings being treated as errors

Good catch, and thank you for testing this!  Does the updated version
shown below do better?

							Thanx, Paul

------------------------------------------------------------------------

commit 74e3470afacaa9d2f37db4773a5fef887ac4ef56
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu May 30 10:11:31 2024 -0700

    ARM: Emulate one-byte cmpxchg
    
    Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on ARM systems
    with ARCH < ARMv6K.
    
    [ paulmck: Apply Arnd Bergmann and Nathan Chancellor feedback. ]
    
    Reported-by: Mark Brown <broonie@kernel.org>
    Closes: https://lore.kernel.org/all/54798f68-48f7-4c65-9cba-47c0bf175143@sirena.org.uk/
    Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
    Closes: https://lore.kernel.org/all/CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com/
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Andrew Davis <afd@ti.com>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Linus Walleij <linus.walleij@linaro.org>
    Cc: Eric DeVolder <eric.devolder@oracle.com>
    Cc: Rob Herring <robh@kernel.org>
    Cc: <linux-arm-kernel@lists.infradead.org>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ee5115252aac4..a867a7d967aa5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -34,6 +34,7 @@ config ARM
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
+	select ARCH_NEED_CMPXCHG_1_EMU if CPU_V6
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_CFI_CLANG
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 44667bdb4707a..a428e06fe94ee 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -5,6 +5,7 @@
 #include <linux/irqflags.h>
 #include <linux/prefetch.h>
 #include <asm/barrier.h>
+#include <linux/cmpxchg-emu.h>
 
 #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
 /*
@@ -162,7 +163,11 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	prefetchw((const void *)ptr);
 
 	switch (size) {
-#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
+#ifdef CONFIG_CPU_V6	/* min ARCH < ARMv6K */
+	case 1:
+		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
+		break;
+#else /* min ARCH >= ARMv6K */
 	case 1:
 		do {
 			asm volatile("@ __cmpxchg1\n"
