Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF80C433F5
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 13:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiDHNzJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiDHNzH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 09:55:07 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687322BF6
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 06:53:02 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g21so10605202iom.13
        for <rcu@vger.kernel.org>; Fri, 08 Apr 2022 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5e9dlqqGa3XJS0I5rHwbdGy3FbPKnOAA+VlJTkacARQ=;
        b=SPBcHZTjSqSCpo5GYly+wtmy+XoJdfchQrLSBDc8XYbL+gUDKfgrxN2I8z6IMp4GkD
         y7nxQcl/1AXr+6DIkf+TY+h7guouYc6qZiemUprSYfeQfBDhtytCgJAZfrO4bt1qfz9S
         2IILQqJli4hYcy0LJ+mP4W5qMfY7sk8W4ZfPRfTGSjFtPxMk12gYmqvhv/i/GaCcldGl
         OSpAt9V9ndydv2ZaoRMEVlAVNvYfFY/P/3fBjJ4Wb54kLuANHBy90dzQA2atRYAy+6IS
         6Et0UdQojaMfzJyAGIJ7ZW8UZTRJdKEiFVoBtB+JRux+2VuG1FRe0VWIQwCRQU6ReOgU
         5tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5e9dlqqGa3XJS0I5rHwbdGy3FbPKnOAA+VlJTkacARQ=;
        b=cRGUDlLBv4YhSihROGRcXd+bBuYtU2Gx9wUHsGpOwBQvAgC/g431iU6hOuQTMekOh5
         2eUjgJA70MsH7+u06BvOhqmgiwmyIXYpfqC2kb98mg1iz5nhtwKY8mzKoyXhNqIXj2aK
         Knp3+BOcsOojiXqYBW4rmJA60ve4L2EVlVpOJpbYVzSnA4WjyVpFgr9eT3mVA10HGhbU
         LuWC9gloWqiUqkcBodhj1SJnJI/YybHtWXM3H95Ct/bcanIjVkru9RStxlDU7IX8iZOZ
         c8dHHekGYQTN+RuqYShxvra7XxqJB/ITGij/LowhTkZpZrRWRnhERHv8j6u+RTH1WTw2
         zShg==
X-Gm-Message-State: AOAM532/vqcACGk5niMxe4uKFrsfwL2+zl99a5qaiN3JkfMZ+FtxCXdv
        pvQVIrGudcSDwgzf1Zctq71HOBvCfTcbxn14jv0=
X-Google-Smtp-Source: ABdhPJwRDgOcxjcoMrIlfHAH1sjXyZsj5D5yz2RRUJm8HP9pAHyYbj6LekeZ7xrD6AvrV8bAaBvo9yeF0RxhHATdGCs=
X-Received: by 2002:a05:6638:2490:b0:323:b728:429f with SMTP id
 x16-20020a056638249000b00323b728429fmr9594498jat.308.1649425981987; Fri, 08
 Apr 2022 06:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1> <87pmls6nt7.fsf@mpe.ellerman.id.au>
In-Reply-To: <87pmls6nt7.fsf@mpe.ellerman.id.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 8 Apr 2022 15:52:50 +0200
Message-ID: <CANiq72mWFrN8TP6Rj0cyON0MCR3AFW1b4qhjFrNQZ8rZw9B1RA@mail.gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, rcu <rcu@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 8, 2022 at 9:23 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> I haven't seen it in my testing. But using Miguel's config I can
> reproduce it seemingly on every boot.

Hmm... I noticed this for some kernel builds: in some builds/commits,
it triggered the very first time, while in others I had to re-try
quite a few times. It could be a "fluke", but since it happened to you
too (and Zhouyi seemed to need 12 tries), it may be that particular
kernel builds makes the bug much more likely.

> For me it bisects to:
>
>   35de589cb879 ("powerpc/time: improve decrementer clockevent processing")
>
> Which seems plausible.
>
> Reverting that on mainline makes the bug go away.

That is great, thanks for that -- I can revert that one in our CI meanwhile.

> I'll try and work out what it is about Miguel's config that exposes
> this vs our defconfig, that might give us a clue.

Yeah, it is one based on the "debug" one you sent for Rust PPC.
Assuming you based that one on the others we had for other archs, then
I guess we are bound to find some things like this at times like with
randconfig, since I made them to be fairly minimal and "custom"... :)

Cheers,
Miguel
