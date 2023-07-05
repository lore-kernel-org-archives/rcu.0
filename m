Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE9BC0015E
	for <rcu@archiver.kernel.org>; Wed,  5 Jul 2023 12:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGEMVk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGEMVi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 08:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C7A173F;
        Wed,  5 Jul 2023 05:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8BAF61551;
        Wed,  5 Jul 2023 12:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90380C433C8;
        Wed,  5 Jul 2023 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688559696;
        bh=/RJsOdn51lmoJ/8lwVGWqKSTdVW/dqbGjnpp3Fk7yTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7bU/VyONhjKx7e0HYGs+kdNGwUk17YMvwNbjDZQbxc5ChxgAMteU0qqvrpi9CWFi
         kOeoJwBdK79AJo4U1Hzv0qVxSLji4mMiqkVQR5czMtMZU/ipiHCGdRunBqznsAS7Uv
         c0UEPSBG4yd1Ow5h29QbmFAWvwAz68Lay2zVNyFLjSz//N7U+RvXo9Bqp/iaaqV6+k
         hz8iHYvwX4pgawpnyT2aIefPu67FTyzVA8CQj3uaycNHILH482BDFz3OcxJty/KFjj
         EyGyZ2VDd9AJRCj5wwSYAdWXp90qw9UlaKz7myJidcX4qPSULnHzRfqLBPHM5JJXc9
         tDH2Chp7hGyCQ==
Date:   Wed, 5 Jul 2023 14:21:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 2/9] rcu: Use rcu_segcblist_segempty() instead of open
 coding it
Message-ID: <ZKVgTDus667TOcYU@localhost.localdomain>
References: <20230531101736.12981-1-frederic@kernel.org>
 <20230531101736.12981-3-frederic@kernel.org>
 <CAEXW_YQhufHtuNc5stZQpBY8JSd99NVWEzqv=-QbeMFOA-vDnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQhufHtuNc5stZQpBY8JSd99NVWEzqv=-QbeMFOA-vDnQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Fri, Jun 02, 2023 at 07:00:00PM -0400, Joel Fernandes a écrit :
> On Wed, May 31, 2023 at 6:17 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > This makes the code more readable.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/rcu_segcblist.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index f71fac422c8f..1693ea22ef1b 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -368,7 +368,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
> >         smp_mb(); /* Ensure counts are updated before callback is entrained. */
> >         rhp->next = NULL;
> >         for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
> > -               if (rsclp->tails[i] != rsclp->tails[i - 1])
> > +               if (!rcu_segcblist_segempty(rsclp, i))
> 
> Hopefully the compiler optimizer will be smart enough to remove this
> from the inlined code ;-):
> if (seg == RCU_DONE_TAIL)
>    return &rsclp->head == rsclp->tails[RCU_DONE_TAIL];

I'm counting on that indeed :-)

> 
> Otherwise it appears to be no functional change for this and the below
> change, and straightforward so for this patch:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks.
