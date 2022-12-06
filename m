Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E6CC3A5A7
	for <rcu@archiver.kernel.org>; Tue,  6 Dec 2022 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiLFVDg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Dec 2022 16:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLFVDf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Dec 2022 16:03:35 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8864BBC82
        for <rcu@vger.kernel.org>; Tue,  6 Dec 2022 13:03:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so2355110pjb.0
        for <rcu@vger.kernel.org>; Tue, 06 Dec 2022 13:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jR9u5eEHMWkgObF6Ogu2BeyAzkYrChr8IqwS0O+vMzY=;
        b=q9dU9AvdNvMVEtjAyqfAGrBXqFY2Eph7kxo3O7B5PCPcNhW0wY/Q1/tOwaLS6q/wum
         7n85Zosg3sN99G+seEPsnES7cwsnwYLQtqs4Q16sVBzuhlzeqUYw4UfTKqvaJZdb2do0
         cfHU4JBFoDcTFLaxHl+U4Ph/mXO3NRMDapwGR5fyf0CUJuIkssfyzZOo4Io5eYB6zpYh
         cKJ11+mW8a3MFtfzETb96uWtDyT7jt4JzBA2+3Js3zoyTH+ezLDl1lPTAei/e2xRK8oL
         588yLCqY3EQRDoaJQl3nwAaKn/TOZ4HL9Y9+rdfbsCd2DGGC4ZDnGoMbbTJ9p6Gsw5wC
         laWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR9u5eEHMWkgObF6Ogu2BeyAzkYrChr8IqwS0O+vMzY=;
        b=X0RmJ1PmEl7SC8nVURR6G+UCk6xApgV4SlD+S7nn9GxI7gfkaXStqJ685MPJV8hhmo
         /ViIH3BHo9ZZZgWu2EkqdlRQ9nee1zvQQ5/aBUY8YWOsUgggC61UJaBjOn+7N9E1kWvr
         SAFgC10uj2nw7tTvt3Yatjw3NOWZcD1h/8gJ3/F+7iZbZXQr21T6wVhnTJxaGb0zDfSX
         ZYFLqTWye8Y6PQLs76FV3tKbhbLOaYlKAw9fQKsYQzB/+cEq2cVi7HuK41X/WrYEgyG4
         6NCV5BQTqJyaHBcQMtU4EUWRSdK3kEGxVyohzsfM33rexUfefbRBvvIXy2cnFiWsYtyb
         FcHA==
X-Gm-Message-State: ANoB5pk8s7XeQhibyZCygA+xSQea55FL6QLg3D8ipwAt6u73EQEXRaMC
        v+AWt1Mhak4TAe/ktzTx0n4KPw==
X-Google-Smtp-Source: AA0mqf4dkXbs09Gx5AtXZWb4CYsGaGD+WsEDGhF32IXJO7qSPH0nHc/PdOzuRlISspVXe3VM+Udytw==
X-Received: by 2002:a17:90a:5911:b0:218:7b32:d353 with SMTP id k17-20020a17090a591100b002187b32d353mr92383407pji.100.1670360614069;
        Tue, 06 Dec 2022 13:03:34 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id nn6-20020a17090b38c600b00219f8eb271fsm1823805pjb.5.2022.12.06.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:03:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p2f6A-005Kb0-Pp; Wed, 07 Dec 2022 08:03:30 +1100
Date:   Wed, 7 Dec 2022 08:03:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        Josh Triplett <josh@joshtriplett.org>,
        RCU <rcu@vger.kernel.org>,
        syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
Message-ID: <20221206210330.GU3600936@dread.disaster.area>
References: <000000000000bd587705ef202b08@google.com>
 <20221206033450.GS3600936@dread.disaster.area>
 <CACT4Y+b-DCu=3LT+OMHuy4R1Fkgg_cBBtVT=jGtcyiBn4UcbRA@mail.gmail.com>
 <20221206153211.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+ZbmxyKJXM2zrJR6gNGSUS8j2_-Nu2dpC6gBEjcE3ercw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZbmxyKJXM2zrJR6gNGSUS8j2_-Nu2dpC6gBEjcE3ercw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 06, 2022 at 05:19:10PM +0100, Dmitry Vyukov wrote:
> On Tue, 6 Dec 2022 at 16:32, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Dec 06, 2022 at 12:06:10PM +0100, Dmitry Vyukov wrote:
> > > On Tue, 6 Dec 2022 at 04:34, Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > On Mon, Dec 05, 2022 at 07:12:15PM -0800, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > INFO: rcu detected stall in corrupted
> > > > >
> > > > > rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4122 } 2641 jiffies s: 2877 root: 0x0/T
> > > > > rcu: blocking rcu_node structures (internal RCU debug):
> > > >
> > > > I'm pretty sure this has nothing to do with the reproducer - the
> > > > console log here:
> > > >
> > > > > Tested on:
> > > > >
> > > > > commit:         bce93322 proc: proc_skip_spaces() shouldn't think it i..
> > > > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1566216b880000
> > > >
> > > > indicates that syzbot is screwing around with bluetooth, HCI,
> > > > netdevsim, bridging, bonding, etc.
> > > >
> > > > There's no evidence that it actually ran the reproducer for the bug
> > > > reported in this thread - there's no record of a single XFS
> > > > filesystem being mounted in the log....
> > > >
> > > > It look slike someone else also tried a private patch to fix this
> > > > problem (which was obviously broken) and it failed with exactly the
> > > > same RCU warnings. That was run from the same commit id as the
> > > > original reproducer, so this looks like either syzbot is broken or
> > > > there's some other completely unrelated problem that syzbot is
> > > > tripping over here.
> > > >
> > > > Over to the syzbot people to debug the syzbot failure....
> > >
> > > Hi Dave,
> > >
> > > It's not uncommon for a single program to trigger multiple bugs.
> > > That's what happens here. The rcu stall issue is reproducible with
> > > this test program.
> > > In such cases you can either submit more test requests, or test manually.
> > >
> > > I think there is an RCU expedited stall detection.
> > > For some reason CONFIG_RCU_EXP_CPU_STALL_TIMEOUT is limited to 21
> > > seconds, and that's not enough for reliable flake-free stress testing.
> > > We bump other timeouts to 100+ seconds.
> > > +RCU maintainers, do you mind removing the overly restrictive limit on
> > > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT?
> > > Or you think there is something to fix in the kernel to not stall? I
> > > see the test writes to
> > > /proc/sys/vm/drop_caches, maybe there is some issue in that code.
> >
> > Like this?
> >
> > If so, I don't see why not.  And in that case, may I please have
> > your Tested-by or similar?
> 
> I've tried with this patch and RCU_EXP_CPU_STALL_TIMEOUT=80000.
> Running the test program I got some kernel BUG in XFS and no RCU
> errors/warnings.

What BUG did it trigger? Where's the log?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
