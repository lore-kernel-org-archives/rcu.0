Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D0C43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 13:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B382077D
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585746933;
	bh=Qw5UkCfWUouqsZ0lF98v7H7n8RFq7s26OLUDW22L0Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JJowi4xT9qd0CLPj7FVAosUdMzhKmkdWUKymrVT0C1LZsMzvtAixhz2BVE14sKqm0
	 gR5c1xGoFIB9ip0xU97mDqc6eZOLGT+8Oqm26DFoP7n3IBImyIGcQL8dbpRhQwI2mZ
	 sDhr/8uBt4Y7gA+FXhtdnI65n3Vtuun71+X6PC+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbgDANPd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:15:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34492 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbgDANPd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 09:15:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so11663wrl.1;
        Wed, 01 Apr 2020 06:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nqvkqNGMuXID7lI1fswCDVvlcVmjjuU+dPdiaYDon8=;
        b=ZMotiFppu5iYsPChFvwvBQh/MQJMsRnpm3U+vY/0F5TcGnI2uMkrVBL7FqFjMdo8+g
         wqmEnxJNxBMXwv/DeaIe8bIOLIjLevo5+p1xJIJHakkklNh5No3dPIXNXCJbJnZNIUKe
         L4fn84Kb9Bphv8LQQAMZqdV5OSDCI+8t0BD1HUpMCTfSgVtcyRqg2KPSBUAA/NAg8JoQ
         QaEACPi/WYViZzz+NjuKe6VgLr0nJFp8gsl3SYW8w86oD+0zD+3jaEA0SzByS69pR0oZ
         hjPSogukvvGjyHTDB4PniY1BEYmAD5hC/jYJI7xPc7t3O8kSOeh1lbrrjB/O2gdcBMG/
         sK/A==
X-Gm-Message-State: ANhLgQ3V7X7RYmt3Vxw2mdSqf3kC2T9vxtnN0bMwIR/Cj1kf1EKhDo+F
        Vi5RnA6cI/U3gtdj8UCvgvk=
X-Google-Smtp-Source: ADFU+vuLQ5n4h2oATutOYE6daFLh+JwtCBKG5iEDDxu7W0Ra0C4tfAkK3wF9YRRGd1pPcMZnI7nwYA==
X-Received: by 2002:a5d:49c8:: with SMTP id t8mr26498357wrs.5.1585746930942;
        Wed, 01 Apr 2020 06:15:30 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id t10sm2651323wrx.38.2020.04.01.06.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 06:15:30 -0700 (PDT)
Date:   Wed, 1 Apr 2020 15:15:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <20200401131528.GK22681@dhcp22.suse.cz>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331161215.GA27676@pc636>
 <20200401070958.GB22681@dhcp22.suse.cz>
 <20200401123230.GB32593@pc636>
 <20200401125503.GJ22681@dhcp22.suse.cz>
 <20200401130816.GA1320@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401130816.GA1320@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 01-04-20 15:08:16, Uladzislau Rezki wrote:
> On Wed, Apr 01, 2020 at 02:55:03PM +0200, Michal Hocko wrote:
> > On Wed 01-04-20 14:32:30, Uladzislau Rezki wrote:
> > > On Wed, Apr 01, 2020 at 09:09:58AM +0200, Michal Hocko wrote:
> > > > On Tue 31-03-20 18:12:15, Uladzislau Rezki wrote:
> > > > > > 
> > > > > > __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
> > > > > > memory reserves regarless of the sleeping status.
> > > > > > 
> > > > > Michal, just one question here regarding proposed flags. Can we also
> > > > > tight it with __GFP_RETRY_MAYFAIL flag? Means it also can repeat a few
> > > > > times in order to increase the chance of being success.
> > > > 
> > > > yes, __GFP_RETRY_MAYFAIL is perfectly valid with __GFP_ATOMIC. Please
> > > > note that __GFP_ATOMIC, despite its name, doesn't imply an atomic
> > > > allocation which cannot sleep. Quite confusing, I know. A much better
> > > > name would be __GFP_RESERVES or something like that.
> > > > 
> > > OK. Then we can use GFP_ATOMIC | __GFP_RETRY_MAYFAIL to try in more harder
> > > way.
> > 
> > Please note the difference between __GFP_ATOMIC and GFP_ATOMIC. The
> > later is a highlevel flag to use for atomic contexts. The former is an
> > explicit way to give an access to memory reserves. I am not familiar
> > with your code but if you have an existing gfp context coming from the
> > caller then just do (gfp | __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL).
> > If you do not have any gfp then decide based on whether the current
> > context is allowed to sleep
> > 	gfp = GFP_KERNEL | __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL;
> > 	if (!sleepable)
> > 		gfp &= ~__GFP_DIRECT_RECLAIM;
> 
> We call it from atomic context, so we can not sleep, also we do not have
> any existing context coming from the caller. I see that GFP_ATOMIC is high-level
> flag and is differ from __GFP_ATOMIC. It is defined as:
> 
> #define GFP_ATOMIC (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
> 
> so basically we would like to have __GFP_KSWAPD_RECLAIM that is included in it,
> because it will also help in case of high memory pressure and wake-up kswapd to
> reclaim memory.
> 
> We also can extract:
> 
> __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL | __GFP_KSWAPD_RECLAIM
> 
> but that is longer then
> 
> GFP_ATMOC |  __GFP_RETRY_MAYFAIL

OK, if you are always in the atomic context then GFP_ATOMIC is
sufficient. __GFP_RETRY_MAYFAIL will make no difference for allocations
which do not reclaim (and thus not retry). Sorry this was not clear to
me from the previous description.

-- 
Michal Hocko
SUSE Labs
