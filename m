Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEF82C6B
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171360; cv=none; b=o9CoJ1gylPx1bTY2WdtPuXWIYrc8Dv5iBWKaCvtWTUjIGsnRYH4lXDdWVg9EZxE/tk1bQ1MgDWjkEZO3zHfcNFWOiIpRjyTEy7YgFwD7x5hzkSwvaO2Vh0gaXPDMnkMpdt2OZKuXSalEY+KZuVbQBwwLM2JhxstluGBHCLKaKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171360; c=relaxed/simple;
	bh=gO7H/QD3sCIUOOZ/wn6F6RmqRKoTzJ0NdLqYjmO+cwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BUEJE/VGUX3S/8t5FTqBE8y+gdMcHKWgzqzpnZJjlamudXVYUtpJ1UaZbzDWgfauV5tOkpPIT7lUqSkbjbdevZWb38bsuFP9YPKJMr7QKEWGf7nK0V0JFy8kgpM600KRKooXrmI8HADV1H/OskPh0BsY4rWAdpeSdPHXK9GPiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjrPmLD7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjrPmLD7"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a934ad50so1011310266b.1
        for <rcu@vger.kernel.org>; Wed, 08 May 2024 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715171357; x=1715776157; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zEBhlNXwGWUDbnMH/rJ8ZBpKust/0cIB9pGhEH98Cw=;
        b=jjrPmLD7MmNc0H6ja8rje7mtc7RjEZ4myOsa+gPib3+TboJkfPInz15OC+cDeA2hHt
         MfvNntTo+QWmpMo2ZG2AORTJcBjTnsAQzt29Q2KZ6gAQVX6TXfc4PxuVh64sTyrLP5Cb
         uiF0r98GA5z6vSFVnvAktzDj9rSI8AnLIZfLEYaPMCnXbn+rS+dbBv7uOWILxSegAeIH
         KNj/r9JDfVUsDleh8UxzCegZFoODwGCcKtu1WfMQhF44LuRHUfpVoD1icGDVHgw8/GYK
         60itUPl7M0D5N9o7tEaU31t2fB6oPR4jFTLvSiDAnS/KXOwlS3Gpn3nwtUHPHI3nrlXl
         pqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715171357; x=1715776157;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zEBhlNXwGWUDbnMH/rJ8ZBpKust/0cIB9pGhEH98Cw=;
        b=c/FM556eGL3rTl2KpNy+tsPGvgi5fk6iEIe1Vr5C0PfguoQ4w/nKT8ql01wB7qQHtt
         8DZdKryIp3thRckRqkCC6erWYznX+Fh91Dw7HvBmENUyOAwMIInw7GGTx9I4y6K3aMri
         EhKF9SIifQ+8G9N/9B+mwRJnhO5EkKKfbwnH9EDeglWU4ZdS7pRl0AnvzGh0D7zdzSMr
         hUWXFlSuIBk3rOg1UUs6CpsWaPSdo+xoUU7AbFIq5tGCpM7VgmaU77IDGYasrCuMt+xb
         tMnnhtm6/6pmpb/Z8luBasx427n7Zuu/JqwlPB027ldYap9iqkvkFh4sdxxqKNfnZRIl
         GfuA==
X-Gm-Message-State: AOJu0YxLqbK9oBUTiOOZ1NahGTfJKYwOdQMmbVdJWbYkHrETzdEUmcQd
	lvgNtyPe7/O6OwZ6SiPwo6Y+kazEXJLog9yXMaWwsO/kcyjFV50XUxNg+j2F+IRWljVYmof7wJW
	h
X-Google-Smtp-Source: AGHT+IFLdWRfsMFpM5faK/7lvG7adj866tG7uSjGZxPDsrt/OacxecelGQS+k7X0Dn6FFCg66HI0mw==
X-Received: by 2002:a17:906:c78c:b0:a59:ced4:25af with SMTP id a640c23a62f3a-a59fb95d55cmr143680466b.41.1715171356884;
        Wed, 08 May 2024 05:29:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090652d800b00a59aa17f23fsm5275651ejn.203.2024.05.08.05.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 05:29:16 -0700 (PDT)
Date: Wed, 8 May 2024 15:29:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: dwmw@amazon.co.uk, paulmck@kernel.org
Cc: rcu@vger.kernel.org
Subject: [bug report] rcu: Kill rnp->ofl_seq and use only rcu_state.ofl_lock
 for exclusion
