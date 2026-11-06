Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999477;
	b=sf3oQSQZtBMOQz3iP/kkbR/LVkPa4WTqLFItofsry4rtoMRPyvAUbbYgkOsCHMC+/v6l
	 MeeVwseRudW2c4uNT6ycLZAXAk9eaA3PzE4nfG8rOmpRAzVTKewzSJxeQrRHuiej5qLmy
	 w8wGu2YmKRhutPfQ/FCAEMlY5MV4AKzpSgI5WP+FIJawNEEJiTJzci6d1rqSAb+yGWfhM
	 i5hjnQ77QtGigGlv4CR6IITAOTEFxYBydsMAU1AvDQgsoG8GkWIBAXzeTLE/tAt1ixtox
	 5Rtgc2i1UoLoy3XEFUU5KrN+Inor11ZjGssFgSXc4C4BVfRdS/pxR/vevW5SJ+LQqJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999477;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qyq2PLhyOao6mpFoudZyaRzzk5GKGs33fo3H1xwZTCc=;
	b=yxqetiNG/DXUQzN6MUE0GyYuFu5NXIolUutguOQTHWBbEBP+dMixtocWuEKorIBTQPLI
	 9aB7geGs7axHa+mF1lB44bTq/VcQLJ4R9uLHwzubmEOpgBDDjVIYSqMKbc+EgMv4TRPlm
	 10pQg2zsI32KNWRtuKTKNeHvnen/QAVipFFBalsuccm3dp1L2Ne43YoOP9l4zB7bAuX//
	 z+lbXGJJpIDbr2fs5FZXLgqSPzHVJ4iaUmTPtz0BsvcHISR8mRcb/z1xB8yYmLnFYrIgh
	 e75Evk7vsdoq18EzRTa3e1A83+HQXneTlmoeNBj/iFBwqK/qOYgOKgjJ3/CyWU1sKWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mB0kYrP5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D430B606A32C;
	Fri,  6 Nov 2026 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mB0kYrP5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18B31F008A1;
	Fri,  6 Nov 2026 21:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999476;
	bh=qyq2PLhyOao6mpFoudZyaRzzk5GKGs33fo3H1xwZTCc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=mB0kYrP5E+kMoJW2mWs2JUrhZYEfNrOdE7QmZqdxLxBfLtwmvQzB2Oi6gKwS6ySzh
	 1uZ7uHeKKX9x1VgJdIYDM+gglleI0ShCoN8TjDsCRRlm3pQG23X532TDgRxcyedFzM
	 fKt4BqbNfFRXSRU7NHjCg7Rm9nkq8Pnwo3e3tRrubOWgF/KYO73uLd/xBdEgrXZbXv
	 2jV+f5yPjI6EsOAX0kw3IoaZXYDj2tFvveOpkm6h8Z6PAYD5MbXqdWN+ZCf4vcB+FS
	 Ms1TlwhnuUy3Y77es6z6Bxl6UBUE8De2KjirhvxnGwxspmDVQy96AcaZ6dlFOjIL/j
	 qLu0fnWqjUi+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4E8A6CE0840; Fri,  6 Nov 2026 13:11:16 -0800 (PST)
Date: Fri, 6 Nov 2026 13:11:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, dave@stgolabs.net,
	josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 0/5] rcu: Record callback enqueue stacks and add torture
 tests
Message-ID: <dda59546-c03a-4c4c-9df3-a107bc629e2c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261106143913.3627722-1-kunwu.chan@gmail.com>
 <7883f32c-80b8-4bfa-a4e4-f1e04da647f3@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7883f32c-80b8-4bfa-a4e4-f1e04da647f3@nvidia.com>

