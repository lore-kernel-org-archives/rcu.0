Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A64EE77360
	for <rcu@archiver.kernel.org>; Sat, 30 Sep 2023 07:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjI3Haj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 Sep 2023 03:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjI3Hai (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 Sep 2023 03:30:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4E08F
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 00:30:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE0CC433C7;
        Sat, 30 Sep 2023 07:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696059035;
        bh=4vmIoLnmHU8Xl+NMZVowotEmH+UQLHeafK17BEtzkQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3FZvYaNT9r233dGeB8WlMme8CXYVC6z+9ivl5P6iVc0PMprVqLwBf87E0xJ7TKpk
         r/sGsTc5u75SJ4siNeoE+kMLCvGtKfGikEdT72DTi8Qn1GXX065IN8S+7nH/oj7J3c
         bOsyOsxK1b1ZtDSEdBuUfnKay/2z+73l5xKdFevxSA2TfJJEu67DoN9CAZ+Sq8GuTv
         Opm8KYcz81Pi47hhqWSvq5Ie/O14pGNeCqtqlN6CcZJpLiXMmVuU9W7oHoocspzSWg
         UqPphdWfxUBgAFI+gFQe4rAbkHdU13xSBEHjZpFfDt70ro/+x53Brwp8Pk9O8LAKTl
         iNDSB/lwETAsw==
Date:   Sat, 30 Sep 2023 09:30:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Subject: Re: SRCU: kworker hung in synchronize_srcu
Message-ID: <ZRfOmBO1DxoU65RA@lothringen>
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <ZRdTYPFtGrbPqhUY@localhost.localdomain>
 <CAFwiDX9V1tmRo+qv=3=dmPMsDvoRU3vBai3NBP6KBzr6RXGVtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX9V1tmRo+qv=3=dmPMsDvoRU3vBai3NBP6KBzr6RXGVtA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 30, 2023 at 08:15:06AM +0530, Neeraj upadhyay wrote:
> On Sat, Sep 30, 2023 at 4:15 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Le Thu, Sep 28, 2023 at 05:39:17PM -0400, Joel Fernandes a écrit :
> > > If srcu_invoke_callbacks() was really called for the rdp, I would have
> > > expected rcu_segcblist_advance() to advance all those pending
> > > callbacks to 304.
> > >
> > > I posit that probably srcu_invoke_callbacks() is not even being called
> > > in the first place, otherwise why is the DONE segment count still 0?
> > > DONE should not be 0, otherwise callbacks will not run. The segcblist
> > > of the rdp seems out of date perhaps due to rcu_invoke_callbacks() not
> > > being called due to some other bug (or a workqueue/timer issue causing
> > > the srcu_invoke_callbacks() to not run?).
> >
> > Speaking of, I'm looking at srcu_gp_end() and the comment after releasing
> > srcu_gp_mutex says:
> >
> >               "/* A new grace period can start at this point.  But only one. */"
> >
> > But what ensures that?
> >
> 
> I think ->srcu_cb_mutex ensures that.
> 
> /* Prevent more than one additional grace period. */
> mutex_lock(&sup->srcu_cb_mutex);

Yes but right ater it's relaxed (before callbacks are schedule for execution)?
