Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40976C43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 15:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C0C20776
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585582624;
	bh=NxhJeMLF0gnxS/GblNknvb9xP2ZS9OcVmH7tETNg9Z4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=r3RJfO15JFwa3QWgIm9c0SdMlTtUY04ESw7mCIPl+ujr8S1P9QWfM0/w4sB+XCmex
	 fHn1xFXAtqK9qwaebavLf4/mpDhAoI4yQ4SOeDzVX/4aJ0z6smMCLVisCndyWF/YFo
	 +rGOHut4LwRkm54DEbWyujArKoYvYszIIU17xH5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgC3PhD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgC3PhD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Mar 2020 11:37:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EDEA2072E;
        Mon, 30 Mar 2020 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585582623;
        bh=NxhJeMLF0gnxS/GblNknvb9xP2ZS9OcVmH7tETNg9Z4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FDf/PwPyRN400wtCaAxGQhid3YIjr0xYLTyatS1blvlsORMBhNM94oLgXc/0O8eCF
         5o6yBKTbT4SfvEYqqYdmowTBnmRtWRMDnQPO2MZ3OAj5dLWJqbS5mytplRpt61aZ50
         AYuHwHJu35FpobEzqzCbwdwkmJ8JrPt0maoM+BO8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EAE6835226E3; Mon, 30 Mar 2020 08:37:02 -0700 (PDT)
Date:   Mon, 30 Mar 2020 08:37:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 10/18] rcu/tree: Maintain separate array for vmalloc ptrs
Message-ID: <20200330153702.GK19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200330023248.164994-11-joel@joelfernandes.org>
 <202003301715.9gMSa9Ca%lkp@intel.com>
 <20200330152951.GA2553@pc636>
 <20200330153149.GE22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330153149.GE22483@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 30, 2020 at 08:31:49AM -0700, Matthew Wilcox wrote:
> On Mon, Mar 30, 2020 at 05:29:51PM +0200, Uladzislau Rezki wrote:
> > Hello, Joel.
> > 
> > Sent out the patch fixing build error.
> 
> ... where?  It didn't get cc'd to linux-mm?

The kbuild test robot complained.  Prior than the build error, the
patch didn't seem all that relevant to linux-mm.  ;-)

							Thanx, Paul
