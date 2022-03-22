Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94368C433EF
	for <rcu@archiver.kernel.org>; Tue, 22 Mar 2022 12:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiCVMdE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiCVMdD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Mar 2022 08:33:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CD17DA9A
        for <rcu@vger.kernel.org>; Tue, 22 Mar 2022 05:31:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c62so1967712edf.5
        for <rcu@vger.kernel.org>; Tue, 22 Mar 2022 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kq+06BP6vD8UbXUJT7pklQ3S/G87xpUpKpomd/gP9DU=;
        b=Vw6LmalGbNmPByBCq9wt5VZZF3SNR4TW6DehiwRdmb0ta+G/spWaFZ1+74w8hN44MD
         1zcrg9uKYhqG7d/aWsH8Szv6/OYuYtGxkZABT7tQG60J5luLCCoytKLGssz2LtDqqpZX
         +z9WL2ZM5NsVchckzfojeBMISYSEz6+Aq9bX7mWEMXyz+pKMxM66Wwzh3DAQuPWdagw5
         sya4DRGECqPAinSTt8/5pjh8M0CtnFhL0OHj2bMAbO/d2V1ddE7vobAE1/UPZyCmzw3t
         Bk8pK9mULn5YdqWDRKIeydC/QUrqWkidUOMRecqSk4TfOc9f+wyQsKAAP21b1NFJOnGa
         LKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kq+06BP6vD8UbXUJT7pklQ3S/G87xpUpKpomd/gP9DU=;
        b=tuGdiT7x0H+E4FX4mHgM+Avo547h3oC3zFAA65Yn/1yhAupiGbuM+1NrPVsHNIEUEl
         3LECc5zoXgQ7nlQszTZTJt1D9lbOYIAGwMcYEeMzbKKKj2CF1mOcdBUF2t50t0nQIaL3
         lpDp4xQcuI5iqjjMrEEzvFye9sv9+ViEmohPVi2n0d71A1/jzJw6K+gKfIQ323Ojc2gD
         VDcU8Yyj7v6sZFBhVoRuGQ9cP4ZsQpH7GnC4joG/MVZ/jdirAGM1Xb90AFAXWYKoaVMm
         hNKGVKyaJWF4FTd67BoptxYy7GcdaEN6KHe52nbVZx4ct9BnE4bis6xDYRXuOlV+H91x
         5S3w==
X-Gm-Message-State: AOAM531ZtZtV/9IUDLbZDCha0vZVIRfR69G4tBjliG+NVvkn3dnK9KDD
        zW25h3bkYrBHfUvLK3Ard86fsdknajVQJB/qgSs=
X-Google-Smtp-Source: ABdhPJwYXoL8V0rzCT1HlBVgWH19LUfsipWEaeq5b/amcY1hPu7vBSUAKprQeQxF1NgyLI3NGHvmTNlyDZ0mx9yZK2E=
X-Received: by 2002:a05:6402:3715:b0:410:a415:fd95 with SMTP id
 ek21-20020a056402371500b00410a415fd95mr27839328edb.288.1647952293015; Tue, 22
 Mar 2022 05:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <Yje18NgLjpPo7VEp@casper.infradead.org> <SA1PR15MB49655CF8AC3998CA9A7CE903B8169@SA1PR15MB4965.namprd15.prod.outlook.com>
 <20220321043813.GF4285@paulmck-ThinkPad-P17-Gen-1> <20220321071327.GA798064@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2woW2UuPg1rSYYc+S6k7qd9JwM4gJFMHhiVcBkDewE_Nw@mail.gmail.com>
 <20220321155746.GG4285@paulmck-ThinkPad-P17-Gen-1> <20220322104909.GB701946@lothringen>
In-Reply-To: <20220322104909.GB701946@lothringen>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 22 Mar 2022 20:31:21 +0800
Message-ID: <CAABZP2ws9oP9sv0Pzbb059+Fm=dmaNWD5VxMZt92QB7m7Nm=GQ@mail.gmail.com>
Subject: Re: Fw: rc6 splat
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Paul McKenney <paulmckrcu@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear Frederic

I may not be right, please correct me if so

On Tue, Mar 22, 2022 at 6:49 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Mon, Mar 21, 2022 at 08:57:46AM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 21, 2022 at 11:46:28PM +0800, Zhouyi Zhou wrote:
> > > Hi Paul and Willy
> > >
> > > I can reproduce the bug. Following is what I do:
> > > 1.1 git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
> > > 1.2 cd linux
> > > 1.3 cp http://154.223.142.244/20220321/config-20220321 to .config
> > > 1.4 make vmlinux -j 16
> > > 1.5 kvm -smp 4 -net none     -serial file:/tmp/console.log -m 512
> > > -kernel vmlinux -append "console=ttyS0"
> > > 1.6 the /tmp/console.log is uploaded to
> > > http://154.223.142.244/20220321/console.log
> > >
> > > 2.1 wget https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.17-rc6.tar.gz
> > > 2.2 - 2.6 the result is similar.
> > >
> > > I am very interested in this topic.
> > > Could you please give me about a week to make a full understand of the
> > > meaning of the warning, and try the fixes one by one, and
> > > find out what happens?
> >
> > Works for me!  The eventual fix likely involves some version of Valentin
> > Schneider's patchset that provides APIs that allow RCU to detect the
> > current preemption state.  Which can change at runtime.  A prototype of
> > this patch is on -rcu here:
> >
> > 2436ee0b4cea ("EXP preempt/dynamic: Introduce preempt mode accessors")
> >
> > It is entirely possible that the fix might need to go to mainline sooner
> > rather than later.
>
> I guess it's possible to do that but that patch alone shouldn't fix anything.
> Also, what is the issue exactly? :-)
The issue is with certain kernel configuration
(http://154.223.142.244/20220321/config-2022032), the mainline (and
-rcu ) kernel  will warn
"call_rcu_tasks() has been failed" in rcu_tasks_verify_self_tests.
(http://154.223.142.244/20220321/console.log)

Kind Regard
Zhouyi
> I can't rewind far enough the conversation.
>
> Thanks.
