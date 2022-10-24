Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A28C38A2D
	for <rcu@archiver.kernel.org>; Mon, 24 Oct 2022 21:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJXVyk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiJXVxx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Oct 2022 17:53:53 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DCC39118
        for <rcu@vger.kernel.org>; Mon, 24 Oct 2022 13:07:53 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id e15so7083665qvo.4
        for <rcu@vger.kernel.org>; Mon, 24 Oct 2022 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDpgzQG8dmgEoiEUfYcpSbDd31DVRx70fLapPMBjtJI=;
        b=LCfRZon3vZnZHSxce4XZXcxfQd2il/sh41ERF0J3f8mlXerhKZxGO+aNgMRfqAC7u8
         HXrBUv5kabYITECZt9ZOzVsYJQ5cii/lIZ/BHPsZYpeqfaLHH/DPc3J0Pxxw0KRxbMZL
         y1vY9wimStgmzEIEHtluo6/5SDdCg6pmWfi/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDpgzQG8dmgEoiEUfYcpSbDd31DVRx70fLapPMBjtJI=;
        b=Spx9n5Kb5MHL1XrS9jXrfhz8sxBe9nVPJ+r8IY2QdvNtHhXgVKnDdhpp9tFKk5+Y4w
         cm5zL5ROClVU5nOHcAmMIpq+pMOji5CWjhlUaTxQYOkxoipz2vjCr7A+RCkCLvj2xkfP
         S5zX6wzq4R2WEIHcxV2OwvKcf4SQErqtjmHk1ZzW6F1fk+yyTdH98GAbwl6CQOUCv9DX
         gQ8nreLvfDVjQgSpK7Eece6NOnNTaE7LAvxyKiSNv3L8qS2xIKhbc4Zl8b9VZYmJJQ9H
         8JGx1GEA7lAaYsjaqbjlnyBcIHEJIkwynd2+/xqX+W3F0BMZzzaFdeUTqbf62463G/yp
         QWXw==
X-Gm-Message-State: ACrzQf0siaq+I5NwoDgm7ObdnJdu4N4k/9B/O1fpw4TEqWnXy19T/H1L
        zkkLg2Cxa6/PzhHIDNp6WHvnvttt7n/b1A==
X-Google-Smtp-Source: AMsMyM79jFEo6nY8D+btmCVlTCcJJ7Q263PyHSzYEq8wHIJryd5csuggdQwT4uqTZ4Xo55xfbZ/odA==
X-Received: by 2002:a05:6214:500f:b0:4b1:d2b1:54c with SMTP id jo15-20020a056214500f00b004b1d2b1054cmr29113036qvb.54.1666641990638;
        Mon, 24 Oct 2022 13:06:30 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id j19-20020a05620a411300b006cfaee39ccesm557238qko.114.2022.10.24.13.06.28
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:06:29 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id y72so12188373yby.13
        for <rcu@vger.kernel.org>; Mon, 24 Oct 2022 13:06:28 -0700 (PDT)
X-Received: by 2002:a25:84cf:0:b0:6b3:c0c3:19d8 with SMTP id
 x15-20020a2584cf000000b006b3c0c319d8mr28662460ybm.349.1666641988539; Mon, 24
 Oct 2022 13:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wi1GXyh+kn1XfrbLA209MBGktteN=L+=cTEcoruxBtu3g@mail.gmail.com> <20221024200446.GD5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221024200446.GD5600@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 13:06:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5fhyHfabjN6kDD+ow5m1JF4iduq0SHDkidqK1+G9aLA@mail.gmail.com>
Message-ID: <CAHk-=wi5fhyHfabjN6kDD+ow5m1JF4iduq0SHDkidqK1+G9aLA@mail.gmail.com>
Subject: Re: [GIT PULL] Keep synchronize_rcu() from enabling irqs in early boot
To:     paulmck@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 24, 2022 at 1:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Please accept my apologies for my confusion!
>
> Please see below for a pull request for a better-formatted commit.

Oh, it was such a small nit that I already pulled your tree - my note
was really just a "not a big deal, but in the future it would be nice
if.."

                Linus
