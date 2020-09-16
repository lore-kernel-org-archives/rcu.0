Return-Path: <SRS0=+/rT=CZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2886C2BB84
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 18:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6F521941
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600281154;
	bh=HYwhM1wvJq+PP6+3ZxYuGja3O/ADjo0jvjpne4xOCuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mAbPqVqpAlbS2q5G+X5Qh7xCULjp6UBD6SQV1RiJUyDFDtM0NVj6aMXd/d3O1ElB+
	 7guzdctHKEu/d4uu5+hEGp0DHSYqEHMj3WVtRZbrUigpRn2KGj7GNwy2WwgOhNFHeJ
	 BJOyreYmUaPfh30PcZGCguKwXhZc/WjqhTAL1Xsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgIPSc1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgIPScX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Sep 2020 14:32:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A743BC061788
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2020 11:32:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u21so6777439ljl.6
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2020 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oa2KOKBruJIa8JzwEuXDvn8lq/AyW8Gh05WzKpjKQjk=;
        b=UEueMUHZ3w1bML4TffC03SPtwmMbG26ZS04QoHTBFtkbazq0zj1LMx+FyboyvzzASg
         nydFo8G58LEHhfHuiZfy7mbpmIDsIlzAJfeeTzYG6VJXbIqW/NS9VqvGKvKAt1o7QE3H
         aEBuUY03yHBMaYNPFFjhHL22z9bGvgl38mViw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oa2KOKBruJIa8JzwEuXDvn8lq/AyW8Gh05WzKpjKQjk=;
        b=eEJcCE4JDoXqhUm2kFGRgCGH9L9+ltm/djAz6kDFG47cfD/hYSPJBpfjSvnBJ2PMjR
         vW+snol4zDglfn9Y/48+CQMTTLFWpayn4rXY+FHIr1QmMno3GLKjzJXp9VFjBUAf+ls4
         7YfE9L4L9kp4P2FqgqfrhQ2V027vSaquNBg40dVmBjv9z8xzPHq8DM3MpYPrziffTfTj
         /cY2yJlaZmOtW5sD4BD+iXaPNvpEK6Ny/4Vi1lGc75E2Y8mzx2dQQAbmWsEiFF3PDImF
         aPvRDs4lmxKDshShirDljOihLQKnQghaQUjcFST3QLFQScTaAlgpUXAmYZ1SzNYG9CQG
         ZPbg==
X-Gm-Message-State: AOAM530PtKNDgchk4pKbRGYNIIEnADZfqo01NCWRCMPG6WBqTwtoUZuE
        5hmDYx3MAy1l+R2FglJE1ldcWsewJHqtWw==
X-Google-Smtp-Source: ABdhPJxYp2RW/vbWmjpHWfrmbK7tH7xGaQFDOKK8JtszgL0UhsjQ5lG3QkGnNGfoXApPC1n8CSO1+w==
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr8499719ljp.140.1600281140506;
        Wed, 16 Sep 2020 11:32:20 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id j8sm5091209lfr.80.2020.09.16.11.32.18
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 11:32:19 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id u8so8078798lff.1
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2020 11:32:18 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr9071213lfg.603.1600281136741;
 Wed, 16 Sep 2020 11:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de> <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com> <20200916152956.GV29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200916152956.GV29330@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Sep 2020 11:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsMycgMHJrCmeetR3r+K5bpSRtmVWfd8iaoQCYd_VYAg@mail.gmail.com>
Message-ID: <CAHk-=wjsMycgMHJrCmeetR3r+K5bpSRtmVWfd8iaoQCYd_VYAg@mail.gmail.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 16, 2020 at 8:29 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> All fair, but some of us need to write code that must handle being
> invoked from a wide variety of contexts.

Note that I think that core functionality is different from random drivers.

Of course core code can (and will) look at things like

        if (in_interrupt())
            .. schedule work asynchronously ..

because core code ends up being called from odd places, and code like
that is expected to have understanding of the rules it plays with.

But something like RCU is a very different beast from some "walk the
scatter-gather list" code.

RCU does its work in the background, and works with lots of different
things. And it's so core and used everywhere that it knows about these
things. I mean, we literally have special code explicitly to let RCU
know "we entered kernel context now".

But something like a driver list walking thing should not be doing
different things behind peoples back depending on whether they hold
spinlocks or not. It should either just work regardless, or there
should be a flag (or special interface) for the "you're being called
in a crtitical region".

Because dynamically changing behavior really is very confusing.

               Linus
