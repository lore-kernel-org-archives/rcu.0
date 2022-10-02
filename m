Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4FDC433F5
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 12:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJBMek (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJBMej (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 08:34:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115456433
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 05:34:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p5so9190647ljc.13
        for <rcu@vger.kernel.org>; Sun, 02 Oct 2022 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a72r0sKF4e9o8nKbJk+BcZpt4NoJ54Fp10FCFT8Iyaw=;
        b=ASkzHV7k1z9lU/4aiGlYjZT38k6Pg8yc42VGk8WNbwVKwmcr5fVu5S7OtmwxiQdVBw
         OM9rJUJkEDjFll92onTt9BUU1V+Zq2G8QywPkPfg/INM+jllmTWC8irjomigX0TIdZ38
         E/Eih9aX4WkvT69zqDHK4BYk+9iYljm9w8aZffVNmjQEU7Q9KZqUGTEd2AdrJG4ymH0W
         PI10sS132m0GkrBjXP89lX9ra9DLl3DFbRBgbo9aMGW6oYjQc0tOFzrO0cIsxs/RNlME
         vQo06w/Fd7lGFS4mcBWbwFd+rpk8PB1k0ZUfVGjdfb5UvsNZ8HFzZwDJHWU4DMtySFBC
         bhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a72r0sKF4e9o8nKbJk+BcZpt4NoJ54Fp10FCFT8Iyaw=;
        b=PVlwujuBxTXB/KfqSLVJ1ohF0ZQGioVPTRP9995o3nvTXPcJozhvdBUJxmPHhjd2Er
         Ql6QVLIKWxStO4ZLpB0s41hCuRo0P5FxEa3VsmJPnWyZNVS+5MJtNwKKy+j/P3JQQr20
         CpHVam8usAJ8ZBsU1ohKhx7j51NgfccBTuyCBgN+3iVMAAoDgEwfyra2ESq5VHwXSrNj
         g+XATGC8nOAj6uf0WzwnuD1G+d4niQw+0ypcqSqqyUrUMB48mu06Y9xqG6hie/6fwL4s
         WWPcC8McHj2jt7MPgD9wIl74sEoXcVrK6uRGAtewzbQbf+MH2XNI98uW3OfbJHFOtsei
         SyOw==
X-Gm-Message-State: ACrzQf2c1bNhyKVBRgQtixO7cAZWH8KODtg71JH2Ihj76Z5nUccruLts
        hHN69GPTHfNIUPaLwKeCYo//Fv0AALqbACh4VNRd2MkgWg==
X-Google-Smtp-Source: AMsMyM4yP3NpjNCPAApdiHRKHYX/NIUAXHNPAS0+Qmj2nbvSjdzRAm6jrisFtO2R5jeElTZMVnutMQ+eMruznegjDDU=
X-Received: by 2002:a2e:960e:0:b0:26b:e5ae:cd78 with SMTP id
 v14-20020a2e960e000000b0026be5aecd78mr5011421ljh.129.1664714069238; Sun, 02
 Oct 2022 05:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220915055825.21525-1-kernelfans@gmail.com> <20220915055825.21525-2-kernelfans@gmail.com>
 <20220916145240.GA27819@lothringen> <CAFgQCTuB72QZNL4AW95WntkCUqAinzis=6Mjwyfdy_NiMi_pgQ@mail.gmail.com>
 <20220919105149.GA58144@lothringen> <Yyk3acmumN7ezhhv@piliu.users.ipa.redhat.com>
 <20220920092303.GE69891@lothringen> <a7bfc699-fb8d-6dbc-6b4b-299a88e371a1@joelfernandes.org>
In-Reply-To: <a7bfc699-fb8d-6dbc-6b4b-299a88e371a1@joelfernandes.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Sun, 2 Oct 2022 20:34:17 +0800
Message-ID: <CAFgQCTukQ3_5FEh=ddWw9ffhimrmiUUYecTw7kwDaeGb=L4nkw@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] rcu: Keep qsmaskinitnext fresh when rcutree_online_cpu()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Oct 1, 2022 at 10:26 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
>
>
> On 9/20/22 05:23, Frederic Weisbecker wrote:
> > On Tue, Sep 20, 2022 at 11:45:45AM +0800, Pingfan Liu wrote:
> >> On Mon, Sep 19, 2022 at 12:51:49PM +0200, Frederic Weisbecker wrote:
> >>> On Mon, Sep 19, 2022 at 06:24:21PM +0800, Pingfan Liu wrote:
> >>>> On Fri, Sep 16, 2022 at 10:52 PM Frederic Weisbecker
> >>>> <frederic@kernel.org> wrote:
> >>>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >>>>>> index 438ecae6bd7e..ef6d3ae239b9 100644
> >>>>>> --- a/kernel/rcu/tree_plugin.h
> >>>>>> +++ b/kernel/rcu/tree_plugin.h
> >>>>>> @@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> >>>>>>  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> >>>>>>  {
> >>>>>>       struct task_struct *t = rnp->boost_kthread_task;
> >>>>>> -     unsigned long mask = rcu_rnp_online_cpus(rnp);
> >>>>>> +     unsigned long mask;
> >>>>>>       cpumask_var_t cm;
> >>>>>>       int cpu;
> >>>>>>
> >>>>>> @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> >>>>>>       if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
> >>>>>>               return;
> >>>>>>       mutex_lock(&rnp->boost_kthread_mutex);
> >>>>>> +     /*
> >>>>>> +      * Relying on the lock to serialize, so when onlining, the latest
> >>>>>> +      * qsmaskinitnext is for cpus_ptr.
> >>>>>> +      */
> >>>>>> +     mask = rcu_rnp_online_cpus(rnp);
> >>>>>>       for_each_leaf_node_possible_cpu(rnp, cpu)
> >>>>>>               if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
> >>>>>>                   cpu != outgoingcpu)
> >>>>>
> >>>>> Right but you still race against concurrent rcu_report_dead() doing:
> >>>>>
> >>>>>       WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask)
> >>>>>
> >>>>
> >>>> Ah. Indeed, my commit log is not precisely described.
> >>>>
> >>>> In fact, either speedup smp_init [1] or fast kexec reboot [2] still
> >>>> uses the model: one hotplug initiator and several reactors.  The
> >>>> initiators are still excluded from each other by the pair
> >>>> cpu_maps_update_begin()/cpu_maps_update_done(). So there can not be a
> >>>> cpu-up and cpu-down event at the same time.
> >>>
> >>> Yes but two downing CPUs may race right?
> >>>
> >>> So isn't it possible to have rcu_report_dead() racing against
> >>> rcutree_offline_cpu()?
> >>>
> >>
> >> Yes, two downing cpus can be in a batch.
> >>
> >> There is a nuance between onlining and offlining:
> >> -1. onlining relies on qsmaskinitnext, which is stable at the point
> >> rcutree_online_cpu(). And it is what this patch aims for.
> >> -2. offlining relies on cpu_dying_mask [2/3], instead of qsmaskinitnext
> >> which is not cleared yet at the point rcutree_offline_cpu().
> >>
> >> It is asymmetric owning to the point of updating qsmaskinitnext.
> >>
> >> Now considering the racing between rcu_report_dead() and
> >> rcutree_offline_cpu():
> >>
> >> No matter rcutree_offline_cpu() reads out either stale or fresh value of
> >> qsmaskinitnext, it should intersect with cpu_dying_mask.
> >
> > Ah I see now, so the race can happen but it is then cancelled by the
> > stable READ on cpu_dying_mask. Ok.
> >
>
> Maybe I am missing something but, concurrent rcu_report_dead() on CPU's
> of the same node can corrupt ->qsmaskinitnext as Frederick showed. That

There is a pair of lock ops around WRITE_ONCE(rnp->qsmaskinitnext,
rnp->qsmaskinitnext & ~mask), i.e. raw_spin_lock_irqsave_rcu_node(rnp,
flags) and raw_spin_unlock_irqrestore_rcu_node(rnp, flags);

So it should not be a problem, right?

Thanks,

    Pingfan
