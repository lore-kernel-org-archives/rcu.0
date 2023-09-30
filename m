Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C553EE7735F
	for <rcu@archiver.kernel.org>; Sat, 30 Sep 2023 09:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjI3JK2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 Sep 2023 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjI3JK1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 Sep 2023 05:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C31BF
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 02:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08741C433C7;
        Sat, 30 Sep 2023 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696065024;
        bh=F+RtnnGF0KWZJEsq/PAQ00xYCAaLcoy0sUwZtCjaxhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ismuDUTkRg0rsR2N+083qrB1A2zrH1Uf64KDd9mZP1ZUT3hLAlZ5B/KX/Ml/3CIr0
         8mpRZZSp/enUEXCPQYFoPhJNUHyhNeV1Fxq18wH3ZdjRbzNnR7SfjRW/XIh7CkVa4l
         nHUHP43JPfaqM619Mh04iC1EfUs5bPulh4uROhYGU0Ob0cHTYOscN1XlK6fdXCZrzx
         978o/FowqD3gL1gRFAD54n4cnTorOw8x1Q4bawdlQIN+xhqjUm5AwbFV8EZD9P8JDN
         +PqaMLqZZXUEOiZo7M6i+xnxjpw6nmFakCpJcqoqT79SWVx2Ue0ocwkR60ClDbviON
         LSk4FiBczzQ1A==
Date:   Sat, 30 Sep 2023 11:10:21 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Subject: Re: SRCU: kworker hung in synchronize_srcu
Message-ID: <ZRfl_QssVLE0fKSD@localhost.localdomain>
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

Le Sat, Sep 30, 2023 at 08:15:06AM +0530, Neeraj upadhyay a écrit :
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

Oh I confused ->srcu_cb_mutex with ->srcu_gp_mutex, didn't I? ;-)
