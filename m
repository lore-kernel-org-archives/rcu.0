Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0B7083D;
	Sat, 25 Jan 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737831577; cv=none; b=DfIsL0TXIxZneFoUlpBOatKTLdsnVyMCn4zRnvmDxQYdUZv/n8/0o7H4GZyGAfWgJf6iHxVuu98iHdVuX32k7cCKVpjsNM6ie9L1OuwnxsLiMpHF2kIPoqtNeKDegLdrj7rFgkals+kKjzQBGKfTUQhmrU31/uR80pdnORMLwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737831577; c=relaxed/simple;
	bh=t7ozNBFRY+2PyZMeAY73PMOUvPK56SN3oFdLsBuf+K8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IHC1WHFOsiTtgFt37UGAbKA9eEJj+bdags5/I2YmNFKq9wBRwFn8Cw2aTMHBlrTHBrJS2WrKxc25HKcR4BmmCGUn9136BwDcZy3TdNEQvk418YBVWMszjpcOYHAxyy5U8oELn5nzeCaZ2plfnodh0kexi1CQnx2TrPV6OneU9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E8B2D92009C; Sat, 25 Jan 2025 19:59:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DB03192009B;
	Sat, 25 Jan 2025 18:59:32 +0000 (GMT)
Date: Sat, 25 Jan 2025 18:59:32 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2501251839440.27203@angie.orcam.me.uk>
References: <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com> <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com> <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk> <Z4-jgMJgbVriLaCr@minute> <Z5KMHoA7GlHJyUU_@minute>
 <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk> <Z5NxuIFsMUvqWUtC@minute> <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com> <Z5UAFAD6xCSpKJYw@minute> <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk> <Z5Uit9F7xF0ZlMk2@minute>
 <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 25 Jan 2025, Maciej W. Rozycki wrote:

> > Interesting. Perhaps these frames are aligned by PAL-code as well,
> > the reference manual wasn't clear about that.
> 
>  I think it just boils down to the amount of exception nesting.

 Ah, actually most of these faults were entered from the user mode and the 
kernel stack starts at a page boundary, so once the stack frame has been 
allocated by PALcode and SAVE_ALL combined the stack pointer ends up 
misaligned.  For faults entered from the kernel mode the opposite might be 
the case.  So unless we want to play (and we don't) with FP and the saving 
and restoration of SP, we just want to keep SP aligned at all times.

> > I knew about entUna, I thought it's safe as it only deals with 64-bit data
> > and not going to be changed in future, but missed entMM...
> > 
> > I agree, better fix both.
> 
>  Well, we may get away with it in many cases, which is obviously why 
> this bug has survived so long, but in principle it is not safe to enter 
> C code with the stack misaligned, so yes, we need to fix all the code 
> paths, also because a nested exception will cause hell to break loose.  
> 
>  Here just bumping up the frame size and adjusting offsets in assembly 
> code accordingly so as to account for the empty longword at the bottom 
> of the frame should do, just as I did across my change.

 ... or, depending on how you look at it, top of the frame and FAOD in any 
case the longword closest to the stack pointer will be the empty one.

  Maciej
