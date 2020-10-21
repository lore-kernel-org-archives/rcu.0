Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA2FC4363A
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 22:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3461924248
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 22:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="A7pCRop9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506742AbgJUWb2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437578AbgJUWb1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 18:31:27 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18E4C0613CE
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 15:31:27 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p9so4047854ilr.1
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a57dxvhGl8rVyiXX85ftzv8E1G0yYaqyRUK+4JSQTeQ=;
        b=A7pCRop9afVnOSNeD5d7Y3k09ajdeLYtonUESKJ9K1K8gjp8+xyJNaIR9X8c0kwqwY
         U3Au/jOCS9q9nX7JJUFm8XHMbVAeEIhyMbmc65jWgQpBcopEoPgA3HLCv9K8YKUZGIuv
         pDkAcrFeXJxewpqS2ACu8ORkXqd8qWZyWUONk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a57dxvhGl8rVyiXX85ftzv8E1G0yYaqyRUK+4JSQTeQ=;
        b=pnY+ECoy8BIOzWl6g3qwo4iOplUw4pwIpB6/qPIjs2CX0ed1tINypxm6cgp6O2QMHh
         NOsoGgKrykqVOwr9XOcVp6W+ALrzvLiD8sju/05LaJjQtugVqrcO/qUuCjCMHlWPoLu/
         UgMJiZ5u8+1MiS7iTW0qiDvkxVDL22H8t/6WJ3xcjRcxeCwqwf4JKGtlsuXkeD+Nlhbi
         hyI3K7eqOeJNTjqVwmADbaGdqTQKmjXlYp1hYDkh5O+RRBqgeoHKp/szo+uSEWwPmhX1
         2lqdgcNvdeYAk4k5muYOsF5APkAiFQW60SdfCPGQKQJwyRog60gcMzIAhRkWZVLONw7K
         0eOg==
X-Gm-Message-State: AOAM532dOFZ0+iCvwi+PSmvqqbI7r5qH7wWNBQ55GTvQvk3Jg3xnJ+zA
        VHy/uRl5htfeCXDAN+5VRKxpnNRHvbs5PZG5w7+S5Q==
X-Google-Smtp-Source: ABdhPJxJQZW6OdGUrZ61EZKzt0kxREgEL/GgwrftJkOu1Ya6XPE4XIk9uyzvaXXHOpokviPir6Cd9wRoGSQcL6p20cM=
X-Received: by 2002:a92:dec2:: with SMTP id k2mr4287795ilp.78.1603319486982;
 Wed, 21 Oct 2020 15:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-3-joel@joelfernandes.org> <20201015122158.GA127222@lothringen>
 <20201021153314.GB2828884@google.com> <20201021215304.GB78735@lothringen>
In-Reply-To: <20201021215304.GB78735@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 21 Oct 2020 15:31:16 -0700
Message-ID: <CAEXW_YRhU7SPqmh26AtDWxr48-1t2RDQ=MEax+F2+mqbyxH1yw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] rcu/segcblist: Add counters to segcblist datastructure
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 21, 2020 at 2:53 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Wed, Oct 21, 2020 at 11:33:14AM -0400, joel@joelfernandes.org wrote:
> > On Thu, Oct 15, 2020 at 02:21:58PM +0200, Frederic Weisbecker wrote:
> > > On Wed, Oct 14, 2020 at 08:22:57PM -0400, Joel Fernandes (Google) wrote:
> > > > Add counting of segment lengths of segmented callback list.
> > > >
> > > > This will be useful for a number of things such as knowing how big the
> > > > ready-to-execute segment have gotten. The immediate benefit is ability
> > > > to trace how the callbacks in the segmented callback list change.
> > > >
> > > > Also this patch remove hacks related to using donecbs's ->len field as a
> > > > temporary variable to save the segmented callback list's length. This cannot be
> > > > done anymore and is not needed.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  include/linux/rcu_segcblist.h |   2 +
> > > >  kernel/rcu/rcu_segcblist.c    | 133 +++++++++++++++++++++++-----------
> > > >  kernel/rcu/rcu_segcblist.h    |   2 -
> > > >  3 files changed, 92 insertions(+), 45 deletions(-)
> > > >
> > > > diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> > > > index b36afe7b22c9..d462ae5e340a 100644
> > > > --- a/include/linux/rcu_segcblist.h
> > > > +++ b/include/linux/rcu_segcblist.h
> > > > @@ -69,8 +69,10 @@ struct rcu_segcblist {
> > > >   unsigned long gp_seq[RCU_CBLIST_NSEGS];
> > > >  #ifdef CONFIG_RCU_NOCB_CPU
> > > >   atomic_long_t len;
> > > > + atomic_long_t seglen[RCU_CBLIST_NSEGS];
> > >
> > > Also does it really need to be atomic?
> >
> > Yes, it need not be. I will make the change for ->seglen.
> >
> > BTW, for the existing ->len field, doesn't the following need to acquire nocb
> > lock?
> > rcu_nocb_try_bypass -> rcu_segcblist_inc_len
> >
> > It seems that will do a lock-less non-atomic RMW on a nocb offloaded list,
> > otherwise.
>
> I believe it shouldn't be necessary. That's an atomic add and the kthreads
> manipulating it shouldn't have any trouble concurrently. None that I can
> imagine tonight at least...

Ah yeah, of course. I got confused! Thanks.

> > Certainly rcu_nocb_do_flush_bypass() does do it so maybe it was missed?
>
> I believe it increments under the lock here because the inc happens to be on the way
> to the insertion of the callbacks :o)

Makes sense :)

thanks,
 - Joel
