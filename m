Return-Path: <SRS0=JZbX=CN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7936C433E2
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 04:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E156206CA
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 04:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRfF1Fgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIDEFm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Sep 2020 00:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgIDEFl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Sep 2020 00:05:41 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A26C061244;
        Thu,  3 Sep 2020 21:05:40 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j3so2426962qvi.7;
        Thu, 03 Sep 2020 21:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CCg96ChsXARi8LqwOKl/DczJmljgCpaoYipr+OeW0wA=;
        b=rRfF1FgmYfdVZBV5tSyjJWxsFPSuhj2lBE7+eXaXhAvQslNNmo0mesaONMASeE2j6R
         9cLifyuxmqxmnIPYbLaPOPK35kvkeLuoalTWJF/nTnlj6ZLlquqidDCQbTUptRmugC02
         6kukQ7dAifHJ1ipwgaLMHsHXtIMM8QOLgm8LLjFBbazm1sVhetG0lMlYc5dyFQszXqmp
         j0yEKWj6jkATuw1cRlEddEiZlkT3/F07J8kqIcgcIwABV3TvxINMAMGB1RS5ZcoArTij
         sSzy7d7YBD8tBrIUr56Q/+sUEjGgOfcEPSbrNaPiXhpr7t4uJcaebyRV+f41gU2oIyUa
         UNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CCg96ChsXARi8LqwOKl/DczJmljgCpaoYipr+OeW0wA=;
        b=hl+WwJY9IQlE1PmidzZejAGtQcFaS7C1IhqgL/qryUMA8XSlOV0dIAmz52KrQ5C/ZE
         a0iXX9ztqqfHWV3DGfcid3HKbqq7H68/zHlK6+oT8BJBQdBn2D9m3Qo7qu8vysRG1PQh
         5BHQpTb3M7pzPJGPN2gOCa6VnXVMPvQBzqUERSP90pz647s+EODsz2ZuXz64I1DSYpbw
         iAar6nW6BdLfZNFcKb0wiZctQisfm2hWc2kZzR5ANsYjb0J0ZKb1L1wXjfp1jTigqLBS
         pLYmld8BHVkhxiDS7ZzdAv++177fcyrsS42IzGEXS6uuBD4FQPIy5fdjJa85bwAN0NKe
         6ZPw==
X-Gm-Message-State: AOAM530RHqqnnbgSBMHyTe/Dgh8jKNowUx61KG4QWRg+NAbQXYIYYRT/
        gDsFJODiN58guSODS9neJUU=
X-Google-Smtp-Source: ABdhPJymOWrRLpReazQNKLhn/K/UuhwgeMYPrmybPIF4vthRLgt9+vm42YpYnjNag3+PlqfF+r9QXQ==
X-Received: by 2002:a0c:eac5:: with SMTP id y5mr5174350qvp.2.1599192339263;
        Thu, 03 Sep 2020 21:05:39 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g12sm3633714qkm.27.2020.09.03.21.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 21:05:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7DEDB27C0058;
        Fri,  4 Sep 2020 00:05:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 04 Sep 2020 00:05:37 -0400
X-ME-Sender: <xms:EL1RXy3OyomDGfMuGW1gJnocUrhhBbQIeMxJvXE7DC-g8z4jVvHd0g>
    <xme:EL1RX1FTCEDKtjcCG_EJXIpj5SQeJCYyjZTqLWUODpSRSdixp732lznE-4ptiXEFf
    Dx-OT3_-5Ve11bDbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucfkphephedvrdduheehrdduuddurdej
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:EL1RX66XcsL-23NKjnqiCmK1QnfpgylSaMZ7oGNZWvpgsHs2aAjZkQ>
    <xmx:EL1RXz1VXLwIWWStLxXo5Pq7d2IZ6sBcm_6HJmERurLEL3IkRGkW-g>
    <xmx:EL1RX1HdZN7XtsL9I6IHt-oImsK3MpSmmHsX8JDTWTOK0ZFfjoJ_6A>
    <xmx:Eb1RX7UypgdBPgiJlWNBXL9x036DWE39Cfe9-XVSPrs7lsbyxmBQkVQcEC8>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3F306328005E;
        Fri,  4 Sep 2020 00:05:36 -0400 (EDT)
Date:   Fri, 4 Sep 2020 12:05:34 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 05/13] rcu: Always set .need_qs from
 __rcu_read_lock() for strict GPs
Message-ID: <20200904040534.GD7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
 <20200831181120.1044-5-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831181120.1044-5-paulmck@kernel.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Mon, Aug 31, 2020 at 11:11:12AM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The ->rcu_read_unlock_special.b.need_qs field in the task_struct
> structure indicates that the RCU core needs a quiscent state from the
> corresponding task.  The __rcu_read_unlock() function checks this (via
> an eventual call to rcu_preempt_deferred_qs_irqrestore()), and if set
> reports a quiscent state immediately upon exit from the outermost RCU
> read-side critical section.
> 
> Currently, this flag is only set when the scheduling-clock interrupt
> decides that the current RCU grace period is too old, as in about
> one full second too old.  But if the kernel has been built with
> CONFIG_RCU_STRICT_GRACE_PERIOD=y, we clearly do not want to wait that
> long.  This commit therefore sets the .need_qs field immediately at the
> start of the RCU read-side critical section from within __rcu_read_lock()
> in order to unconditionally enlist help from __rcu_read_unlock().
> 

So why not make rcu_preempt_deferred_qs_irqrestore() always treat
need_qs is true if CONFIG_RCU_STRICT_GRACE_PERIOD = y? IOW:

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 982fc5be5269..2a9f31545453 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -449,6 +449,8 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
+		special.b.need_qs = true;
 	rdp = this_cpu_ptr(&rcu_data);
 	if (!special.s && !rdp->exp_deferred_qs) {
 		local_irq_restore(flags);

, and in this way, you can save one store for each rcu_read_lock() ;-)

Regards,
Boqun

> But note the additional check for rcu_state.gp_kthread, which prevents
> attempts to awaken RCU's grace-period kthread during early boot before
> there is a scheduler.  Leaving off this check results in early boot hangs.
> So early that there is no console output.  Thus, this additional check
> fails until such time as RCU's grace-period kthread has been created,
> avoiding these empty-console hangs.
> 
> Reported-by Jann Horn <jannh@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_plugin.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 44cf77d..668bbd2 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -376,6 +376,8 @@ void __rcu_read_lock(void)
>  	rcu_preempt_read_enter();
>  	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
>  		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
> +	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
> +		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
>  	barrier();  /* critical section after entry code. */
>  }
>  EXPORT_SYMBOL_GPL(__rcu_read_lock);
> -- 
> 2.9.5
> 
