Return-Path: <SRS0=xcwz=6D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0794DC38A30
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 21:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88AF2137B
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 21:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/Gl7cBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDSVsN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Apr 2020 17:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgDSVsM (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 19 Apr 2020 17:48:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F67C061A0C;
        Sun, 19 Apr 2020 14:48:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b11so9769378wrs.6;
        Sun, 19 Apr 2020 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RT/P01e9LVBLiQX0akCG92TCgmn7YVzHtr3iIUS3YSA=;
        b=L/Gl7cBYOXHJJsXUkJSWh/sHhMTTzen8EtVWcgicbg4Hifx9ByLTaUx4GsrsVbkvwd
         2Pss+mlNF3rJPk8E82MA/jeVxGhaq+RrNcOwrnpVudJfiuro2KP8d1bQ/dfFnGygPZ6d
         qz/WJU36NRRgwIaVl2TgqOaM1jxyd7TvaPXh/nbYHp1ikexsv/H+c7hfdDTUca1PdfpD
         HJO4wbxa1A7oWxFw1JFjjkh6jBl+9aUMyxecS6gDZrgK/iJHEBAufCzyZOCLqwxkLcsy
         ofkAUETuPBEu+MyrZxaegGBgM95hQ2gMGV8uUDMifuxtZ6UAXALPDEQQ730IoM0pXy4N
         Id3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RT/P01e9LVBLiQX0akCG92TCgmn7YVzHtr3iIUS3YSA=;
        b=rJ4YWd+iZs4uKyTFFXU+thwRU5+Y1r5NGmvJx30RMq5rm93QruZFAs6rsC0NkFBuSe
         Kt40PXJWCeMmZZdNLzb3nZklN1QlxeNgVvuECfz5WRKbTbaOICIqVTdw9xXXoiqZq0L5
         6XF2FdeYdU4R54416g3wwMPm3XUx1VdOT9xBMD5V+A5wk5j49a7kIz3NFhQRfQzZ5Ije
         po3uZmj/dljbs5OTdbzNcQh5IC6nQ/i/krzOGS6ScGuYdNLdDItbZ+WllJ+uS7CBW23X
         n0GJfm9HqKyy3L835DR0RMOiILMG2bCLbMIwv9e0R/qQTGFWOWTuBAx2i2XXKVEISTXw
         9+Bg==
X-Gm-Message-State: AGi0PuaXixafJcIO5yFxIV52HcfeeOEqtXcfV6zTcE7Px73loBFUSqRj
        saB4j+SMZpyahkiNgdIGPXc=
X-Google-Smtp-Source: APiQypKh7tDPVMuIetE46a9qOBLbIXu/SceYQn4JW6P1B2IgK/DD8W6anNyVXaxhgZtrz0gL/YLvCw==
X-Received: by 2002:adf:f750:: with SMTP id z16mr16326130wrp.115.1587332890035;
        Sun, 19 Apr 2020 14:48:10 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 145sm17681331wma.1.2020.04.19.14.48.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 14:48:09 -0700 (PDT)
Date:   Sun, 19 Apr 2020 21:48:08 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, josh@joshtriplett.org,
        rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: simplify the calculation of rcu_state.ncpus
Message-ID: <20200419214808.ga3fdpl22fzukawh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200417213951.29837-1-richard.weiyang@gmail.com>
 <20200418031922.GR17661@paulmck-ThinkPad-P72>
 <CADZGycYVL9j7jbE1ZY_ZOv2XXv9XwWGPykoE63nJ79VrXwwUCg@mail.gmail.com>
 <20200419152445.GU17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419152445.GU17661@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Apr 19, 2020 at 08:24:45AM -0700, Paul E. McKenney wrote:
>On Sun, Apr 19, 2020 at 06:02:12AM +0800, Wei Yang wrote:
>> On Sat, Apr 18, 2020 at 11:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>> >
>> > On Fri, Apr 17, 2020 at 09:39:51PM +0000, Wei Yang wrote:
>> > > There is only 1 bit set in mask, which means the difference between
>> > > oldmask and the new one would be at the position where the bit is set in
>> > > mask.
>> > >
>> > > Based on this knowledge, rcu_state.ncpus could be calculated by checking
>> > > whether mask is already set in oldmask.
>> >
>> > Nice!!!  Good eyes!
>> >
>> > > BTW, the comment at the last of this line is mysterious. Not sure it
>> > > could be removed or not.
>> >
>> > The "^^^" in that comment says to look at the comment on the preceding
>> > line.  Memory-ordering functions like smp_store_release() are supposed
>> > to have comments indicating what they are ordering.  ;-)
>> >
>> > Could you please do the following things and resubmit?
>> >
>> > 1.      Forward-port to -rcu branch dev?  This tree lives here:
>> >         git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>> >
>> > 2.      Given that oldmask is used only to test to see if a new bit
>> >         was set, why not just replace oldmask with a bool variable
>> >         that is set to "!(rnp->expmaskinitnext & mask)" before the
>> >         bit is ORed into rnp->expmaskinitnext?
>> >
>> > 3.      Put the comment inside the "if" statement with the
>> >         smp_store_release().
>> >
>> > 4.      In -rcu, you will find a ASSERT_EXCLUSIVE_WRITER() statement
>> >         that should also be placed inside the "if" statement with
>> >         the smp_store_release().
>> >
>> 
>> Oops, my email client EAT this mail. Hope this mail will not be banned.
>
>This one made it.  ;-)
>
>> I adjust the code a little according to your suggestion like below. Is this
>> what you expected?
>
>Much better, thank you!
>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index f288477ee1c2..f01367a80b70 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -3732,10 +3732,9 @@ void rcu_cpu_starting(unsigned int cpu)
>>  {
>>         unsigned long flags;
>>         unsigned long mask;
>> -       int nbits;
>> -       unsigned long oldmask;
>>         struct rcu_data *rdp;
>>         struct rcu_node *rnp;
>> +       bool has_seen;
>
>Could you please use a more descriptive name, perhaps something like
>"newcpu"?  Yes, "has_seen" does make sense, but it leaves the reader
>the question "has seen what?".
>
>>         if (per_cpu(rcu_cpu_started, cpu))
>>                 return;
>> @@ -3747,13 +3746,13 @@ void rcu_cpu_starting(unsigned int cpu)
>>         mask = rdp->grpmask;
>>         raw_spin_lock_irqsave_rcu_node(rnp, flags);
>>         WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
>> -       oldmask = rnp->expmaskinitnext;
>> +       has_seen = rnp->expmaskinitnext & mask;
>>         rnp->expmaskinitnext |= mask;
>> -       oldmask ^= rnp->expmaskinitnext;
>> -       nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
>> -       /* Allow lockless access for expedited grace periods. */
>> -       smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
>> -       ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
>> +       if (!has_seen) {
>> +               /* Allow lockless access for expedited grace periods. */
>> +               smp_store_release(&rcu_state.ncpus, rcu_state.ncpus +
>> 1); /* ^^^ */
>> +               ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
>
>One advantage of flipping the conditional is that it allows dropping the
>"if" statement, which saves a few lines of code and gets closer to your
>original suggestion:
>
>	newcpu = !(rnp->expmaskinitnext & mask);
>	rnp->expmaskinitnext |= mask;
>	/* Allow lockless access for expedited grace periods. */
>	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + newcpu); /* ^^^ */
>	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
>
>Yes, this does execute a store-release that doesn't change anything,
>but this is OK because (1) CPU hotplug is infrequent and (2) CPU hotplug
>has very high overhead.  The overhead of the store is thus neglible.
>(But please do not try this to heavily contended cachelines on fastpaths!

I thought I got your point.

>
>And yes, I should have thought of this in response to your initial patch,
>but then again, I should have thought of this when writing this code in
>the first place, shouldn't I have?  ;-)
>

Faire enough.

>							Thanx, Paul
>
>> +       }
>>         rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
>>         rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>>         rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
>> 
>> >                                                         Thanx, Paul
>> >
>> > > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> > > ---
>> > >  kernel/rcu/tree.c | 6 ++----
>> > >  1 file changed, 2 insertions(+), 4 deletions(-)
>> > >
>> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> > > index d91c9156fab2..f0d9251fa663 100644
>> > > --- a/kernel/rcu/tree.c
>> > > +++ b/kernel/rcu/tree.c
>> > > @@ -3364,7 +3364,6 @@ void rcu_cpu_starting(unsigned int cpu)
>> > >  {
>> > >       unsigned long flags;
>> > >       unsigned long mask;
>> > > -     int nbits;
>> > >       unsigned long oldmask;
>> > >       struct rcu_data *rdp;
>> > >       struct rcu_node *rnp;
>> > > @@ -3381,10 +3380,9 @@ void rcu_cpu_starting(unsigned int cpu)
>> > >       rnp->qsmaskinitnext |= mask;
>> > >       oldmask = rnp->expmaskinitnext;
>> > >       rnp->expmaskinitnext |= mask;
>> > > -     oldmask ^= rnp->expmaskinitnext;
>> > > -     nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
>> > >       /* Allow lockless access for expedited grace periods. */
>> > > -     smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
>> > > +     if (!(oldmask & mask))
>> > > +             smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + 1); /* ^^^ */
>> > >       rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
>> > >       rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>> > >       rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
>> > > --
>> > > 2.23.0
>> > >

-- 
Wei Yang
Help you, Help me
