Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4CCC43333
	for <rcu@archiver.kernel.org>; Tue, 26 Jan 2021 17:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F1D230FC
	for <rcu@archiver.kernel.org>; Tue, 26 Jan 2021 17:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbhAZGBf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbhAYNuQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 Jan 2021 08:50:16 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21471C061574;
        Mon, 25 Jan 2021 05:49:35 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so15296919ljo.13;
        Mon, 25 Jan 2021 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2MM+4DHLq4mp2pSrUD4kY/YnjjgN4sqE1Uy0H5xVv0o=;
        b=KXVDm+WW4ACBvvvDHjXxCbU1MHDSH3NqA7x4rWe9rFWATO/o7DRkmAb7X7o6a3IAU2
         dCA4V78CS8ZNg2w1tC6G71EvAztwKy6LF2fJJzyKY4H+P1e6bN1p4+9YekqBap9RA/JC
         b9M1juSlVmI3MN0qtulhPlZExjmRmXp3w6zmFM8VkQgARnTOD+gNt2nk6rCDVrx1l4sI
         5ag3+4fBjiC3WjM2GW+n3vIxRXHYtou0R5Wic7rdOgRGe9UYwy4KC4BopiuVgGa7ibDN
         DpGKxQxjCjQ+qCnCiw8RmIoJhwzr2i7EOdpGw6IftwsujaQHZIjKCd3zAlAgWlJIT17o
         OWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2MM+4DHLq4mp2pSrUD4kY/YnjjgN4sqE1Uy0H5xVv0o=;
        b=FENmYbpvphd0CybDq88B8a9AZBYP7JX+/PIs0rfC78gVoBiRAX4SXb1G83D12usGUy
         VQeNYUW3Ze1I4ysbNYu99XAdEM4YQYIO9fIsWu6MvMtd24QDxRVqy5honfH9C2+l6Nb1
         Dy3v4NDymsyzC7Y4y4JDuMEVgzB2IS4+dUB1gh3LJY0rVpyFtc+5LGSVWvJE6ln5s4yM
         Ydsh5NUPgdBBD1gz3+oWwrSebj2C4a7MsSyHdZqPxUqX+fev1QgLc53ml+LNVebHrPUC
         PdPCRaEMda7W5eK+safK5f/d8KAojv2z1pj26rtH8NqeInVljWJR4hINHB0eWh7VY9BU
         X4Kw==
X-Gm-Message-State: AOAM532sX5S3EeuOZ6UymYFiS/MfZuxHmQ5NGCvv+sj16xWW3Y7hVnHc
        Enzd2vD+0/2b5ujQ9JbtVBo=
X-Google-Smtp-Source: ABdhPJzLgsYIWgKYL5z68o7tmI7vgCytx2MuYbT83+rMx51nWQUIv4MLd/bZx++48yOlLzOzh0vlUw==
X-Received: by 2002:a2e:3516:: with SMTP id z22mr241879ljz.508.1611582573590;
        Mon, 25 Jan 2021 05:49:33 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id a73sm319650lfd.45.2021.01.25.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 05:49:32 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 25 Jan 2021 14:49:30 +0100
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
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
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI0=?= =?utf-8?Q?=3A?= [PATCH 3/3]
 kvfree_rcu: use migrate_disable/enable()
Message-ID: <20210125134930.GA1869@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120162148.1973-3-urezki@gmail.com>
 <BYAPR11MB263252B1BD73A38DD8C0AF4EFFBF0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210124215700.GB1076@pc636>
 <BYAPR11MB2632939DA9FB6AC1B25FA847FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632ACF42A88E65F1C164021FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2632ACF42A88E65F1C164021FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> 
