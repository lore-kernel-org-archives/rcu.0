Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126B0C6FA82
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 19:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiITTNn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiITTNm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 15:13:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A675CF5
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 12:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E45356230F
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 19:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E3BC433C1;
        Tue, 20 Sep 2022 19:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663701220;
        bh=UGK6kcWEKXVITruzBJa3ajK79d4fj4/g8v4dNrP1yvc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I7PwW2B0LFZBowcJtcgn5mlLBmA2vskiYjGi7d3+SMgBgrWjudny3BjA5sBkQJsdO
         zQrNaVrIw1qOm/wX2MJx+KJfElDMcHJtt95ic9S5IBAwdioE1OJ+uQD6FRuCusVCUO
         EQxyVHVniins1tFEbHRwT+rZBWURabz2td3gXztQu/8x+33qKMtjOfC86dQLVgXS4B
         AC8VoVD22IGepszMxaZkE3jyiko5Ay/L8E6EYpxzStkTST7apaYIgeta6c+p64V9Xx
         7awc3IBylY8K/nl63HsIiifB0vhd58TpfCGgDJultsIEppunPwPc34t9fOj5nyOMIU
         eaw2ZkaGg9GNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C5D405C0AEC; Tue, 20 Sep 2022 12:13:39 -0700 (PDT)
Date:   Tue, 20 Sep 2022 12:13:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen>
 <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920094645.GG69891@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 20, 2022 at 11:46:45AM +0200, Frederic Weisbecker wrote:
> On Tue, Sep 20, 2022 at 03:26:28PM +0800, Pingfan Liu wrote:
> > On Fri, Sep 16, 2022 at 03:42:58PM +0200, Frederic Weisbecker wrote:
> > > Note this is only locking the rdp's node, not the root node.
> > > Therefore if CPU 0 and CPU 256 are going off at the same time and they
> > > don't belong to the same node, the above won't protect against concurrent
> > > TICK_DEP_BIT_RCU set/clear.
> > > 
> > 
> > Nice, thanks for the careful thoughts. How about moving the counting
> > place to the root node?
> 
> You could but then you'd need to lock the root node.
> 
> > > My suspicion is that we don't need this TICK_DEP_BIT_RCU tick dependency
> > > anymore. I believe it was there because of issues that were fixed with:
> > > 
> > > 	53e87e3cdc15 (timers/nohz: Last resort update jiffies on nohz_full IRQ entry)
> > > and:
> > > 
> > > 	a1ff03cd6fb9 (tick: Detect and fix jiffies update stall)
> > > 
> > > It's unfortunately just suspicion because the reason for that tick dependency
> > > is unclear but I believe it should be safe to remove now.
> > > 
> > 
> > I have gone through this tick dependency again, but got less.
> > 
> > I think at least from the RCU's viewpoint, it is useless since
> > multi_cpu_stop()->rcu_momentary_dyntick_idle() has eliminate the
> > requirement for tick interrupt.
> 
> Partly yes.
> 
> > Is there a way to have a convincing test so that these code can be removed?
> > Or this code will be got along with?
> 
> Hmm, Paul might remember which rcutorture scenario would trigger it?

TREE04 on multisocket systems, preferably with faster CPU-hotplug
operations.  This can be accomplished by adding this to the kvm.sh
command line:

	rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30

It does take some time to run.  I did 4,000 hours worth of TREE04
to confirm lack of bug.  But an 80-CPU dual-socket system can run
10 concurrent instances of TREE04, which gets things down to a more
manageable 400 hours.  Please let me know if you don't have access
to a few such systems.

I will let Frederic identify which commit(s) should be reverted in
order to test the test.

							Thanx, Paul
