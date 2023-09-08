Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A031EEE57E2
	for <rcu@archiver.kernel.org>; Fri,  8 Sep 2023 08:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjIHI1L (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbjIHI1L (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 04:27:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342C1BEA
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 01:27:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4356C433C9;
        Fri,  8 Sep 2023 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694161626;
        bh=70t99Qk8NMmyiv+T+mNfmBrKFrv7H5+TfTWldMToWtE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y4xA+xMcHQlbB57zx7gr5/bUYNaKHER4G0x2xr1t2bAkAKyQKkDSqgzdd5cq7zynH
         7gfxPuUz9nbZC48+F2ryYMrK0nm5rPjhCszoz7347uRSUzei9an5zOfzo5Z2yr0eca
         wL5iaBj0GWc3zi3daCMZVgngN34abckF9L9iUKNn9DY/gilto72F7/GZSmZABfANZx
         jGy65PADreYba9+GfU+vXEbaSDiBJjBBHjnDtwolDx5WY65xWgajf7e3rEXokzBK3m
         hLVKZiNip9pMXR9xBR8Cd2x/9VzLMmIHKMnG6VEgKxVi2JKGfUPVz2mUDFW3krUQsl
         NeR8yjqzbUcAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 41638CE0BB0; Fri,  8 Sep 2023 01:27:06 -0700 (PDT)
Date:   Fri, 8 Sep 2023 01:27:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state
 RTWS_COND_SYNC_FULL
Message-ID: <0526cf20-7d6f-4e2b-a28e-692ff8bc5955@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
 <FFC37117-94F4-49EC-86D7-508753C48A11@joelfernandes.org>
 <CAEXW_YStFf6Lt43GiLMCO5wBwCJU3aWcv5GvX0_8xaeZTFKMkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YStFf6Lt43GiLMCO5wBwCJU3aWcv5GvX0_8xaeZTFKMkA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 07, 2023 at 08:51:43PM -0400, Joel Fernandes wrote:
> On Thu, Sep 7, 2023 at 4:03 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> >
> >
> > > On Sep 7, 2023, at 12:23 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > ﻿On Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes wrote:
> > >> Hi,
> > >> Just started seeing this on 6.5 stable. It is new and first occurrence:
> > >>
> > >> TREE04 no success message, 234 successful version messages
> > >> [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
> > >> [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
> > >> f0x0 ->state 0x2 cpu 6
> > >> [   38.388342] Call Trace:
> > >> [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
> > >> f0x2 ->state 0x2 cpu 6
> > >> [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
> > >> f0x0 ->state 0x2 cpu 6
> > >> [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g10505
> > >> f0x0 ->state 0x2 cpu 6
> > >> [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g13781
> > >> f0x0 ->state 0x2 cpu 6
> > >> [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g16544
> > >> f0x0 ->state 0x2 cpu 6
> > >> [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g18941
> > >> f0x0 ->state 0x2 cpu 6
> > >> [..]
> > >>
> > >> All logs:
> > >> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/TREE04/
> > >
> > > Huh.  Does this happen for you in v6.5 mainline?
> > >
> > > Both the code under test (full-state polled grace periods) and the
> > > rcutorture test code are fairly new, so there is some reason for general
> > > suspicion.  ;-)
> >
> > Ah. I never saw it on either 6.5 mainline or stable till today. Even on stable
> > I only ever saw it this once. On mainline I have not seen it yet but I do test
> > stable much more since I have been on stable maintenance duty ;-).
> 
> I did a couple of long runs and I am not able to reproduce it anymore. :-/

I know that feeling!

							Thanx, Paul
