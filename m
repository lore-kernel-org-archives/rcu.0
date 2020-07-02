Return-Path: <SRS0=c9Wv=AN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82013C433DF
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 19:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52EC82088E
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 19:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSIlkXh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgGBTpM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBTpL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jul 2020 15:45:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288CC08C5C1;
        Thu,  2 Jul 2020 12:45:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so26584695lji.9;
        Thu, 02 Jul 2020 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aJWEg+4dTR2cdqHopODN867tmAlEblBzH751/xqR3xQ=;
        b=FSIlkXh+8AW9zqepLV4jGUaMriIMs+7Nh4U7vB42alqGnqhBJJB2jVCZtrrw6dVL7/
         V1Pla3rT8uiTRLvtg3Xa5TMWWTOpnrVAE0eYukUohUJHVtDiXGbZ1AooOhqzbWX/Po1u
         WWwCkEg9bI0vGrGRSxfowRzAnAw9gMBHONjCcuhZbnLFNuQcp7H6wsQWFDeKP9eTTj8V
         ktyuiXgeczC1Nidnjdaackgre5tHrBhPjfmY8fwclIiGM//39cQmXuxB8LLr4XEcl2CX
         gpM6oOmziW0QCLg+Bcl8OIWabBMZZkzomNbO2eGHwzuaDHC5ORwzbfVaPgOyDXRSvvUP
         ZZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJWEg+4dTR2cdqHopODN867tmAlEblBzH751/xqR3xQ=;
        b=QEn7ePbrq3t1qgiJxQQ5kwpE9gnFye1pa+f5ggP3aS1y+52YVuDpXcCdnolwFcLMcQ
         /NnJ04sA+qe1NY3CvSrEW/0E6zsuRwpRqHDI0dRJAi764VwLUrUDP5/JQrfxOV1d8VnK
         nY9LvVPfO4LrpWvNjDEBcFR8nEjABB1ZKH0OnyfauUZRU6uUI8WnnKOfGlFwekCCy1MT
         25C3FJHN3uHGteq4Eqb/ZyOg6jMeALD9ABGomtaGBcTJtXQEgXMTjAq6oL4JtOOdbc9d
         Pmcd8bmiQxV+ewGZCOT9ubh5l2jwR7ieoHrEeBIkLOTAYyd/Ie4KeIpSGHaAU6bs8veo
         kWSw==
X-Gm-Message-State: AOAM531xNZtaGhZ+lOc6/7yJ+piSV+ZnvzxbBWshsZ68dJEWqWXhAc2X
        LdHFFyT+qPVepz/1bYpp+uY=
X-Google-Smtp-Source: ABdhPJybTVroeM644KWkZdaN1dBa+0I4v469LW1KaxWkG3TT2t+FSUTVDMFOzFlufNzneqpli2akIw==
X-Received: by 2002:a2e:8882:: with SMTP id k2mr8004718lji.352.1593719109896;
        Thu, 02 Jul 2020 12:45:09 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id n10sm3704165lfb.82.2020.07.02.12.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 12:45:08 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 2 Jul 2020 21:45:06 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200702194506.GA31478@pc636>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > This is not going to work together with the "wait context validator"
> > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > printk() which is why it is still disabled by default.
> > 
> > Fixing that should be "interesting".  In particular, RCU CPU stall
> > warnings rely on the raw spin lock to reduce false positives due
> > to race conditions.  Some thought will be required here.
> 
> I don't get this part. Can you explain/give me an example where to look
> at?
> 
> > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > 
> > Given that the slab allocator doesn't acquire any locks until it gets
> > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > while a raw spinlock is held?  This would require yet another GFP_ flag,
> > but that won't make all that much of a difference in the total.  ;-)
> 
> That would be one way of dealing with. But we could go back to
> spinlock_t and keep the memory allocation even for RT as is. I don't see
> a downside of this. And we would worry about kfree_rcu() from real
> IRQ-off region once we get to it.
> 
Another way of fixing it is just dropping the lock letting the page
allocator to do an allocation without our "upper/local" lock. I did a
proposal like that once upon a time, so maybe it is a time to highlight
it again:

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 21c2fa5bd8c3..249f10a89bb9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3278,9 +3278,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
 }

 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
+       void *ptr, unsigned long *flags)
 {
        struct kvfree_rcu_bulk_data *bnode;
+       struct kfree_rcu_cpu *tmp;
        int idx;

        if (unlikely(!krcp->initialized))
@@ -3306,6 +3308,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
                        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                                return false;

+                       migrate_disable();
+                       krc_this_cpu_unlock(krcp, *flags);
+
                        /*
                         * NOTE: For one argument of kvfree_rcu() we can
                         * drop the lock and get the page in sleepable
@@ -3315,6 +3320,12 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
                         */
                        bnode = (struct kvfree_rcu_bulk_data *)
                                __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
+                       tmp = krc_this_cpu_lock(flags);
+                       migrate_enable();
+
+                       /* Sanity check, just in case. */
+                       WARN_ON(tmp != krcp);
                }
 
                /* Switch to emergency path. */
@@ -3386,7 +3397,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
         * Under high memory pressure GFP_NOWAIT can fail,
         * in that case the emergency path is maintained.
         */
-       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr, &flags);
        if (!success) {
                if (head == NULL)
                        // Inline if kvfree_rcu(one_arg) call.
<snip>

--
Vlad Rezki
