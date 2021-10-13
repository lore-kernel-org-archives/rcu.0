Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9480EC433EF
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74130610C9
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 16:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhJMQKI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJMQKH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Oct 2021 12:10:07 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD2C061570;
        Wed, 13 Oct 2021 09:08:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r17so2990883qtx.10;
        Wed, 13 Oct 2021 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7uzLzVlEK1k1SwYwJ6m4srmWECZfKjn06SLBYpjteds=;
        b=b59jwidyrY9rr6Ob4D7PWKd6ZH0ckheCf1/JEn5sCqVvU8A8QRHrhuH8NHkMG2p1bm
         PH9Lu1uCWwEEVAar/eKlDf1dzBOQZj0Dr53eFwqLvW76o4Vderw+oQwg96cnNSnYb+lE
         6IuthtAWfXmBFmqrymZG9k0Ou9sAOlmd9D6Z2ii8peNwBaNVLeR96P3NgtC8AKEpuOPB
         VIexxdGKNKjfFVbh89+vEj/PHtO6nMpQSX5jAQ73jQtsNLC4tQVQ171dRHiUSgDdKc1+
         c0zsKDaZQ4b21xxJyDRzSf0ZY7GNq51cqaOhnjOvID7Yozx7fcreS8FU1anh2kCFgaDi
         vRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7uzLzVlEK1k1SwYwJ6m4srmWECZfKjn06SLBYpjteds=;
        b=dfBaDGofNUhiq/3HyATI/FS1m8+XGpTfl/p/qalKh/pQ7yana6518czxj8YEVVEO6a
         z6Jv8mLahJ3kUxrITb4bjYhCs5Z0Peh1EnKca33NAUHbaSBatRVGjLyYpUIJd+ym/HOf
         j6JOOwhT3Ro43r2/mMg17ks25gKBYSl3Qdv9fW9OZ3+TEXm3UJdwR6/Gx2YVkrHIPGe7
         VyTe0ClHB2HN3lBHXfVQm8yEt4pxP21YBgBCPuH6Lq8VRPmLKLxfnInDJNPfXXWyOZC/
         iGvyJoggVE35mIMnQJX2BQiPecOu24hTPdGmTuW4TaBkiRDhnpBvL2EOJvAd1F7gQV6g
         UJDA==
X-Gm-Message-State: AOAM531Qiox7/4Qfd8HvNpThpbcpRQDhtBWjDbCCII8RJtJ5kmcogBdO
        6KLwolG0tTfbN3k+whCTjXw=
X-Google-Smtp-Source: ABdhPJxLx13zULepzcOXgx1EQDG4iFIrdDY+R87wZ2UmDQB7HnyV38uijwDp9YNcVpJNpPk7WSC9SA==
X-Received: by 2002:a05:622a:448:: with SMTP id o8mr142349qtx.63.1634141283261;
        Wed, 13 Oct 2021 09:08:03 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d14sm7773499qkg.49.2021.10.13.09.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:08:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id F23FD27C005A;
        Wed, 13 Oct 2021 12:08:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Oct 2021 12:08:01 -0400
X-ME-Sender: <xms:YARnYWchE75d1on4ybnbzXTJCTltQmd8IIraXhTGoFsR1f1EUYR_QQ>
    <xme:YARnYQPfEYMk9xjgeWfRg4XakS7uebbY3dDzD_qvuuJ9gUHP6iWyUXGVqJJg_BIfj
    p_bGwysn1txntdgRg>
X-ME-Received: <xmr:YARnYXj-HAVHlq7Oy8tA4pOOPdXdlfP5LG4-7PpZAlaTlzUHeXomxTwqJXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddutddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:YARnYT-VeyWFVUQWB2HeWZ3eJDR1nR_BSGZWZMKrX7F11cxySsJ79A>
    <xmx:YARnYSvqDHIVgXvoYeN0fgx180iLeFMC1j6UbxAE77IyPQ4Oy4Ngyg>
    <xmx:YARnYaHybNTNzFYwjZPPadHioGEbL4PDFGoTFbwAjJM1flrfkMhu_Q>
    <xmx:YQRnYaHvGFmHZpV-vT_7Toh2Zo2OGwqTAHlUB2G1hRvCZod51DvAZwYNRPo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Oct 2021 12:08:00 -0400 (EDT)
Date:   Thu, 14 Oct 2021 00:07:58 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 03/11] rcu/nocb: Invoke rcu_core() at the start of
 deoffloading
Message-ID: <YWcEXj2+nqO8kIFS@boqun-archlinux>
References: <20211011145140.359412-1-frederic@kernel.org>
 <20211011145140.359412-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011145140.359412-4-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Frederic,

