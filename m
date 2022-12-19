Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ECFC4332F
	for <rcu@archiver.kernel.org>; Mon, 19 Dec 2022 00:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLSAYk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Dec 2022 19:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSAYi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Dec 2022 19:24:38 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EB97640
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 16:24:37 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id n6so1907988ljj.11
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 16:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vo7ioJ5kdivsZMdePfCiOcVlY/wi8p13YFtJ4DsIZ4=;
        b=l82mE2y3R3h9LqHd80GYtvLdetfDZlenlHUwHag3qpcb3+Qg3tbDLa9uj2ItFmIaW6
         dJwDJeV1815vGCRYgraV0mKBUZSCHpGhcGkmRMPCA4gEoFH46RV4pj59xBaHkv8igvVa
         pXBRhBfODAN4SNYsAGMg87S1Ebpcmp28HJX3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Vo7ioJ5kdivsZMdePfCiOcVlY/wi8p13YFtJ4DsIZ4=;
        b=B+rvsFze0hexO4mPtzZGiV5uwqu0kpSC4Rj5X1IsJHLuGk/7r6Aet2lA+Vzdm+qsVc
         QLzsvWUjeURxJ3s1nEdp5xanO3JLibIs/JEMh1E3iuuB5ZcBAI/iOI6VOC04khEWO1wX
         c/8kCoE3Lgmh0RdEOn5+wXGW9CQDYKI0LKoUxpNbPhxHt/hIjM0T2p/+e3ZurnmN/icd
         vHH1ToWE8Y8lLULKcGKX3EX8sUPvjAA9R9DTGlpTMOxHiiVBuWSpJhV/VNuEyTj3ZLXH
         NBbaNv+Eb4LqGFlgdppPSNpq6xYpoqtoOzKm+PL01MlzdtkC1nZKzvr9UJAgLttNHg68
         PnLg==
X-Gm-Message-State: ANoB5pnJcERWNxTrVD5TLQgj/8HPszQBw5LeruNYD0+YsMJG1PVDgjM5
        R5Cwy4OHifN9kWNAFVRdzneLwIHbeZo3Pn//CdWHbQ==
X-Google-Smtp-Source: AA0mqf4DyHlwUBh3B1k9gMPklG4WZBweP7ESkEx0kD/xYiIE4DiFR/cpjSqcj/2i3v+u2drWvweBUdjGhPOaWGSZ1Ug=
X-Received: by 2002:a05:651c:160b:b0:276:4462:2d20 with SMTP id
 f11-20020a05651c160b00b0027644622d20mr23698192ljq.19.1671409475549; Sun, 18
 Dec 2022 16:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com> <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
 <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com> <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
In-Reply-To: <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Dec 2022 19:24:23 -0500
Message-ID: <CAEXW_YTyZaE4ULvm-HygFN2BGm-jayHTbpnYbrJFoo_GOsYKQg@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Dec 18, 2022 at 7:04 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Mathieu,
>
> On Sun, Dec 18, 2022 at 6:38 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2022-12-18 16:30, Joel Fernandes wrote:
> > > Hi Mathieu,
> > >
> > > On Sun, Dec 18, 2022 at 3:56 PM Mathieu Desnoyers
> > > <mathieu.desnoyers@efficios.com> wrote:
> > >>
> > >> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> > >>> Hello, I believe the pre-flip memory barrier is not required. The only reason I
> > >>> can say to remove it, other than the possibility that it is unnecessary, is to
> > >>> not have extra code that does not help. However, since we are issuing a fully
> > >>> memory-barrier after the flip, I cannot say that it hurts to do it anyway.
> > >>>
> > >>> For this reason, please consider these patches as "informational", than a
> > >>> "please merge". :-) Though, feel free to consider merging if you agree!
> > >>>
> > >>> All SRCU scenarios pass with these, with 6 hours of testing.
> > >>
> > >> Hi Joel,
> > >>
> > >> Please have a look at the comments in my side-rcu implementation [1, 2].
> > >> It is similar to what SRCU does (per-cpu counter based grace period
> > >> tracking), but implemented for userspace. The comments explain why this
> > >> works without the memory barrier you identify as useless in SRCU.
> > >>
> > >> Following my implementation of side-rcu, I reviewed the SRCU comments
> > >> and identified that the barrier "/* E */" appears to be useless. I even
> > >> discussed this privately with Paul E. McKenney.
> > >>
> > >> My implementation and comments go further though, and skip the period
> > >> "flip" entirely if the first pass observes that all readers (in both
> > >> periods) are quiescent.
> > >
> > > Actually in SRCU, the first pass scans only 1 index, then does the
> > > flip, and the second pass scans the second index. Without doing a
> > > flip, an index cannot be scanned for forward progress reasons because
> > > it is still "active". So I am curious how you can skip flip and still
> > > scan both indexes? I will dig more into your implementation to learn more.
> >
> > If we look at SRCU read-side:
> >
> > int __srcu_read_lock(struct srcu_struct *ssp)
> > {
> >          int idx;
> >
> >          idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> >          this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> >          smp_mb(); /* B */  /* Avoid leaking the critical section. */
> >          return idx;
> > }
> >
> > If the thread is preempted for a long period of time between load of
> > ssp->srcu_idx and increment of srcu_lock_count[idx], this means this
> > thread can appear as a "new reader" for the idx period at any arbitrary
> > time in the future, independently of which period is the current one
> > within a future grace period.
> >
> > As a result, the grace period algorithm needs to inherently support the
> > fact that a "new reader" can appear in any of the two periods,
> > independently of the current period state.
> >
> > As a result, this means that while within period "0", we _need_ to allow
> > newly coming readers to appear as we scan period "0".
>
> Sure, it already does handle it but that is I believe it is a corner
> case, not the norm.
>
> > As a result, we can simply scan both periods 0/1 for reader quiescence,
> > even while new readers appear within those periods.
>
> I think this is a bit dangerous. Yes there is the preemption thing you
> mentioned above, but that is bounded since you can only have a fixed
> number of tasks that underwent that preemption, and it is quite rare
> in the sense, each reader should get preempted just after sampling idx
> but not incrementing lock count.
>
> However, if we scan while new readers appear (outside of the above
> preemption problem), we can have counter wrap causing a false match
> much quicker.
> The scan loop is:
> check_readers(idx) {
>    count_all_unlocks(idx);
>    smp_mb();
>    count_all_locks(idx);
>    bool done = (locks == unlocks)
>    if (done) {
>          // readers are done, end scan for this idx.
>    } else {
>          // try again later
>    }
> }
>
> So if check_readers() got preempted just after the smp_mb(), then you
> can have lots of tasks enter and exit the read-side critical section
> and increment the locks count. Eventually locks == unlocks will
> happen, and it is screwed. Sure this is also theoretical, but yeah
> that issue can be made "worse" by scanning active readers
> deliberately, especially when such readers can also nest arbitrarily.
>
> > As a result, flipping between periods 0/1 is just relevant for forward
> > progress, not for correctness.
>
> Sure, agreed, forward progress.

Adding to the last statement "But also correctness as described above".

thanks,

 - Joel
