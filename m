Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F61CC001B0
	for <rcu@archiver.kernel.org>; Mon, 10 Jul 2023 20:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGJUbP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Jul 2023 16:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjGJUbG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Jul 2023 16:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E7510FD;
        Mon, 10 Jul 2023 13:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34F52611C6;
        Mon, 10 Jul 2023 20:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DD7C433C8;
        Mon, 10 Jul 2023 20:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689021021;
        bh=+wP0eAg2GbC5oQ+lb4sHxBJC/hNB0xXugQykCtxdp3Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ph18YdcgRHei0djIICVwrzINl8fXNu2Jw01kwm6bnpg8sMfe2J/YRqfEKDwXSI+qJ
         dXrpQeK20aARr8F7Ct7hmeUjISEnZ7ctt6yVzpzGDwyuuHzogL+eQ6gsxKrwZaCV+X
         Jx7InrpQ5DHHzf9r2dRHzbWVl0M2VFltNgSQOz6Cd+Bnfy8MEY6Tw4XWu/5W2LXbC1
         KIAwh/tVN/tkTx27x1ls/8jsZTfLv35O3PrMBGKZlew2mgvZNdZ4kXACpJ4vL4i9Zr
         OBfzusJ4LI+DBJlQ6VnJr/3FdeSTqE0sReDH502YwHMZ6pURGMy4WVFp6fOcz645GC
         Ec6w7khriGdAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2F452CE008B; Mon, 10 Jul 2023 13:30:21 -0700 (PDT)
Date:   Mon, 10 Jul 2023 13:30:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Huang <mmpgouride@gmail.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: Use WRITE_ONCE() for assignments to ->next for
 rculist_nulls
Message-ID: <6563b226-0cbe-4600-be68-2748048cec78@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230706102849.437687-1-mmpgouride@gmail.com>
 <20230706102849.437687-2-mmpgouride@gmail.com>
 <CAEXW_YShqCHHH9Q1icU=oGBbeHO+a1PTY-Q-+KbqVdTm8mR3cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YShqCHHH9Q1icU=oGBbeHO+a1PTY-Q-+KbqVdTm8mR3cw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 10, 2023 at 04:01:07PM -0400, Joel Fernandes wrote:
> On Thu, Jul 6, 2023 at 6:29 AM Alan Huang <mmpgouride@gmail.com> wrote:
> >
> > When the objects managed by rculist_nulls are allocated with
> > SLAB_TYPESAFE_BY_RCU, readers may still hold references to this
> > object that is being added, which means the modification of ->next
> > is visible to readers. So, this patch uses WRITE_ONCE() for assignments
> > to ->next.
> >
> > Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> > ---
> >  include/linux/rculist_nulls.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> > index ba4c00dd8005..89186c499dd4 100644
> > --- a/include/linux/rculist_nulls.h
> > +++ b/include/linux/rculist_nulls.h
> > @@ -101,7 +101,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
> >  {
> >         struct hlist_nulls_node *first = h->first;
> >
> > -       n->next = first;
> > +       WRITE_ONCE(n->next, first);
> >         WRITE_ONCE(n->pprev, &h->first);
> >         rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
> >         if (!is_a_nulls(first))
> > @@ -137,7 +137,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
> >                 last = i;
> >
> >         if (last) {
> > -               n->next = last->next;
> > +               WRITE_ONCE(n->next, last->next);
> >                 n->pprev = &last->next;
> >                 rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
> >         } else {
> 
> Don't you need READ_ONCE() for the read-side accesses as well?

Both hlist_nulls_for_each_entry_rcu() and hlist_nulls_for_each_entry_safe()
use rcu_dereference_raw().  To your point, both hlist_nulls_first_rcu()
and hlist_nulls_next_rcu() look rather strange.  I would have expected
them to also use rcu_dereference_raw().

							Thanx, Paul
