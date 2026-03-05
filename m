Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE2346FAB
	for <rcu@vger.kernel.org>; Thu,  5 Mar 2026 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744930; cv=none; b=PPsXyYI7fXM7pb6KwtL1LefGuBzud6nh8NRyhNZOefS+Rijw9xEez1KbfVLBkzj5wI4jJLEdy21ixEbGSqAMiqnQDlRfTpH6nwJNacRQiI3Xl1TQCjhImiFKwO26+u4+zaxjgOudzI4z7A7wuOMSzigO65/opjVIBafz0HmvduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744930; c=relaxed/simple;
	bh=Q8trJ61nMgSNX6zFqOIyZUKcuRwq8lothkJxpaEZ1qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9tpuuGnIit1r8DRCiio6iE9Ox+PEBsOUu7SB2N7bZ4MKjuHpS6+Ev7aHZuMK1yUgS35RCbjBiyfelFY5U8zENlhjWsy3vlyOop/F7xOut5ropdzmFyTWb7eXoqcQKXqYYp80fMMPACVQr74aXIgIEBKPC9Ot2WD3VqanY1xMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycl8A8op; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycl8A8op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B94DC116C6;
	Thu,  5 Mar 2026 21:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772744929;
	bh=Q8trJ61nMgSNX6zFqOIyZUKcuRwq8lothkJxpaEZ1qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ycl8A8opboS9ShenKfJCA4i4dB728fjLAeabAgYt0ina8wSqNnSIzNKF1NJcNqqnX
	 OGaGJ6egOdaQ7Gf2YWjn8eb7Kk5yhM2H77Z/2WINU2NyW+FPrErBjMr2/qiHCGUyI1
	 u1+n/frQUS4iAOb/GQe3NeJH0Ct7skcK2YEi/L+N15PESs5lP0N1ydWXfQUGdWAoxB
	 NxRWxWXabldfZyVk92E1t/NsD+Oo5Ks5TUVVgFhd0LGwo7KQnGr0airFtpfELydcLW
	 m1bpTsTG4nipfU2/qB+JWh8JrTnmpsrnvkTgM84EJct/oyV5uPdy/tcxI3I+6KaZyc
	 d00z66LT0wjuQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id AF392F40069;
	Thu,  5 Mar 2026 16:08:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 16:08:48 -0500
X-ME-Sender: <xms:4PCpaZaooJwq1zCsIkaOi6omQZdiSSpqLLPtm_X8_5ETYPXIMlWgoA>
    <xme:4PCpaZv7E2qavqiCF-6xPGpwBVo3aE3vkPW8jm_AT5Sz_d11gcUmnlVxWod-1fHxF
    aVDP22yeHTvotkT_RbIJhyjQt09pro5n6YeLIzkGuffqqmO_FwDyqk>
X-ME-Received: <xmr:4PCpaTMy6eFnkOhd18VEMTO4x8wmVimmOCMbwy5UcXsRU9LBnbQXnVIn6_PKKGrZB351umZwySrJlKIRvDUd-elTYQSrlh4G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghu
    lhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtoh
    hmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthho
    pegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4PCpaY5QmMMgsXG9qkkjwgcvPR2RV995GbYvplYWW5WrhORB1iI49Q>
    <xmx:4PCpaRRXKpVZOp7blSX7sHqiGOceG6Ge-DB1_sz6JwGPzaOOI68gvA>
    <xmx:4PCpadAPgSoU45HGeBH2s7BBl20ZoXWoW9WrCbnfd1YAhx05kH6cCw>
    <xmx:4PCpaZF3LOysd_Auon-E6A6ERx43wwYxkLOopEcUYMuP234iwfXLYw>
    <xmx:4PCpafCctgjqxp0xVjq0bH5TUDQEhTnBEOgGaz94sfm0XkIhUJUzmFxJ>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 16:08:48 -0500 (EST)
Date: Thu, 5 Mar 2026 13:08:47 -0800
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v3 1/4] rcutorture: Update due to x86 not supporting
 none/voluntary preemption
