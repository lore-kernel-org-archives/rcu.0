Return-Path: <SRS0=hY+h=6C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D103C2BA19
	for <rcu@archiver.kernel.org>; Sat, 18 Apr 2020 22:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D247721974
	for <rcu@archiver.kernel.org>; Sat, 18 Apr 2020 22:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/DcX3qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgDRWCL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Apr 2020 18:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDRWCK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Apr 2020 18:02:10 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317A0C061A0C;
        Sat, 18 Apr 2020 15:02:09 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q10so4528062ile.0;
        Sat, 18 Apr 2020 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2F1YT95vbFuray7AER8KtaCXNMm/Pj9Jbm9f59uato=;
        b=F/DcX3qn0mWP3wxePs/f6Ber+8vcImQLEQ1CnbNQTcIfCmABYQGfIKgMiyysqaCEL/
         t90eT6S1ZjddO24lMhbAMC2HLortBaB77fS2qG+7q98k3eyT2Z2DWO/6uMtB1ap4ln0a
         jAYld2+pC/YdCQf8AunPt9C7hDJRYHbT+nbebEVsFwuaW54I01nc8i2TmQB9ioCJb9Zq
         OrQXNVF/JswexSm6WLEkxiidIfrvi78E95/ZjahRUOUamjJJ404iE775MJsQbOFTWdJH
         KoTGv6MK30ZK1Pa/TJon0K7fVbjB49hVTNztmqJsFug7Izfg2MhnwZ+Dll0OnNhTUVj8
         qk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2F1YT95vbFuray7AER8KtaCXNMm/Pj9Jbm9f59uato=;
        b=XNWeOnN6cb9LlcHTOIs7pq6wiQaF8VXG74BVvJ41VKXRhKg8everwam/iNzVRzwq9A
         tCJBpeWR9g11/sevzDMqgMaB0x49cF3q9bst+cJ+tF2rmIt3z/R0E2f+Y4l0SONprY6Q
         3MOVT6prPU0NkRN8GE5SEQB8ve5gKjw7qSienTAfkkGIZdwE9CmN5k8yWS/9cwM/ZEc0
         RmGPbLsBugk+C+nAW1Yf2CwawiWqAwsbBg0LpDidjISHZELmbMl7UGrG3WgiYdjwzq3c
         0N/AOUNY+sLcNZ2p0EMHoFSwZRDsRiZv7QzJSggR7V7HH552cKuQQHX7Zr0l3YMCXd+J
         1TPg==
X-Gm-Message-State: AGi0PuZQ+fqF0BjTeFaqj/gr+5xHnMG8A4JhyMQAXgGDeWnE37qNXA7y
        J7bwGsKCSRkf6wXN3p3+UDBI7diyAWdUvgmF1hA=
X-Google-Smtp-Source: APiQypLGAnldNe44/T7TrOcehDST8OjwjHDaKCPvui7D2rvzpgvBzbQYc1MKCX0pK+dGDGtCanJ0ygeCeyDEHHYaggU=
X-Received: by 2002:a05:6e02:790:: with SMTP id q16mr8812413ils.60.1587247328320;
 Sat, 18 Apr 2020 15:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200417213951.29837-1-richard.weiyang@gmail.com> <20200418031922.GR17661@paulmck-ThinkPad-P72>
In-Reply-To: <20200418031922.GR17661@paulmck-ThinkPad-P72>
From:   Wei Yang <richard.weiyang@gmail.com>
Date:   Sun, 19 Apr 2020 06:02:12 +0800
Message-ID: <CADZGycYVL9j7jbE1ZY_ZOv2XXv9XwWGPykoE63nJ79VrXwwUCg@mail.gmail.com>
Subject: Re: [PATCH] rcu: simplify the calculation of rcu_state.ncpus
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     josh@joshtriplett.org, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Apr 18, 2020 at 11:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Apr 17, 2020 at 09:39:51PM +0000, Wei Yang wrote:
> > There is only 1 bit set in mask, which means the difference between
> > oldmask and the new one would be at the position where the bit is set in
> > mask.
> >
> > Based on this knowledge, rcu_state.ncpus could be calculated by checking
> > whether mask is already set in oldmask.
>
> Nice!!!  Good eyes!
>
> > BTW, the comment at the last of this line is mysterious. Not sure it
> > could be removed or not.
>
> The "^^^" in that comment says to look at the comment on the preceding
> line.  Memory-ordering functions like smp_store_release() are supposed
> to have comments indicating what they are ordering.  ;-)
>
> Could you please do the following things and resubmit?
>
> 1.      Forward-port to -rcu branch dev?  This tree lives here:
>         git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>
> 2.      Given that oldmask is used only to test to see if a new bit
>         was set, why not just replace oldmask with a bool variable
>         that is set to "!(rnp->expmaskinitnext & mask)" before the
>         bit is ORed into rnp->expmaskinitnext?
>
> 3.      Put the comment inside the "if" statement with the
>         smp_store_release().
>
> 4.      In -rcu, you will find a ASSERT_EXCLUSIVE_WRITER() statement
>         that should also be placed inside the "if" statement with
>         the smp_store_release().
>

Oops, my email client EAT this mail. Hope this mail will not be banned.

I adjust the code a little according to your suggestion like below. Is this
what you expected?

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f288477ee1c2..f01367a80b70 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3732,10 +3732,9 @@ void rcu_cpu_starting(unsigned int cpu)
 {
        unsigned long flags;
        unsigned long mask;
-       int nbits;
-       unsigned long oldmask;
        struct rcu_data *rdp;
        struct rcu_node *rnp;
+       bool has_seen;

        if (per_cpu(rcu_cpu_started, cpu))
                return;
@@ -3747,13 +3746,13 @@ void rcu_cpu_starting(unsigned int cpu)
        mask = rdp->grpmask;
        raw_spin_lock_irqsave_rcu_node(rnp, flags);
        WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-       oldmask = rnp->expmaskinitnext;
+       has_seen = rnp->expmaskinitnext & mask;
        rnp->expmaskinitnext |= mask;
-       oldmask ^= rnp->expmaskinitnext;
-       nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
-       /* Allow lockless access for expedited grace periods. */
-       smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
-       ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
+       if (!has_seen) {
+               /* Allow lockless access for expedited grace periods. */
+               smp_store_release(&rcu_state.ncpus, rcu_state.ncpus +
1); /* ^^^ */
+               ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
+       }
        rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
        rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
        rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);

>                                                         Thanx, Paul
>
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > ---
> >  kernel/rcu/tree.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d91c9156fab2..f0d9251fa663 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3364,7 +3364,6 @@ void rcu_cpu_starting(unsigned int cpu)
> >  {
> >       unsigned long flags;
> >       unsigned long mask;
> > -     int nbits;
> >       unsigned long oldmask;
> >       struct rcu_data *rdp;
> >       struct rcu_node *rnp;
> > @@ -3381,10 +3380,9 @@ void rcu_cpu_starting(unsigned int cpu)
> >       rnp->qsmaskinitnext |= mask;
> >       oldmask = rnp->expmaskinitnext;
> >       rnp->expmaskinitnext |= mask;
> > -     oldmask ^= rnp->expmaskinitnext;
> > -     nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
> >       /* Allow lockless access for expedited grace periods. */
> > -     smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
> > +     if (!(oldmask & mask))
> > +             smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + 1); /* ^^^ */
> >       rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
> >       rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> >       rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > --
> > 2.23.0
> >
