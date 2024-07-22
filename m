Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7851CAB5
	for <rcu@vger.kernel.org>; Mon, 22 Jul 2024 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684339; cv=none; b=OWCTXQibAomaq88zkSL9QEr9QsdOJFdUHc+t4XkzoYdB/m33zNgSIQCPp3iv2XgktSIhyF9a2V0JDkCSoXeSQTET97867jhWD8jMS6B4vIoRpzVJ9jCB7dWQIMbjU2xj7Z0PnD0qmhrIVqstf5GuAZAwTzTS+QN1aYvH3AeCQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684339; c=relaxed/simple;
	bh=Rmt1EHpAenm5mlggL4qEvhD0ErTUNnAcYszDJw3mMDk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O+3jfxDtaCh0pIwUx33A/O1i5ciQYtSCIk1RATxBrKvrJf9ZkqeEshhWnYGyCHoUn58o5xuDGZImCDZbFTiFTFplGSqnx2viYaMUxAv6jZcFvozaGF4+h3LWaTqayXVkWlsPMhCTqeMBJhZsDUMmtdTtpdz6gWWnPBLlMg4Xb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaVFeAdD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaVFeAdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC02C116B1;
	Mon, 22 Jul 2024 21:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721684339;
	bh=Rmt1EHpAenm5mlggL4qEvhD0ErTUNnAcYszDJw3mMDk=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=BaVFeAdDuAKKbaXJBRnQpl9wtpPjyZn57+ZDbkF+9m3dHzAVAfHUhDz5ky4ABOylC
	 XJcKDRlaxC22UvZn84L9LyLJP6swWN+2KGnG947s5NYI1HaXaBX3SHy9D6yj2yZHqB
	 EAK3HK7wzPAv4P0cnV/9f98la4/OBFlQ+rxwiqH/3ZGHUWmnKTAIUx+21qaG/KAOhk
	 eKHMI3r6aC7FDgfOkUFCn75WJkP3dAyMz7Nku5R3KBOCLbFck3Y88JzikxPlHKx+sx
	 VipDl6ugr4clRku69fJvHtonB0EkPWNVISht1rWtiDxZomtE3qUz1E2SrsA1oH5IZJ
	 8crSUeKvBFPjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5283CE0F8C; Mon, 22 Jul 2024 14:38:53 -0700 (PDT)
Date: Mon, 22 Jul 2024 14:38:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-mm@kvack.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, hannes@cmpxchg.org,
	willy@infradead.org, rcu@vger.kernel.org
Subject: Possible slab-allocator issue
Message-ID: <e6db32f7-d1fa-4d38-acf9-f78234f87170@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I have been chasing a hang [1] in rcuscale, which is a kernel module
that does performance testing for RCU updaters.  I have a good long-term
workaround for this problem, namely an extremely stupid custom allocator,
so I don't need a fix, but I am nevertheless posting this just in case
this affects others.  Or in case I am doing something stupid that I
should avoid doing in the future.

I first encountered this on RCU's "dev" branch, but the problem also
exists in current mainline [2].  One high-probability reproducer for
this hang, tested on both AMD and Intel x86, is as follows:

tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --configs TREE --bootargs "rcuscale.scale_type=tasks rcuscale.minruntime=5 rcuscale.nreaders=0 rcuscale.nwriters rcuscale.gp_async=1 rcuscale.gp_async_max=100000" --trust-make

This script builds a kernel, requires that virtualization be enabled,
and uses the qemu-system-x86_64 command.  I have not run this on a system
with fewer than 16 CPUs.

When it fails, this takes a bit less than ten minutes to fail, which
results in a non-zero exit code from kvm.sh.  Rare successes normally
consume kernel-build time plus less than a minute of run time.

The failure mode is CPU 0 (and always CPU 0) failing to get out of this
(admittedly ugly, since reworked) "retry" loop in the rcu_scale_writer()
function in kernel/rcu/rcuscale.c:

 1 retry:
 2   if (!rhp)
 3     rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 4   if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
 5     atomic_inc(this_cpu_ptr(&n_async_inflight));
 6     cur_ops->async(rhp, rcu_scale_async_cb);
 7     rhp = NULL;
 8   } else if (!kthread_should_stop()) {
 9     cur_ops->gp_barrier();
10     goto retry;
11   } else {
12     kfree(rhp); /* Because we are stopping. */
13   }

The loop begins with the "retry" label on line 1, finds "rhp"
equal to NULL on line 2, gets a NULL from kmalloc(..., GFP_KERNEL)
on line 3, proceeds to the "else if" clause on lines 8-11,
invokes rcu_barrier_tasks() on line 9 (because that is what the
rcuscale.scale_type=tasks kernel boot parameter tells it to do), then
line 10 jumps back to the retry label.  This repeats thousands of times,
consuming some minutes.  There is no drama in the console log, as in no
mention of OOM killer, allocation failures, or much of anything other
than Tasks RCU switching to per-CPU callback queueing due to the heavy
load and the expected rcuscale output.

Note that all 16 CPUs are looping allocating and invoking either
call_rcu_tasks() when allocation succeeds or rcu_barrier_tasks() when
allocation fails.  So CPU 0 could simply be quite unlucky or have other
work so that when the rcu_barrier_tasks() waits for memory to be released,
the other CPUs allocate it all before CPU 0's rcu_scale_writer() task
is awakened.  But again, there is no sign of memory-system drama on
the console log.

I am good, as I implemented a stupid per-CPU-array-based allocator,
which avoids this issue, admittedly quite crudely.

Johannes suggested turning on tracing for the kmem:kmalloc and
kmem:mm_page_alloc trace events, which I did using this command:

tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --configs TREE --kconfig "CONFIG_DEBUG_KERNEL=y CONFIG_RCU_TRACE=y CONFIG_FTRACE=y" --bootargs "rcuscale.scale_type=tasks rcuscale.minruntime=5 rcuscale.nreaders=0 rcuscale.nwriters rcuscale.gp_async=1 rcuscale.gp_async_max=100000 trace_event=kmem:kmalloc,kmem:mm_page_alloc trace_buf_size=3k" --trust-make

I collected the .config file [3] and console output [4].  The console
output features more than 1500 kmalloc trace events and not quite 10
mm_page_alloc trace events.

Please let me know if more information would be helpful.

							Thanx, Paul

[1] https://docs.google.com/document/d/1M_SJ_hVUe-jtkH6BjHzzRFOnAiu1sqThlFnx8Jfp-fg/edit?usp=sharing
[2] bbb3556c014d ("Merge tag 'keys-next-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd"), for example.
[3] https://drive.google.com/file/d/1lZmIvatLyVYzdRK_rv2xNNWDBiGwyQvk/view?usp=sharing
[4] https://drive.google.com/file/d/1jh4hJG877j0Rp65153wtmzKm6jErXZ9n/view?usp=sharing
