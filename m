Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56772C4332F
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 17:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiKQRtS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Nov 2022 12:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbiKQRtR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Nov 2022 12:49:17 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793757C02E
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 09:49:16 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-367b8adf788so26283537b3.2
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 09:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1wrgTKzaDrTBJIAKqG3lHjG1mI6f1GpMwMp11e5egR4=;
        b=sGSF4x/7CTOsgayZlnfj2zXvpdTitbQ0wiOoKT9SHtguKHoW7+ek6d1GzqnEZpw6bU
         YjVWpF/I/Y5R93HVFOgQeDkqofnxtjaoTJOZytTKzU8n/YfGQ9vExjo+7JW9sCps92AW
         EUYGhreqcjqAh7RAsg2zUkCy4DYtAtxR0j3OFk4nPEJzT2DUKHmaIcFb8b1KFpSFyrbw
         hNUIjO4KuaElNKvdBerAmw4rDiV9lZ9RVdKhdYMKf6qnvQwU2n+fd/lUcdUkj7w6/2ga
         tEtWfyTYJZrJzMPfTMwzXQwSTSqJDJOKIVhoCH5oZx55kGDaW0F9vMFRyNnxFx/jrPB/
         SzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wrgTKzaDrTBJIAKqG3lHjG1mI6f1GpMwMp11e5egR4=;
        b=fRdiqP0Bd3lT5KoM9ztEPKUxPwv4a4y0kZzomIWHnWAVgvsADvy+h98ZdUxHhNzSFC
         u46e2+J3/28VI5nZ5FMGJGJRNI1ZkSL30eXoKnbu9Ktw+jjYefVRdL57qm6b+6MO7ek7
         MJXnc+E96gZm8oxpInFxPw2PhQIlozrficAJaFLbeKoi5GOcX0SFsPzAk1iwe44V63jF
         TvMuqSzKSYP4NMUbSvYQ4Cvul9NNUIfbhKFXgfp5FdwB/bvY8uRllphs20HA9b4IIt4i
         bQd9MZiU7aCUxMoefr/94Ni2r36QcZDHPPcTWYJJVgQ1fWCRA18JAUc/Tg1uddZsMkKp
         KATQ==
X-Gm-Message-State: ANoB5pntinvJIlyttH6Sbgl03jQL6AAfRfQoF8GhtfgoSwcZQ29UiOSu
        9+CSXgh5H7OvQhGd2mjl/ipG988ZH6tbQ9+Hrq3nXw==
X-Google-Smtp-Source: AA0mqf75oUkC2jN9k/dkeEOGIn/OfK3gmDlfMwThyzfEwe2njYu0dxQ+llKYE22+YU/VQDAmOt3iBT/0LEi2Shh2NTg=
X-Received: by 2002:a0d:e601:0:b0:356:d0ed:6a79 with SMTP id
 p1-20020a0de601000000b00356d0ed6a79mr2911019ywe.489.1668707355322; Thu, 17
 Nov 2022 09:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20221117031551.1142289-1-joel@joelfernandes.org>
 <20221117031551.1142289-3-joel@joelfernandes.org> <CANn89i+gKVdveEtR9DX15Xr7E9Nn2my6SEEbXTMmxbqtezm2vg@mail.gmail.com>
 <Y3ZaH4C4omQs1OR4@google.com> <CANn89iJRhr8+osviYKVYhcHHk5TnQQD53x87-WG3iTo4YNa0qA@mail.gmail.com>
 <CAEXW_YRULY2KzMtkv+KjA_hSr1tSKhQLuCt-RrOkMLjjwAbwKg@mail.gmail.com>
 <CANn89i+9XRh+p-ZiyY_VKy=EcxEyg+3AdtruMnj=KCgXF7QtoQ@mail.gmail.com> <CAEXW_YS-d_URqjfcasNnqf3zhCKAny8dhhLifAxtrpz1XYd_=w@mail.gmail.com>
In-Reply-To: <CAEXW_YS-d_URqjfcasNnqf3zhCKAny8dhhLifAxtrpz1XYd_=w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 17 Nov 2022 09:49:04 -0800
Message-ID: <CANn89i+GcVzgg56fd9iO5Ma6vSUVvJmLHTvRwPMoYKMPR4G4Lw@mail.gmail.com>
Subject: Re: [PATCH rcu/dev 3/3] net: Use call_rcu_flush() for dst_destroy_rcu
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com,
        jiejiang@google.com, Thomas Glexiner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 17, 2022 at 9:42 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>

>
> Yes, I agree. Your comments here have not been useful (or respectful)
> so I am Ok with that.
>
>  - Joel

Well, I have discovered that some changes went in networking tree
without network maintainers being involved nor CCed.

What can I say ?

It seems I have no say, right ?


commit f32846476afbe1f296c41d036219178b3dfb6a9d
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Sun Oct 16 16:23:04 2022 +0000

    rxrpc: Use call_rcu_flush() instead of call_rcu()

    call_rcu() changes to save power may cause slowness. Use the
    call_rcu_flush() API instead which reverts to the old behavior.

    We find this via inspection that the RCU callback does a wakeup of a
    thread. This usually indicates that something is waiting on it. To be
    safe, let us use call_rcu_flush() here instead.

    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 22089e37e97f0628f780855f9e219e5c33d4afa1..fdcfb509cc4434b0781b76623532aff9c854ce60
100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -253,7 +253,7 @@ void rxrpc_kill_connection(struct rxrpc_connection *conn)
         * must carry a ref on the connection to prevent us getting here whilst
         * it is queued or running.
         */
-       call_rcu(&conn->rcu, rxrpc_destroy_connection);
+       call_rcu_flush(&conn->rcu, rxrpc_destroy_connection);
 }

 /*
