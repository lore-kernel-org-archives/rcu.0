Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CAAC433F5
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73288613AC
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 21:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhJDVYy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Oct 2021 17:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhJDVYy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 Oct 2021 17:24:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0779C061745
        for <rcu@vger.kernel.org>; Mon,  4 Oct 2021 14:23:04 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id v10so23385273oic.12
        for <rcu@vger.kernel.org>; Mon, 04 Oct 2021 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wwnd+0Uys/5mclS0Q4e6bTPUrlA12TRp3NT/fPW6lBo=;
        b=JFfhDmFqiC1T5SV6pkQ69cO3uPXReJ/Jr8fARJ+IGRkVfk+EQMW6qChvKnX4rwNg0r
         3t560EN+OYtmisG+T3r5dgC/JrfpSzr8JrO2nzRbdN/+QP6V4i3uqh+DLTtVGXC140GE
         Iz0dhqkEN68PsV4DncRpOA6lerWs2AHINKIhu9B8UFTzB9VeEl19ztvZTJS98JpkRHAY
         MLHbZQHfkCKQ/DcCPE9YaSz2rFJW7ZOQVVir3+dFRIal6j/O2dS1OBdJ9DlFbbg91o+e
         T7K0gslErIKCnfFzSBuYOmPP5/Fe7r8Im1h8GpozbRqMmx2AlzHXl2zUOBQnTjoKqgxj
         OvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wwnd+0Uys/5mclS0Q4e6bTPUrlA12TRp3NT/fPW6lBo=;
        b=gHKVlLEIF8avx+OrWHo4dV0qs8M02ZJwkDd6Y9/MmEgjnAKrYrKFeZDskeSo8aeDpV
         tvfq6p1p7R5MfDTeXi5zGxsP7cJTuxwOJX9mkxolDxUpcsAQS2CUxceiySPy2O6LqTO1
         alNol85X8x723aVayLU7ap41A1DltKjQLJzMsoj6jbVlewo8sfUHEh8pIkr1QxGISkqZ
         XpsaS7mYwNti+g3H2tW4NIXvfOG4cJ6t0MYH9UOv6PatCzeqSyMwRSfjmld0FcgT9wBI
         1CEiJPvPJS/GUeUYuGlKhMSQqmQMsUC3aDFImvTOsmMbM/OkAns+sD1WqYQE+V73fCBK
         xGLg==
X-Gm-Message-State: AOAM531EN91yPYu3Ge3OwkqbVn+8U/BhTEgL4EmxAtSqfN1llrzTymsy
        xN2hd0EMKhgFIQ51yQZ1opTMbHRMSxOhBS6Oqys=
X-Google-Smtp-Source: ABdhPJxovCtlSMnpEFJdBL/jW4/thTU8DbyyAPfP5PU7Kt7r9Du5zFLiXcc0o8/d7TlOFxm55DH2WeI/duFLrt272gw=
X-Received: by 2002:a05:6808:292:: with SMTP id z18mr4171890oic.61.1633382584199;
 Mon, 04 Oct 2021 14:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
 <YPoNgcLgJY/POS4u@boqun-archlinux> <20210723034928.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <CAOzhvcOLFzFGZAptOTrP9Xne1-LiO8jka1sPF6+0=WiLh-cQUA@mail.gmail.com>
 <20210723172512.GH4397@paulmck-ThinkPad-P17-Gen-1> <CAOzhvcMaTsJTS3y1FVtSOpXfG8EecYp8bKOQ0KOjCOKYJ-UerA@mail.gmail.com>
 <20210723190614.GJ4397@paulmck-ThinkPad-P17-Gen-1> <CAOzhvcMwTzHSbrkPv9DXVAdUcddHEJazz_6p6tzXiJht43RMYg@mail.gmail.com>
 <20210725004823.GN4397@paulmck-ThinkPad-P17-Gen-1> <CAOzhvcMcMY057uJNM9oMsKJubSpQ_yKwHtVEpJkATqumkNebXQ@mail.gmail.com>
 <20210728001010.GF4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210728001010.GF4397@paulmck-ThinkPad-P17-Gen-1>
From:   donghai qiao <donghai.w.qiao@gmail.com>
Date:   Mon, 4 Oct 2021 17:22:52 -0400
Message-ID: <CAOzhvcO3a-GiipELoztmGWOmABuSC=b5vcBu8bC_Q-aT=Fe5ng@mail.gmail.com>
Subject: Re: RCU: rcu stall issues and an approach to the fix
To:     paulmck@kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Paul,
Sorry it has been long..
> > Because I am dealing with this issue in multiple kernel versions, sometimes
> > the configurations in these kernels may different. Initially the
> > problem I described
> > originated to rhel-8 on which the problem occurs more often and is a bit easier
> > to reproduce than others.
>
> Understood, that does make things more difficult.
>
> > Regarding these dynticks* parameters, I collected the data for CPU 0 as below :
> >    - dynticks = 0x6eab02    which indicated the CPU was not in eqs.
> >    - dynticks_nesting = 1    which is in its initial state, so it said
> > it was not in eqs either.
> >    - dynticks_nmi_nesting = 4000000000000004    which meant that this
> > CPU had been
> >      interrupted when it was in the middle of the first interrupt.
> > And this is true: the first
> >      interrupt was the sched_timer interrupt, and the second was a NMI
> > when another
> >     CPU detected the RCU stall on CPU 0.  So it looks all identical.
> > If the kernel missed
> >     a rcu_user_enter or rcu_user_exit, would these items remain
> > identical ?  But I'll
> >     investigate that possibility seriously as you pointed out.
>
> So is the initial state non-eqs because it was interrupted from kernel
> mode?  Or because a missing rcu_user_enter() left ->dynticks_nesting
> incorrectly equal to the value of 1?  Or something else?