> ________________________________________
> 发件人: Uladzislau Rezki <urezki@gmail.com>
> 发送时间: 2021年1月25日 5:57
> 收件人: Zhang, Qiang
> 抄送: Uladzislau Rezki (Sony); LKML; RCU; Paul E . McKenney; Michael Ellerman; Andrew Morton; Daniel Axtens; Frederic Weisbecker; Neeraj Upadhyay; Joel Fernandes; Peter Zijlstra; Michal Hocko; Thomas Gleixner; Theodore Y . Ts'o; Sebastian Andrzej Siewior; Oleksiy Avramchenko
> 主题: Re: 回复: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
> 
> >Hello, Zhang.
> 
> > >________________________________________
> > >发件人: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >发送时间: 2021年1月21日 0:21
> > >收件人: LKML; RCU; Paul E . McKenney; Michael Ellerman
> > >抄送: Andrew Morton; Daniel Axtens; Frederic Weisbecker; Neeraj >Upadhyay; Joel Fernandes; Peter Zijlstra; Michal Hocko; Thomas >Gleixner; Theodore Y . Ts'o; Sebastian Andrzej Siewior; Uladzislau >Rezki; Oleksiy Avramchenko
> > >主题: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
> > >
> > >Since the page is obtained in a fully preemptible context, dropping
> > >the lock can lead to migration onto another CPU. As a result a prev.
> > >bnode of that CPU may be underutilised, because a decision has been
> > >made for a CPU that was run out of free slots to store a pointer.
> > >
> > >migrate_disable/enable() are now independent of RT, use it in order
> > >to prevent any migration during a page request for a specific CPU it
> > >is requested for.
> >
> >
> > Hello Rezki
> >
> > The critical migrate_disable/enable() area is not allowed to block, under RT and non RT.
> > There is such a description in preempt.h
> >
> >
> > * Notes on the implementation.
> >  *
> >  * The implementation is particularly tricky since existing code patterns
> >  * dictate neither migrate_disable() nor migrate_enable() is allowed to block.
> >  * This means that it cannot use cpus_read_lock() to serialize against hotplug,
> >  * nor can it easily migrate itself into a pending affinity mask change on
> >  * migrate_enable().
> >
> >How i interpret it is migrate_enable()/migrate_disable() are not allowed to
> >use any blocking primitives, such as rwsem/mutexes/etc. in order to mark a
> >current context as non-migratable.
> >
> >void migrate_disable(void)
> >{
> > struct task_struct *p = current;
> >
> > if (p->migration_disabled) {
> >  p->migration_disabled++;
> >  return;
> > }
> 
> > preempt_disable();
> > this_rq()->nr_pinned++;
> > p->migration_disabled = 1;
> > preempt_enable();
> >}
> >
> >It does nothing that prevents you from doing schedule() or even wait for any
> >event(mutex slow path behaviour), when the process is removed from the run-queue.
> >I mean after the migrate_disable() is invoked. Or i miss something?
> 
> Hello Rezki
> 
> Sorry, there's something wrong with the previous description.
> There are the following scenarios
> 
> Due to migrate_disable will increase  this_rq()->nr_pinned , after that
> if get_free_page be blocked, and this time, CPU going offline,
> the sched_cpu_wait_empty() be called in per-cpu "cpuhp/%d" task,
> and be blocked.
> 
But after the migrate_disable() is invoked a CPU can not be brought down.
If there are pinned tasks a "hotplug path" will be blocked on balance_hotplug_wait()
call.

> blocked:
> sched_cpu_wait_empty()
> {
>       struct rq *rq = this_rq();
>        rcuwait_wait_event(&rq->hotplug_wait,
>                            rq->nr_running == 1 && !rq_has_pinned_tasks(rq),
>                            TASK_UNINTERRUPTIBLE);
> }
>
Exactly.

> wakeup:
> balance_push()
> {
>         if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
>               
>                 if (!rq->nr_running && !rq_has_pinned_tasks(rq) &&
>                     rcuwait_active(&rq->hotplug_wait)) {
>                         raw_spin_unlock(&rq->lock);
>                         rcuwait_wake_up(&rq->hotplug_wait);
>                         raw_spin_lock(&rq->lock);
>                 }
>                 return;
>         }
> }
> 
> One of the conditions for this function to wake up is "rq->nr_pinned  == 0"
> that is to say between migrate_disable/enable, if blocked will defect CPU going
> offline longer blocking time.
> 
Indeed, the hotplug time is affected. For example in case of waiting for
a mutex to be released, an owner will wakeup waiters. But this is expectable.

>
> I'm not sure that's a problem，and I didn't find it in the kernel code  between 
>  migrate_disable/enable possible sleep calls.
> 
For example z3fold.c:

/* Add to the appropriate unbuddied list */
static inline void add_to_unbuddied(struct z3fold_pool *pool,
				struct z3fold_header *zhdr)
{
	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
			zhdr->middle_chunks == 0) {
		struct list_head *unbuddied;
		int freechunks = num_free_chunks(zhdr);

		migrate_disable();
		unbuddied = this_cpu_ptr(pool->unbuddied);
		spin_lock(&pool->lock);
		list_add(&zhdr->buddy, &unbuddied[freechunks]);
		spin_unlock(&pool->lock);
		zhdr->cpu = smp_processor_id();
		migrate_enable();
	}
}

for PREEMPT_RT kernel a spinlock is converted to rt-mutex, thus it can sleep.

--
Vlad Rezki
