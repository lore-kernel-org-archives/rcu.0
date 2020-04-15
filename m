Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F66C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3840020857
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971952;
	bh=ZahoOvyOJcz1kFNY6YQVGLuycCJ0tnOyCUQXs09WDtg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=uJL1lYpEDNTcMIxNHwqv0YqLNsNowD8qyfyjb/eDwoKGWuuix9ddYcAD1hV/aAsQ2
	 wWB0nyrA3/1bSuWkRupgedfN2Jy9F3dqO8cQwb6rCaA1UXdKZbFLnp4m0m1krqIJH8
	 vvvMV08aElPpZKag0Zm2T7ZxrsgfuDhUGWpkUiV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411266AbgDORcb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411221AbgDORcX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:32:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B916120784;
        Wed, 15 Apr 2020 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971942;
        bh=ZahoOvyOJcz1kFNY6YQVGLuycCJ0tnOyCUQXs09WDtg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SXCCgBYf+vKvTrZv6ilOYFIQM6B39QsXb5IQL4aVV80MDAgsZopmIArjyB7niCakS
         7aozcbMCmFKjJFMy3pJWKBwCNrvdTRiUIJd50Q0AHJ8MDsYljT6+Acl8I1+U2g2I+t
         J2YfBrXloDDVhd2RQtEYSHCyIgwrMbypafcifsLk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 853D63522AD1; Wed, 15 Apr 2020 10:32:22 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:32:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/19] Miscellaneous fixes for v5.8
Message-ID: <20200415173222.GA17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
 <20200415102123.0f87e15747aac6733233dd52@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415102123.0f87e15747aac6733233dd52@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 15, 2020 at 10:21:23AM -0700, Andrew Morton wrote:
> On Wed, 15 Apr 2020 10:10:17 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Subject: [PATCH tip/core/rcu 0/19] Miscellaneous fixes for v5.8
> 
> I was hoping we could get at least the data_race() implementation
> into 5.7-rc1 - I'm sitting on a pile of patches which use it.  Oh well,
> next time.

I could put the stubs somewhere more visible, if that would help.
Me, I ran out of patience, so you are a better man than am I!  ;-)

							Thanx, Paul
