Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0685C433FE
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 18:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiK3SuZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiK3SuT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Nov 2022 13:50:19 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC79D802
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 10:50:18 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l127so19761404oia.8
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 10:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vRCw5HgdZ6+i+5rxJnQV5DsJbEr03vS+VFP709b7Mj0=;
        b=Fj7wpBqfoKfCWqoddByeKCliiIhXWseC/prDubeJZMHCNycQ02GhMtCAVmR9tcFjFj
         DfBiUniDNdOT01JiTghH+KQH04DHEJeuVOsDZEQT+Yg17EVcIlDdDcHWVQZFvMcW6Ikn
         SBXzsr3nawMrT0TrxZz9eHu4IhIqN5adlS11Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRCw5HgdZ6+i+5rxJnQV5DsJbEr03vS+VFP709b7Mj0=;
        b=GOqSGDzMOppOKCBhgF0xrQxKssibXvBlsiiDxFAp45OMtIiHrLvQ5zCH9HJRHapeEx
         wvin9kztSRrcI0dtlfJGVOHeUJcdr8PjupDD7JawTKRTNzpOXI4QMPEMJX8MPIYMlShO
         9jW9Ok1mtoESr4KsxBmjkdYzS43a+ft7Kg/Tq8UQWzW5YqB613ohtF0dk42jOhIuX8Dx
         UkgZUyQgsSlWFR6pVe0TZaVLEGb3S+WnZ2CK16xWFFuUf4qe5Y1j/kpLrvt+q6+ZBPq3
         wFegxIjm9AqJK1KMHBCWVt3fNjhLfFf3Arafb7z1rugY5tQlFwmHLvpbGSpWoYyIwbo9
         eYMQ==
X-Gm-Message-State: ANoB5pmAePe0KmpTBl+L+2wIS1CslB0UrY+GJQbStJqbQCfmUXAcgxQm
        m1vJPfY4t92tMSJdAnuqUNrArtRLPlbX0DcMicShJw==
X-Google-Smtp-Source: AA0mqf5zZ4OhgadIuAOlhIl42LnTHrlqOZnhhcAxa8Ejt2e76YOhwQv/ANm9w6iLKjI4GT6DPpyBAu9Bn2JOnMBXBBg=
X-Received: by 2002:a05:6808:46:b0:35a:ff1:bf0d with SMTP id
 v6-20020a056808004600b0035a0ff1bf0dmr22785001oic.115.1669834217790; Wed, 30
 Nov 2022 10:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
 <20221130181325.1012760-15-paulmck@kernel.org> <CAEXW_YQci19yD5wr2jyYi4wdNZ_CrZuGJ==jF9MObOzWg7f=_Q@mail.gmail.com>
 <CANn89iKifFXDpF8sZXd+rXPhF+3ajVLTuEj6n2Z4H9f27_K0kA@mail.gmail.com>
In-Reply-To: <CANn89iKifFXDpF8sZXd+rXPhF+3ajVLTuEj6n2Z4H9f27_K0kA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Nov 2022 18:50:06 +0000
Message-ID: <CAEXW_YTY4mD7z6y_vtQATCzPwe3_VmRxJNipsSo6GmwQa20e8g@mail.gmail.com>
Subject: Re: [PATCH rcu 15/16] net: Use call_rcu_hurry() for dst_release()
To:     Eric Dumazet <edumazet@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Eric,

On Wed, Nov 30, 2022 at 6:39 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Sure, thanks.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> I think we can work later to change how dst are freed/released to
> avoid using call_rcu_hurry()

That sounds great, if you can give me any high-level guidance (in the
future) on that and what to look for, I can give it a try as well. I
have been wanting to learn more about the networking code :-)

Thanks,

 - Joel


