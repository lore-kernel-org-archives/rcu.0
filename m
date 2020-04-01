Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1A4C43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA2B20BED
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585756634;
	bh=tioNAsS3DXtvfdYJuukfF3Fr46kSHb9D2ocEQNKzcF0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=DozQ89p+8+vjIpn1mXXIBf3PDFuNWWfOnCMnA5U0lQymsGKQgpWT1vb38VYUx9ab9
	 wIXeBqqNUNRo2v02c79IDYXaJpFke+M9FEaCqYpqxHOW+Al+wStEUI0o5iGmlWe9YR
	 i+S9bnyjxjt0JzUxf5DvZgn6dQkNnHhtGjYnc6bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbgDAP5O (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732799AbgDAP5O (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 11:57:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A3120658;
        Wed,  1 Apr 2020 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585756632;
        bh=tioNAsS3DXtvfdYJuukfF3Fr46kSHb9D2ocEQNKzcF0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mhVtctcEFPKIgGEO5NcxHa5nQMx3qy67dZeIj82TsBe05rJ1G3dORpVK6cBkf+fq5
         0IOTxy98mC5CBVeTR8gsrMotfLxi6PsUyFd+QtX3Jhgwv24fPmhB7yqG7FxyO1XnmQ
         2lJd80/FLGziLJzCZkYkkS0D+Ckpt/z+u/xmcJGI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 58D173522887; Wed,  1 Apr 2020 08:57:12 -0700 (PDT)
Date:   Wed, 1 Apr 2020 08:57:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
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
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401155712.GA15147@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
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
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 05:28:05PM +0200, Michal Hocko wrote:
> On Wed 01-04-20 15:22:58, Uladzislau Rezki wrote:
> > > > We call it from atomic context, so we can not sleep, also we do not have
> > > > any existing context coming from the caller. I see that GFP_ATOMIC is high-level
> > > > flag and is differ from __GFP_ATOMIC. It is defined as:
> > > > 
> > > > #define GFP_ATOMIC (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
> > > > 
> > > > so basically we would like to have __GFP_KSWAPD_RECLAIM that is included in it,
> > > > because it will also help in case of high memory pressure and wake-up kswapd to
> > > > reclaim memory.
> > > > 
> > > > We also can extract:
> > > > 
> > > > __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL | __GFP_KSWAPD_RECLAIM
> > > > 
> > > > but that is longer then
> > > > 
> > > > GFP_ATMOC |  __GFP_RETRY_MAYFAIL
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

One nit below, but either way:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index e3ab1c0d9140..8f09cefdfa7b 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -127,6 +127,8 @@ struct vm_area_struct;
>   *
>   * Reclaim modifiers
>   * ~~~~~~~~~~~~~~~~~
> + * Please note that all the folloging flags are only applicable to sleepable

s/folloging/following/

> + * allocations (e.g. %GFP_NOWAIT and %GFP_ATOMIC will ignore them).
>   *
>   * %__GFP_IO can start physical IO.
>   *
> -- 
> Michal Hocko
> SUSE Labs
