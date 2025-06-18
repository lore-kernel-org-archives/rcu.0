Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0118027
	for <rcu@vger.kernel.org>; Wed, 18 Jun 2025 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226785; cv=none; b=Yq52HuUeJigJQpE2YuONgeAQRlPeNtZnaoD4LFxVpwuNvrPVEJr0BgZXXgGkX8yPnnHz5LqHnU3bNZm0Zg9QxmPyDDES//d+bO+CmvlgiItUfAs8E77TRDCL9kBjtFVYmfeGi95G9rIVOg8MBq630JgX4JkAfzByWs/B29GMF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226785; c=relaxed/simple;
	bh=DhKWQUtjBaR9MPSzsUBaNClt7wNmyxTOD0KG9+Ly+N8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcGFJTqaNyaPlplGlht46u3cMnEvhwXtLBcfKV9BFpgoq+N4yvS70X3VM6iJmskdlG+QhTyn4Oq2nEb8UUGpKqbQH67zloEbn0uxaTDLg2icwbPnNq6j1yZzRbjHVT46t7ebXTQA/+IFKZDqLI28t7ABUjNo7PrOK0ChoXeT5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+7BfxYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+7BfxYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACC5C4CEE7;
	Wed, 18 Jun 2025 06:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750226785;
	bh=DhKWQUtjBaR9MPSzsUBaNClt7wNmyxTOD0KG9+Ly+N8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=g+7BfxYbW7/sHnIQxnqWpMC+pX4MT+5eB0Q+mj1nKQ3/wlfEmXCfbNzws2KVUUV0g
	 ko1nE0lMGLnFkEi8ULYzJI14Kj+0E8xGB648YDE3tRbU1W5UTcWlb8S9bhC9F2grso
	 7bybvkuDea3OufU3zdFrfq9UKw/cs/abRbaORnygfirPJRq/s2GU96npG9uLIcWg6O
	 221EuUIfSZ8wI+PtHFx3DzDLjmYh4HgfE9Ks1pXHpIevbLXUZFRLTDdAR/4SsMPxUP
	 aMxjkRBrU0aK1vuKSQqXqjeRo/br+4VrOQAD5W8U4LrxPN+FrDc7ryi5QsbFWSKiWM
	 AqObPvuQ+3zYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4CEC8CE0875; Tue, 17 Jun 2025 23:06:22 -0700 (PDT)
Date: Tue, 17 Jun 2025 23:06:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: Re: TREE02 warning while initializing expedited grace period
Message-ID: <932236e9-78cd-4cbe-aeaa-ec177dae8e6f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b7a341ba-cd4d-468a-9d66-4aabe70a747d@paulmck-laptop>
 <603add86-47b2-42d2-a2f6-9ea1a2e1d64c@paulmck-laptop>
 <f4558fee-7733-47a7-8110-62a6753cf1ae@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4558fee-7733-47a7-8110-62a6753cf1ae@paulmck-laptop>

On Mon, Jun 09, 2025 at 09:14:42AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 05, 2025 at 08:45:19AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > You remember that WARN_ON_ONCE(nr_retries++ > 10) we are looking to add
> > to the __sync_rcu_exp_select_node_cpus() function's initialization of
> > expedited RCU grace periods?
> > 
> > e2cf1ccc99a3 ("rcu/exp: Warn on CPU lagging for too long within hotplug IPI's blindspot")
> > 
> > Well, it triggered during one of 14 TREE02 runs yesterday evening:
> 
> And again in TREE02 today.  The usual distractions have prevented me
> from doing a long run, but hopefully other things will settle down soon
> and I can get a better idea of the statistics of this thing.

Yesterday's 20-hour run got one hit in TREE02 and two each in SRCU-L
and SRCU-P.  Which might be due to a guest-OS migration event.
(The rcutorture runs are guest OSes within a guest OS.)

Except that they all happened at different times.  Besides, the system
subjected to the migration was orchestrating the test (via kvm-remote.sh),
not actually running any part of it.

Well, time to fire off another test, then!  ;-)

							Thanx, Paul

> > [ 7213.736155] WARNING: CPU: 4 PID: 35 at kernel/rcu/tree_exp.h:419 __sync_rcu_exp_select_node_cpus+0x23d/0x350
> > [ 7213.737487] Modules linked in:
> > [ 7213.737907] CPU: 4 UID: 0 PID: 35 Comm: rcu_exp_par_gp_ Not tainted 6.15.0-rc1-00065-g11ef58d03471 #5265 PREEMPT(full)
> > [ 7213.739348] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [ 7213.740845] RIP: 0010:__sync_rcu_exp_select_node_cpus+0x23d/0x350
> > [ 7213.741675] Code: 01 00 00 49 23 86 70 fc ff ff 0f 84 1f 01 00 00 4c 89 ff e8 55 b2 ee 00 bf 01 00 00 00 e8 bb aa ee 00 83 7c 24 04 0a 7e 04 90 <0f> 0b 90 83 44 24 04 01 e9 61 ff ff ff 83 e2 fc 89 95 60 01 00 00
> > [ 7213.744176] RSP: 0000:ffffa4a540163e68 EFLAGS: 00010202
> > [ 7213.751921] RAX: 0000000000000000 RBX: ffff89b45f56c900 RCX: ffffa4a540163d64
> > [ 7213.752896] RDX: 0000000000000000 RSI: ffff89b45f51ac18 RDI: ffff89b45f51ac00
> > [ 7213.753865] RBP: 0000000000000005 R08: 0000000000080062 R09: 0000000000000000
> > [ 7213.757852] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000003
> > [ 7213.758847] R13: 0000000000000004 R14: ffffffff89563e08 R15: ffffffff89563a00
> > [ 7213.759842] FS:  0000000000000000(0000) GS:ffff89b4d5568000(0000) knlGS:0000000000000000
> > [ 7213.761176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 7213.762173] CR2: 0000000000000000 CR3: 000000001de4c000 CR4: 00000000000006f0
> > [ 7213.763402] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 7213.764624] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [ 7213.765838] Call Trace:
> > [ 7213.766271]  <TASK>
> > [ 7213.766658]  ? __pfx_sync_rcu_exp_select_node_cpus+0x10/0x10
> > [ 7213.767616]  kthread_worker_fn+0xb2/0x300
> > [ 7213.768256]  ? __pfx_kthread_worker_fn+0x10/0x10
> > [ 7213.769049]  kthread+0x102/0x200
> > [ 7213.769596]  ? __pfx_kthread+0x10/0x10
> > [ 7213.770238]  ret_from_fork+0x2f/0x50
> > [ 7213.770862]  ? __pfx_kthread+0x10/0x10
> > [ 7213.771524]  ret_from_fork_asm+0x1a/0x30
> > [ 7213.772175]  </TASK>
> > 
> > TREE02 is unusual in having not one but two rcutorture.fwd_progress
> > kthreads.  Although TREE10 also has rcutorture.fwd_progress=2, I normally
> > run only one instance of TREE10 for each 14 instances of TREE02.  Also,
> > TREE02 is preemptible and TREE10 is not, so maybe that has an effect.
> > 
> > If this is the way that things are, we will need to use less aggressive
> > reporting (maybe pr_alert() or similar) and reserve the WARN_ON_ONCE()
> > for much higher thresholds, like maybe 100.
> > 
> > But is there a better way?
> > 
> > Or are there some ideas for making the initialization of expedited RCU
> > grace periods be in less need of repeatedly retrying IPIs?
> > 
> > 							Thanx, Paul
> 
