Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31D38DE1;
	Wed,  2 Apr 2025 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603755; cv=none; b=JNb4+jS+4R8fH8rqFmlT8ZJDh8q8x+D9PbMyDUfeDNR0hTlkqsMR1REelhONQdEp/6m4ia4J7+CJ32Ptve2RFonDSw3j8JP7FFYW/bbfQGNOEyZ/ESbTxopwhydgjl2s5QJdUuWBNO/aROjxdoc0eqPuZGD8BcxXEJAwfB8vyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603755; c=relaxed/simple;
	bh=4oCApGufLXs9Lq7dC02rBNFOMXdkHZiagHocWOovUIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT6J+6Ay9RTGHc9DPt5o1PuxkTfBeqEHhuXd36ULFKyXH1DtlNcqIhtkQLVCueMGqTRRQRPAcOYNIejkNAs9wM21vfbvJ7EIz99gwgR/+QpFRwXwyFOfgy5R7NJxL6kgQW9NlFYwWctaTxZGH0mmjUI0TdKZLVT9+rfwOqD0HHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxxrfecD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxxrfecD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECBEC4CEDD;
	Wed,  2 Apr 2025 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743603754;
	bh=4oCApGufLXs9Lq7dC02rBNFOMXdkHZiagHocWOovUIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxxrfecDKdqGw5+qoqE2gRU3XKdegogLFvYpHkCriR5O0s8Cv9VoBLlejRCM4sr2I
	 UW65azKL1o3AhTE3xS8Q/JCx7HI5Gbc0aikg+9ZAAWtKA/16FyPWrLf+p4I20YI0Hn
	 Wuqsmpz1LVPVgcbvCvl5m5VkKGXJduXwZIUtIaybOZEcKmyGLs123J6oQOFnBcpB6t
	 /Joo4cjWOM8yqAv5cGvTtX6RncQv3F8L2GFHEmAqEIvIBIJEIR13D926iG30iHiSjj
	 dwBUm5ESn/sfCIeEKid5DMLIDiPDOIVqut+nHq28yvFcfmRhyd6wxad7GfAW//Xjw7
	 9xxCOE9zeg3Pg==
Date: Wed, 2 Apr 2025 16:22:31 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: Re: [1/3] rcu: Replace magic number with meaningful constant in
 rcu_seq_done_exact() - Patchwork
Message-ID: <Z-1IJ34Xb6RzucCQ@localhost.localdomain>
References: <8c8932fd34334718e94f979f9bab2fb7.joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c8932fd34334718e94f979f9bab2fb7.joelagnelf@nvidia.com>

Le Tue, Apr 01, 2025 at 12:30:40PM -0400, Joel Fernandes a écrit :
> Hello, Frederic,
> 
> On Tue, 1 Apr 2025 16:27:36 GMT, Frederic Weisbecker wrote:
> > Le Mon, Mar 31, 2025 at 02:29:52PM -0700, Paul E. McKenney a écrit :
> > > The disagreement is a feature, at least up to a point.  That feature
> > > allows CPUs to go idle for long periods without RCU having to bother
> > > them or to mess with their per-CPU data (give or take ->gpwrap).  It also
> > > allows per-rcu_node-leaf locking, which is important on large systems.
> > > 
> > > Trying to make precisely globally agreed-on beginnings and ends of
> > > RCU grace periods will not end well from performance, scalability,
> > > or real-time-response viewpoints.  ;-)
> > 
> > The distributed disagreement is definetly a feature. The duplicate root
> > is more debatable.
> > 
> > > But simplifications that don't hurt performance, scalability, and
> > > real-time-response are of course welcome.
> > 
> > I'm not even sure my proposal is a simplification. Perhaps it is. Another
> > hope is that it could avoid future accidents.
> > 
> 
> Aside from the performance concerns:
> 
> Sorry if this is silly but could you provide a small hint as to how
> unifying the global counter with the node affects QS reporting or hotplug?
> It was not immediately obvious to me. Thanks for the help.

First of all rcu_seq_start() must be before the hotplug scan, otherwise
you run into this:

rcu_state.gp_seq = 4


CPU0/ rcu_gp_kthread()                                CPU 1                                                 CPU 2
-------------                                      ----------                                            -----------
//rcu_gp_init()
rcu_for_each_leaf_node(rnp) {
    raw_spin_lock_rcu_node(rnp);
    rnp->qsmaskinit = rnp->qsmaskinitnext
    raw_spin_unlock_rcu_node(rnp);
}
                                                   rcutree_report_cpu_starting()
                                                       raw_spin_lock_rcu_node(rnp);
                                                       rnp->qsmaskinitnext |= rdp->grpmask
                                                       raw_spin_unlock_rcu_node(rnp);
                                                   
                                                   rcu_read_lock()
                                                   r0 = *X
                                                                                                         r1 = *X
                                                                                                         X = NULL
                                                                                                         cookie = get_state_sychronize_rcu()
                                                                                                         //cookie = 8
rcu_seq_start(&rcu_state.gp_seq)
//rcu_state.gp_seq == 5

rcu_for_each_node_breadth_first(rnp)  {
    raw_spin_lock_rcu_node(rnp);
    // Ignore CPU 1
    rnp->qsmask = rnp->qsmaskinit;
    raw_spin_unlock_rcu_node(rnp);
}
[...]

//rcu_gp_cleanup()
rcu_seq_end(&rcu_state.gp_seq)
// rcu_state.gp_seq == 8
                                                                                                         poll_state_sychronize_rcu(cookie)
                                                                                                         kfree(r1)
                                                   r2 = *r0 // CRASH

                                                   
                                                                                                        

So the same applies if we convert rcu_state to use the root node.
But if we do rcu_seq_start() on the root node, then an update side
can call note_gp_changes() because of the state change (only if the
root node is also the unique leaf). But this then happens before
the loop that initializes all the ->qsmask

It's not a correctness problem because it won't make the rdp to
report a QS too early, since rnp->qsmask isn't intialized anyway,
but note_gp_changes() would needlessly lock the rnp lock to record
the state change in rdp->gp_seq.

This is why we need an intermediate state called RCU_SEQ_STARTED
during which note_gp_changes() can safely ignore the state change.

Then once the root's qsmask is initialized, the state can switch
to RCU_SEQ_WAIT_QS, after which calling note_gp_changes() becomes
useful.

Hope that helped.

Thanks.
