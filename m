Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807901372;
	Sat, 25 Jan 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737824972; cv=none; b=a5IxCpUHaC0WQc283c7UbCdQI9ENSRlDIAhKFb0FdB4EOxEY823ML6o9sA43D3l8jpnFVc2VqB5Evs3IPYlgQ4NBKgzrhuvYE+AvmePyGCRxp0YgibuZ6ZLUOi9JJ05OceRCGNI1z96Xq7UA9Y3TdxIpKhrBVhLBGU6B7MylfP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737824972; c=relaxed/simple;
	bh=w9p9qzkVTITZVdSiCh4KoMRMmSLEnWGIc4/IsMDzhgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI1pCFFfxJZLGRoHbYeCK+I3tXbBBANmxktIyiMJ5sU8BWbhvg3BUDmQf49gcodzQ9+lkQZDw5IXF969HjiKuIBrkFhF1vfKu1UbTIvZI9JdThMs6+h7GUFhGpGxLqWRe1NBG/56DVDcFFiZYGmYD56VL3rmVMAyssVX+fVkVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=J1aymrqN; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="J1aymrqN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+MgISqZ00OB8eFHCAYNkhdk1CL30twXA5x8utDI87G8=; b=J1aymrqNtdSducf3zqzeD1VWEH
	aDugpSH4skVGnu2SXjWxTK8G8opVZXrzKqYnNsX70xGBM1dUQeVZSv9u/QvTjd9xs/4b+PkUeNRsB
	qGKZtrZtZ2x0u/N6mMrB96MbUU85LFsjYicm+vQWGMkxQtCYBo5n/5zfn7cGnMtSP3bw193ZyHUY3
	BkU9rH+uCT4XD86QAUYZfx95e+IP+NNNjvodq1i8WY5Aki2f+ev11hyh66XwjJ7GrkoYlKuNxlfFX
	SoARHReRv0Tx5o3Sh5reiDYAS7uWfDuWECEK3M2fPQirctaveIqzAUbkJ8RlvAGyL2Qi/fUlAv/9q
	B7ZaUeGg==;
