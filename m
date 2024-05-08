Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BA2BAE0
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178819; cv=none; b=Qg55qr1gXDCjLil/SO+hyX3gyq6Q67Kmb/AZK/Ub///mo6fYUomY3+kBOite9HEGr3epj1JgYk7nGkLUia394dBVsMbcYGE0ZCFwhBDptwsNRv1Itc7i1Mokep4e/N4sClrQ02AHjRFFIxFlbF9/VRADDhueN3tRh5GOuaDf56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178819; c=relaxed/simple;
	bh=AWXwofxNQM01JgXw3spKQxCtZ6wVB1VaMxhu+DZiyRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqKJt8BlAxQBwvZi8Xm1bKM9wADOICXQgtBom+emLov4rDkntLBxKqXlWC/Rzne5UEMzKt6/VJiULzZRZvlytw4WX5IuEPta4HUeasr3B9MTCYPC6TFbbRbcTI4XOVHcArs0Tg/G3Y1u1RwCZrqP9ECERrVwe/qfYtmf6z5e57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS3YY1f2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS3YY1f2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA548C113CC;
	Wed,  8 May 2024 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715178818;
	bh=AWXwofxNQM01JgXw3spKQxCtZ6wVB1VaMxhu+DZiyRQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HS3YY1f2CGvGyfjGWOsfCFzD1wW4IFHX8keCVAcpUP2yJSGTuEoCAkzuExlwNXhNt
	 id0IiZVf5sT8aSMF8NYXL5DnLs6ReKbSVYgI/oHpM2Eh2l7LhB1kwXIZHHfZQCfwfu
	 8vmVm0P7xGPosvluZLcvSyhAKADolMjz3w3n4DjVUEM3hA095uN6qr5qpjY2s9QslN
	 jIs/sqHjL6hZygOZ6xjEUASBA1mHnKAcIBhUyUuMZ4yL5GdNDw+wgZn7MpIt6da06X
	 TxutHmTtHeGq67g80dp3qf5zUPSvMK3RigvPWIL4x049bHaXMec1Qy1L/9FIoSJ0sN
	 RqU5VC1jtfJfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 652A2CE0448; Wed,  8 May 2024 07:33:38 -0700 (PDT)
Date: Wed, 8 May 2024 07:33:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dwmw@amazon.co.uk, rcu@vger.kernel.org
Subject: Re: [bug report] rcu: Kill rnp->ofl_seq and use only
 rcu_state.ofl_lock for exclusion
Message-ID: <cef46486-ac26-495d-bd2d-1e998a73a421@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain>

