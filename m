Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DEFC352A1
	for <rcu@archiver.kernel.org>; Tue,  6 Dec 2022 11:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiLFLGY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Dec 2022 06:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiLFLGX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Dec 2022 06:06:23 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2274C5A
        for <rcu@vger.kernel.org>; Tue,  6 Dec 2022 03:06:22 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id q18-20020a056830441200b006704633f258so2672488otv.0
        for <rcu@vger.kernel.org>; Tue, 06 Dec 2022 03:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P6J5/cA2heNXWUf0rHF45pgIEEYc2mRi3nWq/9vPqQM=;
        b=MuusQTa/qnNbDkJ/sjQ7f/u6J0NdkURpovK6EqeCU0Ck0WQA2QUp5cSCNrPXmTGNJK
         q5yimJwPYB7qbUVcC8L/sXz0qrInRz6Uecy+IqJgAuTkafpN+TMCo7gJsXZW9nk66s0f
         gFDwG+rgY/TQljRgOirRpj3zALG5Ut45hKwhFxApgu0EAnBz2oVkiNb+1TruraBAmgMD
         z3CrLDCpC1rPKDRnp2LLOyfLaD1ErxPYPlsskXbjGlWR+PykkIfJeY4MU4VdsUFXiLKD
         Ea/fhLtJyR3jaDX5Spqmto9lVs8qvS6OZWCSUvK/f0hhsA5pk3qeO8Lk7Z0ka9vb0Cgh
         kgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6J5/cA2heNXWUf0rHF45pgIEEYc2mRi3nWq/9vPqQM=;
        b=5VAaDaduojGRhNbu5moL6Vfnzi8qDziAfnukN58gCoSP+j797WYO2zYICnDrON1qpu
         eFzYJfFRI5XJP+0TK5qDthXUdhVi9kjjbnhl+uKuernRKeL6I1WuwbsmrPdLesiED0gW
         Q8NWZYCOha+Rv1i3u9ijHic6R6zfz2K5KNcDE4YnbNN/jkNadeVS5nZU0Cvd44xYksX0
         GahyP+YFywwux9cChus9/yBCqAo7P0BPf/7HACu2UwuV6bOqTRchy9ubznbnKfp7OSgB
         trnMXoS/FEHW5HjPMg3fVW6+K8vBnDJhKAMrehSeVKJRXYd2yTtMeouhq4qRV+2Ry0+L
         UWyQ==
X-Gm-Message-State: ANoB5pnvcnGQLNGVD35oz9RA8m+hOl1S4GUIlc7ebrThusFmmBg6YjFw
        tAMfrE6yjt1YmOcO6tJkogQ71psxXg4lJ84+v11prQ==
X-Google-Smtp-Source: AA0mqf7F266rR1tTxm4R7434AaCrtd594zQmgO0fP+AzuOZHTD8XQLKdBwxpKHtD6aDv2UG/CANbX1nnEjA0t16Atzk=
X-Received: by 2002:a9d:351:0:b0:66e:6cf5:770a with SMTP id
 75-20020a9d0351000000b0066e6cf5770amr12829902otv.269.1670324781674; Tue, 06
 Dec 2022 03:06:21 -0800 (PST)
MIME-Version: 1.0
References: <000000000000bd587705ef202b08@google.com> <20221206033450.GS3600936@dread.disaster.area>
In-Reply-To: <20221206033450.GS3600936@dread.disaster.area>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 6 Dec 2022 12:06:10 +0100
Message-ID: <CACT4Y+b-DCu=3LT+OMHuy4R1Fkgg_cBBtVT=jGtcyiBn4UcbRA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
To:     Dave Chinner <david@fromorbit.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, Josh Triplett <josh@joshtriplett.org>,
        RCU <rcu@vger.kernel.org>
Cc:     syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 6 Dec 2022 at 04:34, Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Dec 05, 2022 at 07:12:15PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > INFO: rcu detected stall in corrupted
> >
> > rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4122 } 2641 jiffies s: 2877 root: 0x0/T
> > rcu: blocking rcu_node structures (internal RCU debug):
>
> I'm pretty sure this has nothing to do with the reproducer - the
> console log here:
>
> > Tested on:
> >
> > commit:         bce93322 proc: proc_skip_spaces() shouldn't think it i..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1566216b880000
>
> indicates that syzbot is screwing around with bluetooth, HCI,
> netdevsim, bridging, bonding, etc.
>
> There's no evidence that it actually ran the reproducer for the bug
> reported in this thread - there's no record of a single XFS
> filesystem being mounted in the log....
>
> It look slike someone else also tried a private patch to fix this
> problem (which was obviously broken) and it failed with exactly the
> same RCU warnings. That was run from the same commit id as the
> original reproducer, so this looks like either syzbot is broken or
> there's some other completely unrelated problem that syzbot is
> tripping over here.
>
> Over to the syzbot people to debug the syzbot failure....

Hi Dave,

It's not uncommon for a single program to trigger multiple bugs.
That's what happens here. The rcu stall issue is reproducible with
this test program.
In such cases you can either submit more test requests, or test manually.

I think there is an RCU expedited stall detection.
For some reason CONFIG_RCU_EXP_CPU_STALL_TIMEOUT is limited to 21
seconds, and that's not enough for reliable flake-free stress testing.
We bump other timeouts to 100+ seconds.
+RCU maintainers, do you mind removing the overly restrictive limit on
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT?
Or you think there is something to fix in the kernel to not stall? I
see the test writes to
/proc/sys/vm/drop_caches, maybe there is some issue in that code.
