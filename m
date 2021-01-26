Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DF5C433DB
	for <rcu@archiver.kernel.org>; Tue, 26 Jan 2021 13:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4FE2223D
	for <rcu@archiver.kernel.org>; Tue, 26 Jan 2021 13:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404906AbhAZNrA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 Jan 2021 08:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405020AbhAZNoV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 Jan 2021 08:44:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70171C0611BD;
        Tue, 26 Jan 2021 05:43:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m22so22767924lfg.5;
        Tue, 26 Jan 2021 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OQBVQzafF3WAXz8Rj+wUggOGA8r5wNMBBaUu9EM+CG8=;
        b=lrx2FI7Y5dJ7hnx0/hONevLyeebykp/8sNmTZqtueyOEJZK/3zpV/l60nM9AL3c3DJ
         3fejPxFP1NUMIrvW58aZpgjO2ZyWhjvxpZJm6GFZWJzfh1hLwGBhebFI9TSAbctgdRG4
         FQ+y+v5ySCc53mskkoWhWUZatldrhphjGdUh8L7RixbDTV6u6sg12dH+BAesBfarHfAT
         hpIwRPdY1T6CAVPIkDV6QLgLy8on9vJ5LizDVkXD7XN91WZ3Qu0d4FokPaQg+XrAeiZW
         oTgZ/B7XkNAYIK3HbkPGvfmTHgvt+H7isn8YIwbsqebvIHAJGCCnoOxIX/ByKl13gkx4
         eJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OQBVQzafF3WAXz8Rj+wUggOGA8r5wNMBBaUu9EM+CG8=;
        b=k+cb9lumz6RHuVz5QEkMXlmJNscaUrDlpM2K1HnhNbz6LG8ZLYd145578weUaZRu1C
         b7CmeU/88Bnlv7lcMTnkyaA3pR3ddU60snlmG8z1EPu9HzdVmpW8rQPX5Y1YGhSnCDEZ
         5mhrpgEFYNo1uSaxKd/DqhyR3usKg9mVcUosO2IvTr+s5Ui+kFlqtR2BkYqrlubzuQ76
         JSBbpdaSaG7Bsj/RaKMIoDOoAszwe/uFKVyDgbjuZWIU56QJ/tLnapDS7ylLFeN9Suhn
         3ToUd+nLoKOPLRwJLVNbp+Qx1YtP4o1MbQFjKfCE9PyIop7o7F5d2t3ZC8RPfLseuJ/r
         ge2w==
X-Gm-Message-State: AOAM531SuvAkTdidKotVvhg1NaAAyNOE3gVuoJICiaP+VtH58dJAjqSb
        XDo/qiWmOgfq6iB2LMuVp6M5tmiHEiqWqQ==
