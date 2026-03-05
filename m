Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339AA292B4B;
	Thu,  5 Mar 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772741507; cv=none; b=i5KIFy72mX1b6bQ3r7IlcNv18XG5d/eRkvT8EZcwZTmuy77+MGZvBuo7zA6/A39ULlP9JLTmYcnsQzkm4RuyDMmvVUehMea4XAfjKsURifTg23L1aQtvZeO9gy3FUGslqUHj14vPLRJWEHHrYOvFD0sQQ8J1heudOkrzzKDqR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772741507; c=relaxed/simple;
	bh=3zrkUIEbmFvdm5y70/K0JhzYCk+67tZDiAMBbEftHd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSZujjIfZHVJnGnkVeV3ExQkZuE43hCGBxQ2EYZy2f/egCpE/tQ5Y5R/fKw2bPIohGHZWNg27RGZvsoxctSd8szMLkEnRR9wSW/xFJMuhVXvzt2jHPi10Y2w9ZYB60G3FGyVh0+sHftruYVgpFpM4vBTOsw0Plb6aCKVJlc71D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNi8zFTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNi8zFTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA746C116C6;
	Thu,  5 Mar 2026 20:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772741506;
	bh=3zrkUIEbmFvdm5y70/K0JhzYCk+67tZDiAMBbEftHd0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QNi8zFTryepMVMRKA2IRzTVKO/Gn6w0RX5zzd6oKwbltIqOwCcVKnCeVf8eTvqF/T
	 /67ZYCZ6bijVBgKsGnOrM4ibAg68i1OMxfd912+SsGdvdYCeDvFNWttdk2+vsYRjk6
	 Btqpk0TNw+GOHcIYqQPpss+tW8+vziq1Pb9qgYdgRWhAxYuqxy9YwrKT9WXDRO9GFB
	 G4Wfv34PNVdr+bu13Jv3Ydr3zIMsrqIwlfgO4vaKnlETlmlr6MHi6np82oKo79Pbg5
	 eZvFvWRPfy8IONRUQQUQsFhJMuWNn9laCkz2+jgno/i0KI4zLIuMTGODmyUWILHdhy
	 5J3P6He7W+cmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F04FCE10B8; Thu,  5 Mar 2026 12:11:46 -0800 (PST)
Date: Thu, 5 Mar 2026 12:11:46 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v3 1/4] rcutorture: Update due to x86 not supporting
 none/voluntary preemption
Message-ID: <fc2186ef-f7f6-4a05-b442-95dbc9831884@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
 <20260303235903.1967409-1-paulmck@kernel.org>
 <dda12988-2a5c-4549-bdfc-8e429fc0aab1@paulmck-laptop>
 <bfe89f6c-3b63-40c6-aa6d-5f523e3e9a31@paulmck-laptop>
 <aanJ65E2VSJd8ZAl@tardis.local>
 <58f83c55-51cf-4a77-a5d1-3a5adfe9e4c2@paulmck-laptop>
 <aangp2xaOayAC8dy@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aangp2xaOayAC8dy@tardis.local>

On Thu, Mar 05, 2026 at 11:59:35AM -0800, Boqun Feng wrote:
> On Thu, Mar 05, 2026 at 11:06:25AM -0800, Paul E. McKenney wrote:
> > On Thu, Mar 05, 2026 at 10:22:35AM -0800, Boqun Feng wrote:
> [...]
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
> > > > index bd5ed7b0da5f0..2be53bf60d65b 100644
> > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
> > > > @@ -1,9 +1,9 @@
> > > >  CONFIG_SMP=n
> > > > -CONFIG_PREEMPT_NONE=y
> > > > +CONFIG_PREEMPT_LAZY=y
> > > > +CONFIG_PREEMPT_NONE=n
> > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > >  CONFIG_PREEMPT=n
> > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > > -CONFIG_PREEMPT_LAZY=n
> > > 
> > > This is the line that was introduced by the said commit, hence this
> > > patch is still separate from that commit I think?
> > 
> > I *think* I have them folded/squashed correctly.
> > 
> > I pushed this out to my -rcu "dev" branch.  The relevant commits are,
> > in order of increasing time of commit:
> > 
> > c70ac5693540 ("rcutorture: Adjust scenarios for default lazy preemption")
> 
> It's the commit c69ac5693540 in your "dev" branch, right?

Right you are!

