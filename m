Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836EE3E6DE7;
	Wed, 14 Oct 2026 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012451; cv=none; b=HfuxdttTRNinIr7StOTK0cxqUEOXPril5q2wu6xNaaGtnGhjYh6WaXGGF4jxb5/ZhwVWtwCl7UxcoChGfYx4XJnktaP6lp3RpnKzg++TQICvZqLNq+hHoN9iKimv/gQ5vKJtPEY2TAC4aGzxzu5dBz47KUtjljm05VwjIrsTXQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012451; c=relaxed/simple;
	bh=Zp29SYvXejqGV0ag5+XFK8Z0FQLDHw102Kp/1wGwXMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7yEHWauQAYTRUPxVyE0X5Dmh0s/UXdukF2Mry0eV1w0l8j+jlMLi3FSWo2FSkEnHZEZJJ67DVp346P6SeC50IJIWWgwR5l7F0wIEJx6imQOdpQZDMbWozqRCsQ9JwhT1krYXhKXtWvwlfrhjl2Yl7BtDkcp88qWsxBrW4PHg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+yHmjUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+yHmjUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A362C1F000C4;
	Wed, 14 Oct 2026 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792012449;
	bh=ecyJCXW1w/LBOKQh3h8HJyMBz0P8eZq+cLObkoMpR5k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Y+yHmjUw/BUfpqonNaXdtWtu5iJoIzxxDCheh1jZMHSMBa4wKdEQjUTCN5SgHp8gs
	 Bw77CHTFl1kBXXU/p7qtFd/CirHfe6/26flkIXHaHXVkQmG/Phsz4IWokjSJNNoNYE
	 lUv45e84hA+39sOiDBD79CvrvlsbQqAIwz1dL0xQSq8cHr+K4jYTR2b8o81UL1P0ea
	 7/5AeZkm2x5+EuYDZgvdRhUnV6Pmlt/1YzUzekX5oCtEkHQjvGJT9uY4uK1E35cOwZ
	 IKP9pS5hiY603/kRLaL7IsIcHHHU9GzY2y4XSini4Mpk9Ahwr6jo5grTXr0a3gXfCX
	 ZawpSCWs3Db1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5F731CE0C55; Wed, 14 Oct 2026 14:14:09 -0700 (PDT)
Date: Wed, 14 Oct 2026 14:14:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 04/21] srcutree: Add an atomic Tree SRCU
Message-ID: <0514b2ce-217e-4e0e-9b2e-3f145a3e8afd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
 <20261007205924.1983367-4-paulmck@kernel.org>
 <729dfdb236e4daaf2438b74d4d921993a156ec34.camel@infradead.org>
 <d1539cc5-0ff3-400e-a487-eedd942cf6f5@paulmck-laptop>
 <3aba8068a1424c91c81ec35b2ea6dfaa28161fb1.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aba8068a1424c91c81ec35b2ea6dfaa28161fb1.camel@infradead.org>

On Mon, Oct 12, 2026 at 01:49:15PM +0100, David Woodhouse wrote:
> On Thu, 2026-10-08 at 08:51 -0700, Paul E. McKenney wrote:
> > On Thu, Oct 08, 2026 at 09:39:29AM +0200, David Woodhouse wrote:
> > > If it isn't already too late (i.e. if it hasn't already made it to a
> > > tree where changing commit-ids is painful), please could you change my
> > > attribution to use the dwmw@amazon.co.uk email address for both Co-
> > > developed-by: and Signed-off-by: tags? I'm fairly sure you made up that
> > > Signed-off-by: with the infradead address, which is naughty of you :)
> > 
> > Indeed, I would have grabbed the first email I could find from you and
> > applied the From: field from that email, as opposed to finding the exact
> > email containing your prototype of the patch and then locating and copying
> > out the Signed-off-by.  And if I were to happen to find the email that
> > I am now replying to, I would once again get infradead rather than amazon.
> > 
> > Apologies, but life was flowing fast, and it probably will be from time
> > to time in the future.  So thank you for checking and please continue
> > to do so.
> 
> Yeah, no problem. I do try to be good and give a SoB even when I'm
> throwing out a snippet of code that's *directional* and doesn't even
> compile. Mostly because I hate it when I'm on the receiving end of
> such, *use* the snippet I'm given, and then have to chase for a real
> SoB from a drive-by co-author.
> 
> In this case I think it was 
> https://lore.kernel.org/all/fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org/
> which did have them both on the patch itself.
> 
> > > I tell people you should only ever cut-and-paste SoB lines, because
> > > that way the magic is intact. So here are the two you need for patches
> > > 4 and 5 of this series:
> > > 
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > Thank you again, and I have this note to myself for my next rebase:
> > 
> > a5130cf7b27f ("srcutree: Add an atomic Tree SRCU")
> > 85d5f89bdc42 ("srcutiny: Add an atomic Tiny SRCU")
> > 	Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
> > 	Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > Does that cover it?
> 
> Looks good, thanks!

And these are now applied in my -rcu tree:

60df507b6091 ("srcutree: Add an atomic Tree SRCU")
a48669f0c49c ("srcutiny: Add an atomic Tiny SRCU")

I intend to send the pull request before the merge window opens, so if
further adjustment is needed, please let me know right away.

> > And while we are discussing, how goes the use case?
> 
> It's working well. Torture tests and Sashiko reviews have tweaked it a
> bit, and found one issue that was already there in the upstream kernel.
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-srcu-v2
> 
> I've also backported it to a production tree (albeit using non-atomic
> SRCU there for now) and it works there too.
> 
> I still have to put my own eyes on some of those latest tweaks (and
> probably rewrite/decimate the commit messages). Will do so once the
> dust settles on the atomic-srcu work and I can rebase on top of a
> stable commit. But there's no rush; this whole thing has been on the
> back burner for a long time.

Here is hoping!  ;-)

							Thanx, Paul
