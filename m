Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8461C00140
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 01:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiHSBWK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Aug 2022 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHSBWJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Aug 2022 21:22:09 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D7FD274E
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 18:22:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y187so2375211iof.0
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 18:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=++fASc0fsxHxUOS23IzKRmPzdmpS9qfA0Lyv2k53js8=;
        b=c702vnQs1zjXA6roO7+CTFJfTOyEb022/1v0c4gnp6L7ldFKZmMCjIie7sigbTgmp8
         bDQC7LFk1YVUA6Wf6ymxs7G0ork60nMr2/dzxAjOQXiPG3+n/Khzj18qcSIwEXrRS/hc
         mqgjI8GQIeey3koM69rJ2LVvb9m04IlQUx+uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=++fASc0fsxHxUOS23IzKRmPzdmpS9qfA0Lyv2k53js8=;
        b=ydffebdDfD9RkZYfkxAU9uzXiS45Ca+ImNM+Cc/5MUOU3LEruUTQ5keWKj4Qnw+iea
         XNssd6W3STYZLzSHtz0/T3wY1WLN2q6HZKDkQKN/G+7+tJNx2aVW3HT5NQrrs7T/3tTk
         SdSApX00OIPu8+vokqH6PSEnsasPbh3MUiLcgO3BIw2WMzmCL1NfDlI1aCD7uSSiaHlq
         3SPAVhc6tSUBsuAda25oMX6iAh/e3Un81z/yA7kZ/isxKPeEh5dvGeaFtJDKmsgMN/me
         JAO9eldYmNtXvlD1temvYwssRIHk+NWTKIqcTNP+UV36iwGz1VjCrn/B0GEnqqudzVu2
         8qwQ==
X-Gm-Message-State: ACgBeo2NRWtC04pdU7khUfK9E0OvfFmSE/b6yqbgjUehAZPmCvn9KG8F
        LShFdiGLwypSZYXoew6DG5o0E+2NiJ/aKaKbRs546A==
X-Google-Smtp-Source: AA6agR5vFOW/E8QynJcG0gtsehHMRrUpp4xChp+K4n7D1RBfO/XILooLXp0w7vWVi2QnZp5mb2wocfaKqdmX8Un4cM4=
X-Received: by 2002:a5d:9914:0:b0:67c:2039:caff with SMTP id
 x20-20020a5d9914000000b0067c2039caffmr2416925iol.201.1660872127769; Thu, 18
 Aug 2022 18:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <20220809034517.3867176-5-joel@joelfernandes.org> <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
In-Reply-To: <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Aug 2022 21:21:56 -0400
Message-ID: <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
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

On Thu, Aug 18, 2022 at 7:05 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > [Sorry, adding back the CC list]
> >
> > On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > This is required to prevent callbacks triggering RCU machinery too
> > > quickly and too often, which adds more power to the system.
> > >
> > > When testing, we found that these paths were invoked often when the
> > > system is not doing anything (screen is ON but otherwise idle).
> >
> > Unfortunately, I am seeing a slow down in ChromeOS boot performance
> > after applying this particular patch. It is the first time I could
> > test ChromeOS boot times with the series since it was hard to find a
> > ChromeOS device that runs the upstream kernel.
> >
> > Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
> > patch? I wonder if the issue is with wake up interaction with the nocb
> > GP threads.
> >
> > We ought to disable lazy RCU during boot since it would have little
> > benefit anyway. But I am also concerned about some deeper problem I
> > did not catch before.
> >
> > I'll look into tracing the fs paths to see if I can narrow down what's
> > causing it. Will also try a newer kernel, I am currently testing on
> > 5.19-rc4.
>
> I got somewhere with this. It looks like queuing CBs as lazy CBs
> instead of normal CBs, are triggering expedited stalls during the boot
> process:
>
>   39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
> CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.
>
> No idea how/why lazy RCU CBs would be related to expedited GP issues,
> but maybe something hangs and causes that side-effect.
>
> initcall_debug did not help, as it seems initcalls all work fine, and
> then 8 seconds after the boot, it starts slowing down a lot, followed
> by the RCU stall messages. As a next step I'll enable ftrace during
> the boot to see if I can get more insight. But I believe, its not the
> FS layer, the FS layer just triggers lazy CBs, but there is something
> wrong with the core lazy-RCU work itself.
>
> This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
> recent kernels and debug.

More digging, thanks to trace_event= boot option , I find that the
boot process does have some synchronous waits, and though these are
"non-lazy", for some reason the lazy CBs that were previously queued
are making them wait for the *full* lazy duration. Which points to a
likely bug in the lazy RCU logic. These synchronous CBs should never
be waiting like the lazy ones:

[   17.715904]  => trace_dump_stack
[   17.715904]  => __wait_rcu_gp
[   17.715904]  => synchronize_rcu
[   17.715904]  => selinux_netcache_avc_callback
[   17.715904]  => avc_ss_reset
[   17.715904]  => sel_write_enforce
[   17.715904]  => vfs_write
[   17.715904]  => ksys_write
[   17.715904]  => do_syscall_64
[   17.715904]  => entry_SYSCALL_64_after_hwframe

I'm tired so I'll resume the debug later.
