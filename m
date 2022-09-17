Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D8ECAAA1
	for <rcu@archiver.kernel.org>; Sat, 17 Sep 2022 22:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiIQWmm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Sep 2022 18:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIQWmm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Sep 2022 18:42:42 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EC1B7D0
        for <rcu@vger.kernel.org>; Sat, 17 Sep 2022 15:42:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v128so20194828ioe.12
        for <rcu@vger.kernel.org>; Sat, 17 Sep 2022 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=kahzIo799kyEdsYA+23YsXtPtnybsy8lc1MLAua0e7E=;
        b=Rf3WH51PkjSqqIi93EzQibr1PLt7e/h+ghOoTUlaLFbW1ZMlcwydeSTtDZR7p84h3r
         pDXF7HNP4GO5DdBNB5RBpxGGAwqO3Zv1Zw+/hNJyYbOjMtR1AeRuKsigfDgI065K5+P7
         fXQ95DsvPYW1ASsWe0RFgAbCbsmPHOWk3wJnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kahzIo799kyEdsYA+23YsXtPtnybsy8lc1MLAua0e7E=;
        b=Drx8ekFOeN54ozpuENFVPZliKNjvqIUH88KDHIdnXpmMRoFNrs8csR+EDNlwZKvP1p
         B/dw78pof0DF9mxL5sdfo82SOZ6vH5+RfVpwGrkJRRl9dzSbFhzmCID/BDOvYLw1/fAn
         CtL/hTmuDgvuypXsgH6bBIJGmtWvpWTKPHXerBe9AnBzZ4r1qPHsNwQDHW7EssxVqTll
         zBmyBT4UCghxTAUICvBrjx960PTkBkdbkB95TJbICDjHBEMKtSRtzAo2oa2yB7ZSN/zn
         dK4TDEBAC0ftwQw1Le/clDH00NFPjy3Y1/9GUZ4CzgEXW3tKZKp8dFBTic24R+TSh4ZH
         BmwQ==
X-Gm-Message-State: ACrzQf0exxGrTEAjaI5JAloFepbPf4vwBdNEliI/sLpKyYlxZ5F7FHfO
        JOVI7V+NgSvXDvbmBqsuB4V6wA88ig5iFLVNNt1Rc51csVz5GQ==
X-Google-Smtp-Source: AMsMyM4D6EMYXRIrbuXciSc9uyILe9hzR1LlpWVr7/Sre3HhKRI38byd9jGaieo0sA/pnbfV0wzBeKiQzcFyeiVLE5Y=
X-Received: by 2002:a05:6638:19:b0:35a:52a2:dfbe with SMTP id
 z25-20020a056638001900b0035a52a2dfbemr4871472jao.213.1663454560516; Sat, 17
 Sep 2022 15:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220917164200.511783-1-joel@joelfernandes.org>
 <20220917164200.511783-4-joel@joelfernandes.org> <20220917195807.GA39579@lothringen>
 <CAEXW_YQxwDF5jhS9gdLa0FsNeD+WoZL0PQydMbT4hsUtLm0hMA@mail.gmail.com> <20220917222108.GB40100@lothringen>
In-Reply-To: <20220917222108.GB40100@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 17 Sep 2022 18:42:29 -0400
Message-ID: <CAEXW_YSbwRUqz1f2i4LQpxmSyW5PWYWnifRj0UaTHP6pL7m9Lw@mail.gmail.com>
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

On Sat, Sep 17, 2022 at 6:21 PM Frederic Weisbecker <frederic@kernel.org> w=
rote:
>
> On Sat, Sep 17, 2022 at 05:43:06PM -0400, Joel Fernandes wrote:
> > On Sat, Sep 17, 2022 at 3:58 PM Frederic Weisbecker <frederic@kernel.or=
g> wrote:
> > >
> > > On Sat, Sep 17, 2022 at 04:42:00PM +0000, Joel Fernandes (Google) wro=
te:
> > > > @@ -2809,17 +2825,15 @@ void call_rcu(struct rcu_head *head, rcu_ca=
llback_t func)
> > > >       }
> > > >
> > > >       check_cb_ovld(rdp);
> > > > -     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > > > +
> > > > +     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
> > > > +             __trace_rcu_callback(head, rdp);
> > > >               return; // Enqueued onto ->nocb_bypass, so just leave=
.
> > > > +     }
> > >
> > > I think the bypass enqueues should be treated differently. Either wit=
h extending
> > > the current trace_rcu_callback/trace_rcu_kvfree_callback (might break=
 tools)
> > >
> > > or
> > > with creating a new trace_rcu_callback_bypass()/trace_rcu_kvfree_call=
back_bypass().
> > >
> > > Those could later be paired with a trace_rcu_bypass_flush().
> >
> > I am having a hard time seeing why it should be treated differently.
> > We already increment the length of the main segcblist even when
> > bypassing. Why not just call the trace point instead of omitting it?
>
> I'm not suggesting to omit it. I'm suggesting to improve its precision.

That's exactly what I'm doing :-). It is imprecise the way it is, by
calling it where it needs to be (not omitting it), I am making it more
precise.

> > Otherwise it becomes a bit confusing IMO (say someone does not enable
> > your proposed new bypass tracepoint and only enables the existing one,
> > then they would see weird traces where call_rcu is called but their
> > traces are missing trace_rcu_callback).
>
> Well, if they decided to see only half of the information...

It is not that they decide, there are lots of RCU tracepoints and it
is likely common to enable just a few of them.

> > Not to mention - your
> > suggestion will also complicate writing tools that use the existing
> > rcu_callback tracepoint to monitor call_rcu().
>
> If we add another tracepoint, the prototype will be the same as the
> existing one, not many lines to add. If instead we extend the existing
> tracepoint, it's merely just a flag to check or ignore.
>
> OTOH your suggestion doesn't provide any bypass related information.

Bypass related information is not relevant to this patch. I am already
using trace_rcu_callback() in my (yet to be released) rcutop, and I
don't use it for any bypass information.

> > Also if you see the definition of rcu_callback, "Tracepoint for the
> > registration of a single RCU callback function.".  That pretty much
> > fits the usage here.
>
> Doesn't tell if it's a bypass or not.

It doesn't tell a lot of things, so what? Saying that it is bypass is
not the point of this patch.

> > As for tracing of the flushing, I don=E2=80=99t care about tracing that=
 at the
> > moment using tracepoints
>
> You will soon enough ;-)

I respect your experience in the matter :-)

> > but I don=E2=80=99t mind if it is added later.
> > Maybe let=E2=80=99s let Paul help resolve our disagreement on this one?=
 :)
>
> FWIW, I would be personally interested in such tracepoints (or the extens=
ion

Understood.

> of the existing ones, whichever way you guys prefer), they would be of gr=
eat help
> for debugging.
>
> Also if rcu_top is ever released, I really hope the kernel will be ready =
in
> case we want the tool to display bypass related informations.

I feel the main issue you have with my patch is that it does not add
the information you want, however the information you mention is
beyond the scope of the patch and can in future/different patches.
This patch only fixes an *existing* broken tracepoint.

I can certainly add a new bypass-related tracepoint in the future, but
I don't see how that's relevant to my patch.

> Please be careful while designing tracepoints that may be consumed by use=
rspace
> released tools. Such tracepoints eventually turn into ABI and there is no=
 way
> back after that.

Sure thing, that's why I'm fixing the broken tracepoint. Some
registered callbacks can be invisible to the user.

 - Joel
