Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFBBC433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Feb 2021 14:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366C464F3F
	for <rcu@archiver.kernel.org>; Thu,  4 Feb 2021 14:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhBDOLj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Feb 2021 09:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbhBDOKl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Feb 2021 09:10:41 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4B5C0613D6;
        Thu,  4 Feb 2021 06:10:00 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id h7so4710422lfc.6;
        Thu, 04 Feb 2021 06:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ROsNBFOVgXpvoSLbKZaV0d4yUjvdIm2b4y/a7AC2dcs=;
        b=FdaocmDOvg2yZ/gNysSosoZ/g7rTBsHP7lG44qUxOVaBcjU/c/3zvwYMfaMf32iFYK
         PPJcqoKCpBzuKctqG3a398gC6Ddo5rgyxyOf/LS5kAW6eHz26Afj7Ke4YiWq70RosAbw
         mKStmfolf+81PFFAewyX0Cy557byUklhKmUZANGGBKL3+Iv0lHRLMiCFO8rJQv93qj83
         kGVENFI+YRyfhkiMM3eygrBPaWDiD+VefIVZTzYVC+jefI990vfoTt3KXb+HAsbhN/TY
         SrSBrXoqqdKg1Az8LlIPke3Vj1CB6HpAdFYspTDlF1z4Jqha6z9eZfswyacMFwha0oKA
         EOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ROsNBFOVgXpvoSLbKZaV0d4yUjvdIm2b4y/a7AC2dcs=;
        b=iiQu+zl2TAYNnhWpn0HUBc3ob4iDChxwF48yJ27GgGKCwYH3QvNFIM68a1ZkDQg/8t
         bS60dzg/r4ahyzm5PTApC7faN/IdnktGbw84qlqZxydWoBKZsaiMUMXt/53esvxKq5gw
         hYKRHkJq9CY95otYUFFKFD+4V7+6W0c1Y5aa8rLbHcKFYdcm31oCX7RLkDkiEmww5ywb
         No3ECdPJpx7YuiGR4yi8vzv95L4Yz3Slvwr/RoHbnODnUS4T6wKdgOU9y89/vNmbQzt7
         PYWgNlGnRy50GJVN5Gq6EQMXTAwk5eiN/t2QvL+DmGic6Vox1j0F9qZ3e7x6dOznHCjj
         jPeg==
X-Gm-Message-State: AOAM533ir/NCdIs+W4t3IjIvciouiLMR0jmR98ECD1ArcBRIP8QWUqud
        LJG3vPUwAUa3WJTOkHxBb0M=
X-Google-Smtp-Source: ABdhPJwSfcPJb73ZMM4cJklCmbm3gRHEwGOseYeWXFT0p3j20WtHXZxlKjMlrnZ4sEZFJINF2wyU3Q==
X-Received: by 2002:a19:3fcc:: with SMTP id m195mr4685315lfa.459.1612447799268;
        Thu, 04 Feb 2021 06:09:59 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u4sm670966ljl.40.2021.02.04.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:09:58 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 4 Feb 2021 15:09:56 +0100
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v3] kvfree_rcu:
 Release page cache under memory pressure
Message-ID: <20210204140956.GA1904@pc638.lan>
References: <20210130131851.23285-1-qiang.zhang@windriver.com>
 <20210201195753.GA2026@pc638.lan>
 <BYAPR11MB2632485C92F0CE711BE80EB4FFB59@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632D4B3C28AFBD67AC10263FFB39@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632ECCBD7196CF92C5FA49BFFB39@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2632ECCBD7196CF92C5FA49BFFB39@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> 发件人: Uladzislau Rezki <urezki@gmail.com>
