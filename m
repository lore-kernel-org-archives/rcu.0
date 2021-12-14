Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BA1C433EF
	for <rcu@archiver.kernel.org>; Tue, 14 Dec 2021 18:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhLNSAB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Dec 2021 13:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhLNSAA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Dec 2021 13:00:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D5C061574
        for <rcu@vger.kernel.org>; Tue, 14 Dec 2021 10:00:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so65703336edd.0
        for <rcu@vger.kernel.org>; Tue, 14 Dec 2021 10:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQFMA3+Z1cU9BKBa/xdkX6aDYzyAsFvC+TKbS6Vm6Zg=;
        b=gTg5kR+VUdpfcGW+bHSxImk4B0y+ymN/50CBLWI2sJ7tpg+XXYxAbP4u0Iov4oSDG9
         09Cld/bqAyEO8Y+vZ3JJmqcap8VDeW8dHjmOPHSCvFWm4n4Iikrow35ighAHUQ8hGfVT
         374j9kwDask753QU3bCPFYfUNc1ZRJMtPudNi8D0iR3pEaHCBV1BVHCO8gEPfbtU+2UI
         TgBK1Lg/2McbJU6lwPJpeddC4C+e1GFLXN34qz6Yz9EQvUYDNr0DOVtZzjd4iR3JRfAY
         FFovjR4LUVZuTpHP4X8tWZAk6RTw6gI+X74UW0QTheBmIuoGCXeYHwCrno2s4gB3Pcwy
         rKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQFMA3+Z1cU9BKBa/xdkX6aDYzyAsFvC+TKbS6Vm6Zg=;
        b=gkVdeWQrtVu8oTwmrqglptoj3PCFcl+iAyUsW7HttrbwcNSPTJB3aBJPNckXhatVRI
         tGJwp5LePksrM0+qxsbZaYbWnTAFUoQ9OkJUIRpMybm2uVOuEA0iS43X6iBWsB1hVzQ5
         BPnZAmxBTGbDCXEkKtS0nqRDtiYLV92efqU0feO2xBW+7JzPEYQ18vVb4z+BiOuTsl38
         8mvbJbkCNc4PGUeE5o4iFT0wAvnkYFY5WZoIr9ZjAs73q4ktY2h55zcGDUbPfBMdxcRY
         FO6SgCml5r/AhDlhXRXB5I3yHU9PJSkN4EXSJ96x9tJdH0hNUSHUVmq0W+DQDUC7St59
         YMYQ==
X-Gm-Message-State: AOAM530Tg2zTR+tC/V4kRTXOu8t2Jkwor0A39jgW3y4GByh/USttRnzI
        R1LCR3v0DqBc6Qq4AUu2Js/s5spz8ICvaFlRTvQcCrfTEkXqpg==
X-Google-Smtp-Source: ABdhPJwEigEySV+GHXYsHX4fotPS5qTQVWinxfq7hovCfTG+J5sSX4AoLIWehZOTlP3y7GH46IWGuGJ28ghIF/EDoAo=
X-Received: by 2002:aa7:c9ce:: with SMTP id i14mr9911297edt.300.1639504798424;
 Tue, 14 Dec 2021 09:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20211214045758.GA1713844@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2xOHYLxSAfSfQgCXXEuNXYM=uU-cDS_KO+MLcQAV_yCoQ@mail.gmail.com> <CANpmjNMpm0ZnWKzpWOFRtOU8EfFDP2t2spyOnW2Rx8LFGO2S-w@mail.gmail.com>
In-Reply-To: <CANpmjNMpm0ZnWKzpWOFRtOU8EfFDP2t2spyOnW2Rx8LFGO2S-w@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 15 Dec 2021 01:59:47 +0800
Message-ID: <CAABZP2w8+bZWWP_bRi+Vfokm-xDwOga5TrjFnJwEmx2zGiMHiw@mail.gmail.com>
Subject: Re: FYI, a few new KCSAN splats
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thank Marco for giving me such valuable advice.

Both RCU and KCSAN are very attractive and amazing to me, I have
carefully read your advice and will strive to acquire expertise in the
following days.

Thanks again
Zhouyi

On Wed, Dec 15, 2021 at 12:57 AM Marco Elver <elver@google.com> wrote:
>
> On Tue, 14 Dec 2021 at 09:38, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> [...]
> > 2) The KCSAN kernel compile with clang-12:
> > CONFIG_HAVE_ARCH_KCSAN=y
> > CONFIG_HAVE_KCSAN_COMPILER=y
> > CONFIG_KCSAN=y
> > CONFIG_KCSAN_SELFTEST=y
> > # CONFIG_KCSAN_EARLY_ENABLE is not set
> > CONFIG_KCSAN_NUM_WATCHPOINTS=64
> > CONFIG_KCSAN_UDELAY_TASK=80
> > CONFIG_KCSAN_UDELAY_INTERRUPT=20
> > CONFIG_KCSAN_DELAY_RANDOMIZE=y
> > CONFIG_KCSAN_SKIP_WATCH=4000
> > CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE=y
> > # CONFIG_KCSAN_INTERRUPT_WATCHER is not set
> > CONFIG_KCSAN_REPORT_ONCE_IN_MS=3000
> > # CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN is not set
> > # CONFIG_KCSAN_STRICT is not set
> > CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y
> > # CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is not set
> > CONFIG_KCSAN_IGNORE_ATOMICS=y
> > CONFIG_KCSAN_PERMISSIVE=y
>
> Note, rcutorture selects CONFIG_KCSAN_STRICT=y, which may be one part
> of the issue.  The other is that the -rcu tree has KCSAN enhancements
> not yet available in mainline, which are enabled together with
> CONFIG_KCSAN_STRICT, and make KCSAN slightly more aggressive (i.e.
> finds data races faster) as well. Although you can also locally make
> KCSAN a bit more aggressive by lowering CONFIG_KCSAN_SKIP_WATCH (boot
> param kcsan.skip_watch=), to e.g. 2000-3000, but too low and you'll
> hurt forward-progress.
>
> -- Marco