On Mon, Oct 11, 2021 at 04:51:32PM +0200, Frederic Weisbecker wrote:
> On PREEMPT_RT, if rcu_core() is preempted by the de-offloading process,
> some work, such as callbacks acceleration and invocation, may be left
> unattended due to the volatile checks on the offloaded state.
> 
> In the worst case this work is postponed until the next rcu_pending()
> check that can take a jiffy to reach, which can be a problem in case
> of callbacks flooding.
> 
> Solve that with invoking rcu_core() early in the de-offloading process.
> This way any work dismissed by an ongoing rcu_core() call fooled by
> a preempting deoffloading process will be caught up by a nearby future
> recall to rcu_core(), this time fully aware of the de-offloading state.
> 
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/rcu_segcblist.h | 14 ++++++++++++++
>  kernel/rcu/rcu_segcblist.c    |  6 ++----
>  kernel/rcu/tree.c             | 17 +++++++++++++++++
>  kernel/rcu/tree_nocb.h        |  9 +++++++++
>  4 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> index 812961b1d064..659d13a7ddaa 100644
> --- a/include/linux/rcu_segcblist.h
> +++ b/include/linux/rcu_segcblist.h
> @@ -136,6 +136,20 @@ struct rcu_cblist {
>   *  |--------------------------------------------------------------------------|
>   *  |                           SEGCBLIST_RCU_CORE   |                         |
>   *  |                           SEGCBLIST_LOCKING    |                         |
> + *  |                           SEGCBLIST_OFFLOADED  |                         |
> + *  |                           SEGCBLIST_KTHREAD_CB |                         |
> + *  |                           SEGCBLIST_KTHREAD_GP                           |
> + *  |                                                                          |
> + *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
> + *  |   handles callbacks concurrently. Bypass enqueue is enabled.             |
> + *  |   Invoke RCU core so we make sure not to preempt it in the middle with   |
> + *  |   leaving some urgent work unattended within a jiffy.                    |
> + *  ----------------------------------------------------------------------------
> + *                                      |
> + *                                      v
> + *  |--------------------------------------------------------------------------|
> + *  |                           SEGCBLIST_RCU_CORE   |                         |
> + *  |                           SEGCBLIST_LOCKING    |                         |
>   *  |                           SEGCBLIST_KTHREAD_CB |                         |
>   *  |                           SEGCBLIST_KTHREAD_GP                           |
>   *  |                                                                          |
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index c07aab6e39ef..81145c3ece25 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -265,12 +265,10 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
>   */
>  void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
>  {
> -	if (offload) {
> +	if (offload)
>  		rcu_segcblist_set_flags(rsclp, SEGCBLIST_LOCKING | SEGCBLIST_OFFLOADED);
> -	} else {
> -		rcu_segcblist_set_flags(rsclp, SEGCBLIST_RCU_CORE);
> +	else
>  		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_OFFLOADED);
> -	}
>  }
>  
>  /*
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e38028d48648..b236271b9022 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2717,6 +2717,23 @@ static __latent_entropy void rcu_core(void)
>  	unsigned long flags;
>  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;
> +	/*
> +	 * On RT rcu_core() can be preempted when IRQs aren't disabled.
> +	 * Therefore this function can race with concurrent NOCB (de-)offloading
> +	 * on this CPU and the below condition must be considered volatile.
> +	 * However if we race with:
> +	 *
> +	 * _ Offloading:   In the worst case we accelerate or process callbacks
> +	 *                 concurrently with NOCB kthreads. We are guaranteed to
> +	 *                 call rcu_nocb_lock() if that happens.

If offloading races with rcu_core(), can the following happen?

	<offload work>				
	rcu_nocb_rdp_offload():
	    					rcu_core():
						  ...
						  rcu_nocb_lock_irqsave(); // no a lock
	  raw_spin_lock_irqsave(->nocb_lock);
	    rdp_offload_toggle():
	      <LOCKING | OFFLOADED set>
	      					  if (!rcu_segcblist_restempty(...))
						    rcu_accelerate_cbs_unlocked(...);
						  rcu_nocb_unlock_irqrestore();
						  // ^ a real unlock,
						  // and will preempt_enable()
	    // offload continue with ->nocb_lock not held

If this can happen, it means an unpaired preempt_enable() and an
incorrect unlock. Thoughts? Maybe I'm missing something here?

Regards,
Boqun

> +	 *
> +	 * _ Deoffloading: In the worst case we miss callbacks acceleration or
> +	 *                 processing. This is fine because the early stage
> +	 *                 of deoffloading invokes rcu_core() after setting
> +	 *                 SEGCBLIST_RCU_CORE. So we guarantee that we'll process
> +	 *                 what could have been dismissed without the need to wait
> +	 *                 for the next rcu_pending() check in the next jiffy.
> +	 */
>  	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
>  
>  	if (cpu_is_offline(smp_processor_id()))
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 71a28f50b40f..3b470113ae38 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -990,6 +990,15 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  	 * will refuse to put anything into the bypass.
>  	 */
>  	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> +	/*
> +	 * Start with invoking rcu_core() early. This way if the current thread
> +	 * happens to preempt an ongoing call to rcu_core() in the middle,
> +	 * leaving some work dismissed because rcu_core() still thinks the rdp is
> +	 * completely offloaded, we are guaranteed a nearby future instance of
> +	 * rcu_core() to catch up.
> +	 */
> +	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
> +	invoke_rcu_core();
>  	ret = rdp_offload_toggle(rdp, false, flags);
>  	swait_event_exclusive(rdp->nocb_state_wq,
>  			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
> -- 
> 2.25.1
> 
