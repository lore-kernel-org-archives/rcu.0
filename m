Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B539CE75453
	for <rcu@archiver.kernel.org>; Tue,  3 Oct 2023 12:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjJCMWI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Oct 2023 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjJCMWH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Oct 2023 08:22:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989C0AC
        for <rcu@vger.kernel.org>; Tue,  3 Oct 2023 05:22:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAD3C433C7;
        Tue,  3 Oct 2023 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696335724;
        bh=SjeALn1CbFzpGi0pBG+GYoZ1jLvUXLHPt4ojKqH4uDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=an5cDcl9z00PivbI9ay0ZkSbZHs1Ofor5iymtEUzk/CxSNt4jOIjuiixyPTDjzJgU
         0WVXAi/tooARJL7wP8ZT9XoGXARCeMP+aIDNS7orA/vQwfOfnP487jke6fwY/xbLBc
         56mCfnTn+ovoWr03rQD3zAbGrRQpV11ni+LV6Q1Z8k+cIgzq377rFpOvqi5tARfisr
         KICRpMi4flpIZ+d1BZLsgcussJmEyl3cHWHwqPBuEQrnjLKrvW03odXeE7JNTP/c3s
         xG/Khva0qW60zyLBeulz/aXBsYQgPyN7+FxtoaLQlD13sa+GdhnD6UQRMn6By0WYoM
         1DfqY5gINSv3g==
Date:   Tue, 3 Oct 2023 14:22:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Subject: Re: SRCU: kworker hung in synchronize_srcu
Message-ID: <ZRwHadV/p6f7RzGn@lothringen>
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain>
 <CAFwiDX9NBdPy-CZA6i9XEd5jM+j9e57zMoW2AwAoNtzDt+8qbw@mail.gmail.com>
 <ZRqeZ31cLs8bocBo@lothringen>
 <CAFwiDX9TMNqG7h-FbzBYu04ew7-6x_-TinzCW6ta+7NX-BRO1Q@mail.gmail.com>
 <ZRsxk_fZZoUGJ_my@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRsxk_fZZoUGJ_my@localhost.localdomain>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 02, 2023 at 11:09:39PM +0200, Frederic Weisbecker wrote:
> > >         spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
> > >         WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
> > >         WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
> > > @@ -1245,7 +1243,18 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> > >         s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> > > -       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> > > +       /*
> > > +        * Acceleration might fail if the preceding call to
> > > +        * rcu_segcblist_advance() also failed due to a prior grace
> > > +        * period seen incomplete before rcu_seq_snap(). If so then a new
> > > +        * call to advance will see the completed grace period and fix
> > > +        * the situation.
> > > +        */
> > > +       if (!rcu_segcblist_accelerate(&sdp->srcu_cblist, s)) {
> > 
> > We can add below also? Here old and new are rcu_seq_current() values used in
> > the 2 calls to rcu_segcblist_advance().
> > 
> > WARN_ON_ONCE(!(rcu_seq_completed_gp(old, new) && rcu_seq_new_gp(old, new)));
> 
> Very good point! "new" should be exactly one and a half grace period away from
> "old", will add that.
> 
> Cooking proper patches now.

Actually this more simple fix below. rcu_seq_snap() can be called before
rcu_segcblist_advance() after all. The only side effect is that callbacks
advancing is then _after_ the full barrier in rcu_seq_snap(). I don't see
an obvious problem with that as that barrier only cares about:

1) Ordering accesses of the update side before call_srcu() so they don't bleed
2) See all the accesses prior to the grace period of the current gp_num

The only things callbacks advancing need to be ordered against are carried by
snp locking.

I still remove the accelerations elsewhere and advancing in srcu_gp_start() in
further patches. I'll also avoid advancing and acceleration in
srcu_gp_start_if_needed if there is no callback to queue.

The point is also that this simple fix alone can be easily backported and
the rest can come as cleanups.


diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5602042856b1..8b09fb37dbf3 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1244,10 +1244,10 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	spin_lock_irqsave_sdp_contention(sdp, &flags);
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
+	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
-	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
+	WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s) && rhp);
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
 		sdp->srcu_gp_seq_needed = s;
 		needgp = true;
