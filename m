Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD06C4332F
	for <rcu@archiver.kernel.org>; Mon, 19 Dec 2022 00:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiLSAa7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Dec 2022 19:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLSAaz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Dec 2022 19:30:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B52765C
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 16:30:54 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m29so11249728lfo.11
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1OBjhyDWJmKvItPhJFDCPWQ91ZWI56mtuyyNiTsGCkg=;
        b=HEuzuqZt+PU1rDq1ZXdEabMkRWe3nr0AZyWAzyCmhKZX60emK9uCP8p234vx9Ae3uI
         g3pzcUqYrv212yHOILWPaNd3MZeFKEHYVtkSftlFOyT5ges0bRdWFciRG1TD2Etvvuss
         qinpMReOFg48REG+Os2L/PzafKwDDZEwXj4A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OBjhyDWJmKvItPhJFDCPWQ91ZWI56mtuyyNiTsGCkg=;
        b=BKcvqDJd0R+UtXAgVy2OH8+aEqtrhReoQbOAbMC/+Jxg8RrvFwWLBf/EloNL28n/6a
         OVPoTt37eMiLTtMYC5UZfehryXezRr07bInS/B3p/MQJcircBp8FZ96FxsfVffhvA7WQ
         vBT8jjfFrBZyegF/55+I+V2ST7Inm6Snn+EilTW2VbqaTBIWnlIQ/PohPLouJN/W7UWI
         B+CEDPzhdHQ9PwFDFgV7GbncHNPcnjhep+2/n71aOivhiNMn8kimhyPjPANhtASS+8oQ
         8G5kM7ebY5hzflOnzzDZURYl49l1jMRBpNJLjD4uTsFzxk4mvwSZ61N9Vp9sVOymH0Wg
         ukoQ==
X-Gm-Message-State: ANoB5pn5sSnrkBl5wuC9QsuEgStis53uUkmwBWI2xUwaqlwoD7rOnbXM
        UDVUHx7ZrEwTi1KXKa+yV9F6rBAkGiic+nr2rmziPe+U7LWNz8zY
X-Google-Smtp-Source: AA0mqf4keBvURRTu6rhoPIio7aWE1T8RG16/Vno+bBmkWyON1iWQx34syGjiwbqooUTGuz5odKJky9KR2jlqNInPbH8=
X-Received: by 2002:ac2:510c:0:b0:4af:d4e:dfa7 with SMTP id
 q12-20020ac2510c000000b004af0d4edfa7mr27926812lfb.582.1671409852760; Sun, 18
 Dec 2022 16:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <20221218191310.130904-3-joel@joelfernandes.org> <20221218214243.GA1990383@lothringen>
 <Y5+hk6+WX2LwZ7hi@google.com>
