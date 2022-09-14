Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F9ECAAD3
	for <rcu@archiver.kernel.org>; Wed, 14 Sep 2022 13:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiINNeS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINNeR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Sep 2022 09:34:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F54DB2A
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 06:34:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i26so25201980lfp.11
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=caNx3mxWU2rKz0DBT96Qhiuvj1D7mOJC0UYFdBk9Py8=;
        b=pa8lMM+VHY9JCNn5tyXsFOIuUkAsldtDy2K4Satuy8Oy7sVmxootAVcHF0cb1SWnyX
         OyDFtfVixhlltfHentBkJx3iNwZ3kEOk7DERo9EmqmOib/EPuXkdAINJFyNRV2Cf1pKm
         Y66o9srOwU6zgV+TnhQdY2VwiaAtVrtBJgRv+i/pXPcksk4mWZamcCV2vVPBy6J3eGzN
         HtRQjAIAex9Lz3TDnzVoZIcfmjUirNM6rPL7QVACcrQ5FWuKdpRLb2cO/T4vfK3okOhN
         Be9QGRag/HRUru6uEsIQ0EauIjscd7wPb5IAav197wT+S870ET067UcN2FJvsldRAY+6
         Hrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=caNx3mxWU2rKz0DBT96Qhiuvj1D7mOJC0UYFdBk9Py8=;
        b=P+KQQCE7Wr0HXf9m1oIhkuOTqv/PYB0VKWvYyNjO/F1WZMaqhb7uimhKIlthBDzc96
         Xa0Y2EPXrf6BmKNJsCDvm9Sd/WBkwfwKvGKM0PAIpmfDXtmit3mtw5CojjGHza/ZfF29
         lc7aKowVZnAnHZyfKKA3TAhFqAcKRGvCsBodk6ibQC/m7sCLEcvGpZaEiG5HaAIq+A5L
         39sWrqRThN7rt6kCwfiAbmfEobF8RT71MG43qP+clzsbo+yFzlZF4dVuR8EqaMuqxVbT
         HspgDCIeMTTcrEQp+t4ZKZQgNHSPc6ymh1aw5aJOMh3dCy/GlUYilLQbdAYg7uBkPHw2
         TWzA==
X-Gm-Message-State: ACgBeo0UxuUqWbk4PJR2zuXqcrem5FJtdKstaZs6X4CMr0CSkKv9bnUH
        EFv/0hd2hPRntTDh9zcTPB8DypOvXWy8pmQC1w==
X-Google-Smtp-Source: AA6agR5p03liH36xYhOqCfEqbGrihfxSfb1lDw3xJmmusAXPzzR+hKOa0sGHOJ0x6rtsmvI5fx5RiyzrwOLqZPJ1ARI=
X-Received: by 2002:a05:6512:3089:b0:494:965b:31c2 with SMTP id
 z9-20020a056512308900b00494965b31c2mr11600033lfd.22.1663162454962; Wed, 14
 Sep 2022 06:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220905033852.18988-1-kernelfans@gmail.com> <20220906172441.GY4315@paulmck-ThinkPad-P17-Gen-1>
 <Yxf2jRB9LXr4q6ri@piliu.users.ipa.redhat.com> <20220910203622.GI4315@paulmck-ThinkPad-P17-Gen-1>
 <YyGpC03H0c9EXTv9@piliu.users.ipa.redhat.com> <20220914122701.GB1879@lothringen>
In-Reply-To: <20220914122701.GB1879@lothringen>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 14 Sep 2022 21:34:03 +0800
Message-ID: <CAFgQCTuq5Le1HTGtYFNUcveXfg30_=EwwTuRWCfJPuJmn93VXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rcu: remove redundant cpu affinity setting during teardown
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 14, 2022 at 8:27 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Wed, Sep 14, 2022 at 06:12:27PM +0800, Pingfan Liu wrote:
> > On Sat, Sep 10, 2022 at 01:36:22PM -0700, Paul E. McKenney wrote:
> > Actually, the scheduler will pick up one online cpu for the boost
> > thread.
> >
> > On the last cpu, boost is subject to migration, and is pushed away by
> > __balance_push_cpu_stop()
> > {
> >         if (task_rq(p) == rq && task_on_rq_queued(p)) {
> >                 cpu = select_fallback_rq(rq->cpu, p);
> >                 rq = __migrate_task(rq, &rf, p, cpu);
> >         }
> > }
> >
> > Now, turning to select_fallback_rq(), inside that function, if
> > p->cpus_ptr has no suitable cpus, then case cpuset or possible will make it
> > point to cpuset or cpu_possible_mask.  So finally, there is a valid cpu
> > is picked up. (I have not found the online cpu there. The trick should hide
> > elsewhere. But that rendered the same result as in v5.16, where
> > rcu_boost_kthread_setaffinity()->cpumask_setall(cm))
> >
> > But now, in 6.0, it changes into housekeeping_cpumask(HK_TYPE_RCU),
> > which appeals for a more careful thinking.
> > If there is a cpuset for housekeeping so that select_fallback_rq() can
> > pick up one from that cpuset?
> >
> > To Frederic, could you show some light here and is it worth introducing
> > such a cpuset so that select_fallback_rq() can pick up a cpu in
> > housekeeping set in this case?
> >
> >
> > Anyway, as the last resort, TICK_DEP_BIT_RCU has already appealed for
> > the awareness of the concurrent rcutree_offline_cpu(), the affinity
> > setting could be done there if select_fallback_rq() can not work.
>
> Here is the way I understand it: suppose the outgoing CPU was the last online
> one in this rcu node, in this case the migration performed in
> sched_cpu_deactivate() will find only one CPU in p->cpus_mask, but that CPU is
> now out of cpu_active_mask, so the task is affined by default to cpu_possible_mask.
>
> So there is a short window between sched_cpu_deactivate() and
> rcutree_offline_cpu() where the task may run on all cpu_possible_mask. Does it
> matter? Maybe, I don't know...
>

OK, then it is pointless to introduce a housekeeping cpuset.

> After that we reach rcutree_offline_cpu() -> rcu_boost_kthread_setaffinity()
> that fails to fill the cpumask since the node is now empty. As the resulting
> cpumask is empty, it fills it as a last resort to the HK_TYPE_RCU housekeeping
> set which has to have at least 1 online CPU (nohz_full constraint). So the task
> is finally affine to that housekeeping set.
>

Yes, exactly.

> Like Paul said, I'd rather indeed remove the rcu_boost_kthread_setaffinity()
> call from rcutree_dead_cpu() as this one looks useless.
>

OK, I will take that way.

Thanks to both of you for the generous help. I will bring up V2 soon.


Thanks,

    Pingfan
