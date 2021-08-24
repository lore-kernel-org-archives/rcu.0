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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D71C4338F
	for <rcu@archiver.kernel.org>; Tue, 24 Aug 2021 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BAB61214
	for <rcu@archiver.kernel.org>; Tue, 24 Aug 2021 14:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhHXOoQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbhHXOoP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Aug 2021 10:44:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66265C061757;
        Tue, 24 Aug 2021 07:43:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x11so44990854ejv.0;
        Tue, 24 Aug 2021 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IA1Q0iyJnFyXg0kf5oPdvIoooL7RmKaTRR2Z0M5Fthg=;
        b=FS8AAa5yPX+3reawFSOOWtRVHJQ7tPQMeFjjRH7VU7nkTlHYw/wbhxkC3LL1Bovdqw
         kTVYWdZOAy9aWdGnLbbRas8VMeNxQPjzlFd9tI9uTaT2tOJE+XS2n4Ynj4Gx7/JalHrI
         s87lN7jG7bDzW/hKyrXEuCM7pGxWR3buoGBL3izh6Jkc2wPxbm4TNtm9BmVTGj7AYwwv
         Ideo+SRaOfm76cmeI1HsVzmpI/wlRmpiErBp70kO+d00hxTVtFZJ/A5s2PCaaFY/yzSi
         7JEqXcjNoya+LiQKxuxjRdYWwVNVpQTspUAvpxZajHA2rKSQwWUwegxdMc1hHIosm/ri
         bU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IA1Q0iyJnFyXg0kf5oPdvIoooL7RmKaTRR2Z0M5Fthg=;
        b=fRD2XQVJKrZmIHq1fx/uE4c3Y2zaj6Z/YtSBNSpIzw+6Hroa7tEV3I5puorJuIuxgH
         zWqzOkjRbzjuQKTcU0wVM85vk1t8hK2fuqDPjeB661WInZ/LsoQVrDf+Qn/SmZm3oZnV
         dVkeY8f3UFoU5hZB51FHwu0uV2nLY6fpRONs1hbVvUpaioAVxBBJf3tst98v8LoPN8vW
         KfGBLT9cb2QqCiraQ/hPB72Tq2FGcPYZsGNIU6HAy3M+CqbNWk0QQ7D1vB4qg7sxFCdO
         3yD6cw7Ac+ryhCLi6/vFcqneKO3z2gj2TRAnMUdpbYBfCNUyJbL45Tc1boLw0UNkrOUT
         bGqw==
X-Gm-Message-State: AOAM533l7aHf8dhG/e8M/qT1C2UwcfhqLBsUZJu7GKVFU07HGCQxBO0c
        vmHBkwSBWJ6JfokSd0QDZ2GtJKvrWMoWUZ0Yd70=
X-Google-Smtp-Source: ABdhPJyoE5kIHbbujgDIf+OYP2FxVEo3R6EwQOgxJCM0EN7nTyF16CEVs3QmzWjKoyzuOxs5nqpK5NpGAGNiFGCfDYM=
X-Received: by 2002:a17:906:6c8f:: with SMTP id s15mr4302205ejr.52.1629816210025;
 Tue, 24 Aug 2021 07:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210810210319.6564-1-zhouzhouyi@gmail.com> <YRM5heBfgNtEGvoC@boqun-archlinux>
 <YST4aWMArEBsKW07@hirez.programming.kicks-ass.net>
In-Reply-To: <YST4aWMArEBsKW07@hirez.programming.kicks-ass.net>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 24 Aug 2021 22:43:18 +0800
Message-ID: <CAABZP2wtAVYmWfSBmJDyaLuTFQGq6KsN=3uogZtm8FK1_bAJAg@mail.gmail.com>
Subject: Re: [PATCH][RFC] lockdep: improve comments in wait-type checks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thank both of you for correcting my mistakes.
I do benefit a lot from your emails.

Cheers
Zhouyi

On Tue, Aug 24, 2021 at 9:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Aug 11, 2021 at 10:44:21AM +0800, Boqun Feng wrote:
> > Hi,
> >
> > On Wed, Aug 11, 2021 at 05:03:19AM +0800, Zhouyi Zhou wrote:
> > > Hi Peter,
> > >   I think comments in wait-type checks may benifit from some comments
> > > improvement.
> >
> > Thanks for looking into this!
> >
> > Even for an RFC patch, it's better that you write a proper commit log,
> > and note that you can put all this background information right after
> > the "---" line, if you think that will help people review it.
> >
> > >   I recklessly add Paul to signed-off-by, because I asked his opinion
> > > about comment in rcu_read_lock_bh part.
> > >
> >
> > Probably a Suggested-by will suffice, but I leave that to Paul ;-)
>
> This, also since Paul never actually touched the patch.
>
> > > Thanks a lot
> > > Zhouyi
> > >
> > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > Please make you the last one in the "Signed-off-by" list, see
> > Documentation/process/submitting-patches.rst:
> >
> > "Notably, the last Signed-off-by: must always be that of the developer
> > submitting the patch."
>
> The first sob should be that of the author, and given that's the same
> person as the submitter in this case, he's got a problem at his hands
> ;-)
>
