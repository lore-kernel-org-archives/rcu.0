Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D6EC07E9A
	for <rcu@archiver.kernel.org>; Wed, 14 Jul 2021 04:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB96613AF
	for <rcu@archiver.kernel.org>; Wed, 14 Jul 2021 04:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhGNErt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Jul 2021 00:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNErt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Jul 2021 00:47:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2430FC0613DD;
        Tue, 13 Jul 2021 21:44:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h2so1321230edt.3;
        Tue, 13 Jul 2021 21:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCP3w3tFCinM6Ly6XsUgy2VIfVWYdK6TgKJMdEz5D5U=;
        b=lWqwRtFk6o4MDzbuCehOSmGvyKHu98cEPG//eKaRfHBIwo8YXlLtt3gGsg/AKgtHR1
         MrLKl8rkb3JmyuK7UbQOsS3Hh+t6Bw0X0kI1PaeKVvS5m17D4psn/zfb9XzjA+pFbpYR
         R9EOm/7IS67jsq8JL4KZTN0j7pOnAkef3CP52nVLJHVlgE7jlq7Ex6xx7ifn5mHoK3Hk
         JPRFWSVMhTHXZqQrSZvv/JVfeH2ukOxnFFn0n3LewX+pGjBZa9Ae/DdJP7ug+SFyaBSF
         S6vbmslyHiyzIvrPRREDDs6oz9a/FZ/1/xu5vSPbluNm41xeKzDFVplPeGHuP5jHQJ/d
         epnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCP3w3tFCinM6Ly6XsUgy2VIfVWYdK6TgKJMdEz5D5U=;
        b=Ghth+ofd3xd0Kb4mIiDy+Y/BRJDll9ndl5LyU+wGQN0aROyyilqfa0ECZ/WPlxgGf4
         k4+jCrGHV20tyDF9MADbXFWbNX6tVHhXzeI7YN0w23M9IV9oixkEKcd4vyg24dWtChSa
         rk3gyqsjT6nshvmKTso/cgVG5RBrPG2ZbsvxTGtr6bqJpLNu3dDNajN4KsuiZzN4XoAC
         TyQhmUPN9bvK9FwP/zWz4dy4STFzJL9HwHL1S6pRqpI6l+XgYjgtMnsOuZLv2ETnnZPe
         K6xjzrtFhGeW7u/vpBhGm8tEsQFACwOb0MrjfhmFPiCT8w0+vmSm3DPnAKgImUJFNjqX
         gSgg==
X-Gm-Message-State: AOAM531ygkBRmouawkxGbcm91Iu/LBUmKbdoCztluutMJKzXiMEF7Sqm
        dAVT3T+Kf/+3w426zHVX+gPyMsuIWjcUvxGXBpQ=
X-Google-Smtp-Source: ABdhPJzyxQLG5rmCkADBSGBjAHqdJ+GbX3lojlE/LnRCGHRv8dVQ8LCQ/PbPASGUhSnuxB8g3Dta/NsMfDIGQ3Ov/E0=
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr10785712eds.374.1626237895604;
 Tue, 13 Jul 2021 21:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210713005645.8565-1-zhouzhouyi@gmail.com> <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
 <20210713131812.GV4397@paulmck-ThinkPad-P17-Gen-1> <20210713151908.GW4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210713151908.GW4397@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 14 Jul 2021 12:44:36 +0800
Message-ID: <CAABZP2zO6WpaYW33V_Di5naxr1TRm0tokCmTZahDuXmRupxd=A@mail.gmail.com>
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
To:     paulmck@kernel.org
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 13, 2021 at 11:19 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jul 13, 2021 at 06:18:12AM -0700, Paul E. McKenney wrote:
> > On Tue, Jul 13, 2021 at 09:09:04AM -0400, Mathieu Desnoyers wrote:
> > > ----- On Jul 13, 2021, at 12:16 AM, paulmck paulmck@kernel.org wrote:
> > >
> > > > On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
> > > >> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > >>
> > > >> Hi Paul,
> > > >>
> > > >> During my studying of RCU, I did a grep in the kernel source tree.
> > > >> I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
> > > >> should be CONFIG_TASKS_TRACE_RCU instead.
> > > >>
> > > >> Without memory fencing, the idle/userspace task inspection may not
> > > >> be so accurate.
> > > >>
> > > >> Thanks for your constant encouragement for my studying.
> > > >>
> > > >> Best Wishes
> > > >> Zhouyi
> > > >>
> > > >> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > >
> > > > Good eyes, and those could cause real bugs, so thank you!
> > >
> > > Hi Paul,
> > >
> > > This makes me wonder: what is missing testing-wise in rcutorture to
> > > catch those issues with testing before they reach mainline ?
> >
> > My guess:  Running on weakly ordered architectures.  ;-)
>
> And another guess:  A tool that identifies use of Kconfig options
> that are not defined in any Kconfig* file.
Based on Paul's second guess ;-),  I did a small research, and I think
the best answer is to modify scripts/checkpatch.pl. We modify checkpatch.pl
to identify use of Kconfig options that are not defined in any Kconfig* file.

As I am a C/C++ programmer, I would be glad to take some time to learn
perl (checkpatch is implented in perl) first if no other volunteer is
about to do it ;-)

>
>                                                         Thanx, Paul
Thanx
Zhouyi
