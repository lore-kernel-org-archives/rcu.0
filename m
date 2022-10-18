Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5223C4332F
	for <rcu@archiver.kernel.org>; Tue, 18 Oct 2022 18:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJRS7n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJRS7k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Oct 2022 14:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D7A1E3F6;
        Tue, 18 Oct 2022 11:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B93F76158B;
        Tue, 18 Oct 2022 18:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14582C433C1;
        Tue, 18 Oct 2022 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666119577;
        bh=5qxrJBoguQRA72orQ32MErE5aTKmsySC7JSf7fVJMnA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bCF46hffZCFrkaKhs7Ot1u/98M3HLZu0sRefSZDOppGcaV75tBvQBQ2xTabRkCaIJ
         /kPa9ZzIHojxXErztuWiLA2LRDuybvkeDYLe6zgilX+tfQJ8TAR47AsHiH5TME+vId
         LOBHZsKwlcoLDOf8wiFVs30LTVmPUyn4VSZLyY70vHskYJ9ZdjjBixNQXT+lBAbXW8
         b2V2vKTMnHTH7y9FjkJZDFLRnQS0FzxDT2KwakgiV3napfzBlc3WkqelPrxu3ObuDS
         c34vCizSMBWeuBvuIpk+/u+WOR17rc8EfdVo/VYJ8gILR/CGJ//+JfbsaaVLJRDe9G
         Ghm+qVYd2K4Iw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B3B6B5C0990; Tue, 18 Oct 2022 11:59:36 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:59:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        pmladek@suse.com, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <87ilkh0y52.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilkh0y52.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 18, 2022 at 08:50:57PM +0206, John Ogness wrote:
> On 2022-10-18, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > Currently, I have this series on -rcu branch srcunmisafe.2022.10.03a,
> > with Frederic's patches on branch "dev".  I will be producing a shiny
> > new branch with your fix and Frederic's debug later today, Pacific
> > Time.  With luck, based on v6.1-rc1.
> 
> Perfect!
> 
> > I will be incorporating these commits from Frederic:
> >
> > 6558b914fc4e ("srcu: Warn when NMI-unsafe API is used in NMI")
> > 5dc788627109 ("srcu: Explain the reason behind the read side critical section on GP start")
> > 54a118fce487 ("srcu: Debug NMI safety even on archs that don't require it")
> >
> > Are there other patches I should be applying?
> 
> Not that I am aware of.

And if you are in a hurry, the v6.0-rc1 stack is at srcunmisafe.2022.10.18a.
With luck, the v6.1-rc1 stack will be at srcunmisafe.2022.10.18b before
the day is over, Pacific Time.

							Thanx, Paul
