Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176DAFC0E;
	Sat, 25 Jan 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737824507; cv=none; b=s5yD1gURZLuKUGdkzddILIQzdCGwaFDkcWSSYrRn1ABNByXUJNx4ExARFC85R/oNyEsPY3a+Y4PMYKRzMType4p6JZ++OiIbgCh0mAgPP/IGQmBeahQIb7C83M9NSaxzrKcyslvkoBsu2xIrlLyQoUbfeKLG+KvtSqkjjnM/tvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737824507; c=relaxed/simple;
	bh=UROe1PpKVBm9ZvOzEcNtUFZFtokSWTGU+1fBROnJZ70=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aYz/BUHqrHgKxx54F+meoOICq8hAmmQK0RlQH2zLclN+2Cx0f69I9Ia1pHbIOgBNLrd1yTmHCoHBNPt/h3u3OVHEWsGcx4j+Of/Y2B+VT12UM3qhNqrYF3vZBuNJ9tWEoNnPZdcdFzP0CaTXo2aYIWqcMcrMk2oDsxGIt2bQWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C8E9B92009C; Sat, 25 Jan 2025 18:01:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id BE0EF92009B;
	Sat, 25 Jan 2025 17:01:42 +0000 (GMT)
Date: Sat, 25 Jan 2025 17:01:42 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <Z5UAFAD6xCSpKJYw@minute>
Message-ID: <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk> <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com> <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com> <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk> <Z4-jgMJgbVriLaCr@minute> <Z5KMHoA7GlHJyUU_@minute> <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk> <Z5NxuIFsMUvqWUtC@minute> <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>
 <Z5UAFAD6xCSpKJYw@minute>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 25 Jan 2025, Ivan Kokshaysky wrote:

> > Are there other parts of the code that might unalign the stack, even
> > if the stack is properly aligned to begin with? i.e passing an uneven
> > number of function arguments on the stack or inside interrupt
> > handlers? Alpha does not make use of a separate interrupt stack,
> > right?
> 
> Good questions. No, there is no separate interrupt stack, it's always the
> kernel one. Stack frames from interrupts in user mode are 64-byte aligned
> though. Interrupts in kernel mode, user mode syscalls and exceptions all
> use 6 x 64-bit word frames and do not change the stack [mis]alignment.
> 
> So, what we have now:
> 1. The "normal" kernel stack is always misaligned by 8, thanks to
>    the sizeof(struct pt_regs);
> 2. Syscalls and exceptions handlers receive 16-byte aligned stack, as it
>    gets "fixed" by SAVE_ALL macro in entry.S, which pushes the odd number
>    of registers on the stack;
> 3. Interrupt handlers may, or may not, have got an aligned stack depending
>    on kernel/user mode in which the interrupt had come.
> 
> Ugh.

 Yeah, just as I observed in my other reply, but notice that syscalls and 
exceptions handlers typically actually do *not* receive a 16-byte aligned 
stack now.

> > On stack alignment in "ALPHA Calling Standard":
> > D.3.1 Stack Alignment
> > 
> > "This standard requires that stacks be octaword aligned at the time a
> > new procedure is invoked. During the body of a procedure, however,
> > there is no requirement to keep this level of alignment (even though
> > it may be beneficial). This implies that any asynchronous interrupt
> > handlers must properly align the stack before any standard calls are
> > made."
> 
> I hope we can rely on GCC changing $sp only by multiplies of 16.

 Absolutely, the compiler would be completely broken otherwise.

> (Yes, there is still the UAPI issue that Maciej pointed out, but that's
> another story.)

 So we now have two variants to pick from.  I wish we could take yours as 
it's certainly neater, but is it safe enough?

 I can see arch/alpha/include/uapi/asm/ptrace.h was only incarnated as 
late as in 2012 with commit 96433f6ee490 ("UAPI: (Scripted) Disintegrate 
arch/alpha/include/asm") and according to the change heading made in an 
automated way, with little public discussion, so maybe its existence is 
actually an accident?  Unlike some other platforms we don't expose this 
`struct pt_regs' via ptrace(2) for PTRACE_GETREGS/PTRACE_SETREGS, which 
we don't implement.

 NB, here's a corresponding stack alignment report for your change:

start_kernel: SP: fffffc0000dcfe90
do_entInt: SP: fffffc0000dcfc60
copy_thread: SP: fffffc0000dcfc90, regs: fffffc0000dcff10, childregs: fffffc0001837f10, childstack: fffffc0001837ed0
do_page_fault: SP: fffffc0001837bb8
sys_exit_group: SP: fffffc00028bfef0
do_entUnaUser: SP: fffffc0001bcfe68
do_entArith: SP: fffffc0001dfbee0
do_entIF: SP: fffffc0001fafee0

so there's still work to be done for `entMM' and `entUna' exceptions.

  Maciej
