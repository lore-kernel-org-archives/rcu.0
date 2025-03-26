Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71E5028C;
	Wed, 26 Mar 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743031296; cv=none; b=ukR0+XKef8zU1Sn9uc2hg124BDF0OtprFVv8dGeuV71O6m6QMNhILaicLjnGR5F298f0S0vMJVACkrEoT6DHArD+4f5dROmRgCpON69IOD5s/QS7CTI5y1UJk2/5erv5W7LYPD+tt2D5UEqmqRngJ2cDgCul2ybBu6fpNKvqcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743031296; c=relaxed/simple;
	bh=lgNxuxN9BEKZ/qMmg9zwTlKkDmzDFfXUpPWJ/K2w6Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZjQLdZP/cdk2J0Uk4h4waemUvydJShFzCka5uFXrYOPXGKJqfPMWyXSqFqFqUt7+YGulOFhKL9a3sMwfqk19jPiMug7xD+nbC2Wr8XdzVg9wjWAOhV1J3IyqrQ3FlBVyvYhRosR2hQzu+PQCkk7jPIKSFnadCdeQCqozCj1t6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le71A9jA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le71A9jA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4D7C4CEE2;
	Wed, 26 Mar 2025 23:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743031295;
	bh=lgNxuxN9BEKZ/qMmg9zwTlKkDmzDFfXUpPWJ/K2w6Ag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Le71A9jAr23Pbr2eaaDZNY/F2p4X9dmWnGCRbIrRHsC7FDW5apRa3BrJokxsiOFbo
	 0fuWGs8sue07IGDvNmAsImD5KkhxfMn8f000Py6+FElunlvVMM3PXtR4UdnYFaBRUP
	 rz7uMoJOC6ViLYCi06BhFFyPjNnV9puwNM3IDUQr4rJ68zqMmmjSobR3bN0y7x57yH
	 tF7ZdS3AlsLabp5aXwpjkMKd2XSOjhuy5kinT2KQDslEXYyd1RDs/RzrhajqTYEQkD
	 nII8EPEeydBf7bZugXONzgHy4aeBHYWXSEI4FGQcYMQ3tM78PHylC7VtbLlRC7pTbn
	 oU4faA36OtbmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 343B2CE0C2A; Wed, 26 Mar 2025 16:21:35 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:21:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/3] rcu: Add warning to ensure rcu_seq_done_exact() is
 working
Message-ID: <6fbebe6b-89a0-4347-9363-36ccf6b13b62@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-3-joelagnelf@nvidia.com>
 <4a40eba2-ebd3-42a8-a25f-b7a0ff94256b@paulmck-laptop>
 <E9D67C85-37FD-4BA7-990D-2BA2ED7E5963@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E9D67C85-37FD-4BA7-990D-2BA2ED7E5963@nvidia.com>

On Wed, Mar 26, 2025 at 10:50:13PM +0000, Joel Fernandes wrote:
> 
> 
> > On Mar 26, 2025, at 6:36 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Mon, Mar 24, 2025 at 01:01:54PM -0400, Joel Fernandes wrote:
> >> The previous patch improved the rcu_seq_done_exact() function by adding
> >> a meaningful constant for the guardband.
> >> 
> >> Ensure that this is working for the future by a quick check during
> >> rcu_gp_init().
> >> 
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > This is a good test for the guardband being way too short.
> 
> Thanks. Let me know if I could add your review tag!
> 
> > Are there other tests the should be run, possibly on a separate gp_seq
> > used only for testing?  Should the test below be under CONFIG_PROVE_RCU?
> 
> Yes, I could move it to PROVE RCU and it should be sufficient for testing.
> 
> The other test I was working on is to force the counter wrapping and hence gpwrap which is related. 

Very good on both counts.

> Maybe we could also some testing around false negatives not happening too often (for examples with the rcu_seq_done()).
> 
> I will add more tests if I come across usecases.

Keep the counter from just after the start (or just before the end)
of the previous grace period and verify that it also has not ended just
after the start of the current grace period?

							Thanx, Paul

> Thanks!
> 
> Joel
> 
> > 
> >                            Thanx, Paul
> > 
> >> ---
> >> kernel/rcu/tree.c | 5 +++++
> >> 1 file changed, 5 insertions(+)
> >> 
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index 659f83e71048..29ddbcbea25e 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -1798,6 +1798,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> >>    struct rcu_data *rdp;
> >>    struct rcu_node *rnp = rcu_get_root();
> >>    bool start_new_poll;
> >> +    unsigned long old_gp_seq;
> >> 
> >>    WRITE_ONCE(rcu_state.gp_activity, jiffies);
> >>    raw_spin_lock_irq_rcu_node(rnp);
> >> @@ -1825,7 +1826,11 @@ static noinline_for_stack bool rcu_gp_init(void)
> >>     */
> >>    start_new_poll = rcu_sr_normal_gp_init();
> >>    /* Record GP times before starting GP, hence rcu_seq_start(). */
> >> +    old_gp_seq = rcu_state.gp_seq;
> >>    rcu_seq_start(&rcu_state.gp_seq);
> >> +    /* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
> >> +    WARN_ON_ONCE(rcu_seq_done_exact(&old_gp_seq, rcu_seq_snap(&rcu_state.gp_seq)));
> >> +
> >>    ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> >>    trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> >>    rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> >> --
> >> 2.43.0
> >> 
