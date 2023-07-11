Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB49EB64DC
	for <rcu@archiver.kernel.org>; Tue, 11 Jul 2023 16:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGKQqb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjGKQqH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Jul 2023 12:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F61710;
        Tue, 11 Jul 2023 09:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4390B61578;
        Tue, 11 Jul 2023 16:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F642C433C7;
        Tue, 11 Jul 2023 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093918;
        bh=QHHaVhuDb/fpz3+5xT4XiUFFyUebF9LSiDkWDmgfTbE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ubCZgvjFumslnZJ2eGB0cJVb8Mvp8/FrsFWIamsyMOw4bds3tWkgMgOcBPeyP7IC7
         1u4bqKu+s6hJ6EfobixPIc+FMjGhT7KrlF+v417NbAJopOpMbQv5m9qC8Ymhl8f8Uq
         OWZL6De33NlZyosBveUh2QDSp8zlJuTbly1nquP1kgL+xt0B2kiMTOllmBVLD6jjQ4
         TX/KPu2tFfo2r7lp1w6dlXmdINU7cuxWeOkwextQrtkFI9EAjT/PSLsHo06+hDyEye
         0uuNBxado2+UaHsNFPF6daLAkN2gnapdtfeeiMqRaAw+rjfgUZXAAQZ/gVXPmfkr0p
         zZNZ2IZAVGcng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2DB0BCE03F1; Tue, 11 Jul 2023 09:45:18 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:45:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, frederic@kernel.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        josh@joshtriplett.org, boqun.feng@gmail.com, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: Use WRITE_ONCE() for assignments to ->next for
 rculist_nulls
Message-ID: <e7268754-f6ed-4455-a965-848bf36df6f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230706102849.437687-1-mmpgouride@gmail.com>
 <20230706102849.437687-2-mmpgouride@gmail.com>
 <CAEXW_YShqCHHH9Q1icU=oGBbeHO+a1PTY-Q-+KbqVdTm8mR3cw@mail.gmail.com>
 <6563b226-0cbe-4600-be68-2748048cec78@paulmck-laptop>
 <4179F0C7-D2A8-42A5-AF29-22949ADA15C0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4179F0C7-D2A8-42A5-AF29-22949ADA15C0@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 11, 2023 at 10:56:02PM +0800, Alan Huang wrote:
> 
> > 2023年7月11日 04:30，Paul E. McKenney <paulmck@kernel.org> 写道：
> > 
> > On Mon, Jul 10, 2023 at 04:01:07PM -0400, Joel Fernandes wrote:
> >> On Thu, Jul 6, 2023 at 6:29 AM Alan Huang <mmpgouride@gmail.com> wrote:
> >>> 
> >>> When the objects managed by rculist_nulls are allocated with
> >>> SLAB_TYPESAFE_BY_RCU, readers may still hold references to this
> >>> object that is being added, which means the modification of ->next
> >>> is visible to readers. So, this patch uses WRITE_ONCE() for assignments
> >>> to ->next.
> >>> 
> >>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> >>> ---
> >>> include/linux/rculist_nulls.h | 4 ++--
> >>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>> 
> >>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> >>> index ba4c00dd8005..89186c499dd4 100644
> >>> --- a/include/linux/rculist_nulls.h
> >>> +++ b/include/linux/rculist_nulls.h
> >>> @@ -101,7 +101,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
> >>> {
> >>>        struct hlist_nulls_node *first = h->first;
> >>> 
> >>> -       n->next = first;
> >>> +       WRITE_ONCE(n->next, first);
> >>>        WRITE_ONCE(n->pprev, &h->first);
> >>>        rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
> >>>        if (!is_a_nulls(first))
> >>> @@ -137,7 +137,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
> >>>                last = i;
> >>> 
> >>>        if (last) {
> >>> -               n->next = last->next;
> >>> +               WRITE_ONCE(n->next, last->next);
> >>>                n->pprev = &last->next;
> >>>                rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
> >>>        } else {
> >> 
> >> Don't you need READ_ONCE() for the read-side accesses as well?
> > 
> > Both hlist_nulls_for_each_entry_rcu() and hlist_nulls_for_each_entry_safe()
> > use rcu_dereference_raw().  To your point, both hlist_nulls_first_rcu()
> > and hlist_nulls_next_rcu() look rather strange.  I would have expected
> > them to also use rcu_dereference_raw().
> 
> hlist_nulls_first_rcu() and hlist_nulls_next_rcu() were added in commit:
> 
> 	67bdbffd696f(“rculist: avoid __rcu annotations”)
> 
> According to the commit message, this avoids warnings from missing __rcu annotations.

Indeed it does, apologies for the noise!

							Thanx, Paul
