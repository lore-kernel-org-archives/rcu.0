Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF04C433EF
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 22:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbiDHWqp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 18:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbiDHWqp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 18:46:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2696E4B1CC
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 15:44:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bq8so19937527ejb.10
        for <rcu@vger.kernel.org>; Fri, 08 Apr 2022 15:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uxGjxzfYVWTJq15O79jiPZ7fmw/KK3EXoBwkGCxxE0=;
        b=d4lqFsZ2QMM3SrgV987egc5/wg2Uat+S3IaT5jgvUTTE/Hl/TpWzin2anDdB1bJRyk
         f0uU5OIiXGu/C3VQgANPUuTg8bDBGMjGpc9PuQXooNTvwO3spuyexxLuXhLDPGgSpH6Z
         tOtm9FrDQPao2IhJMcu7Zq7za+a2vzua1FzMZCpVP1u9FUOFwnzW3mzWT5tqTjBRq5zz
         1m1W2pGQ0B/ObbGp8WWkjFgspkmm1b2pZUJWP1hY8IFB/y6fO+TklB9OUTBEhJ/9LE60
         XXCMIOWPQSive9pR+5LUKDFrraccsLekpieBdGj+MNv5NlQwqzGCQ0OugeTyGd9cQf/N
         xCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uxGjxzfYVWTJq15O79jiPZ7fmw/KK3EXoBwkGCxxE0=;
        b=kq0DrNGUpGLjDE4g+Q3487JVDv1j2o0LJWeouvpII4La2wrPg4wDjGc82vd1+W2XKo
         aDnPAFk19Ge6lNQ+Cl1VOaXZG2rAKL98DUex6HaGSGskyHPl0jpz4oMt4dA9DRisTvzI
         HV1z57SE8OCxNMW1NtSp503q7QlcMGDiLZV5GSYCbfTBkHZt8z8bQ4eQdDlTKwGZMUja
         M2VW/ID8u94YWTMo6unAG2scq1TkDeP+2b6I5dpV2Xrp8H8+H5F3SEm2lggLN2XeTHf7
         tVMNxvH44whPI0wX4aG3q+NTwwj1Lu10zyDuJvucj0gRu8vPVxssvEdik0MRhq4nByGb
         jNvw==
X-Gm-Message-State: AOAM530vkDAgL5eEtb7dSd1fhMoret/h6mxaFXo0/guuDcTvRCR1T8WQ
        CF5/cfLi01rIGo44rGHO4GBk/n0+w1t7QWK1zSsekhCWFNQ=
X-Google-Smtp-Source: ABdhPJzshiLSsi59vRK2c90VhZnu1mGzbrqtQeHKbye31r+Es+bv/setowLd1crHYftMGD2qbpUaLljJqNY9srr7eOQ=
X-Received: by 2002:a17:907:6d07:b0:6e7:979e:9c0a with SMTP id
 sa7-20020a1709076d0700b006e7979e9c0amr20046460ejc.614.1649457878762; Fri, 08
 Apr 2022 15:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <Yje18NgLjpPo7VEp@casper.infradead.org> <SA1PR15MB49655CF8AC3998CA9A7CE903B8169@SA1PR15MB4965.namprd15.prod.outlook.com>
 <20220321043813.GF4285@paulmck-ThinkPad-P17-Gen-1> <20220321071327.GA798064@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2woW2UuPg1rSYYc+S6k7qd9JwM4gJFMHhiVcBkDewE_Nw@mail.gmail.com>
 <20220321155746.GG4285@paulmck-ThinkPad-P17-Gen-1> <20220322104909.GB701946@lothringen>
 <CAABZP2ws9oP9sv0Pzbb059+Fm=dmaNWD5VxMZt92QB7m7Nm=GQ@mail.gmail.com>
In-Reply-To: <CAABZP2ws9oP9sv0Pzbb059+Fm=dmaNWD5VxMZt92QB7m7Nm=GQ@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 9 Apr 2022 06:44:27 +0800
Message-ID: <CAABZP2yzi6ZPxoVu=3+EHiBW3EFEjxTkibSL-FbnSLaj9LBcrQ@mail.gmail.com>
Subject: Re: Fw: rc6 splat
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Paul McKenney <paulmckrcu@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        rcu <rcu@vger.kernel.org>, Zhouyi Zhou <zhouzhouyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[CC RCU and Frederic and Matthew]

Hi Paul

After several days'  experiment on my Thinkpad P1 gen 4 (Intel 11800H
8 core 16 threads), I found that it is CONFIG_NFS_V4 that makes the
difference.
If I remove CONFIG_NFS_V4 from TASKS01, the probability of triggering
the warning is significantly increased!

And, Yes, there is no CONFIG_NFS_V4 in Matthew's original email.

This is very interesting. After debugging the kernel, I found
init_nfs_v4 does a lot of work, did it lend grace period to the test?
I am very happy to continue to do research on this topic ;-)

Thank you for your guidance!

Thanks
Zhouyi

On Tue, Mar 22, 2022 at 8:31 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> Dear Frederic
>
> I may not be right, please correct me if so
>
> On Tue, Mar 22, 2022 at 6:49 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Mon, Mar 21, 2022 at 08:57:46AM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 21, 2022 at 11:46:28PM +0800, Zhouyi Zhou wrote:
> > > > Hi Paul and Willy
> > > >
> > > > I can reproduce the bug. Following is what I do:
> > > > 1.1 git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > 1.2 cd linux
> > > > 1.3 cp http://154.223.142.244/20220321/config-20220321 to .config
> > > > 1.4 make vmlinux -j 16
> > > > 1.5 kvm -smp 4 -net none     -serial file:/tmp/console.log -m 512
> > > > -kernel vmlinux -append "console=ttyS0"
> > > > 1.6 the /tmp/console.log is uploaded to
> > > > http://154.223.142.244/20220321/console.log
> > > >
> > > > 2.1 wget https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.17-rc6.tar.gz
> > > > 2.2 - 2.6 the result is similar.
> > > >
> > > > I am very interested in this topic.
> > > > Could you please give me about a week to make a full understand of the
> > > > meaning of the warning, and try the fixes one by one, and
> > > > find out what happens?
> > >
> > > Works for me!  The eventual fix likely involves some version of Valentin
> > > Schneider's patchset that provides APIs that allow RCU to detect the
> > > current preemption state.  Which can change at runtime.  A prototype of
> > > this patch is on -rcu here:
> > >
> > > 2436ee0b4cea ("EXP preempt/dynamic: Introduce preempt mode accessors")
> > >
> > > It is entirely possible that the fix might need to go to mainline sooner
> > > rather than later.
> >
> > I guess it's possible to do that but that patch alone shouldn't fix anything.
> > Also, what is the issue exactly? :-)
> The issue is with certain kernel configuration
> (http://154.223.142.244/20220321/config-2022032), the mainline (and
> -rcu ) kernel  will warn
> "call_rcu_tasks() has been failed" in rcu_tasks_verify_self_tests.
> (http://154.223.142.244/20220321/console.log)
>
> Kind Regard
> Zhouyi
> > I can't rewind far enough the conversation.
> >
> > Thanks.
