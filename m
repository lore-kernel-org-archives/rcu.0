Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E786EE49A4
	for <rcu@archiver.kernel.org>; Sun, 10 Sep 2023 20:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjIJUZv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Sep 2023 16:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjIJUZv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Sep 2023 16:25:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C07135
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 13:25:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCA1C433C8;
        Sun, 10 Sep 2023 20:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694377546;
        bh=NpDI9VoayfsLfRtcFgjDvIBADylHT0sNw7+6tK9Mses=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFRDnV8MQ7nF70ktaXNLALUTXu8TDfo2BabA9k2ngNvSfojAZ0R/MBCnzWkEv36EQ
         mjrS8TP5Hto4Sc7J5u0svW+JaXXSS3aTlB6HDn5AEw1YdO/2LiptRCu+1vtoDVtBu8
         TWb9ryMubnA1YlQVzZ6oOHZEYm9YLsTlMWWI/F6Yz7jD9ENbe+t+Vk++0apGCBpSUa
         kf+Qyw6XRC4BYospC0AmpbZJYCzi7oUyGg4qgJaXqxaUFNcRCe9zDGqoTvxx5pL1Nz
         WZB+b30yKOmhTczT1jqdovnhQ3fa59lHGP/sD7HUGVQYyeYMPkjHcfYn6m5CnfyBsh
         ESBFCFphQZfIA==
Date:   Sun, 10 Sep 2023 22:25:43 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [BUG] NOHZ tick-stop error: local softirq work is pending
Message-ID: <ZP4mRzlA4uCs6-Tk@localhost.localdomain>
References: <CAEXW_YTMCsaaZtyG46tjLv6En7Br0J6SD3WuLCZGhF=tSva26g@mail.gmail.com>
 <4673a906-1baa-41cf-8fd3-7d28fdd0a820@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4673a906-1baa-41cf-8fd3-7d28fdd0a820@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Sun, Sep 10, 2023 at 03:21:33AM -0700, Paul E. McKenney a écrit :
> On Sat, Sep 09, 2023 at 10:28:36PM -0400, Joel Fernandes wrote:
> > Hi Paul, Frederic, ever since this recent patch got merged into all
> > recent stables:
> > https://lore.kernel.org/all/20230818200757.1808398-1-paul.gortmaker@windriver.com/
> >  ..
> > 
> > .. I am seeing this happen a lot now causing rcutorture failures:
> > "NOHZ tick-stop error: local softirq work is pending"
> > 
> > It looks like the "tick-stop error" as local_bh_blocked always returns
> > false on !PREEMPT_RT, so that patch itself seems correct.
> > 
> > However, it appears the string in console-badness.sh is different:
> > 
> > console-badness.sh:grep -v 'NOHZ tick-stop error: Non-RCU local
> > softirq work is pending, handler'
> > 
> > So the string in the script needs an update?
> 
> Looks like it, though I believe that there is a fix in the offing,
> at which point that "grep -v" should just be removed.  Depending on
> timing, of course.

Yep I have a pending fix for that, will post soonish. The grep will still
make sense afterward though.

Thanks.