> On Wed, Nov 30, 2022 at 7:17 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hi Eric,
> >
> > Could you give your ACK for this patch for this one as well? This is
> > the other networking one.
> >
> > The networking testing passed on ChromeOS and it has been in -next for
> > some time so has gotten testing there. The CONFIG option is default
> > disabled.
> >
> > Thanks a lot,
> >
> > - Joel
> >
> > On Wed, Nov 30, 2022 at 6:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > >
> > > In a networking test on ChromeOS, kernels built with the new
> > > CONFIG_RCU_LAZY=y Kconfig option fail a networking test in the teardown
> > > phase.
> > >
> > > This failure may be reproduced as follows: ip netns del <name>
> > >
> > > The CONFIG_RCU_LAZY=y Kconfig option was introduced by earlier commits
> > > in this series for the benefit of certain battery-powered systems.
> > > This Kconfig option causes call_rcu() to delay its callbacks in order
> > > to batch them.  This means that a given RCU grace period covers more
> > > callbacks, thus reducing the number of grace periods, in turn reducing
> > > the amount of energy consumed, which increases battery lifetime which
> > > can be a very good thing.  This is not a subtle effect: In some important
> > > use cases, the battery lifetime is increased by more than 10%.
> > >
> > > This CONFIG_RCU_LAZY=y option is available only for CPUs that offload
> > > callbacks, for example, CPUs mentioned in the rcu_nocbs kernel boot
> > > parameter passed to kernels built with CONFIG_RCU_NOCB_CPU=y.
> > >
> > > Delaying callbacks is normally not a problem because most callbacks do
> > > nothing but free memory.  If the system is short on memory, a shrinker
> > > will kick all currently queued lazy callbacks out of their laziness,
> > > thus freeing their memory in short order.  Similarly, the rcu_barrier()
> > > function, which blocks until all currently queued callbacks are invoked,
> > > will also kick lazy callbacks, thus enabling rcu_barrier() to complete
> > > in a timely manner.
> > >
> > > However, there are some cases where laziness is not a good option.
> > > For example, synchronize_rcu() invokes call_rcu(), and blocks until
> > > the newly queued callback is invoked.  It would not be a good for
> > > synchronize_rcu() to block for ten seconds, even on an idle system.
> > > Therefore, synchronize_rcu() invokes call_rcu_hurry() instead of
> > > call_rcu().  The arrival of a non-lazy call_rcu_hurry() callback on a
> > > given CPU kicks any lazy callbacks that might be already queued on that
> > > CPU.  After all, if there is going to be a grace period, all callbacks
> > > might as well get full benefit from it.
> > >
> > > Yes, this could be done the other way around by creating a
> > > call_rcu_lazy(), but earlier experience with this approach and
> > > feedback at the 2022 Linux Plumbers Conference shifted the approach
> > > to call_rcu() being lazy with call_rcu_hurry() for the few places
> > > where laziness is inappropriate.
> > >
> > > Returning to the test failure, use of ftrace showed that this failure
> > > cause caused by the aadded delays due to this new lazy behavior of
> > > call_rcu() in kernels built with CONFIG_RCU_LAZY=y.
> > >
> > > Therefore, make dst_release() use call_rcu_hurry() in order to revert
> > > to the old test-failure-free behavior.
> > >
> > > [ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Cc: David Ahern <dsahern@kernel.org>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Eric Dumazet <edumazet@google.com>
> > > Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > Cc: <netdev@vger.kernel.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  net/core/dst.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/dst.c b/net/core/dst.c
> > > index bc9c9be4e0801..a4e738d321ba2 100644
> > > --- a/net/core/dst.c
> > > +++ b/net/core/dst.c
> > > @@ -174,7 +174,7 @@ void dst_release(struct dst_entry *dst)
> > >                         net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
> > >                                              __func__, dst, newrefcnt);
> > >                 if (!newrefcnt)
> > > -                       call_rcu(&dst->rcu_head, dst_destroy_rcu);
> > > +                       call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
> > >         }
> > >  }
> > >  EXPORT_SYMBOL(dst_release);
> > > --
> > > 2.31.1.189.g2e36527f23
> > >