On Fri, Nov 06, 2026 at 01:49:04PM -0500, Joel Fernandes wrote:
> 
> 
> On 11/6/2026 9:39 AM, Kunwu Chan wrote:
> > This series adds KASAN auxiliary stack recording for RCU Tasks
> > callbacks, rcutorture coverage for duplicate-callback detection,
> > and KASAN aux-stack verification tests across RCU and SRCU flavors.
> > 
> > This series is based on [1]. For testing, I also applied Joel
> > Fernandes' fix for debugobjects tracking of barrier callbacks
> > [2], which is needed for the barrier tests.
> > 
> > The changes:
> > - Record the enqueueing stack in call_rcu_tasks_generic().
> > - Enable duplicate-callback testing for the "tasks" and
> >   "tasks-tracing" torture types.
> > - Add a KASAN aux-stack verification test module with a Kconfig
> >   choice for each supported flavor.
> > - Add one rcutorture scenario per flavor for the verification
> >   test.
> > 
> > Tested on x86_64:
> > 
> > - TASKS01, TASKS02, TASKS03, TRACE01, and TRACE02 completed
> >   3-minute runs successfully.
> > 
> > - With CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and
> >   rcutorture.object_debug=1, duplicate-callback detection was
> >   triggered as expected for both torture types.
> > 
> > - TRACE01 was run for 1 minute with
> >   CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and
> >   rcutorture.object_debug=1. The test detected both duplicate
> >   callback heads through the SRCU enqueue path:
> > [    0.405836] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
> > [    0.405852] ODEBUG: activate active (active state 1) object: 0000000020df980d object type: rcu_head hint: 0x0
> > [    0.734724] rcu: __call_srcu(): Duplicate call_srcu() CB 0000000020df980d->rcu_torture_leak_cb+0x0/0x10()
> > [    0.734780] ODEBUG: activate active (active state 1) object: 000000006634e8c9 object type: rcu_head hint: 0x0
> > [    0.776688] rcu: __call_srcu(): Duplicate call_srcu() CB 000000006634e8c9->rcu_torture_leak_cb+0x0/0x10()
> > [    0.779126] rcutorture: WARN: Duplicate call_tasks-tracing() test complete.
> > [   65.411342] tasks-tracing-torture:--- End of test: SUCCESS: ...
> > 
> > Both duplicate callback heads (the stack-allocated rh2 and
> > the kmalloc-allocated rhp) were rejected and neither was invoked.
> > 
> > - With CONFIG_DEBUG_OBJECTS_RCU_HEAD=y,
> >   object_debug=1, and n_barrier_cbs=4, the TASKS01 barrier
> >   test completed 630/630 rounds without barrier errors.
> >   The only debugobjects warnings were the four intentional
> >   warnings from the duplicate-callback test at startup.
> > 
> > - All five aux-stack scenarios (TASKSKASAN01, TREEKASAN01,
> >   SRCUKASAN01, TINYKASAN01, and SRCUTINYKASAN01) produced the
> >   expected KASAN use-after-free reports. Each report's
> >   "Last potentially related work creation" entry showed the
> >   expected enqueue helper:
> > 
> > ===== TASKSKASAN01 =====
> > [    1.244567] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0xb0
> > [    1.244707] Last potentially related work creation:
> > [    1.244716]  aux_test_call_rcu_tasks.constprop.0+0xc/0x20
> > 
> > ===== TREEKASAN01 =====
> > [    0.670399] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0xb0
> > [    0.670561] Last potentially related work creation:
> > [    0.670571]  aux_test_call_rcu_tree.constprop.0+0xc/0x20
> > 
> > ===== SRCUKASAN01 =====
> > [    0.658679] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0xc0
> > [    0.658919] Last potentially related work creation:
> > [    0.658932]  aux_test_call_srcu.constprop.0+0x16/0x30
> > 
> > ===== TINYKASAN01 =====
> > [    0.951503] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0xb0
> > [    0.951641] Last potentially related work creation:
> > [    0.951650]  aux_test_call_rcu_tiny.constprop.0+0xc/0x20
> > 
> > ===== SRCUTINYKASAN01 =====
> > [    1.009005] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0xc0
> > [    1.009141] Last potentially related work creation:
> > [    1.009150]  aux_test_call_srcu.constprop.0+0x16/0x30
> 
> I'm not feeling very excited about adding more configs just for KASAN. That
> sounds like a maintenance burden. I believe Paul already has KASAN testing in
> his scripts. Is it possible to activate this testing only when those are enabled?

The usual way that I do KASAN testing is with the --kasan argument
to kvm.sh.  I use --kconfig and --bootargs to specify further testing,
usually as another option in torture.sh.  This causes the testing to
be carried out as a matter of course.

One good thing is that the Kconfig choice in patch 4/5 is automated so
that RCU_KASAN_AUX_TEST causes the right testing to happen depending on
what is configured.

Is it possible to drive this from --kasan and the rcutorture.object_debug
kernel boot parameter or something similar?  Or is there a better way
to make the overall testing happen?

							Thanx, Paul
