Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7A157A7C
	for <rcu@vger.kernel.org>; Tue, 23 Jul 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753470; cv=none; b=JFJIgjYS/kuH1kOwU2kIMOEm6P4fEQU5zoXosZTaOJY6J1ktAfyi+gBMxW5fLNQirsL4s2iq3/nSf52Ex8dUNtwt3A02X1KybJITrhCoqM5EynO2kjdZI9gzgUQozIAVOFlpEC5CY0pixPZvysPnhsQNclkG6x6H67kdGc7yVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753470; c=relaxed/simple;
	bh=/NMltdABXWM3MKVA7ivnuxyHwBGYWFSnsB5Ip85fMwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvcYlSauXX/yQEvb0GnvNYYJX7e/X0YlVGdtAW4Ot7tLFDsjkGP07ajqNSvNcbm7x9hzOzid7T/ouBF+m+gNNLlI1Sd8DwGjBrjcDm4UjC85NaQivnBbjiVCLWUo8goNt7A/dU60Om/kouJqmx9PpMyiV1BbI1pb65ys9JQS4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LABelpDq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LABelpDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF96C4AF09;
	Tue, 23 Jul 2024 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721753469;
	bh=/NMltdABXWM3MKVA7ivnuxyHwBGYWFSnsB5Ip85fMwE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LABelpDqXHEnfEaftkTtwLhhgwyCzNB2zlEXWzFWUmqdzm/0pvWoLU32BXHsD21Ke
	 ifcvpIaj77MisTdRxvonNAJj42sK+oy0UeXcZvjdXRSpjISw2s4NnyR0HepYw7g08L
	 5DpcvmMZkVyPppEFaBngeKw0dlE64iROLTy4bPm9DoEP1fIehnh4K0dyelQl7cm35c
	 yN8SjclroPsPXhMlCv5WuiJIwIH1iHSGyiSb4NT0jeZQUwToAIlI0rbt5nACyVqxiO
	 2XvsujUPEe9CcDDnOJ5gXRSJ5XeJGc6Vy0QwR5Pj+XBdSSTRUJiutWbydwH6bCUIuS
	 M12oi86QPUM/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C85ADCE0BC6; Tue, 23 Jul 2024 09:51:03 -0700 (PDT)
Date: Tue, 23 Jul 2024 09:51:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, hannes@cmpxchg.org, willy@infradead.org,
	rcu@vger.kernel.org
Subject: Re: Possible slab-allocator issue
Message-ID: <5b374b4e-1220-4da3-b4da-fce733417fad@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e6db32f7-d1fa-4d38-acf9-f78234f87170@paulmck-laptop>
 <591ffb38-f92c-41ec-a849-561c34413be5@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591ffb38-f92c-41ec-a849-561c34413be5@suse.cz>

On Tue, Jul 23, 2024 at 11:05:16AM +0200, Vlastimil Babka wrote:
> On 7/22/24 11:38 PM, Paul E. McKenney wrote:
> > Hello!
> 
> Hi!

TL;DR:  My mistakes in testing, nothing to see hear, thank you for
bearing with me, and apologies for wasting your time.

> > I have been chasing a hang [1] in rcuscale, which is a kernel module
> > that does performance testing for RCU updaters.  I have a good long-term
> > workaround for this problem, namely an extremely stupid custom allocator,
> > so I don't need a fix, but I am nevertheless posting this just in case
> > this affects others.  Or in case I am doing something stupid that I
> > should avoid doing in the future.
> > 
> > I first encountered this on RCU's "dev" branch, but the problem also
> > exists in current mainline [2].  One high-probability reproducer for
> > this hang, tested on both AMD and Intel x86, is as follows:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --configs TREE --bootargs "rcuscale.scale_type=tasks rcuscale.minruntime=5 rcuscale.nreaders=0 rcuscale.nwriters rcuscale.gp_async=1 rcuscale.gp_async_max=100000" --trust-make
> > 
> > This script builds a kernel, requires that virtualization be enabled,
> > and uses the qemu-system-x86_64 command.  I have not run this on a system
> > with fewer than 16 CPUs.
> > 
> > When it fails, this takes a bit less than ten minutes to fail, which
> > results in a non-zero exit code from kvm.sh.  Rare successes normally
> > consume kernel-build time plus less than a minute of run time.
> > 
> > The failure mode is CPU 0 (and always CPU 0) failing to get out of this
> > (admittedly ugly, since reworked) "retry" loop in the rcu_scale_writer()
> > function in kernel/rcu/rcuscale.c:
> > 
> >  1 retry:
> >  2   if (!rhp)
> >  3     rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> >  4   if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
> >  5     atomic_inc(this_cpu_ptr(&n_async_inflight));
> >  6     cur_ops->async(rhp, rcu_scale_async_cb);
> >  7     rhp = NULL;
> >  8   } else if (!kthread_should_stop()) {
> >  9     cur_ops->gp_barrier();
> > 10     goto retry;
> > 11   } else {
> > 12     kfree(rhp); /* Because we are stopping. */
> 
> Noted no "rhp = NULL;" but we probably really shouldn't reach this again due
> to torture_must_stop() including kthread_should_stop() so it should be fine.
> 
> > 13   }
> > 
> > The loop begins with the "retry" label on line 1, finds "rhp"
> > equal to NULL on line 2, gets a NULL from kmalloc(..., GFP_KERNEL)
> > on line 3, proceeds to the "else if" clause on lines 8-11,
> 
> So it's been verified that rhp is indeed null after kmalloc() and it's not
> going to the "else if" because of the rest of the condition?

