Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0609DC00140
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 01:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiHSBaB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Aug 2022 21:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240742AbiHSBaA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Aug 2022 21:30:00 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A17755B
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 18:29:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id o2so2360724iof.8
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 18:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T0aGRflnHcadyKOWLRpSKInMHU1tvI4tJ8V9KYlcHws=;
        b=Bjin/0T5CObbnvQlO4PQLx7SzTFhE6p8LLRKjA+OAnYM6s3Ddj6pwYmbddzD6YCbPL
         +TkfjARGcMF6qvD/cyO6WTOVpYABjz9cEJeLjui+r7QGsncuGAAR7ex2fEfLg2bbEvdz
         bpx1Z4+L0rM/resp6SHtGQGwenFUxHN54x0Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T0aGRflnHcadyKOWLRpSKInMHU1tvI4tJ8V9KYlcHws=;
        b=F8rkfEDCFSe1V3fP9O1HfxRVey5nxn7HkL8QARL7c6BvR8HGT1yXLnOmDVSZJ7Cp/L
         ECg6/NhxI1Buo/gsh/NJou9MUVh1hdvNhX1PG+fJhLjh+RPtJ3fIutRITN82iica5vBA
         peRzC1h/6p3Ce1A4E+yHg8wdHh8RW+eZg9pDIHtmClgz8WLGyltzrWJWIW5hTTkp2Rk1
         TMwcBYww2rQUkIcgqo9HA4JdtxeSuxoGwGhtoa8YI3SRyIRREsLEYAA758zC03FyxVJS
         NM9FIQxFeTU6/OHMVQ4yARBG834WRQ73g8J50dSM+oRIUn2FnD+Q/qGsXEyLH1ra3k+n
         K+YQ==
X-Gm-Message-State: ACgBeo1Hvb30rFuZgBVo264jpi6YCTnuo2sN5SIZxoDSi2QhbYou9/Ag
        KVFImy1VANXUgAsJi8ulGBcBk0zQSGjmR09rrmM6NA==
X-Google-Smtp-Source: AA6agR7kbYYGynY4RueKru0Ae6YXLBFh6Dx5HYAUQgrIIEHRhz69Xl1jEEvKvZzWDLXfsavU9JFN64GU4YQIeo4BQ+U=
X-Received: by 2002:a5d:9914:0:b0:67c:2039:caff with SMTP id
 x20-20020a5d9914000000b0067c2039caffmr2426645iol.201.1660872597313; Thu, 18
 Aug 2022 18:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <20220809034517.3867176-5-joel@joelfernandes.org> <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com> <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
In-Reply-To: <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Aug 2022 21:29:45 -0400
Message-ID: <CAEXW_YRFF1xuxcSr1qev0N7OMEbBN9gg36KQSQ7sV8QBuuf8Og@mail.gmail.com>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 18, 2022 at 9:21 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Aug 18, 2022 at 7:05 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > [Sorry, adding back the CC list]
> > >
> > > On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > This is required to prevent callbacks triggering RCU machinery too
> > > > quickly and too often, which adds more power to the system.
> > > >
> > > > When testing, we found that these paths were invoked often when the
> > > > system is not doing anything (screen is ON but otherwise idle).
> > >
> > > Unfortunately, I am seeing a slow down in ChromeOS boot performance
> > > after applying this particular patch. It is the first time I could
> > > test ChromeOS boot times with the series since it was hard to find a
> > > ChromeOS device that runs the upstream kernel.
> > >
> > > Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
> > > patch? I wonder if the issue is with wake up interaction with the nocb
> > > GP threads.
> > >
> > > We ought to disable lazy RCU during boot since it would have little
> > > benefit anyway. But I am also concerned about some deeper problem I
> > > did not catch before.
> > >
> > > I'll look into tracing the fs paths to see if I can narrow down what's
> > > causing it. Will also try a newer kernel, I am currently testing on
> > > 5.19-rc4.
> >
> > I got somewhere with this. It looks like queuing CBs as lazy CBs
> > instead of normal CBs, are triggering expedited stalls during the boot
> > process:
> >
> >   39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
> > CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.
> >
> > No idea how/why lazy RCU CBs would be related to expedited GP issues,
> > but maybe something hangs and causes that side-effect.
> >
> > initcall_debug did not help, as it seems initcalls all work fine, and
> > then 8 seconds after the boot, it starts slowing down a lot, followed
> > by the RCU stall messages. As a next step I'll enable ftrace during
> > the boot to see if I can get more insight. But I believe, its not the
> > FS layer, the FS layer just triggers lazy CBs, but there is something
> > wrong with the core lazy-RCU work itself.
> >
> > This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
> > recent kernels and debug.
>
> More digging, thanks to trace_event= boot option , I find that the
> boot process does have some synchronous waits, and though these are
> "non-lazy", for some reason the lazy CBs that were previously queued
> are making them wait for the *full* lazy duration. Which points to a
> likely bug in the lazy RCU logic. These synchronous CBs should never
> be waiting like the lazy ones:
>

[   17.715904]     init-1         2..... 8917039us : <stack trace>
> [   17.715904]  => trace_dump_stack
> [   17.715904]  => __wait_rcu_gp
> [   17.715904]  => synchronize_rcu
> [   17.715904]  => selinux_netcache_avc_callback
> [   17.715904]  => avc_ss_reset
> [   17.715904]  => sel_write_enforce
> [   17.715904]  => vfs_write
> [   17.715904]  => ksys_write
> [   17.715904]  => do_syscall_64
> [   17.715904]  => entry_SYSCALL_64_after_hwframe
>
> I'm tired so I'll resume the debug later.

Rushikesh, btw do note that using jiffies_till_first_fqs would also
likely slow these synchronous waits down, and thus slow down the boot
process for ChromeOS. This could be what you're seeing with the
jiffies option. No idea why you were not seeing this in earlier
experiments, maybe there was a change in ChromeOS with how selinux
enforce option was being written out, or something. This write syscall
is being done by the init process. I'll add this to the slides as well
as another call_rcu_lazy() selling point (vs using jiffies) :)

 - Joel