> 发送时间: 2021年2月2日 3:57
> 收件人: Zhang, Qiang
> 抄送: urezki@gmail.com; paulmck@kernel.org; joel@joelfernandes.org; rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> 主题: Re: [PATCH v3] kvfree_rcu: Release page cache under memory pressure
> 
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Hello, Zqiang.
> 
> > From: Zqiang <qiang.zhang@windriver.com>
> >
> > Add free per-cpu existing krcp's page cache operation, when
> > the system is under memory pressure.
> >
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > ---
> >  kernel/rcu/tree.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c1ae1e52f638..644b0f3c7b9f 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3571,17 +3571,41 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  }
> >  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> >
> > +static int free_krc_page_cache(struct kfree_rcu_cpu *krcp)
> > +{
> > +     unsigned long flags;
> > +     struct llist_node *page_list, *pos, *n;
> > +     int freed = 0;
> > +
> > +     raw_spin_lock_irqsave(&krcp->lock, flags);
> > +     page_list = llist_del_all(&krcp->bkvcache);
> > +     krcp->nr_bkv_objs = 0;
> > +     raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > +
> > +     llist_for_each_safe(pos, n, page_list) {
> > +             free_page((unsigned long)pos);
> > +             freed++;
> > +     }
> > +
> > +     return freed;
> > +}
> > +
> >  static unsigned long
> >  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> >  {
> >       int cpu;
> >       unsigned long count = 0;
> > +     unsigned long flags;
> >
> >       /* Snapshot count of all CPUs */
> >       for_each_possible_cpu(cpu) {
> >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >
> >               count += READ_ONCE(krcp->count);
> > +
> > +             raw_spin_lock_irqsave(&krcp->lock, flags);
> > +             count += krcp->nr_bkv_objs;
> > +             raw_spin_unlock_irqrestore(&krcp->lock, flags);
> >       }
> >
> >       return count;
> > @@ -3598,6 +3622,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >
> >               count = krcp->count;
> > +             count += free_krc_page_cache(krcp);
> > +
> >               raw_spin_lock_irqsave(&krcp->lock, flags);
> >               if (krcp->monitor_todo)
> >                       kfree_rcu_drain_unlock(krcp, flags);
> > --
> > 2.17.1
> >>
> >Thank you for your patch!
> >
> >I spent some time to see how the patch behaves under low memory condition.
> >To simulate it, i used "rcuscale" tool with below parameters:
> >
> >../rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig >CONFIG_NR_CPUS=64 \
> >--bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 >rcuscale.holdoff=20 rcuscale.kfree_loops=10000 \
> >torture.disable_onoff_at_boot" --trust-make
> >
> >64 CPUs + 512 MB of memory. In general, my test system was running on edge
> >hitting an out of memory sometimes, but could be considered as stable in
> >regards to a test completion and taken time, so both were pretty solid.
> >
> >You can find a comparison on a plot, that can be downloaded following
> >a link: wget >ftp://vps418301.ovh.net/incoming/release_page_cache_under_low_memory.png
> >
> >In short, i see that a patched version can lead to longer test completion,
> >whereas the default variant is stable on almost all runs. After some analysis
> >and further digging i came to conclusion that a shrinker free_krc_page_cache()
> >concurs with run_page_cache_worker(krcp) running from kvfree_rcu() context.
> >
> >i.e. During the test a page shrinker is pretty active, because of low memory
> >condition. Our callback drains it whereas kvfree_rcu() part refill it right
> >away making kind of vicious circle.
> >
> >So, a run_page_cache_worker() should be backoff for some time when a system
> >runs into a low memory condition or high pressure:
> >
> >diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >index 7077d73fcb53..446723b9646b 100644
> >--- a/kernel/rcu/tree.c
> >+++ b/kernel/rcu/tree.c
> >@@ -3163,7 +3163,7 @@ struct kfree_rcu_cpu {
> >        bool initialized;
> >        int count;
> >
> >-       struct work_struct page_cache_work;
> >+       struct delayed_work page_cache_work;
> >        atomic_t work_in_progress;
> >        struct hrtimer hrtimer;
> >
> >@@ -3419,7 +3419,7 @@ schedule_page_work_fn(struct hrtimer *t)
> >        struct kfree_rcu_cpu *krcp =
> >                container_of(t, struct kfree_rcu_cpu, hrtimer);
> >
> >-       queue_work(system_highpri_wq, &krcp->page_cache_work);
> >+       queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
> >        return HRTIMER_NORESTART;
> > }
> >
> >@@ -3428,7 +3428,7 @@ static void fill_page_cache_func(struct work_struct *work)
> >        struct kvfree_rcu_bulk_data *bnode;
> >        struct kfree_rcu_cpu *krcp =
> >                container_of(work, struct kfree_rcu_cpu,
> >-                       page_cache_work);
> >+                       page_cache_work.work);
> >        unsigned long flags;
> >        bool pushed;
> >        int i;
> >@@ -3452,15 +3452,22 @@ static void fill_page_cache_func(struct work_struct >*work)
> >        atomic_set(&krcp->work_in_progress, 0);
> > }
> >
> >+static bool backoff_page_cache_fill;
> >+
> > static void
> > run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> > {
> >        if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> >                        !atomic_xchg(&krcp->work_in_progress, 1)) {
> >-               hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> >-                       HRTIMER_MODE_REL);
> >-               krcp->hrtimer.function = schedule_page_work_fn;
> >-               hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> >+               if (READ_ONCE(backoff_page_cache_fill)) {
> >+                       queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, >HZ);
> >+                       WRITE_ONCE(backoff_page_cache_fill, false);
> >+               } else {
> >+                       hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> >+                               HRTIMER_MODE_REL);
> >+                       krcp->hrtimer.function = schedule_page_work_fn;
> >+                       hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> >+               }
> >        }
> > }
> >
> >@@ -3644,6 +3651,8 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct >shrink_control *sc)
> >                raw_spin_unlock_irqrestore(&krcp->lock, flags);
> >        }
> >
> >+       // Low memory condition, limit a page cache worker activity.
> >+       WRITE_ONCE(backoff_page_cache_fill, true);
> >        return count;
> > }
> 
> >@@ -4634,7 +4643,7 @@ static void __init kfree_rcu_batch_init(void)
> >                }
> >
> >                INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> >-               INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
> >+               INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
> >                krcp->initialized = true;
> >        }
> >        if (register_shrinker(&kfree_rcu_shrinker))
> >
> >below patch fixes it. We should backoff the page fill worker keeping it empty
> >until the situation with memory consumption is normalized.
> 
>   Maybe can cancel the timer and cancel work in the rcu_shrink_count function, after
>   the rcu_shrink_scan function is executed and recover timer.
>   what do you think?
I think it is just easier to schedule a periodic delayed work with HZ
interval. If a system is in a tight memory situation, that periodic
work will not be harmful from CPU cycles point of view. Once it is
settled, the hrtimer takes over to speedup the process of cache filling.

>    
>    The other question is, why not call queue_work function directly to fill page cache, 
>    but through a hrtimer, what is the purpose of this design?
> 
It is done that way because the kvfree_rcu() is supposed that it could
be invoked from the scheduler part. It means that if a CPU holds rq->lock 
queuing the work or placing it into rq will lead to deadlock.

--
Vlad Rezki
