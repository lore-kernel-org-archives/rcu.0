Return-Path: <SRS0=+/rT=CZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C89C43461
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 18:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2267220936
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600281320;
	bh=p9M6U8wwoTRu09wOEb4HjCvVdvi63Y++KCbCy4fQRRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OYLujrjQRoS1uzWPHpish39iE9Pm6VlLmw/mMEpo1133xNWIHVx8wWlzo9ZTEH4O5
	 QQI96OCAOx7/9SXaWlohRfeE46Eq+8DukNJeA6zHqyj4YbCN73/tn4ZoFEdmm7ClOh
	 Dr3nd6PN25FHNwthYKW/uvYUGFyrEBDRvFyKz2qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgIPSfS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgIPSfN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Sep 2020 14:35:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F64AC06178B
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2020 11:35:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so8072300lff.3
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2020 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxuwlCpSO8TsaLIcauC4aS5tgqsK9SeD3UYfP7DN7g0=;
        b=ZKGyeh6DjOj0P0poUJri2yvAXd4omTbSKkycPwhZ3i+69eOgCicq7HjntIxGCUS9d/
         zNZFDIECDK4GwkaKDrKuGgCWjAAnhqqHdcPPPF/38HaA25t0OpynH7kdnV1WYZaxFMxz
         W50ov+r+RFsylVih7TsRScGj6r7RgJSz63qJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxuwlCpSO8TsaLIcauC4aS5tgqsK9SeD3UYfP7DN7g0=;
        b=SG6HUHpsm70xj+uJVs8U1sdXREzkCcXPovUz2SxyQdWZm+yoVNxazPj4psTmlLGJ+9
         qKyoG5Alefg0t9VqZnx/ylpFgI+TX8XSDtRxKnHe2lzwAAI1Wx1AvPCWIHNyGcSL60dl
         lphl8dW8YnnmN9/oJM/zkaTisRV1hA9aqlwoE6Y4rJtDnf0609Ffy9fEGCcO5YjJCf6s
         yzcZnS89xcN0uhK/mF8Av9RrfHeJO4o2R2WoqmJFlv58mc00Y/uf757xfFgcqjosNkjb
         qdWG52mANX4rAOCLX7WVWmEzsksEn1ylLwRGEtd9tBtjTKjlLsSeTpLY8hva9v68jC29
         /UaQ==
X-Gm-Message-State: AOAM533CZY/O0O1WsTW7tyuKcrKCt7+rU9+PHnyCGs3TWXqEJWu6Tjes
        pVmoGeAN1nYC32pMPZZn4HFN2w07BE9IFA==
X-Google-Smtp-Source: ABdhPJw5zQjnbDxgMvi881fKVZa0NqvzMlxKTWHBcP50vTbtekZkl6y+v+kZ85bsLkliEULPW+5Ebg==
X-Received: by 2002:a19:ac49:: with SMTP id r9mr7291327lfc.582.1600281310655;
        Wed, 16 Sep 2020 11:35:10 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id e14sm5537766ljp.15.2020.09.16.11.35.08
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 11:35:10 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id b22so8006667lfs.13
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2020 11:35:08 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr9002648lfb.133.1600281306776;
 Wed, 16 Sep 2020 11:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de> <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <87y2la4xu6.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2la4xu6.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Sep 2020 11:34:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvULv3M2dQzPra1W-uGiX=_6Z_YeGnRDodbtXgJpihWA@mail.gmail.com>
Message-ID: <CAHk-=whvULv3M2dQzPra1W-uGiX=_6Z_YeGnRDodbtXgJpihWA@mail.gmail.com>
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

On Tue, Sep 15, 2020 at 12:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> You wish. I just found a 7 year old bug in a 10G network driver which
> surely would have been found if people would enable debug configs and
> not just run the crap on their PREEMPT_NONE, all debug off kernel. And
> that driver is not subject to bitrot, it gets regular bug fixes from
> people who seem to care (distro folks).

That driver clearly cannot be very well maintained. All the distro
kernels have the basic debug checks in place, afaik.

Is it some wonderful "enterprise hardware" garbage again that only
gets used in special data centers?

Becasue the "enterprise" people really are special. Very much in the
"short bus" special kind of way. The fact that they have fooled so
much of the industry into thinking that they are the competent and
serious people is a disgrace.

              Linus
