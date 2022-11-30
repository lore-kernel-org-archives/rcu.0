Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A32FC433FE
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 18:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiK3ShZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiK3ShV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Nov 2022 13:37:21 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3617293A6A
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 10:37:19 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id z192so22752228yba.0
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 10:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TWoxc95kHVoWpknIf60loTlL+l1uOQrqfMxpVoQ4FLs=;
        b=iaHBSo+r2xkjuhr+NuKX+d2/hf3C02PYqzGrInu0/GPH8YyqqkmULsnTv3tLxAf6Uh
         1mdELNX4DGfaJfOiH0/jJMvycGAo+2YhREt8mD+LJRVuqzH3dP699+Ru+XH+n45XLHFp
         WYCFXm7h+OH+aFWfYY6/RRL6a9H/1fHyn3cdHWATNwQW8uOqDUkmiLH8bZv7cQV2+IVp
         nG8oqZeCEfu8WlvnLXmjG3IJIXHVAv1mwbrZOdy6Dn1OfA8GI1M7xAYnmaWYAOctMokT
         wdHcnLjgcJiKwyFZ532P1PRW5h91fgnH1j8Fs4t4CMQNOFDQ0G4ladLkjhzuumA85S3N
         8saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWoxc95kHVoWpknIf60loTlL+l1uOQrqfMxpVoQ4FLs=;
        b=3FRN9WOOtkCypc2vIxpgwtZG9liL9x6ziUiPceVmKyBiwpzNkTL8rBgV6BTSSmJj87
         aJkQZp29xlFM/5hO8ouR53rzrMn6DDKFMXrnIlacELHGqy3ymObG0AeJVlGir8lIWcCJ
         BHEq1fnthEYJsvbfuoWnVMmJ2CwxhnxD6A/dvLq8quAydg4z90c5znU7V28H1F3qXF39
         CKJ5h8DIwUxWBNNfAZ2v9WYWx3WaH4/Dm8CGbXABavB1HatH+5lZ/I3l3rmqtaaOEzMY
         5MOV3a4T/U+Co6yV5WR7FcTu7nJsRbmZRdthEa9MkbMs9fZhVAcljLpO+cWfqd7lgnGK
         LlyQ==
X-Gm-Message-State: ANoB5pmN0zS3eauuftLbV5O44L2ZYAn3qCl7DhmrNbHrftM9CBdiCBEv
        fKtPshc2Y28qFmLLCu6uN20XpPWRz4m59AWCB0ts3g==
X-Google-Smtp-Source: AA0mqf4iZNHFMjbgFG7zxWiMq6N47O8g3eVoFht3chBI8xB71HwD1QbTghC2XzNBwWwrbV8U39770Cce+bPKjJbsYuQ=
X-Received: by 2002:a25:2546:0:b0:6f0:b332:f35e with SMTP id
 l67-20020a252546000000b006f0b332f35emr33717018ybl.55.1669833438126; Wed, 30
 Nov 2022 10:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
 <20221130181325.1012760-14-paulmck@kernel.org> <CAEXW_YS1nfsV_ohXDaB1i2em=+0KP1DofktS24oGFa4wPAbiiw@mail.gmail.com>
In-Reply-To: <CAEXW_YS1nfsV_ohXDaB1i2em=+0KP1DofktS24oGFa4wPAbiiw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 30 Nov 2022 19:37:07 +0100
Message-ID: <CANn89iKg-Ka96yGFHCUWXtug494eO5i2KU_c8GTPNXDi6mWpYg@mail.gmail.com>
Subject: Re: [PATCH rcu 14/16] rxrpc: Use call_rcu_hurry() instead of call_rcu()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Ah, I see a slightly better name has been chosen ;)

Reviewed-by: Eric Dumazet <edumazet@google.com>

On Wed, Nov 30, 2022 at 7:16 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Eric,
>
> Could you give your ACK for this patch?
>
> The networking testing passed on ChromeOS and it has been in -next for
> some time so has gotten testing there. The CONFIG option is default
> disabled.
>
> Thanks a lot,
>
> - Joel
>
> On Wed, Nov 30, 2022 at 6:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> >
> > Earlier commits in this series allow battery-powered systems to build
> > their kernels with the default-disabled CONFIG_RCU_LAZY=y Kconfig option.
> > This Kconfig option causes call_rcu() to delay its callbacks in order
> > to batch them.  This means that a given RCU grace period covers more
> > callbacks, thus reducing the number of grace periods, in turn reducing
> > the amount of energy consumed, which increases battery lifetime which
> > can be a very good thing.  This is not a subtle effect: In some important
> > use cases, the battery lifetime is increased by more than 10%.
> >
> > This CONFIG_RCU_LAZY=y option is available only for CPUs that offload
> > callbacks, for example, CPUs mentioned in the rcu_nocbs kernel boot
> > parameter passed to kernels built with CONFIG_RCU_NOCB_CPU=y.
> >
> > Delaying callbacks is normally not a problem because most callbacks do
> > nothing but free memory.  If the system is short on memory, a shrinker
> > will kick all currently queued lazy callbacks out of their laziness,
> > thus freeing their memory in short order.  Similarly, the rcu_barrier()
> > function, which blocks until all currently queued callbacks are invoked,
> > will also kick lazy callbacks, thus enabling rcu_barrier() to complete
> > in a timely manner.
> >
> > However, there are some cases where laziness is not a good option.
> > For example, synchronize_rcu() invokes call_rcu(), and blocks until
> > the newly queued callback is invoked.  It would not be a good for
> > synchronize_rcu() to block for ten seconds, even on an idle system.
> > Therefore, synchronize_rcu() invokes call_rcu_hurry() instead of
> > call_rcu().  The arrival of a non-lazy call_rcu_hurry() callback on a
> > given CPU kicks any lazy callbacks that might be already queued on that
> > CPU.  After all, if there is going to be a grace period, all callbacks
> > might as well get full benefit from it.
> >
> > Yes, this could be done the other way around by creating a
> > call_rcu_lazy(), but earlier experience with this approach and
> > feedback at the 2022 Linux Plumbers Conference shifted the approach
> > to call_rcu() being lazy with call_rcu_hurry() for the few places
> > where laziness is inappropriate.
> >
> > And another call_rcu() instance that cannot be lazy is the one
> > in rxrpc_kill_connection(), which sometimes does a wakeup
> > that should not be unduly delayed.
> >
> > Therefore, make rxrpc_kill_connection() use call_rcu_hurry() in order
> > to revert to the old behavior.
> >
> > [ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Marc Dionne <marc.dionne@auristor.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: <linux-afs@lists.infradead.org>
> > Cc: <netdev@vger.kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  net/rxrpc/conn_object.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
> > index 22089e37e97f0..9c5fae9ca106c 100644
> > --- a/net/rxrpc/conn_object.c
> > +++ b/net/rxrpc/conn_object.c
> > @@ -253,7 +253,7 @@ void rxrpc_kill_connection(struct rxrpc_connection *conn)
> >          * must carry a ref on the connection to prevent us getting here whilst
> >          * it is queued or running.
> >          */
> > -       call_rcu(&conn->rcu, rxrpc_destroy_connection);
> > +       call_rcu_hurry(&conn->rcu, rxrpc_destroy_connection);
> >  }
> >
> >  /*
> > --
> > 2.31.1.189.g2e36527f23
> >
