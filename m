Return-Path: <SRS0=XkjU=AY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E5DC4345B
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 23:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41652137B
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 23:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpQg48ZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgGMXk0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGMXkZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jul 2020 19:40:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4F4C061755;
        Mon, 13 Jul 2020 16:40:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so6744838pfn.7;
        Mon, 13 Jul 2020 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fpsv8EDerh6qiZyDs3oAMWjUrkMyk3YGPRpChzbjH/Y=;
        b=rpQg48ZPDV28n5UtMGQ/3OWyaUmfcwnkyJjCbMUIhC3HLfxLQcC7PwLnVoCTsp35By
         bpeANVwJ8mvLd8tM37SeLcFg2J7TQZtrURBKocWk6iud0xJrzlZ5qRtAmZk5eeumwL1X
         +v/ndjJ9dAGHI96Ht7SDzWqfITAZ4Md2Ac3ftwZ1uecL6HAT9RTFPOfH0CpdaX2rgCvT
         koQWmxoZ2L4ZvvCsCPXSQfLS9lRBueXqYSIWIF4iUc6Y3IS9fRSt8h2RimOBu27PGJd0
         WvmUWAPImGksgD3n0vXcs6Hyf9GBXQgwxGu5jEQTP9sXHCFZo4/ylcxfxbUYLRo6wA80
         4Yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fpsv8EDerh6qiZyDs3oAMWjUrkMyk3YGPRpChzbjH/Y=;
        b=iYy8dQDFgX+NUB0M3/OsztMRFEDlNEkvgXuYOl2eauSGwTjoH/aBdAAdJq0M5M9wrC
         2IIFxmXQGHz450t+qwcCVAi18eIgXREv6KnkWD5FVQ3fMaSsMEfEWSVlEiR+KY0NtL7x
         tMRh5K0hwsMQBYhpO3lrdaelrQGe+on9MB/u9DbjqouRdIdyVdjpI8AkXWGAxOCdqbfz
         Ilfd6qNIF6zqnpM80rRsk11LH1dYRDewhBzEjRzzyVaYQJ36gVlzXWsyaf3kzQM1lzJ6
         bA8l6S7nKLHURhFtYEfkzFuvH1V4T27xqVNoBO4k/1iOgR83Flq7I1iJc7QO5xXG28Qt
         fc9g==
X-Gm-Message-State: AOAM5312fFPQ+ybj4q3lvqbSFmdU4JOnKBwLYrb++CqZZU+6xR3nKQyB
        oCaNgcFHoX9DzG2jmIONyAgrJYsMIA==
X-Google-Smtp-Source: ABdhPJwIKVp/kyEpvOizsp28hvM5goUAD5BMaRKk9t8L6zq4F7HWzFMsgj7PVea9g8JVfFchZwAhpg==
X-Received: by 2002:a62:6305:: with SMTP id x5mr1962511pfb.81.1594683624308;
        Mon, 13 Jul 2020 16:40:24 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2409:4071:200a:9520:4919:edd3:5dbd:ffec])
        by smtp.gmail.com with ESMTPSA id nv9sm614823pjb.6.2020.07.13.16.40.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jul 2020 16:40:23 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Tue, 14 Jul 2020 05:10:18 +0530
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Fix _list_check_srcu() macro
Message-ID: <20200713234017.GA23191@madhuparna-HP-Notebook>
References: <20200713174846.8681-1-madhuparnabhowmik10@gmail.com>
 <20200713210244.GL9247@paulmck-ThinkPad-P72>
 <20200713211315.GA19516@madhuparna-HP-Notebook>
 <20200713212624.GM9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713212624.GM9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 13, 2020 at 02:26:24PM -0700, Paul E. McKenney wrote:
> On Tue, Jul 14, 2020 at 02:43:16AM +0530, Madhuparna Bhowmik wrote:
> > On Mon, Jul 13, 2020 at 02:02:44PM -0700, Paul E. McKenney wrote:
> > > On Mon, Jul 13, 2020 at 11:18:46PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > > > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > > 
> > > > This patch fixes the macro _list_check_srcu() for CONFIG_PROVE_RCU_LIST =
> > > > False.
> > > > 
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > 
> > > Thank you, Madhuparna!  I am folding this into your original, but
> > > with lowercase "true".
> > >
> > I am really sorry and thanks for applying this with the correction.
> 
> No worries!  Just thought that I should mention it in case there was
> some subtle reason why TRUE was needed in this case.  ;-)
>
No, it was just a mistake.

Thanks,
Madhuparna

> 							Thanx, Paul
> 
> > > > ---
> > > >  include/linux/rculist.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > > > index 516b4feb2682..a435ad62b90b 100644
> > > > --- a/include/linux/rculist.h
> > > > +++ b/include/linux/rculist.h
> > > > @@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> > > >  #define __list_check_rcu(dummy, cond, extra...)				\
> > > >  	({ check_arg_count_one(extra); })
> > > >  
> > > > -#define __list_check_srcu(cond)
> > > > +#define __list_check_srcu(cond)	TRUE
> > > >  #endif
> > > >  
> > > >  /*
> > > > -- 
> > > > 2.17.1
> > > > 