> > 86126bc6d7ad ("rcutorture: Update due to x86 not supporting none/voluntary preemption")
> > 5631c1565493 ("Revert "rcutorture: Adjust scenarios for default lazy preemption"")
> > 6fd95cee7427 ("Revert "rcutorture: Update due to x86 not supporting none/voluntary preemption"")
> 
> The thing is the combination of the above 4 didn't introduce a clean
> base in rcu/{TINY01, TREE04, TREE05, TREE06}, as shown by:
> 
> 	git diff 'c69ac5693540^..6fd95cee7427' -- tools/testing/selftests/rcutorture/configs/rcu/{TINY01,TREE04,TREE05,TREE06}
> 
> I took a look, it's because commit 86126bc6d7ad ("rcutorture: Update due
> to x86 not supporting none/voluntary preemption") was based on commit
> c69ac5693540, and it moved a few CONFIG_PREEMPT_LAZY configs, and when
> it got reverted in commit 6fd95cee7427, these configs were moved back so
> commit 5631c1565493's revert was partially reverted.
> 
> > 17c52d7b31a1 ("rcutorture: Update due to x86 not supporting none/voluntary preemption")
> > 
> 
> A simple way to verify would be try `cherry-pick` this commit onto
> 7.0-rc1.

Like this?

$ git reset --hard v7.0-rc1
$ git cherry-pick 17c52d7b31a1fbec84172d279b3ab0149bc71627
Auto-merging tools/testing/selftests/rcutorture/configs/rcu/TINY01
Auto-merging tools/testing/selftests/rcutorture/configs/rcu/TREE04
Auto-merging tools/testing/selftests/rcutorture/configs/rcu/TREE05
Auto-merging tools/testing/selftests/rcutorture/configs/rcu/TREE06
[detached HEAD 551d9b94e2c80] rcutorture: Update due to x86 not supporting none/voluntary preemption
 Date: Tue Mar 3 11:28:02 2026 -0800
 12 files changed, 29 insertions(+), 13 deletions(-)
$ git branch lazy-1
$ git checkout v7.0-rc1
Previous HEAD position was 551d9b94e2c80 rcutorture: Update due to x86 not supporting none/voluntary preemption
HEAD is now at 6de23f81a5e08 Linux 7.0-rc1
$ git cherry-pick c69ac56935401534120ef1e40335090b973a97d2
[detached HEAD da3c99da7a639] rcutorture: Adjust scenarios for default lazy preemption
 Date: Wed Jan 21 10:40:30 2026 -0800
 5 files changed, 7 insertions(+)
1$ git cherry-pick 86126bc6d7ad5af56c0bf8beeac12f8feaffa866
[detached HEAD 824577abfb3b0] rcutorture: Update due to x86 not supporting none/voluntary preemption
 Date: Tue Mar 3 11:28:02 2026 -0800
 11 files changed, 26 insertions(+), 17 deletions(-)
$ git diff lazy-1

Still no diff output.  What am I missing?

							Thanx, Paul