As far as the original problem is concerned, the user thread was interrupted by
the timer, so the CPU was not working in the nohz mode. But I saw the similar
problems on CPUs working in nohz mode with different configurations.

>
> > > There were some issues of this sort around the v5.8 timeframe.  Might
> > > there be another patch that needs to be backported?  Or a patch that
> > > was backported, but should not have been?
> >
> > Good to know that clue. I'll take a look into the log history.
> >
> > > Is it possible to bisect this?
> > >
> > > Or, again, to run with CONFIG_RCU_EQS_DEBUG=y?
> >
> > I am building the latest 5.14 kernel with this config and give it a try when the
> > machine is set up, see how much it can help.
>
> Very good, as that will help determine whether or not the problem is
> due to backporting issues.

I enabled CONFIG_RCU_EQS_DEBUG=y as you suggested and
tried it for both the latest rhel8 and a later upstream version 5.15.0-r1,
turns out no new warning messages related to this came out. So,
rcu_user_enter/rcu_user_exit() should be paired right.

>
> > > Either way, what should happen is that dyntick_save_progress_counter() or
> > > rcu_implicit_dynticks_qs() should see the rdp->dynticks field indicating
> > > nohz_full user execution, and then the quiescent state will be supplied
> > > on behalf of that CPU.
> >
> > Agreed. But the counter rdp->dynticks of the CPU can only be updated
> > by rcu_dynticks_eqs_enter() or rcu_dynticks_exit() when rcu_eqs_enter()
> > or rcu_eqs_exit() is called, which in turn depends on the context switch.
> > So, when the context switch never happens, the counter rdp->dynticks
> > never advances. That's the thing I try to fix here.
>
> First, understand the problem.  Otherwise, your fix is not so likely
> to actually fix anything.  ;-)
>
> If kernel mode was interrupted, there is probably a missing cond_resched().
> But in sufficiently old kernels, cond_resched() doesn't do anything for
> RCU unless a context switch actually happened.  In some of those kernels,
> you can use cond_resched_rcu_qs() instead to get RCU's attention.  In
> really old kernels, life is hard and you will need to do some backporting.
> Or move to newer kernels.
>
> In short, if an in-kernel code path runs for long enough without hitting
> a cond_resched() or similar, that is a bug.  The RCU CPU stall warning
> that you will get is your diagnostic.

Probably this is the case. With the test for 5.15.0-r1, I have seen different
scenarios, among them the most frequent ones were caused by the networking
in which a bunch of networking threads were spinning on the same rwlock.

For instance in one of them, the ticks_this_gp of a rcu_data could go as
large as 12166 (ticks) which is 12+ seconds. The thread on this cpu was
doing networking work and finally it was spinning as a writer on a rwlock
which had been locked by 16 readers.  By the way, there were 70 this
kinds of writers were blocked on the same rwlock.

When examining the readers of the lock, except the following code,
don't see any other obvious problems: e.g
 #5 [ffffad3987254df8] __sock_queue_rcv_skb at ffffffffa49cd2ee
 #6 [ffffad3987254e18] raw_rcv at ffffffffa4ac75c8
 #7 [ffffad3987254e38] raw_local_deliver at ffffffffa4ac7819
 #8 [ffffad3987254e88] ip_protocol_deliver_rcu at ffffffffa4a8dea4
 #9 [ffffad3987254ea8] ip_local_deliver_finish at ffffffffa4a8e074
#10 [ffffad3987254eb0] __netif_receive_skb_one_core at ffffffffa49f3057
#11 [ffffad3987254ed0] process_backlog at ffffffffa49f3278
#12 [ffffad3987254f08] __napi_poll at ffffffffa49f2aba
#13 [ffffad3987254f30] net_rx_action at ffffffffa49f2f33
#14 [ffffad3987254fa0] __softirqentry_text_start at ffffffffa50000d0
#15 [ffffad3987254ff0] do_softirq at ffffffffa40e12f6

In the function ip_local_deliver_finish() of this stack, a lot of the work needs
to be done with ip_protocol_deliver_rcu(). But this function is invoked from
a rcu reader side section.

static int ip_local_deliver_finish(struct net *net, struct sock *sk,
struct sk_buff *skb)
{
        __skb_pull(skb, skb_network_header_len(skb));

        rcu_read_lock();
        ip_protocol_deliver_rcu(net, skb, ip_hdr(skb)->protocol);
        rcu_read_unlock();

        return 0;
}

Actually there are multiple chances that this code path can hit
spinning locks starting from ip_protocol_deliver_rcu(). This kind
usage looks not quite right. But I'd like to know your opinion on this first ?

Thanks
Donghai
