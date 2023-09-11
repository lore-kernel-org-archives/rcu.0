Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78000CA0ECE
	for <rcu@archiver.kernel.org>; Tue, 12 Sep 2023 04:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjILERF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjILEQy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Sep 2023 00:16:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E08222635
        for <rcu@vger.kernel.org>; Mon, 11 Sep 2023 19:07:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C455C433BB;
        Mon, 11 Sep 2023 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694467400;
        bh=c8Lxf1xjedd4q1/EQup3iByFiSaU3t2orukkeNNSk88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvASHrQWhd4gQujWdVz9Em06/9NvrQcIkqpW8xoLXUZ15pf2B3H6ASM1ZMMWfwnAW
         3qQ33D11ZbCIYEu6clpbUUc9mWXJlGqMlSccSLdIT72l+zX3X5BnEtvVEo/l5mYpsF
         5lwpvZDAQiWBEfSqOG2kEHqGI/z7/tMSi1rxcsRgmVRgphFwI5JEmh/97nK40FqhAB
         u++BEFqABPXT76GpEbinEEV5mMROxCBg4ty+9OZWMd25kD7I+aqpfcxRHhZzivKoSQ
         OrC1m+MXPmvbbVCUJfa0ICYFfFFRhIP+IxnY0JTRW8CF+PeXQyAx6KjmLR4A263U+d
         kbdDLajPODTuw==
Date:   Mon, 11 Sep 2023 23:23:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [BUG] NOHZ tick-stop error: local softirq work is pending
Message-ID: <ZP-FRbgjye3evLbt@localhost.localdomain>
References: <CAEXW_YTMCsaaZtyG46tjLv6En7Br0J6SD3WuLCZGhF=tSva26g@mail.gmail.com>
 <4673a906-1baa-41cf-8fd3-7d28fdd0a820@paulmck-laptop>
 <ZP4mRzlA4uCs6-Tk@localhost.localdomain>
 <20230910230209.GA1832306@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230910230209.GA1832306@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Sun, Sep 10, 2023 at 11:02:09PM +0000, Joel Fernandes a écrit :
> On Sun, Sep 10, 2023 at 10:25:43PM +0200, Frederic Weisbecker wrote:
> > Le Sun, Sep 10, 2023 at 03:21:33AM -0700, Paul E. McKenney a écrit :
> > > On Sat, Sep 09, 2023 at 10:28:36PM -0400, Joel Fernandes wrote:
> > > > Hi Paul, Frederic, ever since this recent patch got merged into all
> > > > recent stables:
> > > > https://lore.kernel.org/all/20230818200757.1808398-1-paul.gortmaker@windriver.com/
> > > >  ..
> > > > 
> > > > .. I am seeing this happen a lot now causing rcutorture failures:
> > > > "NOHZ tick-stop error: local softirq work is pending"
> > > > 
> > > > It looks like the "tick-stop error" as local_bh_blocked always returns
> > > > false on !PREEMPT_RT, so that patch itself seems correct.
> > > > 
> > > > However, it appears the string in console-badness.sh is different:
> > > > 
> > > > console-badness.sh:grep -v 'NOHZ tick-stop error: Non-RCU local
> > > > softirq work is pending, handler'
> > > > 
> > > > So the string in the script needs an update?
> > > 
> > > Looks like it, though I believe that there is a fix in the offing,
> > > at which point that "grep -v" should just be removed.  Depending on
> > > timing, of course.
> > 
> > Yep I have a pending fix for that, will post soonish. The grep will still
> > make sense afterward though.
> 
> I was wondering why the grep -v will still make sense if the pending fix
> works. Or is there another legitimate reason for the string to appear?

Because my fix will only take out (hr)timer softirqs out of the report. The
others will still be considered buggy if pending while the CPU goes down.
Anyway, cooking the timer patchset to post.

Thanks.