Message-ID: <aanw37BOGTlzx3AV@tardis.local>
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
 <20260303235903.1967409-1-paulmck@kernel.org>
 <dda12988-2a5c-4549-bdfc-8e429fc0aab1@paulmck-laptop>
 <bfe89f6c-3b63-40c6-aa6d-5f523e3e9a31@paulmck-laptop>
 <aanJ65E2VSJd8ZAl@tardis.local>
 <58f83c55-51cf-4a77-a5d1-3a5adfe9e4c2@paulmck-laptop>
 <aangp2xaOayAC8dy@tardis.local>
 <fc2186ef-f7f6-4a05-b442-95dbc9831884@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc2186ef-f7f6-4a05-b442-95dbc9831884@paulmck-laptop>

On Thu, Mar 05, 2026 at 12:11:46PM -0800, Paul E. McKenney wrote:
> On Thu, Mar 05, 2026 at 11:59:35AM -0800, Boqun Feng wrote:
> > On Thu, Mar 05, 2026 at 11:06:25AM -0800, Paul E. McKenney wrote:
> > > On Thu, Mar 05, 2026 at 10:22:35AM -0800, Boqun Feng wrote:
> > [...]
> > > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
> > > > > index bd5ed7b0da5f0..2be53bf60d65b 100644
> > > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
> > > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
> > > > > @@ -1,9 +1,9 @@
> > > > >  CONFIG_SMP=n
> > > > > -CONFIG_PREEMPT_NONE=y
> > > > > +CONFIG_PREEMPT_LAZY=y
> > > > > +CONFIG_PREEMPT_NONE=n
> > > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > > >  CONFIG_PREEMPT=n
> > > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > > > -CONFIG_PREEMPT_LAZY=n
> > > > 
> > > > This is the line that was introduced by the said commit, hence this
> > > > patch is still separate from that commit I think?
> > > 
> > > I *think* I have them folded/squashed correctly.
> > > 
> > > I pushed this out to my -rcu "dev" branch.  The relevant commits are,
> > > in order of increasing time of commit:
> > > 
> > > c70ac5693540 ("rcutorture: Adjust scenarios for default lazy preemption")
> > 
> > It's the commit c69ac5693540 in your "dev" branch, right?
> 
> Right you are!
> 
> > > 86126bc6d7ad ("rcutorture: Update due to x86 not supporting none/voluntary preemption")
> > > 5631c1565493 ("Revert "rcutorture: Adjust scenarios for default lazy preemption"")
> > > 6fd95cee7427 ("Revert "rcutorture: Update due to x86 not supporting none/voluntary preemption"")
> > 
> > The thing is the combination of the above 4 didn't introduce a clean
> > base in rcu/{TINY01, TREE04, TREE05, TREE06}, as shown by:
> > 
> > 	git diff 'c69ac5693540^..6fd95cee7427' -- tools/testing/selftests/rcutorture/configs/rcu/{TINY01,TREE04,TREE05,TREE06}
> > 
> > I took a look, it's because commit 86126bc6d7ad ("rcutorture: Update due
> > to x86 not supporting none/voluntary preemption") was based on commit
> > c69ac5693540, and it moved a few CONFIG_PREEMPT_LAZY configs, and when
> > it got reverted in commit 6fd95cee7427, these configs were moved back so
> > commit 5631c1565493's revert was partially reverted.
> > 
> > > 17c52d7b31a1 ("rcutorture: Update due to x86 not supporting none/voluntary preemption")
> > > 
> > 
> > A simple way to verify would be try `cherry-pick` this commit onto
> > 7.0-rc1.
> 
> Like this?
> 
> $ git reset --hard v7.0-rc1
> $ git cherry-pick 17c52d7b31a1fbec84172d279b3ab0149bc71627
> Auto-merging tools/testing/selftests/rcutorture/configs/rcu/TINY01
> Auto-merging tools/testing/selftests/rcutorture/configs/rcu/TREE04
> Auto-merging tools/testing/selftests/rcutorture/configs/rcu/TREE05
> Auto-merging tools/testing/selftests/rcutorture/configs/rcu/TREE06

