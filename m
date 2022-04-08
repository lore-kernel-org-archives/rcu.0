Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A39C433F5
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 10:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiDHKEh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 06:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiDHKEg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 06:04:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C938B972AA
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 03:02:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ot30so16180467ejb.12
        for <rcu@vger.kernel.org>; Fri, 08 Apr 2022 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jNjdDR9GwRW08Whk7NQY8zl0I1ljR1QYgIpdjTAmx+I=;
        b=JL4EzbSmAH5MOM8Cj48evlVXrKhasMm966jPzXC6EeJt1+9V6B/sUICsndEmALOTBi
         mR9/6Kjyt1nb5bXHsPn4SBW9E3ikaaLxohDOlQ0BBVczMDFNTcZp1AtOCcQAn9FKQf1N
         lNOfY2GXvVVpK0B4rzjqgvAA5F+wkS6TPWNn92zdXfS77T9xkHPn0rx4vYfvrMZ+tycu
         9NoajP1cpc9bcZvDOdGWQuFzd5PcpvphvtGf9XVZdAxY6XFoCiMfG7KbWDeKQN4bv4uq
         6m402ryAa+ar6i76TUxtMLtGQG4G+8DpiVE5vUlzU3b1tL7oAipdY2ooo3Y6kHU6UMWs
         yTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNjdDR9GwRW08Whk7NQY8zl0I1ljR1QYgIpdjTAmx+I=;
        b=VW90aMEan88BMrXrwmO4DJmhm7ZtQZOp90ohUxI+Yv3lYzFcJHEKoUpal477LbgCFC
         Mo7rSks6ugOeDRS4NiPDN3lbvwQPbA0HM53nQp0gBP2qKMIl7w9z9AK6xnpcyTTfOaZf
         mFxDk8pXiBNjptaz2GrJxn2PXUn6eQ8RHPgm8rK4r2S9Z/K+vv75xzpNKWP4EAoro+Uy
         7tTN4T3mGY1jsH05YldD+0exsH+7q6IdBpdFcx6iIRmWXFstoOrypkO52yiZjdE7UqLh
         3RfBbKd/xEXX6mkhhLBJj/MFPDOvtUyAO2jkQM1HvFwWBSGMekNT1yvTtBRCvc5IAKjB
         is/A==
X-Gm-Message-State: AOAM531VIuVctx/hu6tMWzInWt45U4DRz1Apdzq7CjnBlzx3Tdoj2Bg8
        din4r2pMdUvkEwOFwghYYOqb6UEK9uLlUW+ycy8=
X-Google-Smtp-Source: ABdhPJxUh6ig+tIb7ZLGnVrw3jOvwjNLwlMbT2O+DqCy5O0+dBRPvr9pCJpPqC8m34BiyK59oKr/pkmtL8xbvftl/Ck=
X-Received: by 2002:a17:907:7da5:b0:6e4:e40f:60a0 with SMTP id
 oz37-20020a1709077da500b006e4e40f60a0mr17739145ejc.486.1649412151422; Fri, 08
 Apr 2022 03:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1> <87pmls6nt7.fsf@mpe.ellerman.id.au>
In-Reply-To: <87pmls6nt7.fsf@mpe.ellerman.id.au>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 8 Apr 2022 18:02:19 +0800
Message-ID: <CAABZP2wVAzybDTjUWxwGG4HmWK7V8rJVVFxpRx-3F9n5oST3+A@mail.gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 8, 2022 at 3:23 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Wed, Apr 06, 2022 at 05:31:10PM +0800, Zhouyi Zhou wrote:
> >> Hi
> >>
> >> I can reproduce it in a ppc virtual cloud server provided by Oregon
> >> State University.  Following is what I do:
> >> 1) curl -l https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.18-rc1.tar.gz
> >> -o linux-5.18-rc1.tar.gz
> >> 2) tar zxf linux-5.18-rc1.tar.gz
> >> 3) cp config linux-5.18-rc1/.config
> >> 4) cd linux-5.18-rc1
> >> 5) make vmlinux -j 8
> >> 6) qemu-system-ppc64 -kernel vmlinux -nographic -vga none -no-reboot
> >> -smp 2 (QEMU 4.2.1)
> >> 7) after 12 rounds, the bug got reproduced:
> >> (http://154.223.142.244/logs/20220406/qemu.log.txt)
> >
> > Just to make sure, are you both seeing the same thing?  Last I knew,
> > Zhouyi was chasing an RCU-tasks issue that appears only in kernels
> > built with CONFIG_PROVE_RCU=y, which Miguel does not have set.  Or did
> > I miss something?
> >
> > Miguel is instead seeing an RCU CPU stall warning where RCU's grace-period
> > kthread slept for three milliseconds, but did not wake up for more than
> > 20 seconds.  This kthread would normally have awakened on CPU 1, but
> > CPU 1 looks to me to be very unhealthy, as can be seen in your console
> > output below (but maybe my idea of what is healthy for powerpc systems
> > is outdated).  Please see also the inline annotations.
> >
> > Thoughts from the PPC guys?
>
> I haven't seen it in my testing. But using Miguel's config I can
> reproduce it seemingly on every boot.
>
> For me it bisects to:
>
>   35de589cb879 ("powerpc/time: improve decrementer clockevent processing")
>
> Which seems plausible.
I also bisect to 35de589cb879 ("powerpc/time: improve decrementer
clockevent processing")
>
> Reverting that on mainline makes the bug go away.
I also revert that on the mainline, and am currently doing a pressure
test (by repeatedly invoking qemu and checking the console.log) on PPC
VM in Oregon State University.
>
> I don't see an obvious bug in the diff, but I could be wrong, or the old
> code was papering over an existing bug?
>
> I'll try and work out what it is about Miguel's config that exposes
> this vs our defconfig, that might give us a clue.
Great job!
>
> cheers
Thanks
Zhouyi
