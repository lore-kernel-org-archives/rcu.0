Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55D9C433EF
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 14:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiDHO1i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiDHO1i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 10:27:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E1D353A9B
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 07:25:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg10so17729132ejb.4
        for <rcu@vger.kernel.org>; Fri, 08 Apr 2022 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2DoQQgFz7qw9MRtc8eSxOedE/fArJRIQcISz938HxU=;
        b=BAdiVnHZN6uxLx/6Snzgs112QvtFvU1KZQqXra3goU8hv0ht1R+cuXXr6/+lMuwzt1
         4PO2rKowkKCAkKi5hwhDWRvRWAmaRFSdiBhrjcbPy5ezs0m46X5nX9B6pteN/kbX2PEo
         R/3lgpXq7nPscncCc6hP4VWo0bdt3YE684mbwXJ3HUn9uL9ZbLYyFPq4hD+jCPj54Kp5
         TEM0KoJPpY8J/ALpOoosmnVdeKL9Sk1p5uTHl0WiFWMAymGXWNuEBM9lo3NnCkpvDQOa
         ZFp4mMIxadHfGdrSARV+hWlJq9VTcWRZLlI7u+L3uyZ0U2a+UhYvnhqVlUB+gdXE7+69
         dXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2DoQQgFz7qw9MRtc8eSxOedE/fArJRIQcISz938HxU=;
        b=ZeAB+G2xBKl0HY5L2yDTHGJa11qIsymzemzaLMtdQe1Z1/d8xwdsOWrngysHrmuyj4
         q4gipUvssdLNnwPkKmHWOOzt+MLTFejCR3QJ/PAH/cWESxrBt3gXLqMMcwiRZ31l+eGG
         QyoqoT/ryWjFf3+76nxUuqQkTtR2OB3iKq71Uf1C5n8HUK/w2aB67gPlHwisHlAhEzZ3
         kpiMFZzHYSw0EnpMsur4tvtOi8YMabt4IEY6T+QxqmX9M4c/SgPWjOlIaT1GVzU1DzyK
         xKgmlaW9rUWi98zxlp8MZ6YWuGalkpZsccO4DQpXv74w5urmwsbFvaMD2IHlg+JRdOuD
         PxOQ==
X-Gm-Message-State: AOAM53267Znlu54M6AetQM7C/tIA49lUqCBLXWKzoM2s3biTDNuvg6dR
        YSkV2qlNX07Vc5byaO/F6Q+CEBmEaDo4sGXm57I=
X-Google-Smtp-Source: ABdhPJwMMe6CWFJwjcXGuD2SKEWs4JkfV9lHITjThhdtLlmqkmLABQYXc9h+iYmaeyssvf47ZyEN/O3Ml6qX00pak4M=
X-Received: by 2002:a17:907:d1e:b0:6e1:3aa5:8e5 with SMTP id
 gn30-20020a1709070d1e00b006e13aa508e5mr18285929ejc.324.1649427932107; Fri, 08
 Apr 2022 07:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1> <87pmls6nt7.fsf@mpe.ellerman.id.au>
 <CAABZP2wVAzybDTjUWxwGG4HmWK7V8rJVVFxpRx-3F9n5oST3+A@mail.gmail.com> <20220408140712.GZ4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220408140712.GZ4285@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 8 Apr 2022 22:25:20 +0800
Message-ID: <CAABZP2zEU8eULq30ZLcUeqxjXuLTKO4b3wm_Jo458Nq_JJ7pEw@mail.gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, rcu <rcu@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 8, 2022 at 10:07 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Apr 08, 2022 at 06:02:19PM +0800, Zhouyi Zhou wrote:
> > On Fri, Apr 8, 2022 at 3:23 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >
> > > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > > > On Wed, Apr 06, 2022 at 05:31:10PM +0800, Zhouyi Zhou wrote:
> > > >> Hi
> > > >>
> > > >> I can reproduce it in a ppc virtual cloud server provided by Oregon
> > > >> State University.  Following is what I do:
> > > >> 1) curl -l https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.18-rc1.tar.gz
> > > >> -o linux-5.18-rc1.tar.gz
> > > >> 2) tar zxf linux-5.18-rc1.tar.gz
> > > >> 3) cp config linux-5.18-rc1/.config
> > > >> 4) cd linux-5.18-rc1
> > > >> 5) make vmlinux -j 8
> > > >> 6) qemu-system-ppc64 -kernel vmlinux -nographic -vga none -no-reboot
> > > >> -smp 2 (QEMU 4.2.1)
> > > >> 7) after 12 rounds, the bug got reproduced:
> > > >> (http://154.223.142.244/logs/20220406/qemu.log.txt)
> > > >
> > > > Just to make sure, are you both seeing the same thing?  Last I knew,
> > > > Zhouyi was chasing an RCU-tasks issue that appears only in kernels
> > > > built with CONFIG_PROVE_RCU=y, which Miguel does not have set.  Or did
> > > > I miss something?
> > > >
> > > > Miguel is instead seeing an RCU CPU stall warning where RCU's grace-period
> > > > kthread slept for three milliseconds, but did not wake up for more than
> > > > 20 seconds.  This kthread would normally have awakened on CPU 1, but
> > > > CPU 1 looks to me to be very unhealthy, as can be seen in your console
> > > > output below (but maybe my idea of what is healthy for powerpc systems
> > > > is outdated).  Please see also the inline annotations.
> > > >
> > > > Thoughts from the PPC guys?
> > >
> > > I haven't seen it in my testing. But using Miguel's config I can
> > > reproduce it seemingly on every boot.
> > >
> > > For me it bisects to:
> > >
> > >   35de589cb879 ("powerpc/time: improve decrementer clockevent processing")
> > >
> > > Which seems plausible.
> > I also bisect to 35de589cb879 ("powerpc/time: improve decrementer
> > clockevent processing")
>
> Very good!  Thank you all!!!
You are very welcome ;-)  and Thank you all!!!!
>
>                                                         Thanx, Paul
>
> > > Reverting that on mainline makes the bug go away.
> > I also revert that on the mainline, and am currently doing a pressure
> > test (by repeatedly invoking qemu and checking the console.log) on PPC
> > VM in Oregon State University.
After 306 rounds of stress test on mainline without triggering the bug
(last for 4 hours and 27 minutes), I think the bug is indeed caused by
35de589cb879 ("powerpc/time: improve decrementer clockevent
processing") and stop the test for now.

Thanks ;-)
Zhouyi
> > >
> > > I don't see an obvious bug in the diff, but I could be wrong, or the old
> > > code was papering over an existing bug?
> > >
> > > I'll try and work out what it is about Miguel's config that exposes
> > > this vs our defconfig, that might give us a clue.
> > Great job!
> > >
> > > cheers
> > Thanks
> > Zhouyi
