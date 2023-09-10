Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970BEC71153
	for <rcu@archiver.kernel.org>; Sun, 10 Sep 2023 21:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjIJVs4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Sep 2023 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjIJVsz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Sep 2023 17:48:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A9DCC5
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 14:48:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686FCC433C8;
        Sun, 10 Sep 2023 21:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694382526;
        bh=J15kuB0W4e6FZ42Hmjbt4WHjVwbPn7u2a0UF7aP3e/w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g9xPZou5rP2cMSXLPQmuw16RslGXeg9zEJkUJB9/M57FBCRH6vNd/5g1B2XybH7xd
         PSUZxNeZKzb/oC897YajWrSxL1TV30iNHHkWexw/RbTd2R9cfpdP/erl80KHx+SowO
         bl0cs2Ozgs6sTBgbvKeABev+JfqUYTpSHjP2Bg8njjE+luB2kP9RcYaucL4Vl67eUN
         HufJFH4U+GLTjLSjNnhjPfep5jr4LFByvlhtbjWegp3hbpaNRqNic51FclvOnr22r/
         enH56BZP2hkPBA9YD2/BfaYZw6cnBEeiOa9uGsGZbB14XY8TUVUQASegU3wSTWoNVn
         emW5HeosEGREg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01ECECE080C; Sun, 10 Sep 2023 14:48:45 -0700 (PDT)
Date:   Sun, 10 Sep 2023 14:48:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [BUG] NOHZ tick-stop error: local softirq work is pending
Message-ID: <65cfb329-e6b4-4bba-8718-7888c9249830@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEXW_YTMCsaaZtyG46tjLv6En7Br0J6SD3WuLCZGhF=tSva26g@mail.gmail.com>
 <4673a906-1baa-41cf-8fd3-7d28fdd0a820@paulmck-laptop>
 <ZP4mRzlA4uCs6-Tk@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZP4mRzlA4uCs6-Tk@localhost.localdomain>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Sep 10, 2023 at 10:25:43PM +0200, Frederic Weisbecker wrote:
> Le Sun, Sep 10, 2023 at 03:21:33AM -0700, Paul E. McKenney a écrit :
> > On Sat, Sep 09, 2023 at 10:28:36PM -0400, Joel Fernandes wrote:
> > > Hi Paul, Frederic, ever since this recent patch got merged into all
> > > recent stables:
> > > https://lore.kernel.org/all/20230818200757.1808398-1-paul.gortmaker@windriver.com/
> > >  ..
> > > 
> > > .. I am seeing this happen a lot now causing rcutorture failures:
> > > "NOHZ tick-stop error: local softirq work is pending"
> > > 
> > > It looks like the "tick-stop error" as local_bh_blocked always returns
> > > false on !PREEMPT_RT, so that patch itself seems correct.
> > > 
> > > However, it appears the string in console-badness.sh is different:
> > > 
> > > console-badness.sh:grep -v 'NOHZ tick-stop error: Non-RCU local
> > > softirq work is pending, handler'
> > > 
> > > So the string in the script needs an update?
> > 
> > Looks like it, though I believe that there is a fix in the offing,
> > at which point that "grep -v" should just be removed.  Depending on
> > timing, of course.
> 
> Yep I have a pending fix for that, will post soonish. The grep will still
> make sense afterward though.

So I do nothing?  I can do that!  ;-)

							Thanx, Paul