Received: from minute.unseen.parts ([139.162.151.61]:60734 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tbjen-00009G-0n;
	Sat, 25 Jan 2025 18:09:17 +0100
Date: Sat, 25 Jan 2025 18:09:15 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5Uauwl0qqHhiGZk@minute>
References: <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
 <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>
 <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute>
 <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
 <Z5NxuIFsMUvqWUtC@minute>
 <alpine.DEB.2.21.2501241058520.27203@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2501241058520.27203@angie.orcam.me.uk>

On Sat, Jan 25, 2025 at 03:35:08PM +0000, Maciej W. Rozycki wrote:
> On Fri, 24 Jan 2025, Ivan Kokshaysky wrote:
> 
> > > > > Indeed, SP_OFF in entry.S is the main suspect at the moment.
> > > > 
> > > > In fact, it's the odd number of longs (29) in struct pt_regs that makes
> > > > the stack misaligned by 8 bytes. The patch below works for me - no more
> > > > oopses in rcu-torture test.
> > > > 
> > > > Unless I'm missing something, this change shouldn't have any ill effects.
> > > 
> > >  Umm, this is a part of UAPI, and the change in alignment changes the ABI 
> > > (think padding where `struct pt_regs' has been embedded into another 
> > > structure), so AFAICT it is a no-no.
> > 
> > Well, the only userspace applications I can think of that need kernel
> > stack layout are debuggers, but at least alpha gdb doesn't use this header.
> > Doesn't matter, though - padding *after* PAL-saved registers is wrong
> > thing to do. I think it's the reason for oopses that Magnus reported
> > today.
> > 
> > A "long" padding memder of pt_regs placed *before* PAL-saved registers
> > would be a proper fix for kernel, but it most likely would break gdb...
> > 
> > >  But the only place I could quickly find this should matter for is this:
> > > 
> > > 	/* ... and find our stack ... */
> > > 	lda	$30,0x4000 - SIZEOF_PT_REGS($8)
> > > 
> > > which should be straightforward to fix:
> > > 
> > > 	lda	$30,0x4000 - ((SIZEOF_PT_REGS + 15) & ~15)($8)
> > > 
> > > or suchlike.  Have I missed anything?
> > 
> > That's the first thing I thought of too, but no, it's just a kernel
> > entry point after the bootloader. The stack pointer of kernel threads
> > is assigned in alpha/kernel/process.c. Particularly, these macros
> > in ptrace.h (non-uapi) are interesting:
> > 
> > #define task_pt_regs(task) \
> >   ((struct pt_regs *) (task_stack_page(task) + 2*PAGE_SIZE) - 1)
> > 
> > #define current_pt_regs() \
> >   ((struct pt_regs *) ((char *)current_thread_info() + 2*PAGE_SIZE) - 1)
> > 
> > I'll try to play with alignment here, but it will take some time.
> 
>  So after a crash course in PALcode stack frames I have come up with the 
> following WIP patch that works for me.  If things go well, I'll clean it 
> up a little and turn into a proper patch submission.  Not that I think I 
> can make the end result particularly pretty, there's no easy way AFAICT.
> 
>  NB with some instrumentation here's what gets reported for stack without:
> 
> start_kernel: SP: fffffc0000dcfe98
> do_entInt: SP: fffffc0000dcfc30
> copy_thread: SP: fffffc0000dcfc98, regs: fffffc0000dcff18, childregs: fffffc0001837f18, childstack: fffffc0001837ed8
> do_page_fault: SP: fffffc0001837bc8
> sys_exit_group: SP: fffffc0002917ef8
> do_entUnaUser: SP: fffffc0001f33e70
> do_entArith: SP: fffffc0001f33ee8
> do_entIF: SP: fffffc000184bee8
> 
> and with the patch:
> 
> start_kernel: SP: fffffc0000dcfe90
> do_entInt: SP: fffffc0000dcfc20
> copy_thread: SP: fffffc0000dcfc90, regs: fffffc0000dcff18, childregs: fffffc000183bf18, childstack: fffffc000183bed0
> do_page_fault: SP: fffffc000183bbc0
> sys_exit_group: SP: fffffc00028d3ef0
> do_entUnaUser: SP: fffffc000292fe70
> do_entArith: SP: fffffc0001d7fee0
> do_entIF: SP: fffffc0002827ee0
> 
> for the relevant situations (except for `entDbg', but that's analogous and 
> largely unused anyway).
> 
>  Can you guys please give it a try?

Oh. I have little doubt it works, but so much hard work just to keep
the pt_regs thing intact? Instead of asking ourselves how come it ended
up in uapi?

It was commit 96433f6ee49032d7a8b back in 2012 done by some scripting,
I believe it was by mistake, because it's the kernel bowels exposed for
absolutely no reason. I was going to propose a patch below (I don't think
we can remove the file, as it probably break build of packages like
linux-libc), and then add padding to pt_regs with exactly the same effect
as your patch.

Ivan.

diff --git a/arch/alpha/include/uapi/asm/ptrace.h b/arch/alpha/include/uapi/asm/ptrace.h
index 5ca45934fcbb..6b09e1df343d 100644
--- a/arch/alpha/include/uapi/asm/ptrace.h
+++ b/arch/alpha/include/uapi/asm/ptrace.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI_ASMAXP_PTRACE_H
 #define _UAPI_ASMAXP_PTRACE_H
 
-
+#ifdef __KERNEL__
 /*
  * This struct defines the way the registers are stored on the
  * kernel stack during a system call or other kernel entry
@@ -64,10 +64,7 @@ struct switch_stack {
 	unsigned long r14;
 	unsigned long r15;
 	unsigned long r26;
-#ifndef __KERNEL__
-	unsigned long fp[32];	/* fp[31] is fpcr */
-#endif
 };
-
+#endif
 
 #endif /* _UAPI_ASMAXP_PTRACE_H */
