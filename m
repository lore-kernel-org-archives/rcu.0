Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA37CC433EF
	for <rcu@archiver.kernel.org>; Tue, 31 May 2022 19:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347259AbiEaTZe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 May 2022 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiEaTZe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 May 2022 15:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292967D38
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 12:25:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D65560AE5
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 19:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6478BC385A9;
        Tue, 31 May 2022 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654025132;
        bh=CDebadJtu5DJ81GgAcc9PZY1etBOHXomtobOfhufzog=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f/pf9aRfV+jrhN9fpYJRAg63iXhsrSci/Zvf9QMFtlAwVjZgug2jACMPlO8NxjZzj
         aR21POTbSeQXA142nKhwhlrWnZ0oy8HL/mk4ohT2klktgJwst7eN52gm+0FJ0n3zbl
         9gVEEevMyduN/g1zUhI2tgVLjdLsHwv+UO+3vjrL6mWqyxPbGGLRkoyCv5jCpfHeLq
         O48O8n632A++UYDuFYGVmJO0Qh6U03C0VrvknnwXmwuUZWWJNB9Ln3mWmQTerALLDQ
         fYEioYYfhRUiJhU7+o7tOMWmW1C1FQFTAQl5YvDc2537OV5FGbPtJBcsYLOPZsy+Ww
         1K+f4nj20jhKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 066D05C019C; Tue, 31 May 2022 12:25:32 -0700 (PDT)
Date:   Tue, 31 May 2022 12:25:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <20220531192532.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220514163421.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpFawyhgLCj1+X1A@google.com>
 <20220528175735.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <a945a7d1-fc4f-2ca5-8820-c08579f564e4@joelfernandes.org>
 <20220530164203.GB1790663@paulmck-ThinkPad-P17-Gen-1>
 <0da0d321-7007-2c19-7f85-11d6ef8fed1f@joelfernandes.org>
 <20220531042624.GF1790663@paulmck-ThinkPad-P17-Gen-1>
 <6def6fce-13e2-7b80-467f-56a33124d67f@joelfernandes.org>
 <20220531164534.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpZjxKX5sNwl9wMK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpZjxKX5sNwl9wMK@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 31, 2022 at 06:51:48PM +0000, Joel Fernandes wrote:
> On Tue, May 31, 2022 at 09:45:34AM -0700, Paul E. McKenney wrote:

[ . . . ]

> > Here is hoping!
> > 
> > After all, if you thought that taking care of applications that need
> > expediting of grace periods is scary, well, now...
> 
> Haha... my fear is I don't know all the applications requiring expedited GP
> and I keep getting surprised by new RCU usages that pop up in the system, or
> new systems.
> 
> For one, a number of tools and processes, use ftrace directly in the system,
> and it may not be practical to chase down every tool. Some of them start
> tracing randomly in the system. Handling it in-kernel itself would be best if
> possible.

Shouldn't it be possible to hook into the kernel code that runs when
the sysfs tracing files are updated?  As in, why not both?  ;-)

> Productive email discussion indeed! On to writing the code :P

Should be fun!  ;-)

							Thanx, Paul