Yeah, the delta is small enough so that 3-way auto-merging can handle
it. I will just apply with these resolution. Thanks!

> [detached HEAD 551d9b94e2c80] rcutorture: Update due to x86 not supporting none/voluntary preemption
>  Date: Tue Mar 3 11:28:02 2026 -0800
>  12 files changed, 29 insertions(+), 13 deletions(-)
> $ git branch lazy-1
> $ git checkout v7.0-rc1
> Previous HEAD position was 551d9b94e2c80 rcutorture: Update due to x86 not supporting none/voluntary preemption
> HEAD is now at 6de23f81a5e08 Linux 7.0-rc1
> $ git cherry-pick c69ac56935401534120ef1e40335090b973a97d2
> [detached HEAD da3c99da7a639] rcutorture: Adjust scenarios for default lazy preemption
>  Date: Wed Jan 21 10:40:30 2026 -0800
>  5 files changed, 7 insertions(+)
> 1$ git cherry-pick 86126bc6d7ad5af56c0bf8beeac12f8feaffa866
> [detached HEAD 824577abfb3b0] rcutorture: Update due to x86 not supporting none/voluntary preemption
>  Date: Tue Mar 3 11:28:02 2026 -0800
>  11 files changed, 26 insertions(+), 17 deletions(-)
> $ git diff lazy-1
> 
> Still no diff output.  What am I missing?
> 

Not important right now, but if you do:

	git range-diff 'lazy-1^..lazy-1' '17c52d7b31a1^..17c52d7b31a1'

you will see if I applied your v3 onto v7.0-rc1, I wouldn't end up
having the exact changes as the v3 has (some auto resolution happened).

Regards,
Boqun

> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > > The first was applied by Joel to the shared RCU tree, the second is in my
> > > -rcu tree, and the last three are consecutive commits in my -rcu tree.
> > > The following command gives no output, which I was interpreting as my
> > > having done it correctly.  But please double-check.
> > > 
> > > git diff 5631c1565493^..17c52d7b31a1
> > > 
> > > 							Thanx, Paul
> > > 
> > > > Regards,
> > > > Boqun
> > > > 
> > > > >  #CHECK#CONFIG_TINY_RCU=y
> > > > >  CONFIG_HZ_PERIODIC=n
> > > > >  CONFIG_NO_HZ_IDLE=y
> > > > > @@ -12,4 +12,3 @@ CONFIG_RCU_TRACE=n
> > > > >  #CHECK#CONFIG_RCU_STALL_COMMON=n
> > > > >  CONFIG_DEBUG_LOCK_ALLOC=n
> > > > >  CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> > > > > -CONFIG_PREEMPT_COUNT=n
> > > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY02 b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
> > > > > index 30439f6fc20e6..be8860342ef71 100644
> > > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TINY02
> > > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
> > > > > @@ -1,5 +1,6 @@
> > > > >  CONFIG_SMP=n
> > > > > -CONFIG_PREEMPT_NONE=y
> > > > > +CONFIG_PREEMPT_LAZY=y
> > > > > +CONFIG_PREEMPT_NONE=n
> > > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > > >  CONFIG_PREEMPT=n
> > > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
> > > > > index 18efab346381a..8fb124c28f283 100644
> > > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
> > > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
> > > > > @@ -1,7 +1,8 @@
> > > > >  CONFIG_SMP=y
> > > > >  CONFIG_NR_CPUS=5
> > > > >  CONFIG_HOTPLUG_CPU=y
> > > > > -CONFIG_PREEMPT_NONE=y
> > > > > +CONFIG_PREEMPT_LAZY=y
> > > > > +CONFIG_PREEMPT_NONE=n
> > > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > > >  CONFIG_PREEMPT=n
> > > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > > > > index 34aee1acb8662..ac857d5bcb222 100644
> > > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > > > > @@ -1,11 +1,12 @@
> > > > >  CONFIG_SMP=y
> > > > >  CONFIG_NR_CPUS=8
> > > > > +CONFIG_PREEMPT_LAZY=y
> > > > >  CONFIG_PREEMPT_NONE=n
> > > > > -CONFIG_PREEMPT_VOLUNTARY=y
> > > > > +CONFIG_PREEMPT_VOLUNTARY=n
> > > > >  CONFIG_PREEMPT=n
> > > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > > > -CONFIG_PREEMPT_LAZY=n
> > > > >  #CHECK#CONFIG_TREE_RCU=y
> > > > > +#CHECK#CONFIG_PREEMPT_RCU=n
> > > > >  CONFIG_HZ_PERIODIC=n
> > > > >  CONFIG_NO_HZ_IDLE=n
> > > > >  CONFIG_NO_HZ_FULL=y
> > > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> > > > > index 0513aa33c32c4..61d15b1b54d16 100644
> > > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> > > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> > > > > @@ -1,9 +1,10 @@
> > > > >  CONFIG_SMP=y
> > > > >  CONFIG_NR_CPUS=8
> > > > > -CONFIG_PREEMPT_NONE=y
> > > > > +CONFIG_PREEMPT_DYNAMIC=n
> > > > > +CONFIG_PREEMPT_LAZY=y
> > > > > +CONFIG_PREEMPT_NONE=n
> > > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > > >  CONFIG_PREEMPT=n
> > > > > -CONFIG_PREEMPT_LAZY=n
> > > > >  #CHECK#CONFIG_TREE_RCU=y
> > > > >  CONFIG_HZ_PERIODIC=n
> > > > >  CONFIG_NO_HZ_IDLE=y
> > > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
> > > > > index cc3ea23c76557..0e090bb68a0f6 100644
> > > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
> > > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
> > > > > @@ -1,10 +1,12 @@
> > > > >  CONFIG_SMP=y
> > > > >  CONFIG_NR_CPUS=8
> > > > > -CONFIG_PREEMPT_NONE=y
> > > > > +CONFIG_PREEMPT_DYNAMIC=n
> > > > > +CONFIG_PREEMPT_LAZY=y
> > > > > +CONFIG_PREEMPT_NONE=n
> > > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > > >  CONFIG_PREEMPT=n
> > > > > -CONFIG_PREEMPT_LAZY=n
> > > > >  #CHECK#CONFIG_TREE_RCU=y
> > > > > +#CHECK#CONFIG_PREEMPT_RCU=n
> > > > >  CONFIG_HZ_PERIODIC=n
> > > > >  CONFIG_NO_HZ_IDLE=y
> > > > >  CONFIG_NO_HZ_FULL=n
> > > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
> > > > > index 420632b030dc4..b2ce37861e71a 100644
> > > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
> > > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
> > > > > @@ -6,6 +6,7 @@ CONFIG_PREEMPT_VOLUNTARY=n
> > > > >  CONFIG_PREEMPT=n
> > > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > > >  #CHECK#CONFIG_TREE_RCU=y
> > > > > +CONFIG_PREEMPT_RCU=n
> > > > >  CONFIG_HZ_PERIODIC=n
> > > > >  CONFIG_NO_HZ_IDLE=y
> > > > >  CONFIG_NO_HZ_FULL=n
> > > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
> > > > > index 5d546efa68e83..696fba9968c60 100644
> > > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
> > > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
> > > > > @@ -1,6 +1,8 @@
> > > > >  CONFIG_SMP=y
> > > > >  CONFIG_NR_CPUS=8
> > > > > -CONFIG_PREEMPT_NONE=y
> > > > > +CONFIG_PREEMPT_DYNAMIC=n
> > > > > +CONFIG_PREEMPT_LAZY=y
> > > > > +CONFIG_PREEMPT_NONE=n
> > > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > > >  CONFIG_PREEMPT=n
> > > > >  CONFIG_HZ_PERIODIC=n
> > > > > 
> > > 
> 