In-Reply-To: <Y5+hk6+WX2LwZ7hi@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Dec 2022 19:30:41 -0500
Message-ID: <CAEXW_YS13DssjPy=xQ8vbVamZN9syRHspfaCapAOrJcOsU2pMA@mail.gmail.com>
Subject: Re: [RFC 2/2] srcu: Remove memory barrier "E" as it is not required
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Dec 18, 2022 at 6:26 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Sun, Dec 18, 2022 at 10:42:43PM +0100, Frederic Weisbecker wrote:
> > On Sun, Dec 18, 2022 at 07:13:09PM +0000, Joel Fernandes (Google) wrote:
> > > During a flip, we have a full memory barrier before idx is incremented.
> > >
> > > The effect of this seems to be to guarantee that, if a READER sees srcu_idx
> > > updates (srcu_flip), then prior scans would not see its updates to counters on
> > > that index.
> > >
> > > That does not matter because of the following reason: If a prior scan did see
> > > counter updates on the new index, that means the prior scan would would wait
> > > for the reader when it probably did not need to.
> >
> > I'm confused, isn't it actually what we want to prevent from?
> > The point of the barrier here is to make sure that the inactive index that
> > we just scanned is guaranteed to remain seen as inactive during the whole scan
> > (minus the possible twice residual increments from a given task that we debated
> > on Paul's patch, but we want the guarantee that the inactive index won't be
> > incremented thrice by a given task or any further while we are scanning it).
>
> I believe you are talking about the memory barrier after the flip, that's the
> one that guarantees what you are talking about it, I feel. That is, readers
> see the newly inactivated index eventually, so that we are not scanning
> indefinitely.
>
> For that, we need smp_mb() after the flip but before the second scan which is
> a much needed memory barrier IMHO, and not what this patch is talking about.
>
> > If some readers see the new index and increments the lock and we see that while
> > we are scanning it, there is a risk that the GP is going to be delayed indefinetly.
>
> The "new" index is the index after the flip, do you mean the "old" index?
> i.e. the index before the flip? That is what barrier E is talking about, not
> the index after the flip.
>
> >
> > > @@ -982,14 +982,6 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
> > >   */
> > >  static void srcu_flip(struct srcu_struct *ssp)
> > >  {
> > > -   /*
> > > -    * Ensure that if a given reader sees the new value of ->srcu_idx, this
> > > -    * updater's earlier scans cannot have seen that reader's increments
> > > -    * (which is OK, because this grace period need not wait on that
> > > -    * reader).
> > > -    */
> > > -   smp_mb(); /* E */  /* Pairs with B and C. */
> >
> > That said, I've been starring at this very barrier for the whole day, and I'm
> > wondering what does it match exactly on the other end?
> >
> >       UPDATER                               READER
> >       -------                               ------
> >       idx = ssp->srcu_idx;                  idx = srcu_idx;
> >       READ srcu_unlock_count[srcu_idx ^ 1]  srcu_lock_count[idx]++
> >       smp_mb();                             smp_mb();
> >       READ srcu_lock_count[srcu_idx ^ 1]    srcu_unlock_count[old_idx]++
> >       smp_mb()
> >       srcu_idx++;
> >
> > For a true match, I would expect a barrier between srcu_idx read and
> > srcu_lock_count write. I'm not used to ordering writes after reads.
> > So what is the pattern here? I would expect something like the below
> > but that doesn't match the above:
>
> IMHO, it is matching updates to index and the lock count of a reader.
>
> >
> > C rwrw
> >
> > {}
> >
> >
> > P0(int *X, int *Y)
> > {
> >       int x;
> >
> >       x = READ_ONCE(*X);
> >       smp_mb();
> >       WRITE_ONCE(*Y, 1);
> > }
> >
> > P1(int *X, int *Y)
> > {
> >
> >       int y;
> >
> >       y = READ_ONCE(*Y);
> >       smp_mb();
> >       WRITE_ONCE(*X, 1);
> > }
> >
> > exists (0:x=1 /\ 1:y=1)
>
> Hmm, I guess first lets degenerate the real code to an access pattern:
>
>
>     READER                            UPDATER
>
>                                     scanner() {
>                                         count_all_unlocks();
>                                         smp_mb();
>                                         count_all_locks(); (Y)
>                                     }
>
>     rcu_read_lock() {
>         idx = READ(idx); (X)
>         lock_count[idx]++;
>
>         smp_mb();    // mb B
>     }
>
>     rcu_read_unlock() {
>         smp_mb();    // mb C
>         unlock_count[idx]++;
>     }
>                                     srcu_flip() {
>                                         smp_mb(); //E
>                                         idx++; (X)
>     rcu_read_lock() {
>         idx = READ(idx);
>         lock_count[idx]++; (Y)
>
>         smp_mb();    // mb B
>                                         smp_mb();
>                                     }
>     }
>
>
> That becomes:
>
> // READER
> P0(int *X, int *Y)
> {
>         int r0;
>
>         r0 = READ_ONCE(*X);     // PP
>         smp_mb(); // B+C        // QQ
>         WRITE_ONCE(*Y, 1);      // RR
> }
>
> // UPDATER
> P1(int *X, int *Y)
> {
>         int r1;
>
>         r1 = READ_ONCE(*Y);     // SS
>         smp_mb(); // E          // TT
>         WRITE_ONCE(*X, 1);      // UU
> }
>
> Impossible that:
> exists (0:r0=1 /\ 1: r1:1)
>
> Because if r0=1, there is PP ->rf UU relation. So because of the smp_mb(), it
> is impossible that r1=1.
>
> So "E" is saying, if a reader saw new idx, that is the "X" in the litmus
> test, then previous scan where it count all the locks (SS) cannot see the
> lock count updates made at the new index.
>
> However, that does not matter IMHO because due to preemption after current
> index is sampled, we have no control anyway over which lock counts are
> incremented anyway, so this cannot effect correctness.
>
> And if forward progress is a problem, we are doing a full memory barrier
> after the flip anyway so I am not seeing the point of "E".

And you made me realize that the previous scan (the one that happened
before the flip) does not care about lock count on the "new" idx value
(because, duh, in program order, the previous scan was scanning the
old pre-flip idx0, and if we go for scans before that, we end up
running into smp_mb() in the previous scan which is plenty enough. So
I am still not seeing the purpose that "E" serves, as far as it
concerns the comment that this patch deletes.

Anyway, phew, time for a break ;-)
Thanks,

 - Joel
