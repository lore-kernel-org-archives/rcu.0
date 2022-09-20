Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207FC54EE9
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 09:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiITJqw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 05:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiITJqv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 05:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916F6B656
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 02:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EDAC62834
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 09:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402F6C433C1;
        Tue, 20 Sep 2022 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663667208;
        bh=d1ecV4fDAfHZnNwctTPPdgWS1Kn+EseyjHvE/OLrp0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnr4+aAAFNkhi2vq7wJswMRYgW9fx/1yjypR3w+dvlTXLDoXRCGkiRXgS7oJTbcSB
         VOqRx9YwXtg8eDSwUn032TOEfaiE6B19h9dvNZsCfruIidV1EzfgKUKgToQiy12M47
         Vi6Ks7aHehzz7lTd2ufO3K5FiV+8v2zHLhhHkKxmh7qY3h/Q7PihaZmdCIkVNlLypy
         p/5m7VE8j+JyRseA3BKrWJFLVtMIYsyQJHFI/P+HMQWE1GNlCQBEydqKA03rnDpNT9
         roNask6lw5AFqV2vyDn1DsFGddTSyOa73BwNdFsjOrqDLC7d3XPeYdybYDVVZftkva
         Vm3xRfS3xRUmQ==
Date:   Tue, 20 Sep 2022 11:46:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20220920094645.GG69891@lothringen>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen>
 <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 20, 2022 at 03:26:28PM +0800, Pingfan Liu wrote:
> On Fri, Sep 16, 2022 at 03:42:58PM +0200, Frederic Weisbecker wrote:
> > Note this is only locking the rdp's node, not the root node.
> > Therefore if CPU 0 and CPU 256 are going off at the same time and they
> > don't belong to the same node, the above won't protect against concurrent
> > TICK_DEP_BIT_RCU set/clear.
> > 
> 
> Nice, thanks for the careful thoughts. How about moving the counting
> place to the root node?

You could but then you'd need to lock the root node.

> 
> > My suspicion is that we don't need this TICK_DEP_BIT_RCU tick dependency
> > anymore. I believe it was there because of issues that were fixed with:
> > 
> > 	53e87e3cdc15 (timers/nohz: Last resort update jiffies on nohz_full IRQ entry)
> > and:
> > 
> > 	a1ff03cd6fb9 (tick: Detect and fix jiffies update stall)
> > 
> > It's unfortunately just suspicion because the reason for that tick dependency
> > is unclear but I believe it should be safe to remove now.
> > 
> 
> I have gone through this tick dependency again, but got less.
> 
> I think at least from the RCU's viewpoint, it is useless since
> multi_cpu_stop()->rcu_momentary_dyntick_idle() has eliminate the
> requirement for tick interrupt.

Partly yes.

> Is there a way to have a convincing test so that these code can be removed?
> Or this code will be got along with?

Hmm, Paul might remember which rcutorture scenario would trigger it?
