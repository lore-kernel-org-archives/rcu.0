Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968449CF35
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160211; cv=none; b=vFjfMnwe3pIDCa/mbnz+7ukzEQKUjyI7ABEf/2zuU/HHMV/Wf1+8BlyZYfrUr8TGF12SXOYgJ6qFAXJ2GD+ci/skkpNRGeG38wwXy4HrIZClj+Wh8IHEOd62tHBY4H4IhGvBzWgPq6JuhBeRvra8sZADkZ4Q/MVDxDQKDQLA9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160211; c=relaxed/simple;
	bh=/hAmY6yG2+OCPMJTvRs5ChswnMAkCdLCUN+/9Q9fZh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMkHuIH9XCTfwBmNwlLDhG+LhXY7oKEiaBkLVTLFWWTkZOMkbiGxFKwALOeLc9p3GsGpT1ExdFjeGLFGyf7wzXT3kyo+sIoHoI7n7NZimWg2aVfIMocXI29BTrDMj9vH3ciz6o3ssfUBqchv7xggvm60XBGFm9i79ROk9qBWJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPn+PcDu; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPn+PcDu"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351832so486287f8f.3
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 03:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160195; x=1790764995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t1Z4i78iFUVYmXdwkSYq7EkiOAX8N+OcOOj8F5FsldA=;
        b=CPn+PcDupM2GLmmXqlMvdfReA/3wAJMMUSYOaS0cjHThc+wAddPU6ProYKR6TX3Op8
         s5yp4NHCPEyjnz7+u4HLA0GZuhA0Oj8otUoWv8l47UgGGRHC7RB+QKgleMtdEGjeacfa
         cwEabG/Wu8LWuc8bIYyGd5xPBPTKhj+h6H/S0tmTY0FALjfJyBWvjhnn/7VulmBeSwdo
         kCPPPwzI8RbocchihueTj+H9IkBO631KrCldStcev3UFlDv2I9e43Sa0IglFTP0ilagV
         IGoXnifX2h3lYXLiIng8I1BlirUsIfWEbUsc2wBKREgeXUo6mN+LqTu5n8+SmdxH3DVi
         7McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160195; x=1790764995;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1Z4i78iFUVYmXdwkSYq7EkiOAX8N+OcOOj8F5FsldA=;
        b=1Woh/MZbSBiOZpAkPC5a3jFNRNc1hOr+im3ewR+JBjz50qAUvh+jham02Iail2GJLB
         3oEi62EqBxLN7N6z9VXTqcVqZn5lBl5iBhCHSpKlRK4YgjNPxFPp+/soODcb+CDPL2Ck
         XZbM0MkFH8Qf7drRPGX+L4QpSNqaI4UwxeVa/QS9Z6l5ivW1KUyRW8+m0iiO9YtHhyHc
         Ig1/qD2AmE/85zL7OpIBG+EDX+UDFv5A3ns/pyX0xRZNHDUt1Wi4k/X4eRVcJSQgJbLC
         PrO7NASNxohFkLmn/BwpjUs9bWIsGxSTG0agC62QzjCM59ankOlbluPWbeD/RD+PLyv5
         X7kg==
X-Forwarded-Encrypted: i=1; AKwUvBx7Cq3lpT6/6YGPtfDVyYE+N5+CqrC9zpQ0Mf1tFnhIAk2urwJXfT/+XAAID6OVZxwIxKE=@vger.kernel.org
X-Gm-Message-State: AFuF++lJjFVwd2SwWjA4GNp2VU1B2NapQGwX9DABgkWvb326XEi7Jsdc
	kPhhzqDuVnRXgHFMfKVFYSSsezu7ymt/BLskaXcRjSgakj3vpH6xLoe4fi6Re/io
