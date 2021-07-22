Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3167C4338F
	for <rcu@archiver.kernel.org>; Thu, 22 Jul 2021 20:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5E860EB5
	for <rcu@archiver.kernel.org>; Thu, 22 Jul 2021 20:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhGVT1o (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Jul 2021 15:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhGVT1n (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Jul 2021 15:27:43 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D977C061575
        for <rcu@vger.kernel.org>; Thu, 22 Jul 2021 13:08:18 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id x16-20020a4aea100000b0290263aab95660so1589150ood.13
        for <rcu@vger.kernel.org>; Thu, 22 Jul 2021 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vR34w30jvP3dUkVmH3WoVnUNRQ611+xNSh8QyCyp1FY=;
        b=dYHEtVHvSFurDe9tsdA0Igh8CFaLRXR+Lv473iPL0UvJFhwxrrQtPenpmPYfnmoH7j
         iIpIzDo/3A9QBkwufdjS5kqkUjtEhTrPe4d5zk5imQn7dY2XD33VbBZb+j/k//JL28xC
         JY+XA9M6R7Tu+zVONrglvVCKbVllnsUxiq4PeZX2Mm7WPWZHBdQoHu4XPYe4uQ088KlJ
         MdKO4O55ySjjHflQQ4l2j9o3dvmlB+OAJDBq0EJbhpCAhhjNkSBSIsIbiSmJiC6cn5VP
         EHpO59b5KorCrgviqrOdD1Hup6z9P0N+A6RNa9NzJHXkyg4ELfKOkxAEh/HT4uwj3KTz
         trvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vR34w30jvP3dUkVmH3WoVnUNRQ611+xNSh8QyCyp1FY=;
        b=fv/dQE2p55t7hG3kxUDhDL6m6/IKa9LbmCR6ST9UauaTDGIA9LH0BykeJFPNun5KeU
         CCyvAk32A8MWxWvIPSZ8Tq/oeLA4M6N98Vr1KQBKsQ+9AL/t1oAxvGvU2VsDvBPlNpyZ
         yqwqqpejukldk9d1y59E1W2I0UO9hj/oX/bMFCHs0TOk4J1Fvh+b/gLNKy3T4bKszAzN
         Gqe+9O9XLpAY0C27c1ej9NX1y5d9uipzt2vVZFfSIgSs41GiCbscMFRCpS4Pfe3kImQV
         hby6+/E99fn5jTE+qLFDR1xeNRvO3h/SdUBTPZB9MJ7eCTseuxC3OW/VSly7LElw1Kwj
         PEAg==
X-Gm-Message-State: AOAM533V+rJiSET8baMvOQLe9jfD9biwWgG/FQJMC1fzPPIVe31GOnre
        QY9b95LMn+kEjgZU41f0mjY7gXOqIuhBmRFypwRdApoYelZ6gA==
X-Google-Smtp-Source: ABdhPJzx2GKplZpigWcrXe3vPYcI9zN/w21L3s2v7MOJ2yp2nhgYpLXcs52npTZPIkF+PJs9HvEzmPckQBIQbWR+l20=
X-Received: by 2002:a4a:6b12:: with SMTP id g18mr736712ooc.27.1626984497559;
 Thu, 22 Jul 2021 13:08:17 -0700 (PDT)
MIME-Version: 1.0
From:   donghai qiao <donghai.w.qiao@gmail.com>
Date:   Thu, 22 Jul 2021 16:08:06 -0400
Message-ID: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
Subject: RCU: rcu stall issues and an approach to the fix
To:     rcu@vger.kernel.org, donghai qiao <donghai.w.qiao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU experts,

When you reply, please also keep me CC'ed.

The problem of RCU stall might be an old problem and it can happen quite often.
As I have observed, when the problem occurs,  at least one CPU in the system
on which its rdp->gp_seq falls behind others by 4 (qs).

e.g.  On CPU 0, rdp->gp_seq = 0x13889d, but on other CPUs, their
rdp->gp_seq = 0x1388a1.

Because RCU stall issues can last a long period of time, the number of callbacks
in the list rdp->cblist of all CPUs can accumulate to thousands. In
the worst case,
it triggers panic.

When looking into the problem further, I'd think the problem is related to the
Linux scheduler. When the RCU core detects the stall on a CPU, rcu_gp_kthread
would send a rescheduling request via send_IPI to that CPU to try to force a
context switch to make some progress. However, at least one situation can fail
this effort, which is when the CPU is running a user thread and it is the only
user thread in the rq, then this attempted context switching will not happen
immediately. In particular if the system is also configured with NOHZ_FULL for
the CPU and as long as the user thread is running, the forced context
switch will
never happen unless the user thread volunteers to yield the CPU. I think this
should be one of the major root causes of these RCU stall issues. Even if
NOHZ_FULL is not configured, there will be at least 1 tick delay which can
affect the realtime kernel, by the way.

But it seems not a good idea to craft a fix from the scheduler side because
this has to invalidate some existing scheduling optimizations. The current
scheduler is deliberately optimized to avoid such context switching.  So my
question is why the RCU core cannot effectively update qs for the stalled CPU
when it detects that the stalled CPU is running a user thread?  The reason
is pretty obvious because when a CPU is running a user thread, it must not
be in any kernel read-side critical sections. So it should be safe to close
its current RCU grace period on this CPU. Also, with this approach we can make
RCU work more efficiently than the approach of context switch which needs to
go through an IPI interrupt and the destination CPU needs to wake up its
ksoftirqd or wait for the next scheduling cycle.

If my suggested approach makes sense, I can go ahead to fix it that way.

Thanks
Donghai
