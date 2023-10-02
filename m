Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FB1E776CE
	for <rcu@archiver.kernel.org>; Mon,  2 Oct 2023 22:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjJBWqm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Oct 2023 18:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJBWqm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Oct 2023 18:46:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EC493
        for <rcu@vger.kernel.org>; Mon,  2 Oct 2023 15:46:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7173AC433C7;
        Mon,  2 Oct 2023 22:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696286798;
        bh=6uxLXn2eoLVyGqYt2DJ+Syy39/MpG5Mf9aQIry0lVM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ot1iFZwKfnldThvAiOqO7ZEBbnUlCPIblqg7xsUX5eok5WHmhKT2uY7a4DGfiG9cl
         blk/VkcRnE7raBpQolg7g4jL94Zm12r+fSlF2C1/1x4NuYnO4cJYUN6ihVYLHQqJSD
         muUR38rJHXIkvxcZBpsyjeOjYPnohC9kW9fsBpYq5n5dSc9FcBrH1bMbh7VD/gxtQX
         y9t+PGRSJKMxKm+9hyRaL74Sa00KaEFQrvJdkxoC0In+sCRm3jrwDu/OJhG/MsKEmi
         wmk7RXS2ogWv4kIWJyP22Xqa8rF7HY3yal9PXawjDd/Q1Ewi0G2VJoaDCkiLbMUHO8
         MzNySKGMji9Xg==
Date:   Tue, 3 Oct 2023 00:46:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Subject: Re: SRCU: kworker hung in synchronize_srcu
Message-ID: <ZRtIS-8NPKHdY0Ym@localhost.localdomain>
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain>
 <ZRn1PU8enLoM8u1T@localhost.localdomain>
 <CAFwiDX_RxMQ1SgG8Wc+JWB_9i-i90Qmxuei_Yk2yJ7ohTOHjLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX_RxMQ1SgG8Wc+JWB_9i-i90Qmxuei_Yk2yJ7ohTOHjLg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Mon, Oct 02, 2023 at 07:51:10AM +0530, Neeraj upadhyay a écrit :
> > And if this works, can we then remove srcu_invoke_callbacks() self-requeue?
> > If queued several times before it actually fires, it will catch the latest
> > grace period's end. And if queued while the callback runs, it will re-run.
> >
> 
> This makes sense, but not sure for non-wq context which  link [1] mentions,
> whether it needs it.
> 
> > Also why do we have sdp->srcu_invoke_callbacks ? Is that workqueue re-entrant?
> >
> I think you mean sdp->srcu_cblist_invoking ?
> 
> There was a prior discussion on this [1], where Paul mentions about
> non-wq context.

Actually I realize that if we remove that, then two srcu_invoke_callbacks()
can race in such a way that an srcu barrier callback may execute before the
callbacks it is supposed to follow. And if we must keep
sdp->srcu_cblist_invoking then we must also keep self-requeuing.

I'll add a comment about that instead of removing.

Thanks.


> 
> 
> 
> Thanks
> Neeraj
> 
> [1] https://lkml.org/lkml/2020/11/19/1065
> 
> > Thanks.
