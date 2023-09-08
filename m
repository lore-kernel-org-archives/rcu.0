Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B38EE57FB
	for <rcu@archiver.kernel.org>; Fri,  8 Sep 2023 11:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjIHLlf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjIHLlf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 07:41:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3410A1BE7
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 04:41:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CAAC433C8;
        Fri,  8 Sep 2023 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694173289;
        bh=wANzrPUOXNa3oTmbviyTxvd6fFELFdLlAPI33U8T8Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYc+I64LwDfzbwmyzsnYQz9wfpdxpGhEH+JLvT+ECWZA9zdb+fowyB1gERN8HyVks
         o7GCj4C4FK7O8exr03fYmHOn0ifokE+j8KKVsl9uyR61xhWLwKZtQV+UTHEO7h4jQ4
         jmkxCDvTEMe0Jfg7vZngkm9CgIaNEJuBW35F4gbeXYx865AkL2menBxyd8+pSYRjx1
         ciOoiIK4h7uggfuer25TxklVGtadxCqoIHAZ1ltL5G7yefVXuQT80wV6CV3d1axbu/
         q8xU2VD/IbIVvCcS1eckWh/9EAwx8KQb0j52zVpbK30bxxUcWSfIVunmWRMev6pWnU
         mr07ZjLkNHYmw==
Date:   Fri, 8 Sep 2023 13:41:26 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state
 RTWS_COND_SYNC_FULL
Message-ID: <ZPsIZhhZ1sy/45X+@lothringen>
References: <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
 <FFC37117-94F4-49EC-86D7-508753C48A11@joelfernandes.org>
 <CAEXW_YStFf6Lt43GiLMCO5wBwCJU3aWcv5GvX0_8xaeZTFKMkA@mail.gmail.com>
 <0526cf20-7d6f-4e2b-a28e-692ff8bc5955@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0526cf20-7d6f-4e2b-a28e-692ff8bc5955@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 08, 2023 at 01:27:06AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 07, 2023 at 08:51:43PM -0400, Joel Fernandes wrote:
> > On Thu, Sep 7, 2023 at 4:03 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > >
> > >
> > > > On Sep 7, 2023, at 12:23 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > ﻿On Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes wrote:
> > > >> Hi,
> > > >> Just started seeing this on 6.5 stable. It is new and first occurrence:
> > > >>
> > > >> TREE04 no success message, 234 successful version messages
> > > >> [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
> > > >> [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
> > > >> f0x0 ->state 0x2 cpu 6
> > > >> [   38.388342] Call Trace:
> > > >> [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
> > > >> f0x2 ->state 0x2 cpu 6
> > > >> [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
> > > >> f0x0 ->state 0x2 cpu 6
> > > >> [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g10505
> > > >> f0x0 ->state 0x2 cpu 6
> > > >> [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g13781
> > > >> f0x0 ->state 0x2 cpu 6
> > > >> [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g16544
> > > >> f0x0 ->state 0x2 cpu 6
> > > >> [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g18941
> > > >> f0x0 ->state 0x2 cpu 6
> > > >> [..]
> > > >>
> > > >> All logs:
> > > >> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/TREE04/
> > > >
> > > > Huh.  Does this happen for you in v6.5 mainline?
> > > >
> > > > Both the code under test (full-state polled grace periods) and the
> > > > rcutorture test code are fairly new, so there is some reason for general
> > > > suspicion.  ;-)
> > >
> > > Ah. I never saw it on either 6.5 mainline or stable till today. Even on stable
> > > I only ever saw it this once. On mainline I have not seen it yet but I do test
> > > stable much more since I have been on stable maintenance duty ;-).
> > 
> > I did a couple of long runs and I am not able to reproduce it anymore. :-/
> 
> I know that feeling!

Same here, this is after all the reason why we keep the tick dependency within
the hotplug process without really knowing why :o)
