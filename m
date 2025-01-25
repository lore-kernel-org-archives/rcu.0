Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE5A94A;
	Sat, 25 Jan 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737818168; cv=none; b=tCG+WW4OBfwkmB0QMWSzuOiTtzP1UIEaXjbSFQ0R/JMmcODOFqlPmwZSiA5HJAiHHpkjYTbICxFWVWwtvwxiI9UIUNoWsl+4b4EqikkpEWxxLd1oWI5Tbeh1R2O+nAVi1Gp27+yx4PxG5uE3aTZO5gu30cORgRe60ck/v6iqXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737818168; c=relaxed/simple;
	bh=oF4tz9QCQ2oeg0jLTnWNAl9vyAEnX6vj/7Dgl+1EzQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISgE0j2codPGSA8v65nRMiMvzS6DtoMuEGdTN813I8miWXnlBotlCiDI09hnec8iHmhnexn41DH3y79M1ey6W6yq4pdcOaQVkb2MNQuiWtKf3sXlZRlc/aPunwS+8UYckso95zfwhj1OUeyTjoFhJAzUaQbQ9+JcKgQ3PQpQY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=C6q22Olh; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="C6q22Olh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hhj160kQD8iFSe2KQbZv/+7UbJVGxbkae2fFm1F+174=; b=C6q22OlhHTrFHXXlqHodYhC2wG
	tiwooj0zVE3cPnkgYFA3fxz2/mK6JXVZmGHwngfbqeDPU8q3S4GZMPUHSJrLFGsicEFxR84Ognues
	QuwrJRkJYI4fh0jW3we7LqgK+x2XoL5EcdTFUQDAoZomcs5T/6WDp1TPtbjbRFKSGYUxmGfnc8Vfm
	om3sxemza86ZVPj8BXNhYBnbGx7iAg4s4D6HTkRN71Y1IwvCKj5DAmjFxOkEQqnXPYPNIjOH0EFtn
	B42C+YPkuIEYvbKSIfXdDjTxUsWZqN1u7VOvw4zFLrTRMD5CjgmI457QxFp9caw507BniAyk+tLM+
	l9qlZINw==;
Received: from minute.unseen.parts ([139.162.151.61]:49778 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tbhsk-0008T3-0r;
	Sat, 25 Jan 2025 16:15:34 +0100
Date: Sat, 25 Jan 2025 16:15:32 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5UAFAD6xCSpKJYw@minute>
References: <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
 <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>
 <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute>
 <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
 <Z5NxuIFsMUvqWUtC@minute>
 <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>

On Fri, Jan 24, 2025 at 05:57:05PM +0100, Magnus Lindholm wrote:
> Are there other parts of the code that might unalign the stack, even
> if the stack is properly aligned to begin with? i.e passing an uneven
> number of function arguments on the stack or inside interrupt
> handlers? Alpha does not make use of a separate interrupt stack,
> right?

Good questions. No, there is no separate interrupt stack, it's always the
kernel one. Stack frames from interrupts in user mode are 64-byte aligned
though. Interrupts in kernel mode, user mode syscalls and exceptions all
use 6 x 64-bit word frames and do not change the stack [mis]alignment.

So, what we have now:
1. The "normal" kernel stack is always misaligned by 8, thanks to
   the sizeof(struct pt_regs);
2. Syscalls and exceptions handlers receive 16-byte aligned stack, as it
   gets "fixed" by SAVE_ALL macro in entry.S, which pushes the odd number
   of registers on the stack;
3. Interrupt handlers may, or may not, have got an aligned stack depending
   on kernel/user mode in which the interrupt had come.

Ugh.

> On stack alignment in "ALPHA Calling Standard":
> D.3.1 Stack Alignment
> 
> "This standard requires that stacks be octaword aligned at the time a
> new procedure is invoked. During the body of a procedure, however,
> there is no requirement to keep this level of alignment (even though
> it may be beneficial). This implies that any asynchronous interrupt
> handlers must properly align the stack before any standard calls are
> made."

I hope we can rely on GCC changing $sp only by multiplies of 16.

Magnus, can you please try this variant?

(Yes, there is still the UAPI issue that Maciej pointed out, but that's
another story.)

Ivan.

diff --git a/arch/alpha/include/uapi/asm/ptrace.h b/arch/alpha/include/uapi/asm/ptrace.h
index 5ca45934fcbb..72ed913a910f 100644
--- a/arch/alpha/include/uapi/asm/ptrace.h
+++ b/arch/alpha/include/uapi/asm/ptrace.h
@@ -42,6 +42,8 @@ struct pt_regs {
 	unsigned long trap_a0;
 	unsigned long trap_a1;
 	unsigned long trap_a2;
+/* This makes the stack 16-byte aligned as GCC expects */
+	unsigned long __pad0;
 /* These are saved by PAL-code: */
 	unsigned long ps;
 	unsigned long pc;
diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index 4cfeae42c79a..e9dad60b147f 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -19,9 +19,13 @@ static void __used foo(void)
 	DEFINE(TI_STATUS, offsetof(struct thread_info, status));
 	BLANK();
 
+	DEFINE(SP_OFF, offsetof(struct pt_regs, ps));
 	DEFINE(SIZEOF_PT_REGS, sizeof(struct pt_regs));
 	BLANK();
 
+	DEFINE(SWITCH_STACK_SIZE, sizeof(struct switch_stack));
+	BLANK();
+
 	DEFINE(HAE_CACHE, offsetof(struct alpha_machine_vector, hae_cache));
 	DEFINE(HAE_REG, offsetof(struct alpha_machine_vector, hae_register));
 }
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index dd26062d75b3..6fb38365539d 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -15,10 +15,6 @@
 	.set noat
 	.cfi_sections	.debug_frame
 
-/* Stack offsets.  */
-#define SP_OFF			184
-#define SWITCH_STACK_SIZE	64
-
 .macro	CFI_START_OSF_FRAME	func
 	.align	4
 	.globl	\func
