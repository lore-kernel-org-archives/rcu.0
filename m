Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF1C2D0E5
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E47206F6
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 18:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585592499;
	bh=ZTAGOIQwksFTh1Yuz3cAFvv/AlGII90X1jBROlkFK+4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=uWt6J/YvXq9Gfvf0AvnxLOVQKapB0E0XAum9zRWf78HV8K0XmpW25Wlk7Ljh/LTWg
	 C5nQBFrmMxh76KgLwNjLfu9DlV1dOU80aTsBqHSU6ZmJQa+fzC2XtvIWDCdxWA1gzu
	 SjQlPXulHQ01XJ4pDVVsBYGgN6hkSYL/yElpQW1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgC3SVi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgC3SVi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Mar 2020 14:21:38 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C132072E;
        Mon, 30 Mar 2020 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585592497;
        bh=ZTAGOIQwksFTh1Yuz3cAFvv/AlGII90X1jBROlkFK+4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BFiOkZ4IExrXwrQhQpBmT+X/eh4+hc3mAFFcLDbfscJ9Ut340tRd1gNXfepZ0F19x
         Jm4BMcrkL3eo6P9v73z0WN4ay1YZzTVqlAXJscEXx0Enp3x0ApIDidsZ9ycfXUI6K0
         1KDnVEgq5LOBxdR743PaiutpnQKHuR1rlbnGNbaA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7783B35226F8; Mon, 30 Mar 2020 11:21:37 -0700 (PDT)
Date:   Mon, 30 Mar 2020 11:21:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Matthew Wilcox <willy@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 10/18] rcu/tree: Maintain separate array for vmalloc ptrs
Message-ID: <20200330182137.GM19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200330023248.164994-11-joel@joelfernandes.org>
 <202003301715.9gMSa9Ca%lkp@intel.com>
 <20200330152951.GA2553@pc636>
 <20200330153149.GE22483@bombadil.infradead.org>
 <20200330153702.GK19865@paulmck-ThinkPad-P72>
 <20200330171606.GA166021@google.com>
 <20200330174338.GA3690@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330174338.GA3690@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 30, 2020 at 07:43:38PM +0200, Uladzislau Rezki wrote:
> On Mon, Mar 30, 2020 at 01:16:06PM -0400, Joel Fernandes wrote:
> > On Mon, Mar 30, 2020 at 08:37:02AM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 30, 2020 at 08:31:49AM -0700, Matthew Wilcox wrote:
> > > > On Mon, Mar 30, 2020 at 05:29:51PM +0200, Uladzislau Rezki wrote:
> > > > > Hello, Joel.
> > > > > 
> > > > > Sent out the patch fixing build error.
> > > > 
> > > > ... where?  It didn't get cc'd to linux-mm?
> > > 
> > > The kbuild test robot complained.  Prior than the build error, the
> > > patch didn't seem all that relevant to linux-mm.  ;-)
> > 
> > I asked the preprocessor to tell me why I didn't hit this in my tree. Seems
> > it because vmalloc.h is included in my tree through the following includes. 
> > 
> Same to me, i did not manage to hit that build error.

This is a common occurrence for me.  The kbuild test robot can be very
helpful for this sort of thing.  ;-)

							Thanx, Paul
