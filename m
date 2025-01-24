Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C821A931;
	Fri, 24 Jan 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716173; cv=none; b=Bn269bxE81AAYUnyVbid/QN2PLhpuY9bLhoJlkh80CJXPpLKw6WCrd16iWwMbGwXLPLZC7DJ6rPxiGaXmxYqzbL/yNnTrHoQzgIMm6AXikK7KGrWgD0y50T/z3AP84mPWw1vbjHfTwsbDkoLhO489PUbadFRunvuwyX65iqMYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716173; c=relaxed/simple;
	bh=ba6q7KpGM+nNDhAXwMUY4NvWhXartd5G7X++0iO1Ut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN6p2xh6/b17YZRleEicOrzy2bUDnxC2J0i1yj6hIh9XKvBxcpqN7LYk3sz4+nZk7W8HKUrZFLWKRq+jo7SewIR8Q4u+b+4JuBZroZZTq1JWkKpVWw9ARjRYq1WVlY4cAsoszudGUqWgLlIUaOQF5R2Vy0n4CrHpFt7iumpmTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=qp9q8ni5; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="qp9q8ni5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JlfiqEv5fkt0RVGA/r5Jq1FEGs4qwM075l6thDCO3Qo=; b=qp9q8ni5cb3qcb7PCHS1Ts6GB4
	BG5nGucB/AN90xLkOK3VZMFfw+AE93RL7TZ3SyDsPIb99ee0H9DqzqGS/rwKwimPssUWM+aiWptGs
	Kq9nTqYz9MuFEfn24I2De67mcLS9rcG0MSdCQy0MfKdVf7gf/urqFLb3236XKrP3f4yNoASFhvqIk
	dx6gBuvCnDDexYHu5ueBcDvAVc7BqHDuGqU3CXS1FnTMLbvgO+Fufn34Q5bzVszVUZXsOx6OlmYVG
	DUW+FxZBxMVd5ZwqZOcZVRv5g3yqf2ZPQ6kiIfgY4lDsCMTovFNjqpb2FKvF6JEXkrbCpl4qgMRCr
	3EsOFD/g==;
Received: from minute.unseen.parts ([139.162.151.61]:37578 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tbHLu-0006ie-33;
	Fri, 24 Jan 2025 11:55:54 +0100
Date: Fri, 24 Jan 2025 11:55:52 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5NxuIFsMUvqWUtC@minute>
References: <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
 <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>
 <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute>
 <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>

On Thu, Jan 23, 2025 at 11:57:03PM +0000, Maciej W. Rozycki wrote:
> On Thu, 23 Jan 2025, Ivan Kokshaysky wrote:
> 
> > > Indeed, SP_OFF in entry.S is the main suspect at the moment.
> > 
> > In fact, it's the odd number of longs (29) in struct pt_regs that makes
> > the stack misaligned by 8 bytes. The patch below works for me - no more
> > oopses in rcu-torture test.
> > 
> > Unless I'm missing something, this change shouldn't have any ill effects.
> 
>  Umm, this is a part of UAPI, and the change in alignment changes the ABI 
> (think padding where `struct pt_regs' has been embedded into another 
> structure), so AFAICT it is a no-no.

Well, the only userspace applications I can think of that need kernel
stack layout are debuggers, but at least alpha gdb doesn't use this header.
Doesn't matter, though - padding *after* PAL-saved registers is wrong
thing to do. I think it's the reason for oopses that Magnus reported
today.

A "long" padding memder of pt_regs placed *before* PAL-saved registers
would be a proper fix for kernel, but it most likely would break gdb...

>  But the only place I could quickly find this should matter for is this:
> 
> 	/* ... and find our stack ... */
> 	lda	$30,0x4000 - SIZEOF_PT_REGS($8)
> 
> which should be straightforward to fix:
> 
> 	lda	$30,0x4000 - ((SIZEOF_PT_REGS + 15) & ~15)($8)
> 
> or suchlike.  Have I missed anything?

That's the first thing I thought of too, but no, it's just a kernel
entry point after the bootloader. The stack pointer of kernel threads
is assigned in alpha/kernel/process.c. Particularly, these macros
in ptrace.h (non-uapi) are interesting:

#define task_pt_regs(task) \
  ((struct pt_regs *) (task_stack_page(task) + 2*PAGE_SIZE) - 1)

#define current_pt_regs() \
  ((struct pt_regs *) ((char *)current_thread_info() + 2*PAGE_SIZE) - 1)

I'll try to play with alignment here, but it will take some time.

Ivan.
