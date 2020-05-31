Return-Path: <SRS0=Gue3=7N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB25C433DF
	for <rcu@archiver.kernel.org>; Sun, 31 May 2020 20:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C0220707
	for <rcu@archiver.kernel.org>; Sun, 31 May 2020 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590955398;
	bh=hmtgDdWC6lZ/nUwL2krWFTtauOgTMQ9x1SlpzJjdqP8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=gUJf4QPQ2WOy2JUQCiklverGPZc+KiDHtScprKKPRgCfah0mtgGwNJJIC/JmrGPUw
	 2s2WVFEuaXVZQoPzaV9Ogdh54HZ6dqtXpIkqh78nFjaTUhxteHr7KtQcRIrJE6K4KJ
	 Skh+odAnAHlstNCFQbLqE11M36wEvsFgh11ezrYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgEaUDS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 31 May 2020 16:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgEaUDS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 31 May 2020 16:03:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C24B8206E2;
        Sun, 31 May 2020 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590955397;
        bh=hmtgDdWC6lZ/nUwL2krWFTtauOgTMQ9x1SlpzJjdqP8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hmDMC/NM4dZOkaLqatA3i8RqE/h/hTc/ADdTRvzAP2J1g1kuRs0BD+fX7zZWEl0Tv
         aGxKn7sq7f9OF+8orDu1cJFMO9vWwxJ5i/ZvEkA1dRZLf4iZCqy/YII/ypL69D0rbp
         BuDEEKfZxESYguh8dKY0xHvh3Q7oTfvINIkqvtq8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9F7F135229BA; Sun, 31 May 2020 13:03:17 -0700 (PDT)
Date:   Sun, 31 May 2020 13:03:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rcu@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] refperf: work around 64-bit division
Message-ID: <20200531200317.GN2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200529201600.493808-1-arnd@arndb.de>
 <20200530035230.GA2019114@ubuntu-s3-xlarge-x86>
 <CAK8P3a3UB2M7Wv8BZx3-ASbsvxD3KHbHCCQ_04xTLPwkEB6twQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3UB2M7Wv8BZx3-ASbsvxD3KHbHCCQ_04xTLPwkEB6twQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, May 30, 2020 at 10:01:36AM +0200, Arnd Bergmann wrote:
> On Sat, May 30, 2020 at 5:52 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Fri, May 29, 2020 at 10:15:51PM +0200, Arnd Bergmann wrote:
> > >       strcat(buf, "Threads\tTime(ns)\n");
> > >
> > >       for (exp = 0; exp < nruns; exp++) {
> > > +             u64 avg;
> > > +             u32 rem;
> > > +
> > >               if (errexit)
> > >                       break;
> > > -             sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
> > > +
> > > +             avg = div_s64_rem(result_avg[exp], 1000, &rem);
> >
> > Shouldn't this be div_u64_rem? result_avg is u64.
> 
> Yes, you are right. Actually that would be an important optimization
> since div_u64_rem() optimizes for constant divisors while div_s64_rem
> uses the slow path.
> 
> > > +             sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, avg, rem);
> >
> > Would %03u be the better specifier since rem is u32?
> 
> Yes, though this makes no difference in practice.
> 
> Paul, should I send a fixup for these two, or do you prefer to just
> edit it in place?

And here is the update, thank you all!

							Thanx, Paul

------------------------------------------------------------------------

commit 0dd4132157c2cf6bec2a0a6e04163067323abdb1
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri May 29 14:36:26 2020 -0700

    refperf: Work around 64-bit division
    
    A 64-bit division was introduced in refperf, breaking compilation
    on all 32-bit architectures:
    
    kernel/rcu/refperf.o: in function `main_func':
    refperf.c:(.text+0x57c): undefined reference to `__aeabi_uldivmod'
    
    Fix this by using div_u64 to mark the expensive operation.
    
    [ paulmck: Update primitive and format per Nathan Chancellor. ]
    Fixes: bd5b16d6c88d ("refperf: Allow decimal nanoseconds")
    Reported-by: kbuild test robot <lkp@intel.com>
    Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
    Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 99434e7..3b72925 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -478,7 +478,7 @@ static int main_func(void *arg)
 		if (torture_must_stop())
 			goto end;
 
-		result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);
+		result_avg[exp] = div_u64(1000 * process_durations(nreaders), nreaders * loops);
 	}
 
 	// Print the average of all experiments
@@ -489,9 +489,13 @@ static int main_func(void *arg)
 	strcat(buf, "Runs\tTime(ns)\n");
 
 	for (exp = 0; exp < nruns; exp++) {
+		u64 avg;
+		u32 rem;
+
 		if (errexit)
 			break;
-		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
+		avg = div_u64_rem(result_avg[exp], 1000, &rem);
+		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
 		strcat(buf, buf1);
 	}
 
