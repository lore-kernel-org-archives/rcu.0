Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB3EC64ED8
	for <rcu@archiver.kernel.org>; Mon, 27 Feb 2023 15:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjB0POE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjB0POC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Feb 2023 10:14:02 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7781E290
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 07:13:55 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id j17so6767126ljq.11
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5SXc/jrJchHGzpzKP1x2lxlB1TaPEiUmQT++VSbRtCA=;
        b=r+8t87DyShJslxHxR+uFY25wmxvx8Yh3OHtZpG5rFxAgZRZbBjVhev8HdYsOkkmnCL
         lqMfTppL9+UCgkAUOM/PpVAqIrhPhQMbQBuHUUs8MqAsllF54M3d+mW3ytPxQLuMRrA3
         hg2nZN0jKWfkIQ9iyksVOz3q9C7A7Gb/BS8ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SXc/jrJchHGzpzKP1x2lxlB1TaPEiUmQT++VSbRtCA=;
        b=t2dNmB0up4IDJEUtl2zPO39FSnto8OO2ObwcoJIm4SXWNCLjk4W4XB3JpzWExE5pfl
         8DYExkWwZdH88OQrwt0049/7dMpNLENxjVlIuN16XseauikKCXba2C6tps6d7ztmZhHj
         OkjxOzyTQhwMARMo4O+8k5vXca4AtjBWcsHnKqtg/bTXDAl4A3TVq0zgqdShHLxJJcz3
         qo80B7Ym4Wfd6YpYcRGMkD/qAFGHZJt1Mi5wGoyvy37rAJ7NsZ/+xBDnhS+ZTv52y/7e
         EElmzKfCa9zZjwtCyWoL3yvGVkjmSX+UJJNdQcFtMeFDZcjTfXlOBhfSfqG2K2BP+XAH
         NWBQ==
X-Gm-Message-State: AO0yUKXXdC3haw7cqK6y8hRjCvU+pC+e0KLA0imT7Cr9y9BCZQwSnIa+
        J5NfeBd0R54vw2uywQf4rA+QHLsuBXSEXmWJmiUiiA==
X-Google-Smtp-Source: AK7set+QOfUpw7C+vsmSyLyQyi2wlHKvwOnZJxPyGZdqoQUPOJJfmlR+zFVmJcmR69y/6Dux38STi6YocxFP7dfmDCI=
X-Received: by 2002:a2e:a4b5:0:b0:295:b597:c903 with SMTP id
 g21-20020a2ea4b5000000b00295b597c903mr1392295ljm.3.1677510833310; Mon, 27 Feb
 2023 07:13:53 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
 <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
In-Reply-To: <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 27 Feb 2023 10:13:41 -0500
Message-ID: <CAEXW_YS7LAin-Buw6PiG4fwCAtO19aWKNqxBkkqFWFuXkZi=_w@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 27, 2023 at 8:15 AM Joel Fernandes <joel@joelfernandes.org> wrote:
[..]
> >> RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246
> >>
> >> RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c
> >> RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708
> >> RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f
> >> R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000
> >> R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b
> >> FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0
> >> ----------------
> >> Code disassembly (best guess):
> >>   0:   89 07                   mov    %eax,(%rdi)
> >>   2:   49 c7 c0 08 00 00 00    mov    $0x8,%r8
> >>   9:   4d 29 c8                sub    %r9,%r8
> >>   c:   4c 01 c7                add    %r8,%rdi
> >>   f:   4c 29 c2                sub    %r8,%rdx
> >>  12:   e9 76 ff ff ff          jmp    0xffffff8d
> >>  17:   cc                      int3
> >>  18:   cc                      int3
> >>  19:   cc                      int3
> >>  1a:   cc                      int3
> >>  1b:   f3 0f 1e fa             endbr64
> >>  1f:   eb 07                   jmp    0x28
> >>  21:   0f 00 2d e3 8a 34 00    verw   0x348ae3(%rip)        # 0x348b0b
> >>  28:   fb                      sti
> >>  29:   f4                      hlt
> >> * 2a:   fa                      cli <-- trapping instruction
>
> This probably happened before the crash and it is likely unrelated IMO. cli just means interrupts were enabled, the actual problem happened after softirq fired (likely at the tail end of the interrupt).
>

And just to correct myself for completeness, CLI clears the IF flag,
which ends up *disabling maskable interrupts*, not enabling. Still, I
can't see that as a possible reason for the crash.

 - Joel
