Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10A3B7A8;
	Sun,  6 Sep 2026 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788736617; cv=none; b=NDrZrbC5qfxUGD35w2J998PD9GIWvHFJmbcrdM3juOaWTxkk5yjzTgmTZBtlSDfQCrAUXVyzGNnNvgaK0aap/dO3Fg0YPHNiwFYHPh7zdNsa519Sywz1epTxjkH1XLDBZt3/+X9yRn2okupwmS+UycW1tpX93a7sXZO3rgVG6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788736617; c=relaxed/simple;
	bh=HAMgDjq8wGLUKYwe0FZjLi4AlFEGUlhB+0h/SpK/7WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXfiopS69R7tNqOnCy/cABL95Cvzs9mLUe9Ry9eImcKSwohJSr3eOLrc0K25pDbsqLveIbgcGQ24NSnnu9jM902+qCoFj/elq6yO0jqqskU+2uctqwiSEjmxHXti77LReJoPSx+hRyjSidgeKXj94oDn8mNTbeil1G2jOmMQi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQuQBki9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQuQBki9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBB41F00A3A;
	Sun,  6 Sep 2026 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788736615;
	bh=AIg0LhimhcTdRShjHukt/+U5xj0nCpPgMz1QuwH6YFo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jQuQBki9s5oaVFbXWeq+Sv30AE+Tv9FYZDpv95J7V9GJZ6dQJHJW59KQAEt6AEwET
	 UOAXUc/lrrirSS5Po7YtuHjkoQfok4o9577E7+eVMHyGn32A4rdjrMVAoZBobcMMfz
	 Rvz5zhiq4zGnikNXHdgg+z2A4goTdkk3e9S1ZKostdnQcz0vmlIjDA3KFg9+AEbFv5
	 myR779w8COdgbehNZGU60qrUB9GT9tRnd8ZWYrRSHi54mfhsDV5K5Fpkko94ZQLreX
	 o10ijUcIP+6eR8hwutlu5kqsTdF2uB8+XkfzRPq1HaBiUBnaPRiSKNiu9hsGsDB80E
	 lowsaOz+TL2XA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6357FCE09E8; Sun,  6 Sep 2026 16:16:55 -0700 (PDT)
Date: Sun, 6 Sep 2026 16:16:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, boqun@kernel.org,
	frederic@kernel.org, include@grrlz.net, jiangshanlai@gmail.com,
	joelagnelf@nvidia.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
	urezki@gmail.com
Subject: Re: [PATCH] hazptrtorture: Fix inverted sleep condition in
 do_pending kthread
Message-ID: <bbab8067-9bb4-46d0-bbbd-da7b836b04f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop>
 <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org>
 <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop>
 <28838ba4-8618-45d0-9994-3efee251bce2@efficios.com>
 <748b12b2-f1a3-4ed8-8c9b-86fa8d9a5926@paulmck-laptop>
 <179E0ECA-C65D-4480-9E4E-CFA960D55665@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179E0ECA-C65D-4480-9E4E-CFA960D55665@mainlining.org>

On Sun, Sep 06, 2026 at 07:56:29PM +0100, Bradley Morgan wrote:
> On 6 September 2026 19:46:50 BST, "Paul E. McKenney" <paulmck@kernel.org>
> wrote:
> >On Sun, Sep 06, 2026 at 09:09:53AM -0400, Mathieu Desnoyers wrote:
> >> On 2026-09-05 16:40, Paul E. McKenney wrote:
> >> > On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
> >> [...]
> >> > I would not say "no" to a fix for this issue:
> >> > 
> >> >
> >https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
> >> 
> >> I'm not sure this URL actually points to a relevant issue ?
> >
> >Indeed, it does not, apologies!  Here you go:
> >
> >https://lore.kernel.org/all/202608130915.62b53936-lkp@intel.com/
> >
> >> > Once that is in place, I would be happy to put this back into -next.
> >> > 
> >> > At some point, we will need to get rid of the concept of wildcard
> >hazard
> >> > pointers, as those end up instead emulating RCU, but I don't see that
> >> > as an immediate obstacle.
> >> 
> >> I already have the implementation which eliminates the wildcard if we
> >> care about this. It was part of a previous hazptr series version.
> >> 
> >> Do you want me to resurrect it on top of the current series ?
> >> This depends on:
> >> 
> >> - ptr_eq(),
> >> - then use ptr_eq() to compare the loaded pointer (pre mb)
> >>   with the re-loaded pointer (post-mb).
> >> 
> >> See:
> >https://lore.kernel.org/all/20251218014531.3793471-1-mathieu.desnoyers@efficios.com/
> >
> >The main objection was over the content and style of the kernel-doc
> >header comment, right?  I am guessing that it should be possible to
> >resolve this to roughly equal disgust of all concerned.  ;-)
> >
> >We did make some progress on this sort of pointer issue in C++29
> >this past June:
> >
> >https://people.kernel.org/paulmck/c-pointer-zap-and-oota-progress
> >
> >But the piece you need is this guy, which is still in process:
> >
> >https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2025/p3790r1.pdf
> >
> >Plus it will be some time before this reaches all the compilers used
> >to build the Linux kernel, and probably even more time to reach the
> >C language.  I do have pen-on-paper notes that will lead to a draft
> >of the corresponding C-language working paper, but these things do not
> >move quickly.
> >
> >So, yes, we will need something like ptr_eq() for some years to come.
> >
> >Back to your original question, given the fix for the above bug and
> >given the current use case, I believe we can get the current series into
> >mainline.  Give or take Linus's thoughts on the matter.  But either way,
> >we will need a version that allows the user to avoid all wildcard use
> >sooner rather than later.
> >
> >So having a series on top of the current one for a later merge window
> >would be a very good thing!
> >
> Can I participate in this? :)

If Mathieu is OK with it, feel free to look at the patch stack that
Mathieu sent the URL for earlier in this thread.  Either way, please
feel free to look at the stack in my -rcu tree based on v7.3-rc1 and
headed by this commit:

4398b7c192d ("hazptr: Implement two-phase wildcard scan")

Perhaps you can find the bug that kernel test robot located.  ;-)

My -rcu tree is here:

git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

Just so you know, in all cases, your taking on a task does not preclude
others from also taking that same task on.

							Thanx, Paul

> --- Thanks!
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
