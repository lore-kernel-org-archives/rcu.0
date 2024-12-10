Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C222B5A7;
	Tue, 10 Dec 2024 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864180; cv=none; b=sVMl+rOfr2tUzlTe1TBwphOAsjmBHHu3bK3mWlqFer4TCs0oEvKIFBSOLppENJPbWrV389X3F4+QsKrE480prGGmSKudz4Y28G8q75V9Vy3i0Hgk+P3tM5KUgupdz1zB7RhkD5ePODcFA+0L4deVPdHwvZVFgC3LjRrnIkho9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864180; c=relaxed/simple;
	bh=THEjk0HYyYIVTchcG3W1XkEtpfvyVMiqCMTFkm6ZwDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW78LQgVepCSiec1oICOon4InBbXiMOsQ4OKAc28PNobpK9GTh4JBv1pMOZNjvzrFS1w7Tnh6e3As0eZRdb5HA4hcVMI12lO8DmlRAwV5RWF0EovRRQIdcYTUnxdIdphFstswEYbqrf8Kr4vRYUvZMRPaw64lGwxvbygDOS97eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mylcuq93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mylcuq93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB4EC4CED6;
	Tue, 10 Dec 2024 20:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733864177;
	bh=THEjk0HYyYIVTchcG3W1XkEtpfvyVMiqCMTFkm6ZwDI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mylcuq933TaYcPt52z5bR6Z+NzBvNnXdLS4nUVazZQRk3/VplnSIZi2W7fC6VDKAb
	 ehCMWAPrSS/hXxY7ow7/sXfRoSiEi/GVJIAnd+PDl1idlW3tzPGHcG5v/Q5UNbfU8Q
	 ywp4WzyFbWgvnTLgxEggx7O6a+pltM4ULb1WXheAIZ5Qe3sVvtUS/R15OFCvRNFlQl
	 zt4RYzboqIV5q7BROK7itP26mftseArNOScY7c2GGdq8KGlDrzIrsEF6N0yoGIupOX
	 CyVELHD5FOBCAhYTwHIgOAk8Z1+VMeQTZOCZIWcE4sZ0F8BHhSAR/ENjsV407lSNNw
	 2cpIZTlWx4vaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 78C35CE0BC5; Tue, 10 Dec 2024 12:56:17 -0800 (PST)
Date: Tue, 10 Dec 2024 12:56:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zilin Guan <zilinguan811@gmail.com>
Cc: boqun.feng@gmail.com, frederic@kernel.org, jiangshanlai@gmail.com,
	joel@joelfernandes.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	neeraj.upadhyay@kernel.org, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, rostedt@goodmis.org, urezki@gmail.com,
	xujianhao01@gmail.com
Subject: Re: [PATCH v2] rcu: Remove READ_ONCE() for rdp->gpwrap access in
 __note_gp_changes()
Message-ID: <0a2518eb-5547-4609-9254-fd98a317b5d8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241110144747.21379-1-zilinguan811@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110144747.21379-1-zilinguan811@gmail.com>

On Sun, Nov 10, 2024 at 02:47:47PM +0000, Zilin Guan wrote:
> There is one access to rdp->gpwrap in the __note_gp_changes() function
> that does not use READ_ONCE() for protection, while other accesses to
> rdp->gpwrap do use READ_ONCE(). When using the 8*TREE03 and
> CONFIG_NR_CPUS=8 configuration, KCSAN found no data races at that point.
> This is because other functions should hold rnp->lock when calling
> __note_gp_changes(), which ensures proper exclusion of writes to the
> rdp->gpwrap fields for all CPUs associated with that leaf rcu_node
> structure.
> 
> Therefore, using READ_ONCE() to protect rdp->gpwrap within the
> __note_gp_changes() function is unnecessary.
> 
> Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
> ---

I applied this unofficially to -rcu for further review and testing.
The delay was in part do to your "should hold" above, which suggested
that you had not actually verified this yourself.  So this waited until
I had a chance to take a look.

I did the usual editing of the commit log as shown below.  Please let
me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 58b186eb8049230c475262f8e9eab34299677b8a
Author: Zilin Guan <zilinguan811@gmail.com>
Date:   Sun Nov 10 14:47:47 2024 +0000

    rcu: Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes()
    
    There is one access to the per-CPU rdp->gpwrap field in the
    __note_gp_changes() function that does not use READ_ONCE(), but all other
    accesses do use READ_ONCE().  When using the 8*TREE03 and CONFIG_NR_CPUS=8
    configuration, KCSAN found no data races at that point.  This is because
    all calls to __note_gp_changes() hold rnp->lock, which excludes writes
    to the rdp->gpwrap fields for all CPUs associated with that same leaf
    rcu_node structure.
    
    This commit therefore removes READ_ONCE() from rdp->gpwrap accesses
    within the __note_gp_changes() function.
    
    Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6103778828085..6d91dbe64cf0e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1295,7 +1295,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
 		rdp->core_needs_qs = false;
@@ -1309,7 +1309,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
 	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		/*
 		 * If the current grace period is waiting for this CPU,
 		 * set up to detect a quiescent state, otherwise don't
@@ -1324,7 +1324,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
 	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
 		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
-	if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
+	if (IS_ENABLED(CONFIG_PROVE_RCU) && rdp->gpwrap)
 		WRITE_ONCE(rdp->last_sched_clock, jiffies);
 	WRITE_ONCE(rdp->gpwrap, false);
 	rcu_gpnum_ovf(rnp, rdp);
