Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD560C433EF
	for <rcu@archiver.kernel.org>; Wed,  1 Jun 2022 20:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiFAU5H (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiFAU5F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Jun 2022 16:57:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04385D657
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 13:56:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d129so2949023pgc.9
        for <rcu@vger.kernel.org>; Wed, 01 Jun 2022 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uQGLjfrCmc8Yn+ZcXfZinn8kRW2SmrFNw1OOME1c1Q=;
        b=FTUvxM5eJ/WiQeFXFOScRa7kAHgueswmpAevaWO5QRtB2fs652Mi9/CkGM9Xb+NEKs
         fbLEVx2I5QHCcmBN+YdofQAwF3QzDzJjZ6fng/RdZgnxx98vuCuAsd/BRUn3AObx5ocV
         Rl6+nLo8cdcvkQYruu7X3w9dKX5GmYYnjXNKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uQGLjfrCmc8Yn+ZcXfZinn8kRW2SmrFNw1OOME1c1Q=;
        b=srof9TcDz2jGnalC3tHNKH9TE0yxecqLgLy+m7JHBBukoCBXjIxyQQZDKtfsZoQKcd
         GBSmTaG+loXoJ8yI0bEkx4Px/Fr+J+yhmA0z+F4lWmi2RioLPhnmEVgBTl+qAW1dtDef
         nlH0zWAyBtiTeGOq6K0WHfUFECyQ6O+U4M/sZkbgt0GfeXHWmvQiOHFwo4oetTAnt1zz
         gxY/ueOppzci8kZMnRoLyrYT4fISdoE9uLtokCGLfh+ZN6NSH1GL42jFYUJNdAK27Y+8
         +94csTVa2cbBMag2aKcYiicPur1/P9MTU8unKrvEwHRhqjm5eFpCCVFz0PHn9AbQVDwJ
         izUw==
X-Gm-Message-State: AOAM530JfnhZOqpiZBvPQCBVPnEEljbpu1s3lEFDXHPDnXP45syafhrh
        mSXM0jS8fONzvGHr1uTvCRxAYkcopc/BVkd7PN3rkfiJrd0Fjw==
X-Google-Smtp-Source: ABdhPJzJLiJEQRP7nl/0HIaZv1Sg6hQfamYBAfxtREMNxsVVb+UbpC9zrOGIMrC1DcdZFEaB6r8NcQujm8ADsd9k1qg=
X-Received: by 2002:a92:ddcb:0:b0:2cd:95b6:bede with SMTP id
 d11-20020a92ddcb000000b002cd95b6bedemr950963ilr.280.1654110595839; Wed, 01
 Jun 2022 12:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org> <20220512235603.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220601142454.GB1288128@lothringen>
In-Reply-To: <20220601142454.GB1288128@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 1 Jun 2022 15:09:44 -0400
Message-ID: <CAEXW_YQc8DfgbF3SDGbaT9tzuv5jebpdqtiS6J-b_dAcn7Ww+g@mail.gmail.com>
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Fred,

On Wed, Jun 1, 2022 at 10:24 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Thu, May 12, 2022 at 04:56:03PM -0700, Paul E. McKenney wrote:
> > On Thu, May 12, 2022 at 03:04:29AM +0000, Joel Fernandes (Google) wrote:
> > > +   preempt_enable();
> > > +
> > > +   if (debug_rcu_head_queue((void *)head)) {
> > > +           // Probable double call_rcu(), just leak.
> > > +           WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > > +                           __func__, head);
> > > +
> > > +           // Mark as success and leave.
> > > +           return;
> > > +   }
> > > +
> > > +   // Queue to per-cpu llist
> > > +   head->func = func;
> > > +   llist_add(&head->llist_node, &rlp->head);
> >
> > Suppose that there are a bunch of preemptions between the preempt_enable()
> > above and this point, so that the current CPU's list has lots of
> > callbacks, but zero ->count.  Can that cause a problem?
> >
> > In the past, this sort of thing has been an issue for rcu_barrier()
> > and friends.
>
> Speaking of, shouldn't rcu_barrier() flush all the lazy queues? I
> might have missed that somewhere in the patchset though.

Yes, it should. This initial prototype did not handle it and was
mentioned in one of the replies to the cover letter. However, in the
v2 of this, I am planning to use Paul's idea of sticking these in the
bypass list. It simplifies a lot of things which bypass handles
(hotplug, rcu_barrier, de-offload, etc).

Thanks,

 - Joel
