Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0CDC432BE
	for <rcu@archiver.kernel.org>; Wed,  1 Sep 2021 09:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E4E61053
	for <rcu@archiver.kernel.org>; Wed,  1 Sep 2021 09:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbhIAJSW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhIAJSW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Sep 2021 05:18:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0C0C061575
        for <rcu@vger.kernel.org>; Wed,  1 Sep 2021 02:17:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id me10so5087504ejb.11
        for <rcu@vger.kernel.org>; Wed, 01 Sep 2021 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c88R+FAvwJlM8FpJiX5JDC5Io5vB566XAa618GziPaU=;
        b=iJ1Fbxf3vBANGBcLEgMF106n+F4uFoyL6Y0+hpnUgBwLaUHiy8e778XI/I4/Rs3l7C
         tiTPyu7Tj/EOvdfMv5H9Fjd5LalmznFXFnYcOcVUS/NhLFr+N8QSAbOPW9sBuUNKxqR3
         W+U09JpgAZhpP4tQfd+YBnLp6PcDVXhIw2Qu9J/ghywddE5DSGrE5jrW4aLjFym7v/4h
         Wkvu6UYwlpVviTFlX7KN0O4q2fHRM1McJ7WPfRByBR3P1GghI+dRpwel2XuhA4Xc5kzt
         AxeLIOkwfWx6i87lTbfs9syG0s/56EbFac8hFVO8+/ObwxW0hvLXwCKSyMGk047OOq8U
         islQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c88R+FAvwJlM8FpJiX5JDC5Io5vB566XAa618GziPaU=;
        b=q5koyxGMazkxSh915pcxsl4+77u8l5X7KjceI/B/lfkV0D5Vqw6aTkQFe3EL54L1Lp
         vTr/hk8OPoF7zHAq+O/7BobnPy/qeNBqbOwIcXt6rxLud3ooFk+KtUFMpTL7rKMET2Zd
         dtIBExYc/W/raHqeGUm0Rrzq+YtBwEChQ8wpVTLhOCMzF7waRDhu9reMsThyD5ghtOBR
         jnk5haJpAlzkKyVEfB5nmsShhMx0gAm7YucRVOx660Bqwe4NKU3OUB1prgGRghtI1kF+
         w2XJp5rUCsZvLwIMkdSYiToOGWVuSdb4Uw5d6L9i3gxEvjdb22fOVdi3erLN1rwKYfmG
         URGw==
X-Gm-Message-State: AOAM5339rTLlKjysyRCFynzSsF56MWFJNbzekHSUBXCaT/LH61AEjk5E
        ULhcgH/ikml+z3WFwQpeY0TzWdFSdJvTI8ldmB4=
X-Google-Smtp-Source: ABdhPJzoav8kc9yIG/mt4OFYq1KpuMJ2drdupuseuf12AblbOu9t6chvXrPnkVNIF5GlXrGEWf/6KViSaKQKgeCFv1Q=
X-Received: by 2002:a17:906:1d19:: with SMTP id n25mr31838328ejh.11.1630487844067;
 Wed, 01 Sep 2021 02:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210831152144.GA28128@trex> <CAABZP2xGnSLVbgxqjKMq=Oj_H7rYfYjuCvmBpmZ4tRptGs3SEw@mail.gmail.com>
 <CAABZP2wUdToiAWOAgqDZrZtkuEdrXEv9GDgbioW3PZAyseOSgA@mail.gmail.com>
 <CAABZP2zg8c_gkm4+h4-mPCv_uDf5-iJFHEExCDFoES0jmBeuKw@mail.gmail.com> <20210901082321.GA6551@trex>
