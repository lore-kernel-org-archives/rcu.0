Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E758C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49206103A
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG1ScW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG1ScW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 14:32:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E9C061757
        for <rcu@vger.kernel.org>; Wed, 28 Jul 2021 11:32:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a26so5683130lfr.11
        for <rcu@vger.kernel.org>; Wed, 28 Jul 2021 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMGQipmv4P+6hTmePxpJ22V8LdLQi3CACmtx2vw04NE=;
        b=I/BCzuCVYSBhj+aO3Q4aWDfu6lLss36Xk4btqlTUWsx3V8as8ycmR+abRAbzInVD8U
         GZDoL0hQAv0JekGQ4xpA79Nb5tqPYhOcZIv9ILu9WWKb+/T0f2DcATTLmdswj0vh5QcO
         Lfd7SkdRPLRnQBiwbNH1OwFXVCq2MJZiHhG4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMGQipmv4P+6hTmePxpJ22V8LdLQi3CACmtx2vw04NE=;
        b=nejppcR1M04wie7U0NYbEYkhsRFs4WfpN1UJK4OeXNXUAxPTxQdiOUpT8xuwOoC7U/
         BfTMFoftN7iOo3t4k1GUgyWoLtSXseJT6b9C18fGCU7m6lmYCEqKFV+PeuDPM25LQyvN
         5HMe/a20UKFqRtfiiVDVsHLNKRFYfO3CxexwTFjc2qdIILH2s6zi7iGcn4o3mq21SuaV
         xgRC/f5UVWffjLYL6uL+yC9vW22MJiqCRObG3ZgpwVnG9NtlF5K4Ff7CcYSF23RdVw3W
         adLad5F5cefs8owGdM83sNjphhgtq0z0avcWfXRD6oPAunCG2oDgiGS4craQA+SLHBmK
         KziA==
X-Gm-Message-State: AOAM533oNvHeE+vG9NqudXlr3l+hL88BADK2ZrJXkVRo031vwu7WJj3d
        flb+zt/K/CqBRzKM6iLJHNimGpqx0TuTt1XYw3A=
X-Google-Smtp-Source: ABdhPJxZHb3dFz06FyrwThvhkj+WIxS50Q0LhOQxJ/K9Pd3Tc3f636IWy9IIWiZtq2sDX2r1elsxyQ==
X-Received: by 2002:a05:6512:3b89:: with SMTP id g9mr683124lfv.96.1627497138530;
        Wed, 28 Jul 2021 11:32:18 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r4sm67287lfm.214.2021.07.28.11.32.16
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 11:32:16 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a7so4182831ljq.11
        for <rcu@vger.kernel.org>; Wed, 28 Jul 2021 11:32:16 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr660028ljg.48.1627497136138;
 Wed, 28 Jul 2021 11:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com> <1810346528.8990.1627495925037.JavaMail.zimbra@efficios.com>
In-Reply-To: <1810346528.8990.1627495925037.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jul 2021 11:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLZYvjcj=ztF9tF0df8mSGKXwbCdxxy-JnoaE72VY5tQ@mail.gmail.com>
Message-ID: <CAHk-=wiLZYvjcj=ztF9tF0df8mSGKXwbCdxxy-JnoaE72VY5tQ@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 28, 2021 at 11:12 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Are the percpu atomics you have in mind different from what is found in
> Documentation/core-api/this_cpu_ops.rst ?
>
> Namely this_cpu_add_return(pcp, val) in this case.

Nope.

Those are only "CPU-atomic", ie atomic wrt interrupts etc.

The RCU code wants SMP-atomic, and it's mainly that we *could* do the
addressing more efficiently.

        Linus
