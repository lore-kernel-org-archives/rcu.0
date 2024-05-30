Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572633BB2E;
	Thu, 30 May 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089846; cv=none; b=QgJXVhBpLio76Ii3gOyzjIgjc5c5M2y4Of4FVZ+bM52yYt20fQE8yZgmcN7nBD/tdlMjHS+EuYLZUhfPQODlCDbxnbCueqrfLrQN6sZG7rxPuYS6r9OAQMVjeioMcTUIu85UcDVMghJpe0BY8XGIWj5iIDlMoczUP9vZZCUQ3VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089846; c=relaxed/simple;
	bh=d54xnZcBDV6Dva3qktSnp/JSkQgGLI2/wahpg5F/a6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBx24Zei2E9H4SYbeMfJSrdGEZx2gS+9phXl+0OFc4SNUo/Hj6Y2sZ6YKKxXSQO4iccOtObbat7cMlkSXQ4jEEQC5BklHZCM3ETHVjFfrIq9TDEvwPsKpZoAhcOSVuis2zQu93ND3toMrQfZx+wHWAGgXjZSbKv+xrF3dPnC1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkIHdkOk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkIHdkOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE105C2BBFC;
	Thu, 30 May 2024 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717089845;
	bh=d54xnZcBDV6Dva3qktSnp/JSkQgGLI2/wahpg5F/a6k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IkIHdkOkn+1A4kxZ7Cg+6kqPmXAgte6LX+aqh0TUJPhYazehdQhOHquJOLR37QYYn
	 UqVFq+kArC8WSAU91/Z0+5hfxMwcOZ/bZ8tmU/kn4U8mq5af9sasNnQyiiWBxw840Z
	 gAbEbcU6CKFEgLT1JeEmAI4IwJG4fZO2dxCshyck6+nlK2CzKzPNxW0t69w9byeE+u
	 cf4UHUbjqLVxl5KvtQ6FqoNSSBY00c4zFKadR57p6NrHQreZeqBI6CJrkHR0+GvNw/
	 SFBxytRj1VRW8KgJZ7voNnMQZ1sJAfCXANTXoMIT61A2upaMp01qXsffcpOprUXqZe
	 rmOGL/TBKKZLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0A786CE075F; Thu, 30 May 2024 10:24:05 -0700 (PDT)
Date: Thu, 30 May 2024 10:24:05 -0700
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
Message-ID: <214a33ac-d4fa-4d48-ad3c-ad8b00ae1a5e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
 <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
 <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>
 <5426b25f-9c25-4938-99e8-5cdea75e4d3b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5426b25f-9c25-4938-99e8-5cdea75e4d3b@paulmck-laptop>

On Thu, May 30, 2024 at 09:37:21AM -0700, Paul E. McKenney wrote:
> On Thu, May 30, 2024 at 03:27:58PM +0200, Arnd Bergmann wrote:
> > On Thu, May 30, 2024, at 14:26, Russell King (Oracle) wrote:
> > > On Thu, May 30, 2024 at 05:50:52PM +0530, Naresh Kamboju wrote:
> > >> The arm builds failed on Linux next with gcc-13 and clang-18.
> > >> 
> > >> Config: arm imx_v6_v7_defconfig - failed
> > >> 
> > >> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >> 
> > >> Build log:
> > >> -----
> > >> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
> > >> `rcu_trc_cmpxchg_need_qs':
> > >> update.c:(.text+0x348): undefined reference to `__bad_cmpxchg'
> > >> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
> > >> `rcu_read_unlock_trace_special':
> > >> update.c:(.text+0x41c): undefined reference to `__bad_cmpxchg'
> > >> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
> > >> `trc_read_check_handler':
> > >> update.c:(.text+0x4b0): undefined reference to `__bad_cmpxchg'
> > >> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `trc_inspect_reader':
> > >> update.c:(.text+0x1518): undefined reference to `__bad_cmpxchg'
> > >> arm-linux-gnueabihf-ld: update.c:(.text+0x1548): undefined reference
> > >> to `__bad_cmpxchg'
> > >> arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4):
> > >> more undefined references to `__bad_cmpxchg' follow
> > >> make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > >
> > > You get a reference to __bad_cmpxchg() when someone uses cmpxchg() on
> > > a datatype that there are no CPU instructions to perform the atomic
> > > compare-and-exchange.
> > >
> > > As we support 8-bit, 16-bit and 32-bit, I would expect that we're now
> > > seeing cmpxchg() being used on 64-bit values, which are unsupportable
> > > on 32-bit Arm.
> > 
> > A 64-bit cmpxchg() would fail on most 32-bit architectures,
> > other than armv6k+ and i686+. Since this one fails on
> > an armv6 (non-6k) build, it's probably the added 8-bit
> > cmpxchg() that Paul talked about using for RCU, though I
> > don't see that in linux-next here.
> > 
> > I htink we need to use the emulated cmpxchg8() in
> > __cmpxchg() for this case, just like we do on other
> > architectures that only have word size atomics.
> 
> Thank you all for your testing and analysis!
> 
> I will fix this, and also pull the 8046f3005015 ("rcu-tasks: Remove
> open-coded one-byte cmpxchg() emulation") commit out of my -next pile
> in the meantime.

And for an untested first attempt at a fix.

What did I mess up this time?  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 6e43483dd111cf1be58b02a45d0ca729ca2634ba
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu May 30 10:11:31 2024 -0700

    ARM: Emulate one-byte cmpxchg
    
    Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on ARM systems
    with ARCH < ARMv6K.
    
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
index 44667bdb4707a..fd9b99f4dca46 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -162,7 +162,11 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	prefetchw((const void *)ptr);
 
 	switch (size) {
-#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
+#ifdef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
+	case 1:
+		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
+		break;
+#else
 	case 1:
 		do {
 			asm volatile("@ __cmpxchg1\n"
