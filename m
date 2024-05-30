Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CE47A40;
	Thu, 30 May 2024 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105971; cv=none; b=S3ILWdkKFI0o0FreKWIh83JZ6SAYMbR045lkozu4qtfYNdffidCW7ZHs8D99gUFXI2Vy582F0LkgJm0E4uu2ocfPq42PQsOtkyS2okdrAra5vmaCS5hgwQ/eIgNuAwUHSlU29KSnkcWL/rY6Uk5SrM9K2rTNuNIUSLFxngY7A+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105971; c=relaxed/simple;
	bh=abZe/dx3WO1a/0KTAitU4WVK162HfcTJ9SvDqgkQNGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZry3vKBhXGl5TtcPuwZw3q57lErIRgmR+gFx1eGE7NwH6lPtWn6hxXutJcugkkM9Sk+Exk4RtNOmudOga/EfgHf3vlzqngUqwZq3sIRiamiZR2W9f44ncRXhBp+YmtbhNdL2DgkNUtrq0L8DbyRFDd15Pn1ViTd2SH/qVWJjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbQroQDP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbQroQDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16F5C32786;
	Thu, 30 May 2024 21:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717105970;
	bh=abZe/dx3WO1a/0KTAitU4WVK162HfcTJ9SvDqgkQNGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbQroQDPox/NeV/A1CeNS5vY8k7VjI7fDS9fHoThXfLzv41sj3nTeP5yHH/P/I5+N
	 d0qm6Bj8TB2fveY9smh/5HCu/CeJ2mEWTn4eL8EP6Xc7yNyS8rRdP26tfeQ10Nclca
	 2+PadPARXAkHvM17cCUoaZ2/0+W2STPddN7PEzyvo8AvhJxJWUBgkzY7F6BnfWVWqL
	 qrbBw9LfH985G82dHhm1kRXr9l6+R14lyvrfqA9fM0x82rOK7cBjjNdcNU/QijvjqK
	 VweUByCpyvyat8PG24b35WDDf+zoi1cFDehKaiQKfFVg+MYdCvV2tta3rLaRsZfiZi
	 zmOPH6QnQE8lg==
Date: Thu, 30 May 2024 14:52:48 -0700
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
Message-ID: <20240530215153.GA466604@thelio-3990X>
References: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
 <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
 <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>
 <5426b25f-9c25-4938-99e8-5cdea75e4d3b@paulmck-laptop>
 <214a33ac-d4fa-4d48-ad3c-ad8b00ae1a5e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <214a33ac-d4fa-4d48-ad3c-ad8b00ae1a5e@paulmck-laptop>

On Thu, May 30, 2024 at 10:24:05AM -0700, Paul E. McKenney wrote:
> And for an untested first attempt at a fix.
> 
> What did I mess up this time?  ;-)

An include for cmpxchg-emu.h ;)

  In file included from arch/arm/include/asm/atomic.h:16,
                   from include/linux/atomic.h:7,
                   from include/asm-generic/bitops/lock.h:5,
                   from arch/arm/include/asm/bitops.h:245,
                   from include/linux/bitops.h:63,
                   from include/linux/log2.h:12,
                   from kernel/bounds.c:13:
  arch/arm/include/asm/cmpxchg.h: In function '__cmpxchg':
  arch/arm/include/asm/cmpxchg.h:167:26: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
    167 |                 oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
        |                          ^~~~~~~~~~~~~~
  cc1: some warnings being treated as errors

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 6e43483dd111cf1be58b02a45d0ca729ca2634ba
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu May 30 10:11:31 2024 -0700
> 
>     ARM: Emulate one-byte cmpxchg
>     
>     Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on ARM systems
>     with ARCH < ARMv6K.
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
> index 44667bdb4707a..fd9b99f4dca46 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -162,7 +162,11 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>  	prefetchw((const void *)ptr);
>  
>  	switch (size) {
> -#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
> +#ifdef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
> +	case 1:
> +		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> +		break;
> +#else
>  	case 1:
>  		do {
>  			asm volatile("@ __cmpxchg1\n"
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