In-Reply-To: <20210901082321.GA6551@trex>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 1 Sep 2021 17:17:12 +0800
Message-ID: <CAABZP2yERfsiV6VfmEjgDg9p9RD65Yu0y8yEq9f9qSmFxQTJJQ@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        Neeraj Upadhyay <neeraju@codeaurora.org>
List-Id: <soc.lore.kernel.org>
Cc:     paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 1, 2021 at 4:23 PM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 01/09/21, Zhouyi Zhou wrote:
> > Hi,
> >
> > I  perform following two new rounds of experiments:
> >
> >
> > Test environment (x86_64 debian10 virtual machine: kvm -cpu host -smp
> > 8 -hda ./debian10.qcow2 -m 4096 -net
> > user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
> > -vnc :30)
> >
> > 1.   CONFIG_RCU_BOOST=y
> > 1.1 as root, run #stress-ng --sequential 100  --class scheduler -t 5m --times
> > 1.2 as regular user at the same time, run $stress-ng --sequential 100
> > --class scheduler -t 5m --times
> >
> > System begin OOM kill after 6 minutes:
> > 31 19:41:12 debian kernel: [  847.171884] task:kworker/1:0     state:D
> > stack:    0 pid: 1634 ppid:     2 flag\
> > s:0x00004000
> > Aug 31 19:41:12 debian kernel: [  847.171890] Workqueue: ipv6_addrconf
> > addrconf_verify_work
> > Aug 31 19:41:12 debian kernel: [  847.171897] Call Trace:
> > Aug 31 19:41:12 debian kernel: [  847.171903]  __schedule+0x368/0xa40
> > Aug 31 19:41:12 debian kernel: [  847.171915]  schedule+0x44/0xe0
> > Aug 31 19:41:12 debian kernel: [  847.171921]
> > schedule_preempt_disabled+0x14/0x20
> > Aug 31 19:41:12 debian kernel: [  847.171924]  __mutex_lock+0x4b1/0xa10
> > Aug 31 19:41:12 debian kernel: [  847.171935]  ? addrconf_verify_work+0xa/0x20
> > Aug 31 19:41:12 debian kernel: [  847.171948]  ? addrconf_verify_work+0xa/0x20
> > Aug 31 19:41:12 debian kernel: [  847.171951]  addrconf_verify_work+0xa/0x20
> > Aug 31 19:41:12 debian kernel: [  847.171955]  process_one_work+0x1fa/0x5b0
> > Aug 31 19:41:12 debian kernel: [  847.171967]  worker_thread+0x64/0x3d0
> > Aug 31 19:41:12 debian kernel: [  847.171974]  ? process_one_work+0x5b0/0x5b0
> > Aug 31 19:41:12 debian kernel: [  847.171978]  kthread+0x131/0x180
> > Aug 31 19:41:12 debian kernel: [  847.171982]  ? set_kthread_struct+0x40/0x40
> > Aug 31 19:41:12 debian kernel: [  847.171989]  ret_from_fork+0x1f/0x30
> > Aug 31 19:41:12 debian kernel: [  847.176007]
> > Aug 31 19:41:12 debian kernel: [  847.176007] Showing all locks held
> > in the system:
> > Aug 31 19:41:12 debian kernel: [  847.176016] 1 lock held by khungtaskd/56:
> > Aug 31 19:41:12 debian kernel: [  847.176018]  #0: ffffffff82918b60
> > (rcu_read_lock){....}-{1:2}, at: debug_show_a\
> > ll_locks+0xe/0x1a0
> >
> > 2.  # CONFIG_RCU_BOOST is not set
> > 2.1 as root, run #stress-ng --sequential 100  --class scheduler -t 5m --times
> > 2.2 as regular user at the same time, run $stress-ng --sequential 100
> > --class scheduler -t 5m --times
> > System begin OOM kill after 6 minutes:
> > The system is so dead, that I can't save the backtrace to file nor did
> > kernel has a chance to save the log to /var/log/messages
> >
>
> all,
>
> Thanks for testing on x86. we can also reproduce on qemu arm64. So I
> think it will point out to the stress-ng test itself; I will debug it
> early next week - didnt expect so much support so fast TBH, it took me
> by surprise - and will report then (thanks again)

You are very welcome ;-)
I'm very glad that our effort can be of some help to you,
I've learned a lot from both of you during this process.
Looking forward to seeing your report.

Thanks
Zhouyi
