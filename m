Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738D3C4332F
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 01:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiKVBYA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiKVBX7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Nov 2022 20:23:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EDBC21;
        Mon, 21 Nov 2022 17:23:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EFB761505;
        Tue, 22 Nov 2022 01:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BB4C433C1;
        Tue, 22 Nov 2022 01:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669080238;
        bh=PWWcBgmb4XKQgrT0IxdC3iPuQOo7H1FNN1o4PMJQmBU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LcdLuPixy5hqdPb1jxeRna8uwlZd7mBDdZr8XQYYIFEEDZjEPZwQmVJAQ0U2ambRu
         u44HWRuH+6mro9yyerILlocCKpIhCUK5GREfasufvjJdwO6AjzV7V0Al8NTej6GZV+
         3KXohpK9iwEBtge4TqQajSehhPSj43fffThc42XFWKiQbgCr8XPvzG/AyvgEhZA1ln
         6duvpS/ombTynQnjInkr5LPDucKpLqcNHG/fTtqVWOgdZz5jIYXSNLmMXt2F3fLaJb
         /ITyimIxNGoxSn1M2qe5YOVdGCGwbNBLjbUoeJxaaG4u8HfgfoPSaC7sVWkag2ovy9
         bXwUbBLsaacuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 967575C0641; Mon, 21 Nov 2022 17:23:57 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:23:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 rcu 13/16] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <20221122012357.GV4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
 <20221122010421.3799681-13-paulmck@kernel.org>
 <Y3whScgTs0FgrVtY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3whScgTs0FgrVtY@slm.duckdns.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 21, 2022 at 03:09:29PM -1000, Tejun Heo wrote:
> On Mon, Nov 21, 2022 at 05:04:18PM -0800, Paul E. McKenney wrote:
> > And another call_rcu() instance that cannot be lazy is the one
> > in queue_rcu_work(), given that callers to queue_rcu_work() are
> > not necessarily OK with long delays.
> 
> So, this is fine but another thing we can do is propagating the distinction
> through the workqueue interface so that the the choice can be made by
> workqueue users. Would that make sense?

It might well!  My thought was to wait to suggest that until we found a
real-life case where this was needed, but I have no objection to being
proactive here.

But the hard part...  Thought for a good name?  ;-)

							Thanx, Paul