X-Gm-Gg: AYBFou1Gvay+pY1LjQoG8wPh7+snR11xwH4d/S9ul3/aIH2AHPHC63QsbNJk+Wkgh9E
	4Al8/Iitn1lVCf1Nyp6YLjKbANrSYdskPp5N5RwiKU8vQQYltylPu3hVZVWaouU32XvNofLW5kR
	VaGNnLCkDRYyjiefP6ZhWHcFLcXwq8p+v8qLyDGfv5+zkKQURLTdTg0k/JtrwoawTnXlD2mHtul
	lgFmXMS+QNzGS3JnFCsghrJELSOJfXuTI1HeAu1zCVjtdHQkLDXI0+2Ff0QZEDh3s2f9A9HjkfH
	SJQTQ4Dcl0fS/SAFQ4SviVcGCNCKfmduuN+6DJKYcRh0FbP06pFT1xmwK+uk3b6RZd5pXJoAJKp
	bkiEd7hXkPqEURUld85USLlFyornL3QH1Ci1YBia4LbzGi7A0N+tMZht/ibGLBKd3oTyMQai7kK
	RxH5JGexruW9HBYjC8I5xb53GqxPNXM/S5yC0spOGFFvdF6vQJNezmQHhn0aQ2uLD0G9CcWhvWQ
	LCm9BTtFwGVRsEIKtNUV8/cc54CUYQfzb0sYM5IPNjqkg==
X-Received: by 2002:a5d:64cc:0:b0:487:81c:6de with SMTP id ffacd0b85a97d-48867093ce7mr3896298f8f.34.1790160194918;
        Wed, 23 Sep 2026 03:43:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488687791cdsm5534038f8f.22.2026.09.23.03.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:43:14 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:43:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, boqun@kernel.org, joelagnelf@nvidia.com,
 rcu@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>, "Arnd
 Bergmann" <arnd@arndb.de>, linux-arch@vger.kernel.org, "Vineet Gupta"
 <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org, "Russell King"
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, "Guo Ren"
 <guoren@kernel.org>, linux-csky@vger.kernel.org, "Yoshinori Sato"
 <ysato@users.sourceforge.jp>, "Rich Felker" <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org,
 "Chris Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
Message-ID: <20260923114313.75494970@pumpkin>
In-Reply-To: <20260911192540.20983-2-brads@mainlining.org>
References: <20260911192540.20983-1-brads@mainlining.org>
	<20260911192540.20983-2-brads@mainlining.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 19:25:34 +0000
Bradley Morgan <brads@mainlining.org> wrote:

> cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
> cmpxchg() for the architectures lacking native one-byte atomics.
> The same architectures also lack native two-byte cmpxchg(), where
> such an operation is not supported and either fails to compile via
> BUILD_BUG() or fails to link, because the bad pointer sentinels
> these architectures declare are never defined.
> 
> Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
> word with READ_ONCE(), splices the two target bytes through a union
> and loops on cmpxchg() of the full word until the compare succeeds.
> Like cmpxchg_emu_u8() it is fully ordered.
> 
> The Kconfig symbol gating this file is renamed from
> ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
> selects both the one-byte and the two-byte emulation.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/Kconfig                |  2 +-
>  arch/arc/Kconfig            |  2 +-
>  arch/arm/Kconfig            |  2 +-
>  arch/csky/Kconfig           |  2 +-
>  arch/sh/Kconfig             |  2 +-
>  arch/xtensa/Kconfig         |  2 +-
>  include/linux/cmpxchg-emu.h |  1 +
>  lib/Makefile                |  2 +-
>  lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
>  9 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 3bb2e568f5b1..d56064797e09 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1817,7 +1817,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>  	# strict alignment always, even with -falign-functions.
>  	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
>  
> -config ARCH_NEED_CMPXCHG_1_EMU
> +config ARCH_NEED_CMPXCHG_1_2_EMU

Is it actually worth the churn of changing the name?
Maybe just a comment that say it adds both 1 and 2 byte emulation?

David

>  	bool
>  
...
