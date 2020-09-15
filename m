Return-Path: <SRS0=zZsG=CY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F82C433E2
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1507208E4
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600191723;
	bh=ZkX4IpJVrUUwnYeEwsTuxnlSCIoNpjg5abSoyxEllB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UJ4x5vxOSNi1vwN7vZuvxnXuJKen56+2pwbQELJWSVcn45gomTjaUJU4NGk8Oi9zk
	 0xicGPt+tOAph5NC2qyzcLoyn3Xs40i5+5veqNwPcZyGv6xsyiGsbeNWouZubio4nq
	 wCM5QKNlX2Jv8qHcVuQ5ceGfm/r0NnZ1HTqBV4yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgIORl4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgIORlk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Sep 2020 13:41:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404DC06174A
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2020 10:41:40 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i22so6292494eja.5
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2020 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nYcbfWZAApGs9MKHeuMMDYKDYJP/KjXcIMY7yTiRjk=;
        b=hFeX95/TT9jtwZAL/DonKpuMHGRk/7SCmZequDM1VaRmacKDQZY4lc39NgOcx0VujL
         ul3l8yb5Ugprhwk3dogs1JqCkfr90spWSTqKGkSLsF9w3lXrIygeRUDRxh1yw1QSoeb3
         vUCYW8AmUQyz6zbxknLrsvz9nPCTdNe9Dcd+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nYcbfWZAApGs9MKHeuMMDYKDYJP/KjXcIMY7yTiRjk=;
        b=m1HEOQ/1XUtdEVSxip/nD9You94TRCa73Pxm6MG53SiZSTABEFeS8CuJNUpMUtTL4q
         7zcddFWK1LIBEWvZ4YE0MFfoiVoRknlRKZKC/YdArtgjKMuwVN1o7faPq6+oKm7Diigt
         fjjCbYodShoQ6SJxWL9HrLbndiKnm1+W+c7yj854T/DlJHYOiilM10DR22nffyieIGxE
         eTf6Rf0kM+BqKVthXCo3O4lJrQZdiIrdskjcKSfHDIh5R9LKEY9B0SDm6OBlquyEwv5T
         HvoI4cmS4Irl7vQ8OZngevFgnkla04dQJxp+OJ10PwKfZHvWFiH+c/lhKz1ys78AkVB4
         IvHg==
X-Gm-Message-State: AOAM5316fVK+CFTi0BGut4n9aRCEN6ZFFk9OdZbrNghQbPo6c/T1n67j
        BF/8I+L3yej7O17ycEzQFF/M4FrpHWLGZA==
X-Google-Smtp-Source: ABdhPJw6qNLR+QjF4gcLIx6biPafd1uEAumzLCwZzTKtK5nLbbwcW9avSiB0ciOTV+fnaummQsJiQQ==
X-Received: by 2002:a17:906:f8d2:: with SMTP id lh18mr22110917ejb.44.1600191698988;
        Tue, 15 Sep 2020 10:41:38 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id e15sm11881686eds.5.2020.09.15.10.41.38
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:41:38 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id w5so4212451wrp.8
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2020 10:41:38 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr6798322lfg.344.1600191336149;
 Tue, 15 Sep 2020 10:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87bli75t7v.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 10:35:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
Message-ID: <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Tue, Sep 15, 2020 at 1:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> OTOH, having a working 'preemptible()' or maybe better named
> 'can_schedule()' check makes tons of sense to make decisions about
> allocation modes or other things.

No. I think that those kinds of decisions about actual behavior are
always simply fundamentally wrong.

Note that this is very different from having warnings about invalid
use. THAT is correct. It may not warn in all configurations, but that
doesn't matter: what matters is that it warns in common enough
configurations that developers will catch it.

So having a warning in "might_sleep()" that doesn't always trigger,
because you have a limited configuration that can't even detect the
situation, that's fine and dandy and intentional.

But having code like

       if (can_schedule())
           .. do something different ..

is fundamentally complete and utter garbage.

It's one thing if you test for "am I in hardware interrupt context".
Those tests aren't great either, but at least they make sense.

But a driver - or some library routine - making a difference based on
some nebulous "can I schedule" is fundamentally and basically WRONG.

If some code changes behavior, it needs to be explicit to the *caller*
of that code.

So this is why GFP_ATOMIC is fine, but "if (!can_schedule())
do_something_atomic()" is pure shite.

And I am not IN THE LEAST interested in trying to help people doing
pure shite. We need to fix them. Like the crypto code is getting
fixed.

                   Linus