Yes, but as it turns out, incorrectly.  :-(

> I wonder how this loop works, it increases a percpu counter
> n_async_inflight, and rcu_scale_async_cb() decreases it, but can't the
> callback be invoked on a different cpu, making these counters imbalanced?

The theory was that, given the configuration, callbacks must be invoked
on the CPU on which they were queued.  Which is the case.  Except that
there is no per-thread sched_setaffinity(), so there is no guarantee that
the callback will be queued on the same CPU whose counter was incremented.

I now have a patch that associates the counter with the task instead
of the CPU, which will take care of things even on configurations on
which callbacks can be invoked on different CPUs (CPU hotplug enabled
or callback offloading enabled).

So it was a bug in my test code.

On the other hand, my test code has found a great many bugs, so I guess
in the long run I have been winning?

> > invokes rcu_barrier_tasks() on line 9 (because that is what the
> > rcuscale.scale_type=tasks kernel boot parameter tells it to do), then
> > line 10 jumps back to the retry label.  This repeats thousands of times,
> > consuming some minutes.  There is no drama in the console log, as in no
> > mention of OOM killer, allocation failures, or much of anything other
> > than Tasks RCU switching to per-CPU callback queueing due to the heavy
> > load and the expected rcuscale output.
> 
> A GFP_KERNEL failure should definitely produce OOM or allocation failure
> warning (and it's "too small to fail" to start with :)) Silently returning
> NULL is, uh, inconcievable. That would really require a bug in the
> implementation, or perhaps some slab structures corruption due to double
> free or use after free (although I've seen those always manifest in a
> different, much more noisy way).

Good to know that my initial belief was not wrong.

> > Note that all 16 CPUs are looping allocating and invoking either
> > call_rcu_tasks() when allocation succeeds or rcu_barrier_tasks() when
> > allocation fails.  So CPU 0 could simply be quite unlucky or have other
> > work so that when the rcu_barrier_tasks() waits for memory to be released,
> > the other CPUs allocate it all before CPU 0's rcu_scale_writer() task
> > is awakened.  But again, there is no sign of memory-system drama on
> > the console log.
> > 
> > I am good, as I implemented a stupid per-CPU-array-based allocator,
> > which avoids this issue, admittedly quite crudely.
> 
> That shouldn't help if it was a problem with n_async_inflight imbalance as I
> suggested above but who knows, maybe it's being busy in kmalloc() that
> causes some rcu callbacks to be executed elsewhere than on the CPU that
> submitted them, and using your allocator avoids that?

I lost interest in completing the bisection, but given that it was
between v6.4 and v6.6, my guess is that the aforementioned migration
became more probable.

> > Johannes suggested turning on tracing for the kmem:kmalloc and
> > kmem:mm_page_alloc trace events, which I did using this command:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --configs TREE --kconfig "CONFIG_DEBUG_KERNEL=y CONFIG_RCU_TRACE=y CONFIG_FTRACE=y" --bootargs "rcuscale.scale_type=tasks rcuscale.minruntime=5 rcuscale.nreaders=0 rcuscale.nwriters rcuscale.gp_async=1 rcuscale.gp_async_max=100000 trace_event=kmem:kmalloc,kmem:mm_page_alloc trace_buf_size=3k" --trust-make
> > 
> > I collected the .config file [3] and console output [4].  The console
> > output features more than 1500 kmalloc trace events and not quite 10
> > mm_page_alloc trace events.
> 
> Hm but tracing doesn't output to console so I don't see any trace events there.

It does when you invoke ftrace_dump(), but I have to give you the
right console output (something about doing three different bisections
yesterday).  Not that it matters, but here you go:

https://drive.google.com/file/d/1ufjKYGtgf8s8BVS9DHbEB0cftA7cKbsY/view?usp=sharing

Search for "Dumping ftrace buffer:".

Again, please accept my apologies for wasting your time!

							Thanx, Paul

> > Please let me know if more information would be helpful.
> > 
> > 							Thanx, Paul
> > 
> > [1] https://docs.google.com/document/d/1M_SJ_hVUe-jtkH6BjHzzRFOnAiu1sqThlFnx8Jfp-fg/edit?usp=sharing
> > [2] bbb3556c014d ("Merge tag 'keys-next-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd"), for example.
> > [3] https://drive.google.com/file/d/1lZmIvatLyVYzdRK_rv2xNNWDBiGwyQvk/view?usp=sharing
> > [4] https://drive.google.com/file/d/1jh4hJG877j0Rp65153wtmzKm6jErXZ9n/view?usp=sharing
> 