X-Google-Smtp-Source: ABdhPJxmVjRW7oca8dXeaIosnCmMYzLR9WJ80KG0TkgaBMaKOgjIXc+w75hx4jx/A5bHOJWck2Bpug==
X-Received: by 2002:a19:700b:: with SMTP id h11mr2590221lfc.356.1611668619941;
        Tue, 26 Jan 2021 05:43:39 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m78sm2063684lfa.270.2021.01.26.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 05:43:38 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 26 Jan 2021 14:43:36 +0100
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
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbng==?= =?utf-8?B?5aSNOg==?=
 [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
Message-ID: <20210126134336.GA1884@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120162148.1973-3-urezki@gmail.com>
 <BYAPR11MB263252B1BD73A38DD8C0AF4EFFBF0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210124215700.GB1076@pc636>
 <BYAPR11MB2632939DA9FB6AC1B25FA847FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632ACF42A88E65F1C164021FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210125134930.GA1869@pc638.lan>
 <BYAPR11MB2632016E5622E83656CF805BFFBC9@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2632016E5622E83656CF805BFFBC9@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 26, 2021 at 09:33:40AM +0000, Zhang, Qiang wrote:
> 
> 
> ________________________________________
> 发件人: Uladzislau Rezki <urezki@gmail.com>
> 发送时间: 2021年1月25日 21:49
> 收件人: Zhang, Qiang
> 抄送: Uladzislau Rezki; LKML; RCU; Paul E . McKenney; Michael Ellerman; Andrew Morton; Daniel Axtens; Frederic Weisbecker; Neeraj Upadhyay; Joel Fernandes; Peter Zijlstra; Michal Hocko; Thomas Gleixner; Theodore Y . Ts'o; Sebastian Andrzej Siewior; Oleksiy Avramchenko
> 主题: Re: 回复: 回复: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
> 
> > >Hello, Zhang.
> >
> > > >________________________________________
> > > >发件人: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > >发送时间: 2021年1月21日 0:21
> > > >收件人: LKML; RCU; Paul E . McKenney; Michael Ellerman
> > > >抄送: Andrew Morton; Daniel Axtens; Frederic Weisbecker; Neeraj >Upadhyay; Joel Fernandes; Peter Zijlstra; Michal Hocko; Thomas >Gleixner; Theodore Y . Ts'o; Sebastian Andrzej Siewior; Uladzislau >Rezki; Oleksiy Avramchenko
> > > >主题: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
> > > >
> > > >Since the page is obtained in a fully preemptible context, dropping
> > > >the lock can lead to migration onto another CPU. As a result a prev.
> > > >bnode of that CPU may be underutilised, because a decision has been
> > > >made for a CPU that was run out of free slots to store a pointer.
> > > >
> > > >migrate_disable/enable() are now independent of RT, use it in order
> > > >to prevent any migration during a page request for a specific CPU it
> > > >is requested for.
> > >
> > >
> > > Hello Rezki
> > >
> > > The critical migrate_disable/enable() area is not allowed to block, under RT and non RT.
> > > There is such a description in preempt.h
> > >
> > >
> > > * Notes on the implementation.
> > >  *
> > >  * The implementation is particularly tricky since existing code patterns
> > >  * dictate neither migrate_disable() nor migrate_enable() is allowed to block.
> > >  * This means that it cannot use cpus_read_lock() to serialize against hotplug,
> > >  * nor can it easily migrate itself into a pending affinity mask change on
> > >  * migrate_enable().
> > >
> > >How i interpret it is migrate_enable()/migrate_disable() are not allowed to
> > >use any blocking primitives, such as rwsem/mutexes/etc. in order to mark a
> > >current context as non-migratable.
> > >
> > >void migrate_disable(void)
> > >{
> > > struct task_struct *p = current;
> > >
> > > if (p->migration_disabled) {
> > >  p->migration_disabled++;
> > >  return;
> > > }
> >
> > > preempt_disable();
> > > this_rq()->nr_pinned++;
> > > p->migration_disabled = 1;
> > > preempt_enable();
> > >}
> > >
> > >It does nothing that prevents you from doing schedule() or even wait for any
> > >event(mutex slow path behaviour), when the process is removed from the run-queue.
> > >I mean after the migrate_disable() is invoked. Or i miss something?
> >
> > Hello Rezki
> >
> > Sorry, there's something wrong with the previous description.
> > There are the following scenarios
> >
> > Due to migrate_disable will increase  this_rq()->nr_pinned , after that
> > if get_free_page be blocked, and this time, CPU going offline,
> > the sched_cpu_wait_empty() be called in per-cpu "cpuhp/%d" task,
> > and be blocked.
> >
> >But after the migrate_disable() is invoked a CPU can not be brought down.
> >If there are pinned tasks a "hotplug path" will be blocked on balance_hotplug_wait()
> >call.
> 
> > blocked:
> > sched_cpu_wait_empty()
> > {
> >       struct rq *rq = this_rq();
> >        rcuwait_wait_event(&rq->hotplug_wait,
> >                            rq->nr_running == 1 && !rq_has_pinned_tasks(rq),
> >                            TASK_UNINTERRUPTIBLE);
> > }
> >
> >Exactly.
> 
> > wakeup:
> > balance_push()
> > {
> >         if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
> >
> >                 if (!rq->nr_running && !rq_has_pinned_tasks(rq) &&
> >                     rcuwait_active(&rq->hotplug_wait)) {
> >                         raw_spin_unlock(&rq->lock);
> >                         rcuwait_wake_up(&rq->hotplug_wait);
> >                         raw_spin_lock(&rq->lock);
> >                 }
> >                 return;
> >         }
> > }
> >
> > One of the conditions for this function to wake up is "rq->nr_pinned  == 0"
> > that is to say between migrate_disable/enable, if blocked will defect CPU going
> > offline longer blocking time.
> >
> >Indeed, the hotplug time is affected. For example in case of waiting for
> >a mutex to be released, an owner will wakeup waiters. But this is expectable.
> 
> >
> > I'm not sure that's a problem，and I didn't find it in the kernel code  between
> >  migrate_disable/enable possible sleep calls.
> >
> >For example z3fold.c:
> 
> >/* Add to the appropriate unbuddied list */
> >static inline void add_to_unbuddied(struct z3fold_pool *pool,
> >                                struct z3fold_header *zhdr)
> >{
> >       if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
> >                        zhdr->middle_chunks == 0) {
> >                struct list_head *unbuddied;
> >              int freechunks = num_free_chunks(zhdr);
> >
> >                migrate_disable();
> >                unbuddied = this_cpu_ptr(pool->unbuddied);
> >                spin_lock(&pool->lock);
> >                list_add(&zhdr->buddy, &unbuddied[freechunks]);
> >                spin_unlock(&pool->lock);
> >                zhdr->cpu = smp_processor_id();
> >                migrate_enable();
> >        }
> >}
> 
> >for PREEMPT_RT kernel a spinlock is converted to rt-mutex, thus it can sleep.
> 
>  I forgot that. Thank you for your explanation.
> 
>  
No problem. I also has recently learned about spinlock and rt-mutexes :)

--
Vlad Rezki
