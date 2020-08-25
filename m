Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C406C433E1
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4122075F
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 19:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598385485;
	bh=gTvnzTg+mh28yy9zqmATxGIIdaAhnLyvMTWA22zHNvs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hb3H0OlkkfPyQx9XbgtgPxbmzKXbIiHOaBW2prxgi/sPqNn5J8JMOjT/eoPmooIu7
	 KQzP6Ucaw5xUxNMFcH1TKeWHoa1oBEUYqvZE89eGlStDpAwTrb4yurIwInVmSYIFgO
	 sMC4Myt/wNmEojQRnyUagQ6XMQt+SyLTa3yzf6cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHYT6F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHYT6E (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Aug 2020 15:58:04 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F71B2074D;
        Tue, 25 Aug 2020 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598385483;
        bh=gTvnzTg+mh28yy9zqmATxGIIdaAhnLyvMTWA22zHNvs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DCaCFv42ZpU14KZD7iJxSZtD5MEEWCdwE3yFALD9cUx3kcX+BDXKUHx8/D2xJKQ2h
         +/3lqsihXNrjV6iCNYTKhYNDzS8tHaZJpKsfwsb4Eq3+xI09MdsozZc3bFL1C18xNK
         uq0s0U75OVIolNI0SamqgtHr4mM39LbaVyyfcWks=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 30B1135226AE; Tue, 25 Aug 2020 12:58:03 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:58:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dave@stgolabs.net, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: Re: [PATCH v4 -rcu 0/4] Maintain the length of each segment in the
 segcblist
Message-ID: <20200825195803.GV2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200825024842.3408659-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825024842.3408659-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 24, 2020 at 10:48:38PM -0400, Joel Fernandes (Google) wrote:
> This is required for several usecases identified. One of them being tracing how
> the segmented callback list changes. Tracing this has identified issues in RCU
> code in the past. The trace patch is the last one in this series.

Thank you for doing this!  Another use case is of course more accurately
determining whether a given CPU's large pile of callbacks can be best
served by making grace periods go faster, invoking callbacks more
vigorously, or both.  It should also be possible to simplify some of
the callback handling a bit, given that some of the unnatural acts are
due to there having been no per-batch counts.

							Thanx, Paul

> Passes 30 minutes of TREE01, TREE03, TREE07.  Testing of other TREE configs is
> in progress.
> 
> Patches are based on -rcu commit:
> 4f43de2a419a ("Merge branch 'lkmm-dev.2020.08.24a' into HEAD")
> 
> Revision history:
> v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
>     Fixed minor nit from Davidlohr.
> v1->v3: minor nits.
> (https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@joelfernandes.org/)
> 
> Joel Fernandes (Google) (4):
> rcu/segcblist: Do not depend on rcl->len to store the segcb len during
> merge
> rcu/tree: Make rcu_do_batch count how many callbacks were executed
> rcu/segcblist: Add counters to segcblist datastructure
> rcu/trace: Add tracing for how segcb list changes
> 
> include/linux/rcu_segcblist.h |   2 +
> include/trace/events/rcu.h    |  25 +++++++
> kernel/rcu/rcu_segcblist.c    | 119 ++++++++++++++++++++++++++++++++--
> kernel/rcu/rcu_segcblist.h    |   8 +++
> kernel/rcu/tree.c             |  32 +++++++--
> 5 files changed, 175 insertions(+), 11 deletions(-)
> 
> --
> 2.28.0.297.g1956fa8f8d-goog
> 
