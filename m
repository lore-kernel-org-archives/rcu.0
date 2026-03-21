Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524120D4E9;
	Sat, 21 Mar 2026 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063763; cv=none; b=WTm5dTM01tOrqA9i/SkP+4REU3/McYSQ4d84pQ7zdMulR1CuEdaYFpmEv8/+5165WLUCApOMN935nhDZ2wUSGsM+hCf7jsHFlnfNBSzymC7i6NaRAoPHOuF1u03ZrNmAXmIO3GAMdqWpk5Ty8pkLyTNavEK9d7KxUUMdFNqAAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063763; c=relaxed/simple;
	bh=mh6p76DcuMKvsZVq+jRH8JjO2UHkvmtIWgcrxKLwLzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgM06gz2B6Tma4IFYYZ5wFiSKa7tRAyonLpAM32uJze9RZ6zu4coQH0BAM7+MBbnNkmaezs5KNrDqJx76IivpowOWh+4WKr01ipNimx9/PASzcL7M1ofZq2ccnFjDr9phTyIk35UgTItI5XtwSLSxlSvVsBm3RJqbOUZJzzUtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAnZ7DQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAnZ7DQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C116AC4CEF7;
	Sat, 21 Mar 2026 03:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774063762;
	bh=mh6p76DcuMKvsZVq+jRH8JjO2UHkvmtIWgcrxKLwLzk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cAnZ7DQIOmuadhoZlwtekTPxX/lgNr2V9s1dyb2lOFWasMPTw1MmUpMqZKSVAercX
	 cqP9wLO97qCHmw48DsVr24ceI3CL1ay6/2ionKEMKCD+i/wy8ppi9zLBefAXVxruCY
	 APOXHE2Jyde6RecU/+QZ/4eJfb0XedToXcLdXJOILRQvXBlO12rJByvrg0HyORa0UE
	 tvaWGoMu4NefF7K57AFsp10j8UhWnGBtSWUIhUtNqsGXf48TyFCWBYz+Cy0RJGU07d
	 I9mjrqmcCnoQM+Ap8OXseNuxnj7RUnmilNp5FuAe+cfBreXtV4FF7gBloCyZIe7Puc
	 9z2LP8xXeGq5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1FD53CE0AB1; Fri, 20 Mar 2026 20:29:20 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:29:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <ad67e723-7f7d-4350-b886-c04e56c0b78d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
 <89763fcd-3710-49a0-91ca-cd923b47fc1e@nvidia.com>
 <abxfBZ89wIJILuom@tardis.local>
 <c391f8b9-a168-4235-aa7b-6902b4f07002@paulmck-laptop>
 <ab1u-AuqIbJakUYW@tardis.local>
 <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
 <ab18cUI_4jKA8wcA@tardis.local>
 <64a29c44-395a-4199-b580-5bfca715a816@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a29c44-395a-4199-b580-5bfca715a816@paulmck-laptop>

On Fri, Mar 20, 2026 at 04:11:26PM -0700, Paul E. McKenney wrote:
> On Fri, Mar 20, 2026 at 09:57:21AM -0700, Boqun Feng wrote:
> > On Fri, Mar 20, 2026 at 09:24:15AM -0700, Paul E. McKenney wrote:

[ . . . ]

> > I will definitely review it if you beat me to it ;-)
> 
> I am sure that further adjustments will be required.  ;-)

And speaking of further adjustments, heavier rcutorture testing found
the bug allegedly fixed by the following.

I will be testing the stack over the weekend.

							Thanx, Paul

------------------------------------------------------------------------

commit a717ba6b919d1be6d13e3ce13ca70e2afd3c24d0
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Mar 20 20:06:22 2026 -0700

    srcu: Push srcu_node allocation to GP when non-preemptible
    
    When the srcutree.convert_to_big and srcutree.big_cpu_lim kernel boot
    parameters specify initialization-time allocation of the srcu_node
    tree for statically allocated srcu_struct structures (for example, in
    DEFINE_SRCU() at build time instead of init_srcu_struct() at runtime),
    init_srcu_struct_nodes() will attempt to dynamically allocate this tree
    at the first run-time update-side use of this srcu_struct structure,
    but while holding a raw spinlock.  Because the memory allocator can
    acquire non-raw spinlocks, this can result in lockdep splats.
    
    This commit therefore uses the same SRCU_SIZE_ALLOC trick that is used
    when the first run-time update-side use of this srcu_struct structure
    happens before srcu_init() is called.  The actual allocation then takes
    place from workqueue context at the ends of upcoming SRCU grace periods.
    
    Fixes: ce2e65b01ad1 ("srcu: Use raw spinlocks so call_srcu() can be used under preempt_disable()")
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2328827f8775c..678bd9a73875b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -227,9 +227,12 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
-		if (!init_srcu_struct_nodes(ssp, is_static ? GFP_ATOMIC : GFP_KERNEL))
+		if (!preemptible())
+			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_ALLOC);
+		else if (init_srcu_struct_nodes(ssp, GFP_KERNEL))
+			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
+		else
 			goto err_free_sda;
-		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 	}
 	ssp->srcu_sup->srcu_ssp = ssp;
 	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed,
