Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBB2C2D0F3
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D645D20714
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbCNhISd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbgDANIy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:08:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37101 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbgDANIy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 09:08:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id t11so7974363lfe.4;
        Wed, 01 Apr 2020 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SAMZUrHaf9+RJFVzBuxmwfwyF3KI+8bOUUiedYkh9UA=;
        b=qbCNhISdI8VVhTxlTzY9nM4qXcKO6SIwA1oawJ6VK2y4WGQ1j6hWsnlY/ylVqM3alN
         tkNRpk5FVjk0EKPVdhJXWgneuYZSx8dNJeqrw6b5y7NbjCu7vnWZDFtonaJpc3XOetJP
         mw0/gGdhUrZyFfoCUno2VS4w5aiiKumdFRzNI1lJ81vpKDvT6OPDFLNPv+Ypodoipd7+
         Q/2Mrjcyfp1kSrkGv0uaTvvRyDqtMdx7FHtP3PLAZdOuz1z/tNFMeJLIXDDsTBaI6GWW
         0x/2I7OXACf4UMONK/cjNI410Vn2LVZMjsbb89P2w09hckXpwZRDTbY8xgzyr/euZwHA
         DVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SAMZUrHaf9+RJFVzBuxmwfwyF3KI+8bOUUiedYkh9UA=;
        b=aHgUwQ864uhQ/NSmWMMEJJEpXFT0A/LTzFy4eID3MPHALaVxnoOP9ZaBG457+eRbH1
         AfB+8QtfAGH0cuIxsZ/PF4LYc+ScsxzgHz4oHkv93QSvYjdd9QvVfwk3dRePeBR2e60R
         /CytIEzHbDCN2uNOtWI0cXUVkbZp4NnqMkkbsEzE9YO1ctH3i2z5Uyn88BDIo/vawEEt
         2+LZF4ROJJualYt0e8O2A6s0DiamYkaNUnJC2/+YgNOVBwmSfKOXay1brFnAs8zbbMjn
         9UnwYOmS3sUYPI5JhwjcEimxBD8/EKBLtgVvm6eRZewwAKS50nwjFyHfLGhOpujONN8k
         xcBQ==
X-Gm-Message-State: AGi0PuZ2Bz47oS2mKWonD7XLximLlQR0BGApBIyZKWaEN4t9LNOD8PsZ
        15d4GNEWydelr637qX6/CzM=
X-Google-Smtp-Source: APiQypIhWeIoS93e5yzk4/qeD1qrfju0rtki36oK084hXQpYg/f8LwNtxYAH4W+oyPR2KRqxtihvpg==
X-Received: by 2002:a19:ee18:: with SMTP id g24mr15037760lfb.29.1585746530768;
        Wed, 01 Apr 2020 06:08:50 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v20sm1557413lfe.52.2020.04.01.06.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 06:08:49 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 15:08:16 +0200
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
Message-ID: <20200401130816.GA1320@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331161215.GA27676@pc636>
 <20200401070958.GB22681@dhcp22.suse.cz>
 <20200401123230.GB32593@pc636>
 <20200401125503.GJ22681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401125503.GJ22681@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 02:55:03PM +0200, Michal Hocko wrote:
> On Wed 01-04-20 14:32:30, Uladzislau Rezki wrote:
> > On Wed, Apr 01, 2020 at 09:09:58AM +0200, Michal Hocko wrote:
> > > On Tue 31-03-20 18:12:15, Uladzislau Rezki wrote:
> > > > > 
> > > > > __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
> > > > > memory reserves regarless of the sleeping status.
> > > > > 
> > > > Michal, just one question here regarding proposed flags. Can we also
> > > > tight it with __GFP_RETRY_MAYFAIL flag? Means it also can repeat a few
> > > > times in order to increase the chance of being success.
> > > 
> > > yes, __GFP_RETRY_MAYFAIL is perfectly valid with __GFP_ATOMIC. Please
> > > note that __GFP_ATOMIC, despite its name, doesn't imply an atomic
> > > allocation which cannot sleep. Quite confusing, I know. A much better
> > > name would be __GFP_RESERVES or something like that.
> > > 
> > OK. Then we can use GFP_ATOMIC | __GFP_RETRY_MAYFAIL to try in more harder
> > way.
> 
> Please note the difference between __GFP_ATOMIC and GFP_ATOMIC. The
> later is a highlevel flag to use for atomic contexts. The former is an
> explicit way to give an access to memory reserves. I am not familiar
> with your code but if you have an existing gfp context coming from the
> caller then just do (gfp | __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL).
> If you do not have any gfp then decide based on whether the current
> context is allowed to sleep
> 	gfp = GFP_KERNEL | __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL;
> 	if (!sleepable)
> 		gfp &= ~__GFP_DIRECT_RECLAIM;

We call it from atomic context, so we can not sleep, also we do not have
any existing context coming from the caller. I see that GFP_ATOMIC is high-level
flag and is differ from __GFP_ATOMIC. It is defined as:

#define GFP_ATOMIC (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)

so basically we would like to have __GFP_KSWAPD_RECLAIM that is included in it,
because it will also help in case of high memory pressure and wake-up kswapd to
reclaim memory.

We also can extract:

__GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL | __GFP_KSWAPD_RECLAIM

but that is longer then

GFP_ATMOC |  __GFP_RETRY_MAYFAIL

Am i missing something?

Thank you, Michal!

--
Vlad Rezki