> Regards,
> Boqun
> 
> > The first was applied by Joel to the shared RCU tree, the second is in my
> > -rcu tree, and the last three are consecutive commits in my -rcu tree.
> > The following command gives no output, which I was interpreting as my
> > having done it correctly.  But please double-check.
> > 
> > git diff 5631c1565493^..17c52d7b31a1
> > 
> > 							Thanx, Paul
> > 
> > > Regards,
> > > Boqun
> > > 
> > > >  #CHECK#CONFIG_TINY_RCU=y
> > > >  CONFIG_HZ_PERIODIC=n
> > > >  CONFIG_NO_HZ_IDLE=y
> > > > @@ -12,4 +12,3 @@ CONFIG_RCU_TRACE=n
> > > >  #CHECK#CONFIG_RCU_STALL_COMMON=n
> > > >  CONFIG_DEBUG_LOCK_ALLOC=n
> > > >  CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> > > > -CONFIG_PREEMPT_COUNT=n
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY02 b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
> > > > index 30439f6fc20e6..be8860342ef71 100644
> > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TINY02
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
> > > > @@ -1,5 +1,6 @@
> > > >  CONFIG_SMP=n
> > > > -CONFIG_PREEMPT_NONE=y
> > > > +CONFIG_PREEMPT_LAZY=y
> > > > +CONFIG_PREEMPT_NONE=n
> > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > >  CONFIG_PREEMPT=n
> > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
> > > > index 18efab346381a..8fb124c28f283 100644
> > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
> > > > @@ -1,7 +1,8 @@
> > > >  CONFIG_SMP=y
> > > >  CONFIG_NR_CPUS=5
> > > >  CONFIG_HOTPLUG_CPU=y
> > > > -CONFIG_PREEMPT_NONE=y
> > > > +CONFIG_PREEMPT_LAZY=y
> > > > +CONFIG_PREEMPT_NONE=n
> > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > >  CONFIG_PREEMPT=n
> > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > > > index 34aee1acb8662..ac857d5bcb222 100644
> > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > > > @@ -1,11 +1,12 @@
> > > >  CONFIG_SMP=y
> > > >  CONFIG_NR_CPUS=8
> > > > +CONFIG_PREEMPT_LAZY=y
> > > >  CONFIG_PREEMPT_NONE=n
> > > > -CONFIG_PREEMPT_VOLUNTARY=y
> > > > +CONFIG_PREEMPT_VOLUNTARY=n
> > > >  CONFIG_PREEMPT=n
> > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > > -CONFIG_PREEMPT_LAZY=n
> > > >  #CHECK#CONFIG_TREE_RCU=y
> > > > +#CHECK#CONFIG_PREEMPT_RCU=n
> > > >  CONFIG_HZ_PERIODIC=n
> > > >  CONFIG_NO_HZ_IDLE=n
> > > >  CONFIG_NO_HZ_FULL=y
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> > > > index 0513aa33c32c4..61d15b1b54d16 100644
> > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> > > > @@ -1,9 +1,10 @@
> > > >  CONFIG_SMP=y
> > > >  CONFIG_NR_CPUS=8
> > > > -CONFIG_PREEMPT_NONE=y
> > > > +CONFIG_PREEMPT_DYNAMIC=n
> > > > +CONFIG_PREEMPT_LAZY=y
> > > > +CONFIG_PREEMPT_NONE=n
> > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > >  CONFIG_PREEMPT=n
> > > > -CONFIG_PREEMPT_LAZY=n
> > > >  #CHECK#CONFIG_TREE_RCU=y
> > > >  CONFIG_HZ_PERIODIC=n
> > > >  CONFIG_NO_HZ_IDLE=y
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
> > > > index cc3ea23c76557..0e090bb68a0f6 100644
> > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
> > > > @@ -1,10 +1,12 @@
> > > >  CONFIG_SMP=y
> > > >  CONFIG_NR_CPUS=8
> > > > -CONFIG_PREEMPT_NONE=y
> > > > +CONFIG_PREEMPT_DYNAMIC=n
> > > > +CONFIG_PREEMPT_LAZY=y
> > > > +CONFIG_PREEMPT_NONE=n
> > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > >  CONFIG_PREEMPT=n
> > > > -CONFIG_PREEMPT_LAZY=n
> > > >  #CHECK#CONFIG_TREE_RCU=y
> > > > +#CHECK#CONFIG_PREEMPT_RCU=n
> > > >  CONFIG_HZ_PERIODIC=n
> > > >  CONFIG_NO_HZ_IDLE=y
> > > >  CONFIG_NO_HZ_FULL=n
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
> > > > index 420632b030dc4..b2ce37861e71a 100644
> > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
> > > > @@ -6,6 +6,7 @@ CONFIG_PREEMPT_VOLUNTARY=n
> > > >  CONFIG_PREEMPT=n
> > > >  CONFIG_PREEMPT_DYNAMIC=n
> > > >  #CHECK#CONFIG_TREE_RCU=y
> > > > +CONFIG_PREEMPT_RCU=n
> > > >  CONFIG_HZ_PERIODIC=n
> > > >  CONFIG_NO_HZ_IDLE=y
> > > >  CONFIG_NO_HZ_FULL=n
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
> > > > index 5d546efa68e83..696fba9968c60 100644
> > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
> > > > @@ -1,6 +1,8 @@
> > > >  CONFIG_SMP=y
> > > >  CONFIG_NR_CPUS=8
> > > > -CONFIG_PREEMPT_NONE=y
> > > > +CONFIG_PREEMPT_DYNAMIC=n
> > > > +CONFIG_PREEMPT_LAZY=y
> > > > +CONFIG_PREEMPT_NONE=n
> > > >  CONFIG_PREEMPT_VOLUNTARY=n
> > > >  CONFIG_PREEMPT=n
> > > >  CONFIG_HZ_PERIODIC=n
> > > > 
> > 
