Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDBBC433E0
	for <rcu@archiver.kernel.org>; Sun, 24 Jan 2021 21:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497DF222BB
	for <rcu@archiver.kernel.org>; Sun, 24 Jan 2021 21:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbhAXV5q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Jan 2021 16:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbhAXV5p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Jan 2021 16:57:45 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5484C061573;
        Sun, 24 Jan 2021 13:57:04 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id b10so12980754ljp.6;
        Sun, 24 Jan 2021 13:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H1QjR+82mKDdAM86lvxkKFOo5eIQalM15456HEa3zXU=;
        b=EX/rH/YXa0X+MfaGnvWF2TkH75FKf754jpygjpYfUnJrZz27OTzRNpjtKJf7TQ+mTJ
         6uB8rsBjh0QTkL/VsmYO6oja5VtXJubK/upS5SVi5/20+o3YIxN71YlvDIlw7qnivZtX
         CTnus3PUA5LkarYWif8p6jGl30MWYyXxEkYn4+mkiOMJGUzKBCRXaF36y1UHQD28GneN
         iFp708M7GJ48PcyDzxUZoIsKtsg/QRouRfl6TGS4lUPuyU7enmRDLSiQH2+M9sekbcyP
         ebraIbdPEjrX7vxJVdrmR2luWw2fjxcOHrBqzvEnLxN575KbfyTBn3L3aI2/+ej40tWk
         vfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H1QjR+82mKDdAM86lvxkKFOo5eIQalM15456HEa3zXU=;
        b=CuDzxrHZCOEfqbkYAUMrs+uIUX5kuFncu/0NgK1N7eyaBmprOFSeDdSF9Wu5GP3ufb
         wSXLwTNiu+xQxIqLhszZteLR7mHydm+BOE2aGIaHfLqihjj/y2qShNT2JYyLJblkMBl4
         kK7tS03HXaBKJi5mmknndkQkxP2GKmoJhCKitLs/TOV7yx59W8kUEuLVm4MBW2i6CtK7
         hDH/BKcaGMfD8PCS3JuNHca0Qzj0Tsu/pzwzYaXgb4k2TFabgbqqMvZEcZzA5ulHea2Q
         hlhLOFfNCYn9VhCaUnNIOy2ow8zQV9UIXvmMUEAK+xKfIIIIz+VUdnEb44it836qSYIM
         phxQ==
X-Gm-Message-State: AOAM5309IptRadeQPrsbgLAOdL822d1xQJtZm/TGe/znCkSh2FhiqJ53
        mgjSpVZp9O+0aOHzoMoHE14=
X-Google-Smtp-Source: ABdhPJzbhpkY3Ytv5SNvU1bgMcQGrhZdvh6qfNvb0Rq8bkTvFflFiR7in5VeG8hSW/7lzsfUgMPiJg==
X-Received: by 2002:a05:651c:28d:: with SMTP id b13mr498080ljo.75.1611525422950;
        Sun, 24 Jan 2021 13:57:02 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y20sm1114655ljh.124.2021.01.24.13.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 13:57:02 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 24 Jan 2021 22:57:00 +0100
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH 3/3] kvfree_rcu: use
 migrate_disable/enable()
Message-ID: <20210124215700.GB1076@pc636>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120162148.1973-3-urezki@gmail.com>
 <BYAPR11MB263252B1BD73A38DD8C0AF4EFFBF0@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB263252B1BD73A38DD8C0AF4EFFBF0@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Zhang.

> >________________________________________
> >发件人: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >发送时间: 2021年1月21日 0:21
> >收件人: LKML; RCU; Paul E . McKenney; Michael Ellerman
> >抄送: Andrew Morton; Daniel Axtens; Frederic Weisbecker; Neeraj >Upadhyay; Joel Fernandes; Peter Zijlstra; Michal Hocko; Thomas >Gleixner; Theodore Y . Ts'o; Sebastian Andrzej Siewior; Uladzislau >Rezki; Oleksiy Avramchenko
> >主题: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
> >
> >Since the page is obtained in a fully preemptible context, dropping
> >the lock can lead to migration onto another CPU. As a result a prev.
> >bnode of that CPU may be underutilised, because a decision has been
> >made for a CPU that was run out of free slots to store a pointer.
> >
> >migrate_disable/enable() are now independent of RT, use it in order
> >to prevent any migration during a page request for a specific CPU it
> >is requested for.
> 
> 
> Hello Rezki
> 
> The critical migrate_disable/enable() area is not allowed to block, under RT and non RT.  
> There is such a description in preempt.h 
> 
> 
> * Notes on the implementation.
>  *
>  * The implementation is particularly tricky since existing code patterns
>  * dictate neither migrate_disable() nor migrate_enable() is allowed to block.
>  * This means that it cannot use cpus_read_lock() to serialize against hotplug,
>  * nor can it easily migrate itself into a pending affinity mask change on
>  * migrate_enable().
> 
How i interpret it is migrate_enable()/migrate_disable() are not allowed to
use any blocking primitives, such as rwsem/mutexes/etc. in order to mark a
current context as non-migratable.

void migrate_disable(void)
{
 struct task_struct *p = current;

 if (p->migration_disabled) {
  p->migration_disabled++;
  return;
 }

 preempt_disable();
 this_rq()->nr_pinned++;
 p->migration_disabled = 1;
 preempt_enable();
}

It does nothing that prevents you from doing schedule() or even wait for any
event(mutex slow path behaviour), when the process is removed from the run-queue.
I mean after the migrate_disable() is invoked. Or i miss something?

>
> How about the following changes:
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e7a226abff0d..2aa19537ac7c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3488,12 +3488,10 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>                         (*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
>                 bnode = get_cached_bnode(*krcp);
>                 if (!bnode && can_alloc) {
> -                       migrate_disable();
>                         krc_this_cpu_unlock(*krcp, *flags);
>                         bnode = (struct kvfree_rcu_bulk_data *)
>                                 __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
> -                       *krcp = krc_this_cpu_lock(flags);
> -                       migrate_enable();
> +                       raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
>
Hm.. Taking the former lock can lead to a pointer leaking, i mean a CPU associated
with "krcp" might go offline during a page request process, so a queuing occurs on
off-lined CPU. Apat of that, acquiring a former lock still does not solve:

- CPU1 in process of page allocation;
- CPU1 gets migrated to CPU2;
- another task running on CPU1 also allocate a page;
- both bnodes are added to krcp associated with CPU1.

I agree that such scenario probably will never happen or i would say, can be
considered as a corner case. We can drop the:

[PATCH 3/3] kvfree_rcu: use migrate_disable/enable()

and live with: an allocated bnode can be queued to another CPU, so its prev.
"bnode" can be underutilized. What is also can be considered as a corner case.
According to my tests, it is hard to achieve:

Running kvfree_rcu() simultaneously in a tight loop, 1 000 000 allocations/freeing:

- 64 CPUs and 64 threads showed 1 migration;
- 64 CPUs and 128 threads showed 0 migrations;
- 64 CPUs and 32 threads showed 0 migration. 

Thoughts?

Thank you for your comments!

--
Vlad Rezki
