Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20866C352A1
	for <rcu@archiver.kernel.org>; Tue,  6 Dec 2022 20:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLFU66 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Dec 2022 15:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLFU65 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Dec 2022 15:58:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CB02F023
        for <rcu@vger.kernel.org>; Tue,  6 Dec 2022 12:58:56 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 4so15178139pli.0
        for <rcu@vger.kernel.org>; Tue, 06 Dec 2022 12:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ5/FowzAocI0ttW8zswzJn2dKKUi5iFR0Wy//VpliA=;
        b=z9dSMG0BIaedzOQwBdxMcaOKoxGIB8Vr2V3Xcp1oB8Ls3IOBLO5SbowSKXTrGfZ2bY
         B6JW75Vm8GCXneh/xp4CnHEWzPEPEJHzPfPH4qdHnH+Ke0eSgYINGnxFz66jj6CqmWPv
         wl7UFEivh3viOKQjIGEU2i6HbzogPwFL87iJVZrY/pJJkdSrQy2YCz51+aPVuE+Qmmjc
         8giA5yJxl0lA2Rm/Iq9umfTDesSf6meHAoeOt8Zp5CZmTtTh035jyUH5X49EhidLfCD9
         5NxNe6ib7O8ayWjGYnEh0kM2Fj0zG3aK0/BXwqpmpKm1GUMN45oNZg1/KRFzxah2dwpf
         AWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ5/FowzAocI0ttW8zswzJn2dKKUi5iFR0Wy//VpliA=;
        b=kS7Z/Xvs9QS//pA6K3yZgRgJi95Sg85WGR8XHslehFc/4zsuitCxOIOynlVb/VMoOS
         L5ZdH/akQXU1DNXOtxuPX5qYhma0bB+wTZLY6pixr3hokauuQPjyMRy10P/RBZ9oM3CN
         MmEdnKxr6PMotcPQY4vC0ReXBjGu8TAXEiEsyzpnTI0fVFiLsrVMvvCnCOxKp9sV1QPY
         yA7JZJux7RNqVxXFgd9fXomwFKglMEW4mL5iVhQTZdHUakxOTvSRiVhFbCt2qBVN8l2A
         3HPuw59Ci7IwIzdX9DAx+7GbcUqpq0HCLy3GUW5q2yGzZGyJLIBa7Un60wf/rUfwwNpu
         P1Uw==
X-Gm-Message-State: ANoB5pmx48C9YjUNnZ2HJsY08RV4rPwG+nPvlbq442bnbvjrnhKA9Kv4
        ozoX0mD8uEPWpmLLv3s47VQDyiYCkPBmcCvZ
X-Google-Smtp-Source: AA0mqf40viWKnr8AZ2Bv4zDz+yx+XuVLm4+yfcthP+MgoEp2B+LO40XR1hqp80sZLtlD0PL9B2oQ8w==
X-Received: by 2002:a17:90a:f406:b0:219:9e8:84b2 with SMTP id ch6-20020a17090af40600b0021909e884b2mr59976215pjb.121.1670360336013;
        Tue, 06 Dec 2022 12:58:56 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id s30-20020a63925e000000b00477def759cbsm4179848pgn.58.2022.12.06.12.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 12:58:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p2f1e-005KXs-TS; Wed, 07 Dec 2022 07:58:50 +1100
Date:   Wed, 7 Dec 2022 07:58:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, Josh Triplett <josh@joshtriplett.org>,
        RCU <rcu@vger.kernel.org>,
        syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
Message-ID: <20221206205850.GT3600936@dread.disaster.area>
References: <000000000000bd587705ef202b08@google.com>
 <20221206033450.GS3600936@dread.disaster.area>
 <CACT4Y+b-DCu=3LT+OMHuy4R1Fkgg_cBBtVT=jGtcyiBn4UcbRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b-DCu=3LT+OMHuy4R1Fkgg_cBBtVT=jGtcyiBn4UcbRA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 06, 2022 at 12:06:10PM +0100, Dmitry Vyukov wrote:
> On Tue, 6 Dec 2022 at 04:34, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Dec 05, 2022 at 07:12:15PM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > INFO: rcu detected stall in corrupted
> > >
> > > rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4122 } 2641 jiffies s: 2877 root: 0x0/T
> > > rcu: blocking rcu_node structures (internal RCU debug):
> >
> > I'm pretty sure this has nothing to do with the reproducer - the
> > console log here:
> >
> > > Tested on:
> > >
> > > commit:         bce93322 proc: proc_skip_spaces() shouldn't think it i..
> > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1566216b880000
> >
> > indicates that syzbot is screwing around with bluetooth, HCI,
> > netdevsim, bridging, bonding, etc.
> >
> > There's no evidence that it actually ran the reproducer for the bug
> > reported in this thread - there's no record of a single XFS
> > filesystem being mounted in the log....
> >
> > It look slike someone else also tried a private patch to fix this
> > problem (which was obviously broken) and it failed with exactly the
> > same RCU warnings. That was run from the same commit id as the
> > original reproducer, so this looks like either syzbot is broken or
> > there's some other completely unrelated problem that syzbot is
> > tripping over here.
> >
> > Over to the syzbot people to debug the syzbot failure....
> 
> Hi Dave,
> 
> It's not uncommon for a single program to trigger multiple bugs.
> That's what happens here. The rcu stall issue is reproducible with
> this test program.
> In such cases you can either submit more test requests, or test manually.

So you're telling us syzbot reproducers are unreliable and we are
expected to play whack-a-mole with test resubmission until we get
the result we want?

How do I tell syzbot to resubmit the same patch for testing without
having to send the same patch to syzbot via email again? Can I
retrigger a new test run through the web interface?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
