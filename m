Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0A9C4332F
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 14:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiKQOlQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Nov 2022 09:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbiKQOkn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Nov 2022 09:40:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4246073B8D
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 06:39:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCFFB61E7A
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 14:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87DFC433D6;
        Thu, 17 Nov 2022 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668695989;
        bh=lfo7XWZsyzJz1kV9AVsvvxJ69PXuStzXRIjK9YLStpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qnYzU9c6xo4DS8Tjo+8r6kwAHWld7UKAhh2m4ia3I6C+BMeGrJVWA8jyJbWhRS8Ag
         1YLuHwMmov3Lif8WCn7CiY3tQkAVmvetJj031udZoE06COarVj8cThC77478rlzyUL
         cbWVqRsJcp3Yp6HIRv7HJQ+9mypoau7rIaMEWLBfEU82BRyaPx4ahIhCRXRLvepaqk
         DzWrgmfG/F3NPzvreTxybvB15SGjXy1kqNFl3JuwOY+sfS7cTSJxYk8eH3G4EquyYo
         FNwF17CXuxLaNsNrdQjlL+dA5ORobfplrYAgAx+dlxC8yfPy7/X1eO41XeQeAiJFy0
         LnP3s6Qf8mgAw==
Date:   Thu, 17 Nov 2022 15:39:46 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20221117143946.GG839309@lothringen>
References: <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com>
 <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
 <20221002162002.GR4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTtgLfc0NeYqyWk4Ew-pA9rMREjRjWSnQhYLv-V5117s9Q@mail.gmail.com>
 <20221027174620.GC5600@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTuoy+9DdQsVZvbLcn70JaHUhR2HZ=D35Akj4=GceGO2Lg@mail.gmail.com>
 <20221103165143.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221107160726.GA3892067@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107160726.GA3892067@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 07, 2022 at 08:07:26AM -0800, Paul E. McKenney wrote:
> > I ran 200 hours of TREE04 and got an RCU CPU stall warning.  I ran 2000
> > hours on v6.0, which precedes these commits, and everything passed.
> > 
> > I will run more, primarily on v6.0, but that is what I have thus far.
> > At the moment, I have some concerns about this change.
> 
> OK, so I have run a total of 8000 hours on v6.0 without failure.  I have
> run 4200 hours on rcu#revert_tick_dep with 15 failures.  The ones I
> looked at were RCU CPU stall warnings with timer failures.
> 
> This data suggests that the kernel is not yet ready for that commit
> to be reverted.

But that branch has the three commits reverted:

1) tick: Detect and fix jiffies update stall
2) timers/nohz: Last resort update jiffies on nohz_full IRQ entry*
3) rcu: Make CPU-hotplug removal operations enable tick

Reverting all of them is expected to fail anyway.

What we would like to know is if reverting just 3) is fine. Because
1) and 2) are supposed to fix the underlying issue.

I personally didn't manage to trigger failures with just reverting 3)
after thousands hours. But it failed with reverting all of them.

Has someone managed to trigger a failure with only 3) reverted?

Thanks.
