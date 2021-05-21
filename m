Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F185EC43460
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D376D613AC
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 14:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbhEUODx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 10:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236317AbhEUODv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 May 2021 10:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 065406128A;
        Fri, 21 May 2021 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621605748;
        bh=kA9T6I0KtR2vRJObdHAp/gezZexd82kCO/U5xHAWBJ4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HjDs66JCeJSYu0hRBPCQZdEwxtqI6kNlCUohGGayjzdkty0sYZGGQwaMdkRqqnKjJ
         y4RYjJM4vIopEUNcvvD+/3JnFHORbExiAI35Iu4xIpaOIRfZ2bLKVG0RtB7JiRZ5Tk
         SNfzlJzzMEzkf/hzlNYchw31InKCdFFMih76tSYfgtMRXkLJAlkj2sjoxVsYLHkTK8
         l+HfALw+dGl2YPtbOneLDtlMId8NJHObS3ND4a2jLT35LLDoCAMSKS/jOuq34+G/I1
         5CxZIYYnlVoON1xDUjUb4MoXe8coXCGeV5KcRVEguaMfKy/A4bRhvN7tLPiW600n1Y
         zq46YGPnGX5xw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C71775C033C; Fri, 21 May 2021 07:02:27 -0700 (PDT)
Date:   Fri, 21 May 2021 07:02:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <20210521140227.GW4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
 <YKX/H0EwRRLM+cAa@google.com>
 <20210520145318.GJ4441@paulmck-ThinkPad-P17-Gen-1>
 <YKbhg30Q6YlerCoz@google.com>
 <20210521001443.GR4441@paulmck-ThinkPad-P17-Gen-1>
 <YKdWV2lznaxUKBM5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdWV2lznaxUKBM5@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 21, 2021 at 03:42:31PM +0900, Sergey Senozhatsky wrote:
> On (21/05/20 17:14), Paul E. McKenney wrote:
> > > On a side note.
> > > 
> > > I wish we didn't have to put kvm_check_and_clear_guest_paused() all
> > > over the place.
> > > 
> > > We do load jiffies at the start of check_cpu_stall(). So, in theory,
> > > we can just use that captured jiffies (which can become obsolete but
> > > so will grace period timestamps) value and never read current system
> > > jiffies because they can jump way forward. IOW
> > > 
> > > 	jn = j + 3 * rcu_jiffies_till_stall_check() + 3;
> > > 
> > > instead of
> > > 
> > > 	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> > > 
> > > Then we probably can remove kvm_check_and_clear_guest_paused().
> > > 
> > > But that "don't load current jiffies" is rather fragile.
> > > 
> > > kvm_check_and_clear_guest_paused() is not pretty, but at least it's
> > > explicit.
> > 
> > If this works for you, I am very much in favor!
> 
> Oh, no. Sorry for the noise. This is racy and won't work.

I had been hoping!  ;-)

							Thanx, Paul
