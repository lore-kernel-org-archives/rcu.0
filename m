Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFEBC67871
	for <rcu@archiver.kernel.org>; Mon, 24 Oct 2022 21:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiJXVem (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiJXVeU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Oct 2022 17:34:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87B4295B01
        for <rcu@vger.kernel.org>; Mon, 24 Oct 2022 12:41:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a5so6739873qkl.6
        for <rcu@vger.kernel.org>; Mon, 24 Oct 2022 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RHwylrpUhj9v4/w8TtnyC8haWHtRwyVJQggauiAHehQ=;
        b=XwVorEtf3KoWJHKCNWfx/5m0XsHd+TojlQiZa2lTRU2tMPjvHFUP2MXHNmB9G5WCLM
         wnlvDUNfwHCWCVk960vhH/PdBT4jJExZ7npaGpp2QaYphHUTlRih7b+t+2I0i3k+Tru/
         BiOAM6q/OZRt/nZ9nWFvF90lCeUKgKCznjjjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHwylrpUhj9v4/w8TtnyC8haWHtRwyVJQggauiAHehQ=;
        b=dVL56eJqknCs3WyMZkhDnu4RZ6H217WrPBbhPrgzgD213hnAR/AWnLh+guzaG9ilz9
         N9BncqmNnDudimhgzqr+JDALRXWhkJEuubLGzF+JkxVOZszf/TRFV9JSmJhtv6/Feo36
         //tr9PeA6KVLHt6nhduL8bzVcETbnZn5G6V13n6emhQ18qoOywkqygWztcVChXCkyDeX
         bjNvekdFgbW9x1q9+gbcFKoLqGN8IKnIo9koLtpMtYeaqwNfIAkLvGasQkSlGq6d5zLo
         zdRGWithb3OHEvBDiLapWQF5tjs2Jp+Q7ZQ5e0K2SA8jUdLR5nJy1irQUyjKnHlOBEwD
         st0Q==
X-Gm-Message-State: ACrzQf3LpBRXV6zvrmSXrxiDGpa942VtTuSm9uddYeJmt5W2zm1O2koP
        cYXz/FHhglLxmKEssFId8pND+8YAxyduIA==
X-Google-Smtp-Source: AMsMyM4f2pur9iSe4o7nePtKAH4fepqfa6ZrQWYiJF/zhJjuq8iFNMACn2W+tS6XLwRlevmoh41vUA==
X-Received: by 2002:a05:620a:4611:b0:6ee:9e55:9d30 with SMTP id br17-20020a05620a461100b006ee9e559d30mr23440836qkb.210.1666640420002;
        Mon, 24 Oct 2022 12:40:20 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id s14-20020a05620a254e00b006cf8fc6e922sm521858qko.119.2022.10.24.12.40.18
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:40:18 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id l145so12245424ybl.0
        for <rcu@vger.kernel.org>; Mon, 24 Oct 2022 12:40:18 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr32262663ybu.310.1666640417860; Mon, 24
 Oct 2022 12:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 12:40:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1GXyh+kn1XfrbLA209MBGktteN=L+=cTEcoruxBtu3g@mail.gmail.com>
Message-ID: <CAHk-=wi1GXyh+kn1XfrbLA209MBGktteN=L+=cTEcoruxBtu3g@mail.gmail.com>
Subject: Re: [GIT PULL] Keep synchronize_rcu() from enabling irqs in early boot
To:     paulmck@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 24, 2022 at 9:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> This pull request contains a commit that fixes bf95b2bc3e42 ("rcu: Switch
> polled grace-period APIs to ->gp_seq_polled"), which could incorrectly
> leave interrupts enabled after an early-boot call to synchronize_rcu().

Minor stylistic nit-pick - please try to keep the commit tags
together, ie the "Fixes:" tags goes with Reported-by: tags and
sign-offs etc..

              Linus
