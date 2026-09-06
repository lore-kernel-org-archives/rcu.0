Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5335E94F;
	Sun,  6 Sep 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720412; cv=none; b=VoWrvVd3xlwOD4EOr+cTgeXuyJ3k170TLB4MDSTRPh5FRi9tSRuMEAA3xH+QyxxYhqr1ZjVoWXpTr8R2ksBCN90bHxB6smefEFLNABPedh7RuC9p0MHPycqRP+LxIdTrW82XzNDzQ7J9IIUcGTm6YbpJfDmgP6nfr7/+VWwJgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720412; c=relaxed/simple;
	bh=/uybhKdog+sT+G+K76Mu/1ObK+N5OscwmkiO0SEjvYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0AnsFVUdiUL6dwK//aoLO2kTeHLzNOZNFXY4Cj1p7fU46MtpKBlXQODkf0P+GD9rcbSWIZmyGU7lvrg3BpklttfIJK9BfFlWRC8LSr07hUEc3Sr9+B8UUWdcpf4J7gY7Ti1aTQ8wVwJZE+eF8XrwozI5vwyWm87pzVudTy2pBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak8Z7xB8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak8Z7xB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956491F00A3A;
	Sun,  6 Sep 2026 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720410;
	bh=SDogltP7UdUfSqq8GDhVYpUxqSB3y5eMEnNCW+YSSf8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ak8Z7xB8MAiaNescTuff4inXHr1XjD1o+SXNPllKg+MF2tfiPNnHQlS2upBqezHCa
	 2OfcZaMuEX/75OEXGNxIFYtVcizdonwvTalkumoAczVzYTWW6O+3bFjLI7NNLKRPmp
	 T9nEPAx1zNV0SNCPCxt2SkFf010zLc9lVpRC5AKYo8kjDP8aiPv3UcRDP5bU7NrqAU
	 kFHXfAWtrmqNaGfoudewiYyOzfXNkvPEIkrYztbYZLI5gd4vzoOtL/LOifA4mY5VLI
	 cqnGT0PZf3mkzs0VnZra1RKfH4hwAAW3EwZ35tXKDp6dXlSGBt9xaauqD66qtaSZX6
	 JOVAUcEVZXS+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5B313CE09E8; Sun,  6 Sep 2026 11:46:50 -0700 (PDT)
Date: Sun, 6 Sep 2026 11:46:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Bradley Morgan <brads@mainlining.org>, boqun@kernel.org,
	frederic@kernel.org, include@grrlz.net, jiangshanlai@gmail.com,
	joelagnelf@nvidia.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
	urezki@gmail.com
Subject: Re: [PATCH] hazptrtorture: Fix inverted sleep condition in
 do_pending kthread
Message-ID: <748b12b2-f1a3-4ed8-8c9b-86fa8d9a5926@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop>
 <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org>
 <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop>
 <28838ba4-8618-45d0-9994-3efee251bce2@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28838ba4-8618-45d0-9994-3efee251bce2@efficios.com>

On Sun, Sep 06, 2026 at 09:09:53AM -0400, Mathieu Desnoyers wrote:
> On 2026-09-05 16:40, Paul E. McKenney wrote:
> > On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
> [...]
> > I would not say "no" to a fix for this issue:
> > 
> > https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
> 
> I'm not sure this URL actually points to a relevant issue ?

Indeed, it does not, apologies!  Here you go:

https://lore.kernel.org/all/202608130915.62b53936-lkp@intel.com/

> > Once that is in place, I would be happy to put this back into -next.
> > 
> > At some point, we will need to get rid of the concept of wildcard hazard
> > pointers, as those end up instead emulating RCU, but I don't see that
> > as an immediate obstacle.
> 
> I already have the implementation which eliminates the wildcard if we
> care about this. It was part of a previous hazptr series version.
> 
> Do you want me to resurrect it on top of the current series ?
> This depends on:
> 
> - ptr_eq(),
> - then use ptr_eq() to compare the loaded pointer (pre mb)
>   with the re-loaded pointer (post-mb).
> 
> See: https://lore.kernel.org/all/20251218014531.3793471-1-mathieu.desnoyers@efficios.com/

The main objection was over the content and style of the kernel-doc
header comment, right?  I am guessing that it should be possible to
resolve this to roughly equal disgust of all concerned.  ;-)

We did make some progress on this sort of pointer issue in C++29
this past June:

https://people.kernel.org/paulmck/c-pointer-zap-and-oota-progress

But the piece you need is this guy, which is still in process:

https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2025/p3790r1.pdf

Plus it will be some time before this reaches all the compilers used
to build the Linux kernel, and probably even more time to reach the
C language.  I do have pen-on-paper notes that will lead to a draft
of the corresponding C-language working paper, but these things do not
move quickly.

So, yes, we will need something like ptr_eq() for some years to come.

Back to your original question, given the fix for the above bug and
given the current use case, I believe we can get the current series into
mainline.  Give or take Linus's thoughts on the matter.  But either way,
we will need a version that allows the user to avoid all wildcard use
sooner rather than later.

So having a series on top of the current one for a later merge window
would be a very good thing!

							Thanx, Paul
