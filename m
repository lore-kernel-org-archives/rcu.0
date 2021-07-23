Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6352C4320A
	for <rcu@archiver.kernel.org>; Fri, 23 Jul 2021 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7CC60EB5
	for <rcu@archiver.kernel.org>; Fri, 23 Jul 2021 17:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhGWQpL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhGWQpL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Jul 2021 12:45:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8836C061575
        for <rcu@vger.kernel.org>; Fri, 23 Jul 2021 10:25:43 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso2704902otb.10
        for <rcu@vger.kernel.org>; Fri, 23 Jul 2021 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvGVFcnVz1CqKKHS1eRLnSXFPhMt2CAbc4sAuPLNV0w=;
        b=RLfbJSyfH8bJmoFdwSeZd5Mz/XcpbABAWHhatTVxNJxGPYxi3uqmOeyRffinwA7q92
         UX1yJipAgHRmsjAFk36Vo+dG4jUawBaBF+4vn5jHb9udu9/jix8rCcBl72abYLvuCPqN
         fcpFpBQyCeYwuLlOgKhHYDxj9ea8ufdVEQYsbP09Fwruc2Phdr2ediSzrBGnepnt6+sb
         LgOQEdshGferKf4disfgtlOb1MS8mCUrTnzOSHrDlBern007AJwLpZl8W/O+1qBKSukE
         5mVvDx5kOjVwyd4dwyUR2pUZsAOK8k8yWK4po8Hie3vQP3lP8UZYTKMKyz8dKWDm9bch
         7y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvGVFcnVz1CqKKHS1eRLnSXFPhMt2CAbc4sAuPLNV0w=;
        b=B5p2mOAe3jMIxj/v2HZmJTHniA/hx9MyoTOq0wxgjPdX1KF6aHZnuYUc01GauNLPQT
         7u36HBDiooQr26fjvSm1tjzQogUw/Uwwav0EMGzT5w/RXwpyETAYjnO2oEzyT1Nbcqm8
         YjZmgpEyZo7opwphOvDySUexMsn1EWnk2j2ezJrax99DJMDUffaIuW9G2mOXdsGBxY/P
         UOAn9LYAK4p4kI0wPBZm05OXlgocQ+dZlNshvYWnspO1tuTzAlHJfoQDEC0Ozp4ZcDso
         KzyzFBrOvoNNy3fVLueUWK1RAiUelGwoezFqG73QCeuc87NHISwzBNsDluhXIQsUYxFB
         S07A==
X-Gm-Message-State: AOAM532rmCJKSbQQJ0kKvEapX9S71dfWMjnn66W/5F5/o8KbWowKkA9H
        Ctvql4vDXwBGSDkrTvlgmlkCjVqWPoYzcY6vPLM=
X-Google-Smtp-Source: ABdhPJzgt8qVWhP38Ux4GqKqMKB2BAWfT6tb7fICl0HwZhOHkcqNkoSPRKV939L+1mYkG8pH1rkVVBnhCbhMcg3nG/I=
X-Received: by 2002:a9d:1c8a:: with SMTP id l10mr3783146ota.100.1627061143217;
 Fri, 23 Jul 2021 10:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
 <YPoNgcLgJY/POS4u@boqun-archlinux> <20210723034928.GE4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210723034928.GE4397@paulmck-ThinkPad-P17-Gen-1>
From:   donghai qiao <donghai.w.qiao@gmail.com>
Date:   Fri, 23 Jul 2021 13:25:32 -0400
Message-ID: <CAOzhvcM6bBRR7A5pb5iU5H7uBPbZ4rQz67iPn7NwFNjheFKG7w@mail.gmail.com>
Subject: Re: RCU: rcu stall issues and an approach to the fix
To:     paulmck@kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 22, 2021 at 11:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Jul 23, 2021 at 08:29:53AM +0800, Boqun Feng wrote:
> > On Thu, Jul 22, 2021 at 04:08:06PM -0400, donghai qiao wrote:
> > > RCU experts,
> > >
> > > When you reply, please also keep me CC'ed.
> > >
> > > The problem of RCU stall might be an old problem and it can happen quite often.
> > > As I have observed, when the problem occurs,  at least one CPU in the system
> > > on which its rdp->gp_seq falls behind others by 4 (qs).
> > >
> > > e.g.  On CPU 0, rdp->gp_seq = 0x13889d, but on other CPUs, their
> > > rdp->gp_seq = 0x1388a1.
> > >
> > > Because RCU stall issues can last a long period of time, the number of callbacks
> > > in the list rdp->cblist of all CPUs can accumulate to thousands. In
> > > the worst case,
> > > it triggers panic.
> > >
> > > When looking into the problem further, I'd think the problem is related to the
> > > Linux scheduler. When the RCU core detects the stall on a CPU, rcu_gp_kthread
> > > would send a rescheduling request via send_IPI to that CPU to try to force a
> > > context switch to make some progress. However, at least one situation can fail
> > > this effort, which is when the CPU is running a user thread and it is the only
> > > user thread in the rq, then this attempted context switching will not happen
> > > immediately. In particular if the system is also configured with NOHZ_FULL for
> >
> > Correct me if I'm wrong, if a CPU is solely running a user thread, how
> > can that CPU stall RCU? Because you need to be in a RCU read-side
> > critical section to stall RCU. Or the problem you're talking here is
> > about *recovering* from RCU stall?

In response to Boqun's question, the crashdumps I analyzed were
configured with this :

CONFIG_PREEMPT_RCU=n
CONFIG_PREEMPT_COUNT=n
CONFIG_PROVE_RCU=n

Because these configurations were not enabled, the compiler generated
empty binary code for functions rcu_read_lock() and rcu_read_unlock()
which delimit rcu read-side critical sections. And the crashdump
showed both functions have no binary code in the kernel module and I
am pretty sure.  In the first place I thought this kernel might be
built the wrong way,
but later I found other sources that said this was ok.  That's why
when CPUs enter or leave rcu critical section, the rcu core
is not informed.

When the current grace period is closed, rcu_gp_kthread will open a
new period for all. This will be reflected from every
CPU's rdp->gp_seq. Every CPU is responsible to update its own gp when
a progress is made. So when a cpu is running
a user thread whilst a new period is open, it can not update its rcu
unless a context switch occurs or upon a sched tick.
But if a CPU is configured as NOHZ, this will be a problem to RCU, so
rcu stall will happen.

When RCU detects that qs is stalled on a CPU, it tries to force a
context switch to make progress on that CPU. This is
done through a resched IPI. But this can not always succeed depending
on the scheduler.   A while ago, this code
process the resched IPI:

void scheduler_ipi(void)
{
        ...
        if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
                return;
        ...
        irq_enter();
        sched_ttwu_pending();
        ...
        if (unlikely(got_nohz_idle_kick())) {
                this_rq()->idle_balance = 1;
                raise_softirq_irqoff(SCHED_SOFTIRQ);
        }
        irq_exit();
}

As you can see the function returns from the first "if statement"
before it can issue a SCHED_SOFTIRQ. Later this
code has been changed, but similar check/optimization remains in many
places in the scheduler. The things I try to
fix are those that resched_cpu fails to do.

Hope this explains it.

>
> Excellent point, Boqun!
>
> Donghai, have you tried reproducing this using a kernel built with
> CONFIG_RCU_EQS_DEBUG=y?

I haven't tried it. I can do it and update you with the results when I am done.

Thanks!
Donghai

>
>                                                         Thanx, Paul
>
> > Regards,
> > Boqun
