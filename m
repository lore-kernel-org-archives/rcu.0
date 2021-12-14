Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA3CC433F5
	for <rcu@archiver.kernel.org>; Tue, 14 Dec 2021 16:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhLNQ5X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Dec 2021 11:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbhLNQ5T (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Dec 2021 11:57:19 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9F3C061574
        for <rcu@vger.kernel.org>; Tue, 14 Dec 2021 08:57:19 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so21539372otj.7
        for <rcu@vger.kernel.org>; Tue, 14 Dec 2021 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDDcgitIgf9adu7cUNyYWMg6yiDAMD1pLgjC/8r5G7I=;
        b=ZnJXnWIt+Sz0f4rcqTkO0A+ERUTqByGDWg9gBdaxwjm8jM7NHMiP4F8LQdkO10g3mv
         9K39qBF5d4JxCLy+JP4XHGqgXux3jgCFtoE5PFCAJR/H26I9qtK8dWnBR9M7H6izE6kP
         hdSh68w7mwI/W49dxZgw8Ya2/LFlbLnabAoW/MseeASF02OdczdjDbuhbWGDoOeD+FQ0
         zzUaS29U+6VPtp1XKFnHRzZw27RFBZIE704E3NoOQVfN6rPe9F89eeEap23ggVl99EAi
         5dgKmwlBLWTeBkErcTdH5RA97XjXCeEU3fHMf34+LO3GFSNy56b8twYlk0AnrzyAAsn6
         cRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDDcgitIgf9adu7cUNyYWMg6yiDAMD1pLgjC/8r5G7I=;
        b=ZpA0f0yZoWYNnVKXJreoa1W7Qs+1MGyifcHrhZ4mJ8iZY1JIsXURNoJcT2vDGnsOuO
         GyhFuIWUI6Iyf4koJO4+Bjin+zE8H6w8UYwcu6hhkBFzTrIuLxRIDRffN/KsHtIiQJXF
         rEfk8793ax6CZLnSiOL+bNzgcuZymTiqWhPwfubj9jX7dJ387zo1f5UCRK/5Daw2tkPV
         3pJhVoy4Gta8SnUe03KPA/v6pMJkisY0GZWplITF/IzkAcDTcddfDNKjBFuBr6nfq/C0
         RlPp86t7pb642EuJz+L/Ye0u4/3nMRNC7sZyUV1LKfcrlX4XR6zFeMRVPf1G3lXq5Bea
         4YIA==
X-Gm-Message-State: AOAM5333ddp+y66eLKW8amSespN3sx8JdDmD+wz/vIFMkcpegTrKQpzN
        opZU9ncPPQ3YD/VKORO1gwOCs6agW59ZNRO5+6O5EyqqibXZww==
X-Google-Smtp-Source: ABdhPJx44fF5MfuuNvVcTQGUw8TtO3txoYz19vFpAfNAIq0JEBW+nbzsNdwtUX7TV3lLHHnTCOEO2y7Vl0SsuYvi/kU=
X-Received: by 2002:a9d:2ae1:: with SMTP id e88mr5080638otb.157.1639501038113;
 Tue, 14 Dec 2021 08:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20211214045758.GA1713844@paulmck-ThinkPad-P17-Gen-1> <CAABZP2xOHYLxSAfSfQgCXXEuNXYM=uU-cDS_KO+MLcQAV_yCoQ@mail.gmail.com>
In-Reply-To: <CAABZP2xOHYLxSAfSfQgCXXEuNXYM=uU-cDS_KO+MLcQAV_yCoQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Dec 2021 17:57:05 +0100
Message-ID: <CANpmjNMpm0ZnWKzpWOFRtOU8EfFDP2t2spyOnW2Rx8LFGO2S-w@mail.gmail.com>
Subject: Re: FYI, a few new KCSAN splats
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     paulmck@kernel.org, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 14 Dec 2021 at 09:38, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
[...]
> 2) The KCSAN kernel compile with clang-12:
> CONFIG_HAVE_ARCH_KCSAN=y
> CONFIG_HAVE_KCSAN_COMPILER=y
> CONFIG_KCSAN=y
> CONFIG_KCSAN_SELFTEST=y
> # CONFIG_KCSAN_EARLY_ENABLE is not set
> CONFIG_KCSAN_NUM_WATCHPOINTS=64
> CONFIG_KCSAN_UDELAY_TASK=80
> CONFIG_KCSAN_UDELAY_INTERRUPT=20
> CONFIG_KCSAN_DELAY_RANDOMIZE=y
> CONFIG_KCSAN_SKIP_WATCH=4000
> CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE=y
> # CONFIG_KCSAN_INTERRUPT_WATCHER is not set
> CONFIG_KCSAN_REPORT_ONCE_IN_MS=3000
> # CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN is not set
> # CONFIG_KCSAN_STRICT is not set
> CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y
> # CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is not set
> CONFIG_KCSAN_IGNORE_ATOMICS=y
> CONFIG_KCSAN_PERMISSIVE=y

Note, rcutorture selects CONFIG_KCSAN_STRICT=y, which may be one part
of the issue.  The other is that the -rcu tree has KCSAN enhancements
not yet available in mainline, which are enabled together with
CONFIG_KCSAN_STRICT, and make KCSAN slightly more aggressive (i.e.
finds data races faster) as well. Although you can also locally make
KCSAN a bit more aggressive by lowering CONFIG_KCSAN_SKIP_WATCH (boot
param kcsan.skip_watch=), to e.g. 2000-3000, but too low and you'll
hurt forward-progress.

-- Marco
