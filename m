Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D023BB
	for <rcu@vger.kernel.org>; Sun,  3 Mar 2024 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709425158; cv=none; b=Vv5CGI9BL8mBb7CoiumT3MXWD5Im/xnmxqro7Cy++VVLRXfUzC2PjKnqbtvS5qCi6TsFkgOHyICWx2pABiRmVSIP+B96+Ip7lhALneTaH5C+ZGIudIgojs0mninFtQFV6uCX1bmUI85zFukC3XXxVxwTtvlODk+y3/or++xZvE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709425158; c=relaxed/simple;
	bh=2s27Dm+VyELAhWB/hfzuocdz2wha9F91iifdEA4+rq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t91RLFhm+uUjIHKbT/SifY91IE3butfbigUOAKDbJMVIScVZwAoiXPez/rvf7sGl+aEi2B+xrp1VlmOiVZRy/o6OjDckXpyJPVwX2wyoFmFytY1PcMOXbX0lopSENRGeHGXU8UtvJTHdXaRgLJ0iLlzAhYEX15rCQILIqAQ83g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdZNE3Ad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdZNE3Ad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCBBC433F1;
	Sun,  3 Mar 2024 00:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709425158;
	bh=2s27Dm+VyELAhWB/hfzuocdz2wha9F91iifdEA4+rq8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jdZNE3AdpPgwT0W3TSdzhQKdu5oIGnlaJQWkqIZCkopymM32P0Y9IokmgKR6eRvkh
	 FWR1XFgFhjiK4A2KSuIDegIrkLBzs5FTXx+aOJUiPnuVLxDXkULSqs8w1VwlOzopgH
	 HsJWN87lN13BlJvF8H8m4XZibhw/m6mcd6FBj+kV098SURxw06lHeKfc/noJlW8MNK
	 Wqe8aq5PXNQc3kSaoYCk2LBIjyRLuaAhvu286o7UBxgJdtqHqkk+oZlfXU/Ttvk+X+
	 GK682T3upfIyzc9HOSk7sF9sYOXai4xaO4kT1eo0GTZZjc5xZ4pr7FuPPs3Grl2LlX
	 NT8atpCMcy7yw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DF00DCE08FA; Sat,  2 Mar 2024 16:19:17 -0800 (PST)
Date: Sat, 2 Mar 2024 16:19:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Max Boone <contact@maxboone.com>
Cc: boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: Re: Advice sought on RCU stalls on ARM64 WSL2
Message-ID: <99a0fb2c-c936-405f-85bf-847c61531bd5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1a5d96d6-2057-44d9-a4b0-8771c46032fb@paulmck-laptop>
 <3718bb-65e38400-d-5cd53080@68830111>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3718bb-65e38400-d-5cd53080@68830111>

On Sat, Mar 02, 2024 at 08:53:54PM +0100, Max Boone wrote:
> 
> Thank you so much for the quick reply!
> 
> ​​​​​​I haven't filed a bug with Debian specifically as I'm running the linux kernel built and provided by Microsoft and Ubuntu as OS on top. If it helps with the search I'd gladly run Debian and file a bug there, but will still need to build my own kernel as WSL requires some modules (such as HyperV storage and sockets) to be built into the kernel instead (meaning =y) of as modules (meaning =m).

Ah, if you built your own kernel, then you are your own distro as far
as kernel issues are concerned.  ;-)

							Thanx, Paul

> I'll stick to using the rcu list from here on to avoid spam, thanks again!
> ​​​​​
> On Saturday, March 02, 2024 20:43 CET, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>  [ Adding Boqun and the rcu list on CC. ]
> 
> On Sat, Mar 02, 2024 at 07:59:08PM +0100, Max Boone wrote:
> >
> > Dear Dr. McKenney,
> >
> > For a couple of years now I've been the sometimes frustrated owner of a Microsoft Surface Pro X ARM64 device, which has been getting progressively better as more vendors start targeting their builds at ARM64 architectures but since the introduction of the device there have been issues with the Windows Subsystem for Linux (not more than an opinionated Hyper-V VM with extensive tooling) locking up and hanging. 
> >
> > When this happens, traces like the following are dumped in the kernel messages:
> > https://github.com/microsoft/WSL/issues/9454#issuecomment-1942222109
> >
> > When watching your talk "Decoding Those Inscrutable RCU CPU Stall Warnings" you mentioned one can feel free reaching out when bumping into such issues. Building other kernel releases, switching off-and-on modules and playing with the RCU grace period times so far don't seem to work for me (or others in that thread).
> >
> > Anyways, I don't really know where to start looking and the call stacks aren't very informative (to my eye) either. I'm hoping you might help me find the direction to look for the root of this problem.
> 
> I am assuming that you have filed a bug with the Debian folks, and before
> doing that, searched for similar bug reports.
> 
> At first glance, this is because things were stuck here:
> 
> [ 967.115632] clear_rseq_cs.isra.0+0x4c/0x60
> [ 967.116433] do_notify_resume+0xf8/0xeb0
> [ 967.116960] el0_svc+0x3c/0x50
> [ 967.117537] el0t_64_sync_handler+0x9c/0x120
> [ 967.118323] el0t_64_sync+0x158/0x15c
> 
> So including these function names (clear_rseq_cs() and so on) in your
> search for similar bug reports would be a good idea.
> 
> I am unfamiliar with that code.
> 
> So I added Boqun because he works with Linux on HyperV as part of his
> day job and has a great deal of experience with RCU. He will likely
> have quite a number of questions for you including exact versions,
> Debian bug number, the results of your web search, and so on. He might
> also know an ARM person to get involved in this.
> 
> Or maybe he knows the solution off the top of his head!
> 
> Thanx, Paul
> 
> 
>  