Message-ID: <febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David Woodhouse,

Commit 82980b1622d9 ("rcu: Kill rnp->ofl_seq and use only
rcu_state.ofl_lock for exclusion") from Feb 16, 2021 (linux-next),
leads to the following Smatch static checker warning:

	kernel/rcu/tree.c:1844 rcu_gp_init()
	warn: mixing irq and irqsave

        kernel/rcu/srcutree.c:910 srcu_gp_end()
        warn: mixing irq and irqsave

kernel/rcu/tree.c
    1782 static noinline_for_stack bool rcu_gp_init(void)
    1783 {
    1784         unsigned long flags;
    1785         unsigned long oldmask;
    1786         unsigned long mask;
    1787         struct rcu_data *rdp;
    1788         struct rcu_node *rnp = rcu_get_root();
    1789         bool start_new_poll;
    1790 
    1791         WRITE_ONCE(rcu_state.gp_activity, jiffies);
    1792         raw_spin_lock_irq_rcu_node(rnp);
    1793         if (!rcu_state.gp_flags) {
    1794                 /* Spurious wakeup, tell caller to go back to sleep.  */
    1795                 raw_spin_unlock_irq_rcu_node(rnp);
    1796                 return false;
    1797         }
    1798         WRITE_ONCE(rcu_state.gp_flags, 0); /* Clear all flags: New GP. */
    1799 
    1800         if (WARN_ON_ONCE(rcu_gp_in_progress())) {
    1801                 /*
    1802                  * Grace period already in progress, don't start another.
    1803                  * Not supposed to be able to happen.
    1804                  */
    1805                 raw_spin_unlock_irq_rcu_node(rnp);
    1806                 return false;
    1807         }
    1808 
    1809         /* Advance to a new grace period and initialize state. */
    1810         record_gp_stall_check_time();
    1811         /* Record GP times before starting GP, hence rcu_seq_start(). */
    1812         rcu_seq_start(&rcu_state.gp_seq);
    1813         ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
    1814         start_new_poll = rcu_sr_normal_gp_init();
    1815         trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
    1816         rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
    1817         raw_spin_unlock_irq_rcu_node(rnp);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Enables IRQs

    1818 
    1819         /*
    1820          * The "start_new_poll" is set to true, only when this GP is not able
    1821          * to handle anything and there are outstanding users. It happens when
    1822          * the rcu_sr_normal_gp_init() function was not able to insert a dummy
    1823          * separator to the llist, because there were no left any dummy-nodes.
    1824          *
    1825          * Number of dummy-nodes is fixed, it could be that we are run out of
    1826          * them, if so we start a new pool request to repeat a try. It is rare
    1827          * and it means that a system is doing a slow processing of callbacks.
    1828          */
    1829         if (start_new_poll)
    1830                 (void) start_poll_synchronize_rcu();
    1831 
    1832         /*
    1833          * Apply per-leaf buffered online and offline operations to
    1834          * the rcu_node tree. Note that this new grace period need not
    1835          * wait for subsequent online CPUs, and that RCU hooks in the CPU
    1836          * offlining path, when combined with checks in this function,
    1837          * will handle CPUs that are currently going offline or that will
    1838          * go offline later.  Please also refer to "Hotplug CPU" section
    1839          * of RCU's Requirements documentation.
    1840          */
    1841         WRITE_ONCE(rcu_state.gp_state, RCU_GP_ONOFF);
    1842         /* Exclude CPU hotplug operations. */
    1843         rcu_for_each_leaf_node(rnp) {
--> 1844                 local_irq_save(flags);
                         ^^^^^^^^^^^^^^^^^^^^^
It doesn't make sense to mix irq and irqsave.  Either it can be called
with IRQs disabled or it can't...

    1845                 arch_spin_lock(&rcu_state.ofl_lock);
    1846                 raw_spin_lock_rcu_node(rnp);
    1847                 if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
    1848                     !rnp->wait_blkd_tasks) {
    1849                         /* Nothing to do on this leaf rcu_node structure. */
    1850                         raw_spin_unlock_rcu_node(rnp);
    1851                         arch_spin_unlock(&rcu_state.ofl_lock);
    1852                         local_irq_restore(flags);
    1853                         continue;
    1854                 }
    1855 
    1856                 /* Record old state, apply changes to ->qsmaskinit field. */
    1857                 oldmask = rnp->qsmaskinit;
    1858                 rnp->qsmaskinit = rnp->qsmaskinitnext;
    1859 
    1860                 /* If zero-ness of ->qsmaskinit changed, propagate up tree. */
    1861                 if (!oldmask != !rnp->qsmaskinit) {
    1862                         if (!oldmask) { /* First online CPU for rcu_node. */
    1863                                 if (!rnp->wait_blkd_tasks) /* Ever offline? */
    1864                                         rcu_init_new_rnp(rnp);
    1865                         } else if (rcu_preempt_has_tasks(rnp)) {
    1866                                 rnp->wait_blkd_tasks = true; /* blocked tasks */
    1867                         } else { /* Last offline CPU and can propagate. */
    1868                                 rcu_cleanup_dead_rnp(rnp);
    1869                         }
    1870                 }
    1871 
    1872                 /*
    1873                  * If all waited-on tasks from prior grace period are
    1874                  * done, and if all this rcu_node structure's CPUs are
    1875                  * still offline, propagate up the rcu_node tree and
    1876                  * clear ->wait_blkd_tasks.  Otherwise, if one of this
    1877                  * rcu_node structure's CPUs has since come back online,
    1878                  * simply clear ->wait_blkd_tasks.
    1879                  */
    1880                 if (rnp->wait_blkd_tasks &&
    1881                     (!rcu_preempt_has_tasks(rnp) || rnp->qsmaskinit)) {
    1882                         rnp->wait_blkd_tasks = false;
    1883                         if (!rnp->qsmaskinit)
    1884                                 rcu_cleanup_dead_rnp(rnp);
    1885                 }
    1886 
    1887                 raw_spin_unlock_rcu_node(rnp);
    1888                 arch_spin_unlock(&rcu_state.ofl_lock);
    1889                 local_irq_restore(flags);
    1890         }
    1891         rcu_gp_slow(gp_preinit_delay); /* Races with CPU hotplug. */
    1892 
    1893         /*
    1894          * Set the quiescent-state-needed bits in all the rcu_node
    1895          * structures for all currently online CPUs in breadth-first
    1896          * order, starting from the root rcu_node structure, relying on the
    1897          * layout of the tree within the rcu_state.node[] array.  Note that
    1898          * other CPUs will access only the leaves of the hierarchy, thus
    1899          * seeing that no grace period is in progress, at least until the
    1900          * corresponding leaf node has been initialized.
    1901          *
    1902          * The grace period cannot complete until the initialization
    1903          * process finishes, because this kthread handles both.
    1904          */
    1905         WRITE_ONCE(rcu_state.gp_state, RCU_GP_INIT);
    1906         rcu_for_each_node_breadth_first(rnp) {
    1907                 rcu_gp_slow(gp_init_delay);
    1908                 raw_spin_lock_irqsave_rcu_node(rnp, flags);
    1909                 rdp = this_cpu_ptr(&rcu_data);
    1910                 rcu_preempt_check_blocked_tasks(rnp);
    1911                 rnp->qsmask = rnp->qsmaskinit;
    1912                 WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
    1913                 if (rnp == rdp->mynode)
    1914                         (void)__note_gp_changes(rnp, rdp);
    1915                 rcu_preempt_boost_start_gp(rnp);
    1916                 trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
    1917                                             rnp->level, rnp->grplo,
    1918                                             rnp->grphi, rnp->qsmask);
    1919                 /* Quiescent states for tasks on any now-offline CPUs. */
    1920                 mask = rnp->qsmask & ~rnp->qsmaskinitnext;
    1921                 rnp->rcu_gp_init_mask = mask;
    1922                 if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
    1923                         rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
    1924                 else
    1925                         raw_spin_unlock_irq_rcu_node(rnp);
    1926                 cond_resched_tasks_rcu_qs();
    1927                 WRITE_ONCE(rcu_state.gp_activity, jiffies);
    1928         }
    1929 
    1930         // If strict, make all CPUs aware of new grace period.
    1931         if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
    1932                 on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
    1933 
    1934         return true;
    1935 }

regards,
dan carpenter
