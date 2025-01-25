Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9F70803;
	Sat, 25 Jan 2025 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827016; cv=none; b=t49YeokFw6wDMjT+Ev1lDh7MNGS8bTbI7Hdpbu8M30gwQgv1AjBpgbvGEg58PGVfv0HjCm/utjVrum0K4HftyjOzToeTsRlKbWBDT6Hbk8ocUbL5y/6H7ALyOVfT/1RJ0ydRR5EGbrfMBz0IyM/wvG2BuuzPZ0mEcar+ooU+Jjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827016; c=relaxed/simple;
	bh=Sj7c9gcpQHxCZerj7fg4i9OKj0zFQM5n52uYQ5Dhiso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyVGEEhgrNyRLM1DY1uiLQUT8ndBWuAYvxneTw5Hk3/L2GhSqGtP1ZtyH8I/FZxRzZCyhrPOwtqlcVLprrf+u2KWdp6iym2Y2yQJDm5F7YQXAzH5NzxlPBAz+0TA1Hq20NI7VmYkSCL0VJ4DNyijsWrVcKIQNeTmtQNJfN/jOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=sSepjCxP; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="sSepjCxP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iAQ4NQtfbSZb8RD3vB76l/iM8Vuqwdgqh15geR4+8Fw=; b=sSepjCxPnlPkFZB1sFxsB5/oqK
	mPp6YEwDrQVTXywJ2p+oEvEVjvnHFBvzTKJIRdCQpdnFA/RO0XaqDt2ZX+PvlAWkXuXWroNRTPXxf
	BRzzY2SpRorWAiZ904rXeP323q/wpbDGHQ+JJHxIflIjuFQ019Wsh/mxySTFmcFzBLR0n+tVlMiGH
	2qrntXP0eCkZKsWc3rp02N6X8K0Qdccg1LdpBZhTHochZ/2zFxYO272x0Dabirtvu1guGhvXdqM++
	xdvxMbOp0XmtV8K6OcMzH2zRxkxkyCPWuCElS1w12QDkvPCHapYbEwyiQHhVeKbsSig45aJpCERCg
	f9kG3NNA==;
Received: from minute.unseen.parts ([139.162.151.61]:44802 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tbkBm-0000Bh-24;
	Sat, 25 Jan 2025 18:43:22 +0100
Date: Sat, 25 Jan 2025 18:43:19 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5Uit9F7xF0ZlMk2@minute>
References: <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>
 <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute>
 <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
 <Z5NxuIFsMUvqWUtC@minute>
 <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>
 <Z5UAFAD6xCSpKJYw@minute>
 <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>

On Sat, Jan 25, 2025 at 05:01:42PM +0000, Maciej W. Rozycki wrote:
>  Yeah, just as I observed in my other reply, but notice that syscalls and 
> exceptions handlers typically actually do *not* receive a 16-byte aligned 
> stack now.

Interesting. Perhaps these frames are aligned by PAL-code as well,
the reference manual wasn't clear about that.

> > > On stack alignment in "ALPHA Calling Standard":
> > > D.3.1 Stack Alignment
> > > 
> > > "This standard requires that stacks be octaword aligned at the time a
> > > new procedure is invoked. During the body of a procedure, however,
> > > there is no requirement to keep this level of alignment (even though
> > > it may be beneficial). This implies that any asynchronous interrupt
> > > handlers must properly align the stack before any standard calls are
> > > made."
> > 
> > I hope we can rely on GCC changing $sp only by multiplies of 16.
> 
>  Absolutely, the compiler would be completely broken otherwise.
> 
> > (Yes, there is still the UAPI issue that Maciej pointed out, but that's
> > another story.)
> 
>  So we now have two variants to pick from.  I wish we could take yours as 
> it's certainly neater, but is it safe enough?
> 
>  I can see arch/alpha/include/uapi/asm/ptrace.h was only incarnated as 
> late as in 2012 with commit 96433f6ee490 ("UAPI: (Scripted) Disintegrate 
> arch/alpha/include/asm") and according to the change heading made in an 
> automated way, with little public discussion, so maybe its existence is 
> actually an accident?  Unlike some other platforms we don't expose this 
> `struct pt_regs' via ptrace(2) for PTRACE_GETREGS/PTRACE_SETREGS, which 
> we don't implement.

Yeah, a bit of e-mail desync, sorry :)

At the moment I compile gdb with empty asm/ptrace.h just to be 100% sure.

>  NB, here's a corresponding stack alignment report for your change:
> 
> start_kernel: SP: fffffc0000dcfe90
> do_entInt: SP: fffffc0000dcfc60
> copy_thread: SP: fffffc0000dcfc90, regs: fffffc0000dcff10, childregs: fffffc0001837f10, childstack: fffffc0001837ed0
> do_page_fault: SP: fffffc0001837bb8
> sys_exit_group: SP: fffffc00028bfef0
> do_entUnaUser: SP: fffffc0001bcfe68
> do_entArith: SP: fffffc0001dfbee0
> do_entIF: SP: fffffc0001fafee0
> 
> so there's still work to be done for `entMM' and `entUna' exceptions.

I knew about entUna, I thought it's safe as it only deals with 64-bit data
and not going to be changed in future, but missed entMM...

I agree, better fix both.

Ivan.
