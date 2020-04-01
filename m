Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0894CC2D0F3
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 15:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD4820B1F
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 15:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZRaDOcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbgDAPqc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:46:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35776 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732889AbgDAPqc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 11:46:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id k21so26305401ljh.2;
        Wed, 01 Apr 2020 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGo2AC3bFo0cX0Y80FNvQpP9bE2/c336JeB41lJRyRE=;
        b=tZRaDOcYiY6nTed7mYmAPRDObnjaWlOo8msoex1+RLkm5gRTGA7S/T7pIUv688qVWC
         9KQtH9PEB9F9WD9iur48UFi0rhlm5OlkBh4BC56uASN6dSjf/4yz/puLfcZwm9ovxsMm
         ZIuNxR4sMs2HNZHIAQ05TJQbaKiy6joyqe0KXFvDo1VW/jpri9RYQJkSWFXp+91cFSO/
         nOjcwx+pmIYUBonKXicJWR2I/gDWlGfRoOpHFdlRQmcU+llIMqvdV2pCVTPdKOBrTwvF
         SwC51wSyLqib99jVteWF9BH+lDGytmvrIdEN5YhNrhhnsXiQyvdyOPTo/d1+eJ+0D1Ra
         4zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGo2AC3bFo0cX0Y80FNvQpP9bE2/c336JeB41lJRyRE=;
        b=mxfUgSQlqy6OdFE19okhc5VNUK5/1i5+knN9Vzd39EcrzlmBsQT1hudey3FsjTliLA
         T+F0dq/8U6H3b9gozSdEvCK7hroEAiGVIPbzamRO2qfBRkr0wHv6NoSjFZfvR/jxuXme
         70FZAsBzmzUMMPESH867hD33/ERJTodcHpjklkHSPYyXjyfjNbKiw5AmAeKkAkd1bmhw
         MYs9s5W/QKOIysNjTolQE6w5V6bU8mk87MgfmPi24U/qn5qZkDCt4DSSuxQKm3b0PYz7
         PnGHWuTdVlWPV4rtiev+NeyyudnVGqoqW2AGFzwrgNgQmBh1Gq1GQFHx9G2QIXlgSmGm
         FvhA==
X-Gm-Message-State: AGi0Pua2b/1NJo4rmcHtwivAt7+NFg95ro+ZN6D8FFur6Kb83ySUIGbR
        FN3tdvmHStkQXWU+p3sWf9nGfOzyNQU=
X-Google-Smtp-Source: APiQypL/Qg1CoRp9yBB1IV0crCY7gmXDJZBXEVq3T4dQMlAcRYjXGvdxK6t57DKmKs/y3+6db0r/vQ==
X-Received: by 2002:a2e:8195:: with SMTP id e21mr13332304ljg.49.1585755989539;
        Wed, 01 Apr 2020 08:46:29 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v20sm1839292lfe.52.2020.04.01.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:46:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 17:46:18 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401154618.GA3907@pc636>
References: <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331161215.GA27676@pc636>
 <20200401070958.GB22681@dhcp22.suse.cz>
 <20200401123230.GB32593@pc636>
 <20200401125503.GJ22681@dhcp22.suse.cz>
 <20200401130816.GA1320@pc636>
 <20200401131528.GK22681@dhcp22.suse.cz>
 <20200401132258.GA1953@pc636>
 <20200401152805.GN22681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401152805.GN22681@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > 
> > > OK, if you are always in the atomic context then GFP_ATOMIC is
> > > sufficient. __GFP_RETRY_MAYFAIL will make no difference for allocations
> > > which do not reclaim (and thus not retry). Sorry this was not clear to
> > > me from the previous description.
> > > 
> > Ahh. OK. Then adding __GFP_RETRY_MAYFAIL to GFP_ATOMIC will not make any effect.
> > 
> > Thank you for your explanation!
> 
> Welcome. I wish all those gfp flags were really clear but I fully
> understand that people who are not working with MM regurarly might find
> it confusing. Btw. have __GFP_RETRY_MAYFAIL is documented in gfp.h and
> it is documented as the reclaim modifier which should imply that it has
> no effect when the reclaim is not allowed which is the case for any non
> sleeping allocation. If that relation was not immediately obvious then I
> think we need to make it explicit. Would you find it useful?
> 
> E.g.
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index e3ab1c0d9140..8f09cefdfa7b 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -127,6 +127,8 @@ struct vm_area_struct;
>   *
>   * Reclaim modifiers
>   * ~~~~~~~~~~~~~~~~~
> + * Please note that all the folloging flags are only applicable to sleepable
> + * allocations (e.g. %GFP_NOWAIT and %GFP_ATOMIC will ignore them).
>   *
>   * %__GFP_IO can start physical IO.
>   *
That would be definitely clear for me!

--
Vlad Rezki
