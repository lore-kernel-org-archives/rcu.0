Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13622F11;
	Sat,  1 Mar 2025 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740791330; cv=none; b=to/BPiza4f3l3BoBj+9zjLSemM/j++wAB+NDNdNTkGi0KXCxO6cw+uyxqIXpqWdPl8iEGSYE2j+eyXjA2oMLbrv9jad8HO5ahBO+JcdGN0qwHwujPty99pskwWG/TNsFCIpGg8JDaqHaMcbCktlAEMOezGLSNWKglxq/FICKe5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740791330; c=relaxed/simple;
	bh=4M2ydCax4n1CzEN8VEpLsGvuYamMKtjBsavgnJmIvtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAqEBTOAFEjxbnnL9zT/l0UR5DiUwJqo4Nhc00qeBYlJmsGt8O9Tos3fFeK0HpNuWppZ/LZZNu+3YjsAiTBKEDqA1Y0DaS/uWLogYmzpUFM417S+rdVUkOipXDrpWB/vNYuEDX2Qit6svVFAOL7IbCLTEjqK2qLTQACQqvo0SOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTAFspss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTAFspss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A8AC4CEE2;
	Sat,  1 Mar 2025 01:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740791329;
	bh=4M2ydCax4n1CzEN8VEpLsGvuYamMKtjBsavgnJmIvtM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OTAFspsstyzHAuqbWGEev9Bpoy6WVlGQxgRlmGHvm/DU5hkydBGCKkO8x48r7+WPA
	 kvUmc98fvlIoGgy5iqWmqF53d/lZT4fBaa3M1TF6pjuPI8C4tpqsUdpz5exGc81x6M
	 GI42VmOZDRdB+dRHVWsAbXVDbQXDLE0JYM1GOSepQpyD2iNDVwj/Gz4gI8lEzr/L7d
	 1YE+/CZnq0FIuElqOTMGZRTsh+phywqXJWG4o6QSWCZ/H64U6eicl70PXGSg5OFoAl
	 r+Z/A3Z8dTPzHevMpW2NasrAA1L7QhDYXNQ5NIersJS0VNaLMIs7i8xbZQPXSy2gt2
	 e8gVuvF4FenLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1AE10CE0DEB; Fri, 28 Feb 2025 17:08:49 -0800 (PST)
Date: Fri, 28 Feb 2025 17:08:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>

On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> > Hello, Paul!
> > 
> > > > > > > 
> > > > > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > > > > RCU tree:
> > > > > > > 
> > > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > > > > 
> > > > > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > > > > that this is the scenario that tests it.  It happened within five minutes
> > > > > > > on all 14 of the TREE05 runs.
> > > > > > > 
> > > > > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > > > > trigger this whereas you do. Something is wrong.
> > > > > 
> > > > > If you have a debug patch, I would be happy to give it a go.
> > > > > 
> > > > I can trigger it. But.
> > > > 
> > > > Some background. I tested those patches during many hours on the stable
> > > > kernel which is 6.13. On that kernel i was not able to trigger it. Running
> > > > the rcutorture on the our shared "dev" tree, which i did now, triggers this
> > > > right away.
> > > 
> > > Bisection?  (Hey, you knew that was coming!)
> > > 
> > Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection
> > 
> > After revert in the dev, rcutorture passes TREE05, 16 instances.
> 
> Huh.  We sure don't get to revert that one...
> 
> Do we have a problem with the ordering in rcu_gp_init() between the calls
> to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For example,
> do we need to capture the relevant portion of the list before the call
> to rcu_seq_start(), and do the grace-period-start work afterwards?

I tried moving the call to rcu_sr_normal_gp_init() before the call to
rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
Which does not necessarily mean that this is the correct fix, but I
figured that it might at least provide food for thought.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 48384fa2eaeb8..d3efeff7740e7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(void)
 
 	/* Advance to a new grace period and initialize state. */
 	record_gp_stall_check_time();
+	start_new_poll = rcu_sr_normal_gp_init();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	start_new_poll = rcu_sr_normal_gp_init();
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
