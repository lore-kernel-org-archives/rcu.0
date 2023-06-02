Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59829C7EE29
	for <rcu@archiver.kernel.org>; Fri,  2 Jun 2023 22:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjFBWvJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Jun 2023 18:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjFBWvJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Jun 2023 18:51:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3AD1AD
        for <rcu@vger.kernel.org>; Fri,  2 Jun 2023 15:51:04 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f6c0d651adso26432211cf.2
        for <rcu@vger.kernel.org>; Fri, 02 Jun 2023 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685746264; x=1688338264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKh7G4ng+3UxG9GlKhZFKNP2hqzFVCli3no9g2iTE4Q=;
        b=h2rPZeajkV6A9NKcRy8lAuwN4jb7qbuRKd70KeMC3t07qkHw6F5W0zF/PdCrjT9tAH
         AhIcGnaeJ+jdBFtdrt8g6Cs22cMYOgR/wC5UNczlXDFrsDOl0BBcg6JCXYNOcXBfOsAP
         AKAyLmPMn3WKvrpjK8XkeMaLoZv4EbtFbq6rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685746264; x=1688338264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKh7G4ng+3UxG9GlKhZFKNP2hqzFVCli3no9g2iTE4Q=;
        b=URAKIpd8jaNstnnVlh2GB4PKZvcRIxXtvXv/K2tnhaHbnB0cT0MLxrlBM0ixPFGyva
         XZrXo/41sLi6Zm9tgnw92/zjJue4zQDSI41op1ySbFx4eOBT0wO2jkKjzDEss/tQHwQZ
         cTYJEjWN4uuHtdbjRp/LF2hu6FLGGOQQ/qEYaR9gAGynEdM8sCyEAzhG51NFywKg7c9t
         X/ayOqZX9jHiWZs98ahThKSnmzaqWsVbFQT/s4FA2p9H3IlatbKbJ5b5xHKyX63pMJqi
         57CX3fSB1P/rXZ8yi5BnOsKQxSZR8/AafHeMVZTHtgGiBj6mr+hnUK5ImXO8C+D0bSYs
         34IQ==
X-Gm-Message-State: AC+VfDzuUb5ik6FhUdNdivzuZU4Sykxb9ErcOgX50/Qier94nLcuV2K7
        FEsClQCOD1zhTFcoJujQZKeeuA==
X-Google-Smtp-Source: ACHHUZ6z+Qm7ezl/VndW9Nq6+fcUGMGGerFi0l9dMXOr6xPvw+iXH4gyeaGERV3yYI7CUWlMICIOEw==
X-Received: by 2002:a05:622a:355:b0:3f6:c5cd:dc5e with SMTP id r21-20020a05622a035500b003f6c5cddc5emr18316573qtw.23.1685746263995;
        Fri, 02 Jun 2023 15:51:03 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id e6-20020a05622a110600b003f7a54fa72fsm1390379qty.0.2023.06.02.15.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 15:51:03 -0700 (PDT)
Date:   Fri, 2 Jun 2023 22:51:02 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 1/9] rcu: Assume IRQS disabled from rcu_report_dead()
Message-ID: <20230602225102.GA2756690@google.com>
References: <20230531101736.12981-1-frederic@kernel.org>
 <20230531101736.12981-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531101736.12981-2-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 31, 2023 at 12:17:28PM +0200, Frederic Weisbecker wrote:
> rcu_report_dead() is the last RCU word from the CPU down through the
> hotplug path. It is called in the idle loop right before the CPU shuts
> down for good. Because it removes the CPU from the grace period state
> machine and reports an ultimate quiescent state if necessary, no further
> use of RCU is allowed. Therefore it is expected that IRQs are disabled
> upon calling this function and are not to be re-enabled again until the
> CPU shuts down.
> 
> Remove the IRQs disablement from that function and verify instead that
> it is actually called with IRQs disabled as it is expected at that
> special point in the idle path.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fae9b4e29c93..bc4e7c9b51cb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4476,11 +4476,16 @@ void rcu_cpu_starting(unsigned int cpu)
>   */
>  void rcu_report_dead(unsigned int cpu)
>  {
> -	unsigned long flags, seq_flags;
> +	unsigned long flags;
>  	unsigned long mask;
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
>  
> +	/*
> +	 * IRQS must be disabled from now on and until the CPU dies, or an interrupt
> +	 * may introduce a new READ-side while it is actually off the QS masks.
> +	 */
> +	lockdep_assert_irqs_disabled();
>  	// Do any dangling deferred wakeups.
>  	do_nocb_deferred_wakeup(rdp);
>  
> @@ -4488,7 +4493,6 @@ void rcu_report_dead(unsigned int cpu)
>  
>  	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
>  	mask = rdp->grpmask;
> -	local_irq_save(seq_flags);

True, IRQs should be disabled here. The idle loop disables irqs before
calling cpuhp_report_idle_dead() which calls rcu_report_dead().

I was curious about this path called from cpu_die_early() in ARM, in which
case it is an existing bug if it did not already disable interrupts. So your
lockdep check is a good thing in that regard.

For this patch:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>  	arch_spin_lock(&rcu_state.ofl_lock);
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
>  	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> @@ -4502,8 +4506,6 @@ void rcu_report_dead(unsigned int cpu)
>  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	arch_spin_unlock(&rcu_state.ofl_lock);
> -	local_irq_restore(seq_flags);
> -
>  	rdp->cpu_started = false;
>  }
>  
> -- 
> 2.40.1
> 
