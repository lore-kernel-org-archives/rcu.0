Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B252F9C
	for <rcu@vger.kernel.org>; Mon, 11 Dec 2023 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3LoFel/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CFDC433C7;
	Mon, 11 Dec 2023 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702325047;
	bh=CB/ZILfzWkqt0zgGJLAEBpldUB3+zyNpoonT0GRnSAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3LoFel/RjaKrbKg7l7rU7wbifetCkYO+bcMXGxYp2tCcOP6+Un2Uv2NG9kNNqjOC
	 2KLartpPxHgz9YX2hct8ORM0z64paFHwEN4JF+8Yhnynt0/PQtWQpEhqaHq3nqEu5A
	 R7oTFH3hZeBkVbDcgQ0g2tlqyqm3inbjP8MGE5FB0IQ4zMiQ3Btip/Bp9lqxwSnSKz
	 MbSsczCe5HJDHzugjfTTArg/5+szlNFSjFUo9k37Y3XXDxVwxiivYW3+ZUhpQRw8JO
	 jJmsil+9/v8W+qjEKNE+LDLQzxvVlQF/VWhWMW4SbBWX8ctYw90jNFyY1oh3rqt7DV
	 /jUd5MPrw00Iw==
Date: Mon, 11 Dec 2023 21:04:04 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/8] rcu: Fix expedited GP deadlock (and cleanup some
 nocb stuff)
Message-ID: <ZXdrNJFCaXAFMITp@localhost.localdomain>
References: <20231208220545.7452-1-frederic@kernel.org>
 <0be847d6-804e-4f9d-9eb4-beee9efb6c78@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0be847d6-804e-4f9d-9eb4-beee9efb6c78@paulmck-laptop>

Le Mon, Dec 11, 2023 at 08:38:59AM -0800, Paul E. McKenney a écrit :
> On Fri, Dec 08, 2023 at 11:05:37PM +0100, Frederic Weisbecker wrote:
> > TREE04 can trigger a writer stall if run with memory pressure. This
> > is due to a circular dependency between waiting for expedited grace
> > period and polling on expedited grace period when workqueues go back
> > to mayday serialization.
> > 
> > Here is a proposal fix.
> 
> The torture.sh "acceptance test" with KCSAN and --duration 30 ran
> fine except for this in TREE09:
> 
> kernel/rcu/tree_nocb.h:1785:13: error: unused function '__call_rcu_nocb_wake' [-Werror,-Wunused-function]
> 
> My guess is that the declaration of __call_rcu_nocb_wake() in
> kernel/rcu/tree.h needs an "#ifdef CONFIG_SMP", but you might have a
> better fix.

Could be because if CONFIG_RCU_NO_CB_CPU=n, the function is only called
(though as dead code) from rcutree_migrate_callbacks() which in turn only
exists if CONFIG_HOTPLUG_CPU=y.

Something like that then:

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 35f7af331e6c..e1ff53d5084c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -445,6 +445,8 @@ static void rcu_qs(void);
 static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp);
 #ifdef CONFIG_HOTPLUG_CPU
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
+static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
+				 unsigned long flags);
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
 static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
@@ -466,8 +468,6 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
 			  rcu_callback_t func, unsigned long flags, bool lazy);
-static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
-				 unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
 static bool do_nocb_deferred_wakeup(struct rcu_data *rdp);
 static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
