Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77455EB64D7
	for <rcu@archiver.kernel.org>; Wed, 28 Jun 2023 13:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjF1Nen (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jun 2023 09:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjF1Neh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jun 2023 09:34:37 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CCE129
        for <rcu@vger.kernel.org>; Wed, 28 Jun 2023 06:34:36 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3fde9d3868fso48625651cf.2
        for <rcu@vger.kernel.org>; Wed, 28 Jun 2023 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687959275; x=1690551275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUR2HzgwIlf0PNY2Vlu5mCQ2oSpb3hPdwXu6404Qku0=;
        b=oNPRliG9VY+Ifto9VK55An4ZLzSoDr3+cniSDmjBLIP5fl9JjUesDjlxr59tjQPhgV
         ut9w3ETh46NQMbYBUZW+R/yfR1mIEEwIFZV9urrs5adpkFBbPuigvCCUrJle6rMDrcyx
         3MM4V2aMXUYBP7tHkW/94hHbz5W8O6eTQLfSbtbn4nwaU+IiclvEgAWlZDGhg6MZTZHN
         b8OXek8CX4wwM3aJQ2TnnS9S2xDzgMhPJFyW1SXW24V82PCqYS36u+xKY3fz/UvxVyta
         ahVKDtyvWDwppv442ou8OK1l0vrU2VSl9pLw6+RLIVyXBnvk29uz39sQrZ21HP0elTjU
         jwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959275; x=1690551275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUR2HzgwIlf0PNY2Vlu5mCQ2oSpb3hPdwXu6404Qku0=;
        b=e/Tc20MPjQ77vDyt0wgK5+L6JnXu/3gE3o5uugI9oYx7FXu8YjFx6ae3pg6t8ZHJN0
         wVphnJkZhShE0etfmw8pP9Lkd682GsDH/LHV7hkEU4aD6t2X3joTlBpTn0ppJK6NADmm
         07IWFFHaMSCxuFnLI6jduoJO4ypkzyH8PVz1vfL7zWUm4w/zoaKnVExuOhfO6U1Pc+KL
         TZ1DPor/PlFG4DVE5RcpnlOi4zj3Y1W/XdY102xqpUho6oNtzaDj2JHa6eeNfUAFgzLX
         KGwWXxi9DrQerTNYc83lTmTdlTH9BXpfU4t1+cop19ELurDzjf1Bijx4RmfDb0SSt301
         3ICQ==
X-Gm-Message-State: AC+VfDwjTjJmukREwsZ1uz9r1ugjZwkeOSjcnD0dM2yVQmUUA3n6mxg0
        RseGlRyVmLkTyegnQwYajUO8JaMeZwOo7DWZhFg=
X-Google-Smtp-Source: ACHHUZ5izNmMxQPGPvKpE54joa1VYbocTWHIWTi8LLxZlvEZ1L47Rxm4yWKPBneZKIiIgSemk7TNPQ==
X-Received: by 2002:ac8:5e53:0:b0:3f6:c609:e9da with SMTP id i19-20020ac85e53000000b003f6c609e9damr42900911qtx.44.1687959275398;
        Wed, 28 Jun 2023 06:34:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id cc23-20020a05622a411700b003f7fd3ce69fsm2766717qtb.59.2023.06.28.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:34:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qEVJa-009NuX-4G;
        Wed, 28 Jun 2023 10:34:34 -0300
Date:   Wed, 28 Jun 2023 10:34:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Subject: Re: [GIT PULL] RCU changes for v6.5
Message-ID: <ZJw26orq0ZLEOL9q@ziepe.ca>
References: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
 <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
 <fcc987bb-4ce4-4816-a909-cffa4c3f24ff@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc987bb-4ce4-4816-a909-cffa4c3f24ff@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 27, 2023 at 11:30:46AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 27, 2023 at 10:56:21AM -0700, Linus Torvalds wrote:
> > On Sun, 25 Jun 2023 at 08:35, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.06.22a
> > >
> > > o       Eliminate the single-argument variant of k[v]free_rcu() now
> > >         that all uses have been converted to k[v]free_rcu_mightsleep().
> > 
> > Well, clearly not all users had been.
> > 
> > The base of this RCU was v6.4-rc1, and when that commit was done, we
> > still had a single-argument variant:
> > 
> >   7e3f926bf453 ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")
> > 
> > but look here:
> > 
> >      git grep 'kfree_rcu([^,()][^,()]*)' 7e3f926bf453
> > 
> > results in
> > 
> >    7e3f926bf453:drivers/infiniband/sw/rxe/rxe_verbs.c:     kfree_rcu(mr);
> > 
> > so the RCU tree itself can not possibly have built cleanly.
> > 
> > How the heck did this pass testing in linux-next? Did linux-next just
> > assume that it was a merge error, and fix it up?
> 
> Because idiot here failed to notice that the needed change was only
> in -next, and not yet in mainline.

It passed testing in linux-next because Stephen fixes eveything so it compiles:

https://lore.kernel.org/all/20230328121609.68105dd5@canb.auug.org.au/

It seems Stephen's report is a bit odd because it wasn't a merge issue
vs rdma, it was vs v6.4-rc1..

I suppose the question is why didn't something like Intel 0-day catch
it when it trial compiled the RCU tree's branch.

BTW, Stephen's merge is different than yours, his is based on Bob's
note here:

https://lore.kernel.org/linux-rdma/e704127e-1bfe-f351-db95-bfea6916e8f9@gmail.com/

I'll fix it in the next cycle.

Thanks,
Jason
