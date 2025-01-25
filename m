Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F9B8494;
	Sat, 25 Jan 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737829508; cv=none; b=uC7wTxlfcEajiWdKFQQIMdZuJs1kNEqiPhkA7KxWJDPfN2ahFaxwZSoglrVDEpONLwdVug7ibZvWgmEeIDDTuNiTi0w4u7Mt3y3L9EFQTuaJp7bNGjnQPfotdkb/h/JKw4HDKkcgHHzgAHk3v8sPtij9L4ajIQXBJsgkiGh86v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737829508; c=relaxed/simple;
	bh=QdnU0QkInNynrbPNs2+Ahwiz2RtiAbkmo/EtEeE6ap8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jyeEgdQMmmzVOR2GAaECtqNOmpvbYJwU+yZIK5e6f97ne2s+Mts7pQjynhIZdYatJV0fa2ivA+hNz1d7sxYkAZ600l0uIkBDNxZYzYvYrVgZVIkIwcMV462KdIhj4ypupjLaE/DeF980eyFRz3NGnzFmc2DwliRVBAbZqIvLOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A84CB92009C; Sat, 25 Jan 2025 19:25:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A2E3D92009B;
	Sat, 25 Jan 2025 18:25:04 +0000 (GMT)
Date: Sat, 25 Jan 2025 18:25:04 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <Z5Uit9F7xF0ZlMk2@minute>
Message-ID: <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk>
References: <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com> <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com> <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk> <Z4-jgMJgbVriLaCr@minute> <Z5KMHoA7GlHJyUU_@minute>
 <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk> <Z5NxuIFsMUvqWUtC@minute> <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com> <Z5UAFAD6xCSpKJYw@minute> <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>
 <Z5Uit9F7xF0ZlMk2@minute>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 25 Jan 2025, Ivan Kokshaysky wrote:

> >  Yeah, just as I observed in my other reply, but notice that syscalls and 
> > exceptions handlers typically actually do *not* receive a 16-byte aligned 
> > stack now.
> 
> Interesting. Perhaps these frames are aligned by PAL-code as well,
> the reference manual wasn't clear about that.

 I think it just boils down to the amount of exception nesting.

> >  So we now have two variants to pick from.  I wish we could take yours as 
> > it's certainly neater, but is it safe enough?
> > 
> >  I can see arch/alpha/include/uapi/asm/ptrace.h was only incarnated as 
> > late as in 2012 with commit 96433f6ee490 ("UAPI: (Scripted) Disintegrate 
> > arch/alpha/include/asm") and according to the change heading made in an 
> > automated way, with little public discussion, so maybe its existence is 
> > actually an accident?  Unlike some other platforms we don't expose this 
> > `struct pt_regs' via ptrace(2) for PTRACE_GETREGS/PTRACE_SETREGS, which 
> > we don't implement.
> 
> Yeah, a bit of e-mail desync, sorry :)

 No worries.

> At the moment I compile gdb with empty asm/ptrace.h just to be 100% sure.

 I can't see this stuff being used anywhere in Alpha/GDB.

> >  NB, here's a corresponding stack alignment report for your change:
> > 
> > start_kernel: SP: fffffc0000dcfe90
> > do_entInt: SP: fffffc0000dcfc60
> > copy_thread: SP: fffffc0000dcfc90, regs: fffffc0000dcff10, childregs: fffffc0001837f10, childstack: fffffc0001837ed0
> > do_page_fault: SP: fffffc0001837bb8
> > sys_exit_group: SP: fffffc00028bfef0
> > do_entUnaUser: SP: fffffc0001bcfe68
> > do_entArith: SP: fffffc0001dfbee0
> > do_entIF: SP: fffffc0001fafee0
> > 
> > so there's still work to be done for `entMM' and `entUna' exceptions.
> 
> I knew about entUna, I thought it's safe as it only deals with 64-bit data
> and not going to be changed in future, but missed entMM...
> 
> I agree, better fix both.

 Well, we may get away with it in many cases, which is obviously why 
this bug has survived so long, but in principle it is not safe to enter 
C code with the stack misaligned, so yes, we need to fix all the code 
paths, also because a nested exception will cause hell to break loose.  

 Here just bumping up the frame size and adjusting offsets in assembly 
code accordingly so as to account for the empty longword at the bottom 
of the frame should do, just as I did across my change.

  Maciej
