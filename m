Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376F13AF7
	for <rcu@vger.kernel.org>; Mon, 11 Dec 2023 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkPPYIge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CDAC433C9;
	Mon, 11 Dec 2023 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702312740;
	bh=JGP5scqqz/G1q85Ox8Gnu7cOnTT2TgsJaikSLnT5GoE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qkPPYIgeeegC+BG9xu4cWmc+FxTsPG8qWSIlwVmQDnotTPPLlkZ6S/Tx/LWM/rJid
	 T2wN5wxab7kGy6FQbGByGJLcbffVuaLq/1sISpO8nIo5YOfjKDhfQF0OnOf5GYbYOS
	 O8Gq2tCoJit6UGJe8ZwhIU+cBHPWm+d9Pk45ec/GNMPuXwPyYu/dvAxwNnSVGps5AL
	 MVe8RMB/0/KwiKrHp0Qtgb7xqw9vfZjeTur8Ewf13Sam7rXroYiSkcb6fCMgE49q15
	 ZmEnfZ7nVJAS+6hC6Rsu0Pj1WkL0WevQiom/8qEPGarOhLRYDxvsg0CdGi1G5v9Bb+
	 1QuHPWtXgxmvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1A5ECE0569; Mon, 11 Dec 2023 08:38:59 -0800 (PST)
Date: Mon, 11 Dec 2023 08:38:59 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/8] rcu: Fix expedited GP deadlock (and cleanup some
 nocb stuff)
Message-ID: <0be847d6-804e-4f9d-9eb4-beee9efb6c78@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231208220545.7452-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208220545.7452-1-frederic@kernel.org>

On Fri, Dec 08, 2023 at 11:05:37PM +0100, Frederic Weisbecker wrote:
> TREE04 can trigger a writer stall if run with memory pressure. This
> is due to a circular dependency between waiting for expedited grace
> period and polling on expedited grace period when workqueues go back
> to mayday serialization.
> 
> Here is a proposal fix.

The torture.sh "acceptance test" with KCSAN and --duration 30 ran
fine except for this in TREE09:

kernel/rcu/tree_nocb.h:1785:13: error: unused function '__call_rcu_nocb_wake' [-Werror,-Wunused-function]

My guess is that the declaration of __call_rcu_nocb_wake() in
kernel/rcu/tree.h needs an "#ifdef CONFIG_SMP", but you might have a
better fix.

						Thanx, Paul

> Frederic Weisbecker (8):
>   rcu/nocb: Make IRQs disablement symetric
>   rcu/nocb: Re-arrange call_rcu() NOCB specific code
>   rcu/exp: Fix RCU expedited parallel grace period kworker allocation
>     failure recovery
>   rcu/exp: Handle RCU expedited grace period kworker allocation failure
>   rcu: s/boost_kthread_mutex/kthread_mutex
>   rcu/exp: Make parallel exp gp kworker per rcu node
>   rcu/exp: Handle parallel exp gp kworkers affinity
>   rcu/exp: Remove rcu_par_gp_wq
> 
>  kernel/rcu/rcu.h         |   5 -
>  kernel/rcu/tree.c        | 222 +++++++++++++++++++++++++--------------
>  kernel/rcu/tree.h        |  12 +--
>  kernel/rcu/tree_exp.h    |  81 +++-----------
>  kernel/rcu/tree_nocb.h   |  38 ++++---
>  kernel/rcu/tree_plugin.h |  52 ++-------
>  6 files changed, 191 insertions(+), 219 deletions(-)
> 
> -- 
> 2.42.1
> 
