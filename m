Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7DC433F5
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 17:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiDHRE4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 13:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiDHREr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 13:04:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2D2493EE
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 10:02:42 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e1so6902516ile.2
        for <rcu@vger.kernel.org>; Fri, 08 Apr 2022 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+cmSU0Va28wW3Wv27B01VfHd9CC4OB3jfpn/xb5rpDI=;
        b=k/HNWFMWUhwt5qbzB1IFJsSLxCUYI+nUO25IG7WP0fG4xUGslpD7gKg8IgZyAe2Z5T
         XTkga/PZ7VkogQDCJUAvDf+jS5PdNFlfp2Sfyvtma0bfgOLuV4TULJVHCVc+TADLwsXQ
         fSAeFByQvHnpplIJfZbugAjZoRxjB8bj69g+X7yNEWHVX9EgRXYihshUH3DxwFwD+b30
         Jt7m5F0KXE8CaOQpNOi0ObrsZt6tlXk0Xbqcpa1k3nRlsWqsquZVqGcqeb/db6D70r55
         +u8NeL9/JhKD4GVWqqEkYllK28NpQmzHgbDBVhW4kGssvNffQAI4/QCquN3Kpj3DmMjZ
         9giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cmSU0Va28wW3Wv27B01VfHd9CC4OB3jfpn/xb5rpDI=;
        b=w3VMnd8SuUaxVRzR0UDh7FtRjDQ7GGB37BAb6y29HvS9Zm/DnFk+JuEKNt3TuP6obm
         okLBTgRoVetr7wwvAOMK7tdKDPhK9fOYtyUOQKPGr2MDvIkgQwhkUaWrwO8iQYp1uHFC
         iTjJnOFTJd8qTN5zZEz3OSpCMLW8l3V99rumXJWluPvgNwOhegGDv0vExH4CB9OkUkfr
         z+tvpAHlwXpMoLoyVnIBjMx5tQkUdsPM2A32qBZbCUTXIthwPy0nTXf0VwF+CIxcXxms
         zfMqSJMiEp7/fD8YjLhe8YR7rN34A9Hwi91A9Q3zrvljimEFnNGv4sdmjXtyU2rP015q
         jwhg==
X-Gm-Message-State: AOAM533qwqZsPLcXhcwqawLHFN5rfbY3VOWvHrK1yg1Bbb0m3aIZj4wV
        YGpCjnyNCmUl4ybI/0ULs2OA0HawG9ft3lJTXuNLw1iL
X-Google-Smtp-Source: ABdhPJxuX89crWnUYos8OlxCY0JszVtXNikV3THYVoau7sPe8UOdn4n0i+tRO5nTSPvJh54DHbIACrJtJqwLHCU1HcU=
X-Received: by 2002:a05:6e02:1846:b0:2c7:b032:5d92 with SMTP id
 b6-20020a056e02184600b002c7b0325d92mr9261539ilv.237.1649437361331; Fri, 08
 Apr 2022 10:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1> <87pmls6nt7.fsf@mpe.ellerman.id.au>
 <87k0bz7i1s.fsf@mpe.ellerman.id.au>
In-Reply-To: <87k0bz7i1s.fsf@mpe.ellerman.id.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 8 Apr 2022 19:02:30 +0200
Message-ID: <CANiq72=UXURR-caoXrP7zQNWmeKRtzZGRwF1iTi9svZEuHP22g@mail.gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, rcu <rcu@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 8, 2022 at 4:42 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> The Rust CI has it disabled because I copied that from the x86 defconfig
> they were using back when I added the Rust support. I think that was
> meant to be a stripped down fast config for CI, but the result is it's

Indeed, that was my intention when I created the original config.

> So I'll send a patch to turn HIGH_RES_TIMERS on for the Rust CI, and we
> can debug this further without blocking them.

Thanks! I can also do it on your behalf, if you prefer, when I sync with -rc1.

Cheers,
Miguel
