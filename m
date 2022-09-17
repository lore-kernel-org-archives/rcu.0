Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22213C6FA82
	for <rcu@archiver.kernel.org>; Sat, 17 Sep 2022 21:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIQVnU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Sep 2022 17:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQVnT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Sep 2022 17:43:19 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DD2E9D0
        for <rcu@vger.kernel.org>; Sat, 17 Sep 2022 14:43:17 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 138so19162500iou.9
        for <rcu@vger.kernel.org>; Sat, 17 Sep 2022 14:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=b9bwUAUeen3ZxuyndIbZYoAduo/aHvBL3BmOUTyZqvE=;
        b=CM3cRv7m9TdrNLRi6rmQ9jU84QtM6gTd1m+k4MPbENvwXrBaNmXJ9aBHpXFQC+yE/E
         QnAGN/VRjYdEwgSN6P0oFywzdvT0POfMc4vaL3/ZXXFRUNiBdABnI8plMiNCyaQmQq95
         0HhwHv2ts064bm9DKlbpcKaTMdJupT6pNrh4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b9bwUAUeen3ZxuyndIbZYoAduo/aHvBL3BmOUTyZqvE=;
        b=imdVpvrFjXjFSchBwsMw9QB6fIEMq4ly5dPvITqjbi8cSABSSQ/QT4woqA7SXPZ3cO
         ZodIIcBnWvvJHapuiXbjwytaF6oUWQYMGssrPhL682TvNaX4zg7GQXcsjFP2TNCKo57T
         F/BofYiNM2jNzuNLJj/doFiFEoNeGR+glRYio93e77fQrNjTXS943fP2TUszWGxBlEiL
         hGt4GgmDjWUHNtEum4+DLXHDuaGyE/J4ucLzQQwODu5V/1/5x9qCDJ3AHiNqAwehUpAU
         uTL/VyxiHGCNmQ4f/jadDWcNdS15Ei4gADv/8oD5vdogiZgyrJ4aNdS9qoQBknXaM303
         iKwg==
X-Gm-Message-State: ACrzQf01YxvHBYFaigNzKQ2FfYjNRub6fsiSMkNCrsRUR3WAJdaQD0gf
        UR/vsTmtTWzmox1Io67NoBwN34Gi6bZotUvGBob9dPzm5CcIqBdw
X-Google-Smtp-Source: AMsMyM4AGE4CG1BNZBSt3toXCS8NcpeYiEEPPXKMjJbkwtML5PP1t0OfOJ62bApctQfdhMxJwvnflyru33gD/zK4jbA=
X-Received: by 2002:a05:6602:26d5:b0:68a:db5d:2923 with SMTP id
 g21-20020a05660226d500b0068adb5d2923mr4409914ioo.175.1663450997039; Sat, 17
 Sep 2022 14:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220917164200.511783-1-joel@joelfernandes.org>
 <20220917164200.511783-4-joel@joelfernandes.org> <20220917195807.GA39579@lothringen>
In-Reply-To: <20220917195807.GA39579@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 17 Sep 2022 17:43:06 -0400
Message-ID: <CAEXW_YQxwDF5jhS9gdLa0FsNeD+WoZL0PQydMbT4hsUtLm0hMA@mail.gmail.com>
Subject: Re: [PATCH rcu/next 3/3] rcu: Call trace_rcu_callback() also for
 bypass queuing (v2)
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 17, 2022 at 3:58 PM Frederic Weisbecker <frederic@kernel.org> w=
rote:
>
> On Sat, Sep 17, 2022 at 04:42:00PM +0000, Joel Fernandes (Google) wrote:
> > @@ -2809,17 +2825,15 @@ void call_rcu(struct rcu_head *head, rcu_callba=
ck_t func)
> >       }
> >
> >       check_cb_ovld(rdp);
> > -     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > +
> > +     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
> > +             __trace_rcu_callback(head, rdp);
> >               return; // Enqueued onto ->nocb_bypass, so just leave.
> > +     }
>
> I think the bypass enqueues should be treated differently. Either with ex=
tending
> the current trace_rcu_callback/trace_rcu_kvfree_callback (might break too=
ls)
>
> or
> with creating a new trace_rcu_callback_bypass()/trace_rcu_kvfree_callback=
_bypass().
>
> Those could later be paired with a trace_rcu_bypass_flush().

I am having a hard time seeing why it should be treated differently.
We already increment the length of the main segcblist even when
bypassing. Why not just call the trace point instead of omitting it?
Otherwise it becomes a bit confusing IMO (say someone does not enable
your proposed new bypass tracepoint and only enables the existing one,
then they would see weird traces where call_rcu is called but their
traces are missing trace_rcu_callback). Not to mention - your
suggestion will also complicate writing tools that use the existing
rcu_callback tracepoint to monitor call_rcu().

Also if you see the definition of rcu_callback, "Tracepoint for the
registration of a single RCU callback function.".  That pretty much
fits the usage here.

As for tracing of the flushing, I don=E2=80=99t care about tracing that at =
the
moment using tracepoints, but I don=E2=80=99t mind if it is added later.

Maybe let=E2=80=99s let Paul help resolve our disagreement on this one? :)

thanks,

 - Joel

>
>
> Thanks.
>
>
> > +
> >       // If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb=
_lock.
> >       rcu_segcblist_enqueue(&rdp->cblist, head);
> > -     if (__is_kvfree_rcu_offset((unsigned long)func))
> > -             trace_rcu_kvfree_callback(rcu_state.name, head,
> > -                                      (unsigned long)func,
> > -                                      rcu_segcblist_n_cbs(&rdp->cblist=
));
> > -     else
> > -             trace_rcu_callback(rcu_state.name, head,
> > -                                rcu_segcblist_n_cbs(&rdp->cblist));
> > +     __trace_rcu_callback(head, rdp);
> >
> >       trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> >
> > --
> > 2.37.3.968.ga6b4b080e4-goog
> >