On Wed, May 08, 2024 at 03:29:12PM +0300, Dan Carpenter wrote:
> Hello David Woodhouse,
> 
> Commit 82980b1622d9 ("rcu: Kill rnp->ofl_seq and use only
> rcu_state.ofl_lock for exclusion") from Feb 16, 2021 (linux-next),
> leads to the following Smatch static checker warning:
> 
> 	kernel/rcu/tree.c:1844 rcu_gp_init()
> 	warn: mixing irq and irqsave

There are actually cases where this does make sense, one example being
where some called function (for example, rcu_report_qs_rnp() below)
needs a flags argument.

But...

>         kernel/rcu/srcutree.c:910 srcu_gp_end()
>         warn: mixing irq and irqsave
> 
> kernel/rcu/tree.c
>     1782 static noinline_for_stack bool rcu_gp_init(void)
>     1783 {
>     1784         unsigned long flags;
>     1785         unsigned long oldmask;
>     1786         unsigned long mask;
>     1787         struct rcu_data *rdp;
>     1788         struct rcu_node *rnp = rcu_get_root();
>     1789         bool start_new_poll;
>     1790 
>     1791         WRITE_ONCE(rcu_state.gp_activity, jiffies);
>     1792         raw_spin_lock_irq_rcu_node(rnp);
>     1793         if (!rcu_state.gp_flags) {
>     1794                 /* Spurious wakeup, tell caller to go back to sleep.  */
>     1795                 raw_spin_unlock_irq_rcu_node(rnp);
>     1796                 return false;
>     1797         }
>     1798         WRITE_ONCE(rcu_state.gp_flags, 0); /* Clear all flags: New GP. */
>     1799 
>     1800         if (WARN_ON_ONCE(rcu_gp_in_progress())) {
>     1801                 /*
>     1802                  * Grace period already in progress, don't start another.
>     1803                  * Not supposed to be able to happen.
>     1804                  */
>     1805                 raw_spin_unlock_irq_rcu_node(rnp);
>     1806                 return false;
>     1807         }
>     1808 
>     1809         /* Advance to a new grace period and initialize state. */
>     1810         record_gp_stall_check_time();
>     1811         /* Record GP times before starting GP, hence rcu_seq_start(). */
>     1812         rcu_seq_start(&rcu_state.gp_seq);
>     1813         ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
>     1814         start_new_poll = rcu_sr_normal_gp_init();
>     1815         trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
>     1816         rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
>     1817         raw_spin_unlock_irq_rcu_node(rnp);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Enables IRQs
> 
>     1818 
>     1819         /*
>     1820          * The "start_new_poll" is set to true, only when this GP is not able
>     1821          * to handle anything and there are outstanding users. It happens when
>     1822          * the rcu_sr_normal_gp_init() function was not able to insert a dummy
>     1823          * separator to the llist, because there were no left any dummy-nodes.
>     1824          *
>     1825          * Number of dummy-nodes is fixed, it could be that we are run out of
>     1826          * them, if so we start a new pool request to repeat a try. It is rare
>     1827          * and it means that a system is doing a slow processing of callbacks.
>     1828          */
>     1829         if (start_new_poll)
>     1830                 (void) start_poll_synchronize_rcu();
>     1831 
>     1832         /*
>     1833          * Apply per-leaf buffered online and offline operations to
>     1834          * the rcu_node tree. Note that this new grace period need not
>     1835          * wait for subsequent online CPUs, and that RCU hooks in the CPU
>     1836          * offlining path, when combined with checks in this function,
>     1837          * will handle CPUs that are currently going offline or that will
>     1838          * go offline later.  Please also refer to "Hotplug CPU" section
>     1839          * of RCU's Requirements documentation.
>     1840          */
>     1841         WRITE_ONCE(rcu_state.gp_state, RCU_GP_ONOFF);
>     1842         /* Exclude CPU hotplug operations. */
>     1843         rcu_for_each_leaf_node(rnp) {
> --> 1844                 local_irq_save(flags);
>                          ^^^^^^^^^^^^^^^^^^^^^
> It doesn't make sense to mix irq and irqsave.  Either it can be called
> with IRQs disabled or it can't...

... that is not the case here.  We could use local_irq_disable().

I can queue a patch.

However...

>     1845                 arch_spin_lock(&rcu_state.ofl_lock);
>     1846                 raw_spin_lock_rcu_node(rnp);
>     1847                 if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
>     1848                     !rnp->wait_blkd_tasks) {
>     1849                         /* Nothing to do on this leaf rcu_node structure. */
>     1850                         raw_spin_unlock_rcu_node(rnp);
>     1851                         arch_spin_unlock(&rcu_state.ofl_lock);
>     1852                         local_irq_restore(flags);
>     1853                         continue;
>     1854                 }
>     1855 
>     1856                 /* Record old state, apply changes to ->qsmaskinit field. */
>     1857                 oldmask = rnp->qsmaskinit;
>     1858                 rnp->qsmaskinit = rnp->qsmaskinitnext;
>     1859 
>     1860                 /* If zero-ness of ->qsmaskinit changed, propagate up tree. */
>     1861                 if (!oldmask != !rnp->qsmaskinit) {
>     1862                         if (!oldmask) { /* First online CPU for rcu_node. */
>     1863                                 if (!rnp->wait_blkd_tasks) /* Ever offline? */
>     1864                                         rcu_init_new_rnp(rnp);
>     1865                         } else if (rcu_preempt_has_tasks(rnp)) {
>     1866                                 rnp->wait_blkd_tasks = true; /* blocked tasks */
>     1867                         } else { /* Last offline CPU and can propagate. */
>     1868                                 rcu_cleanup_dead_rnp(rnp);
>     1869                         }
>     1870                 }
>     1871 
>     1872                 /*
>     1873                  * If all waited-on tasks from prior grace period are
>     1874                  * done, and if all this rcu_node structure's CPUs are
>     1875                  * still offline, propagate up the rcu_node tree and
>     1876                  * clear ->wait_blkd_tasks.  Otherwise, if one of this
>     1877                  * rcu_node structure's CPUs has since come back online,
>     1878                  * simply clear ->wait_blkd_tasks.
>     1879                  */
>     1880                 if (rnp->wait_blkd_tasks &&
>     1881                     (!rcu_preempt_has_tasks(rnp) || rnp->qsmaskinit)) {
>     1882                         rnp->wait_blkd_tasks = false;
>     1883                         if (!rnp->qsmaskinit)
>     1884                                 rcu_cleanup_dead_rnp(rnp);
>     1885                 }
>     1886 
>     1887                 raw_spin_unlock_rcu_node(rnp);
>     1888                 arch_spin_unlock(&rcu_state.ofl_lock);
>     1889                 local_irq_restore(flags);
>     1890         }
>     1891         rcu_gp_slow(gp_preinit_delay); /* Races with CPU hotplug. */
>     1892 
>     1893         /*
>     1894          * Set the quiescent-state-needed bits in all the rcu_node
>     1895          * structures for all currently online CPUs in breadth-first
>     1896          * order, starting from the root rcu_node structure, relying on the
>     1897          * layout of the tree within the rcu_state.node[] array.  Note that
>     1898          * other CPUs will access only the leaves of the hierarchy, thus
>     1899          * seeing that no grace period is in progress, at least until the
>     1900          * corresponding leaf node has been initialized.
>     1901          *
>     1902          * The grace period cannot complete until the initialization
>     1903          * process finishes, because this kthread handles both.
>     1904          */
>     1905         WRITE_ONCE(rcu_state.gp_state, RCU_GP_INIT);
>     1906         rcu_for_each_node_breadth_first(rnp) {
>     1907                 rcu_gp_slow(gp_init_delay);
>     1908                 raw_spin_lock_irqsave_rcu_node(rnp, flags);

... here we do need flags because ...

>     1909                 rdp = this_cpu_ptr(&rcu_data);
>     1910                 rcu_preempt_check_blocked_tasks(rnp);
>     1911                 rnp->qsmask = rnp->qsmaskinit;
>     1912                 WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
>     1913                 if (rnp == rdp->mynode)
>     1914                         (void)__note_gp_changes(rnp, rdp);
>     1915                 rcu_preempt_boost_start_gp(rnp);
>     1916                 trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
>     1917                                             rnp->level, rnp->grplo,
>     1918                                             rnp->grphi, rnp->qsmask);
>     1919                 /* Quiescent states for tasks on any now-offline CPUs. */
>     1920                 mask = rnp->qsmask & ~rnp->qsmaskinitnext;
>     1921                 rnp->rcu_gp_init_mask = mask;
>     1922                 if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
>     1923                         rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);

... rcu_report_qs_rnp() needs them.

>     1924                 else
>     1925                         raw_spin_unlock_irq_rcu_node(rnp);

And we do have the odd ignoring of those flags here.  Which is fine.

							Thanx, Paul

>     1926                 cond_resched_tasks_rcu_qs();
>     1927                 WRITE_ONCE(rcu_state.gp_activity, jiffies);
>     1928         }
>     1929 
>     1930         // If strict, make all CPUs aware of new grace period.
>     1931         if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>     1932                 on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
>     1933 
>     1934         return true;
>     1935 }
> 
> regards,
> dan carpenter
