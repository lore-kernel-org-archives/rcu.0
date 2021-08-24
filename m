Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E97C4338F
	for <rcu@archiver.kernel.org>; Tue, 24 Aug 2021 14:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF0561220
	for <rcu@archiver.kernel.org>; Tue, 24 Aug 2021 14:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhHXOqF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbhHXOqE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Aug 2021 10:46:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E151C061757;
        Tue, 24 Aug 2021 07:45:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dm15so7076659edb.10;
        Tue, 24 Aug 2021 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBWcZREBUGB90xDbuFF9gZCvZy0CAlmgbb34f8DLTCA=;
        b=OX4xbhOYvpditCNbjIcDT+wiZ7eKJxv1Cfh+ILYt6ici869VEpTrVGCpAqvXi419fu
         pZv/g04QnU7zeUIUXv4zWwhL/FdYo/ji/mfTsXCjqFPawlG66FcaJqc5Ot/9ckcLIPlP
         JxE/DcJFAgPFNKeP6l/UnTzw+ESNG9PC0oDq91SZUz6Yw8fzf6mVTkyeZpDJOBr8otPZ
         i5iNYX+SiE8pe7YgJwRQwUcmPnKeU9nZZQkCM85pXdpBNCJkO4qLnPd/4/ix7dTUIuXE
         ZUrpJ964+LxsTppwouVy8aFnzmxH0YgXwULMFU0Mg9ZHCIb5Drtt4GlL62EEd/sxqNBU
         z7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBWcZREBUGB90xDbuFF9gZCvZy0CAlmgbb34f8DLTCA=;
        b=tuRCs3GeMVm66XSfiu1G5/31ZkXDqsUpH/SIEcS3PVEwuw/cj1XT9uGr5fP2GtJgUe
         WG4mhrfakFPK6hVtEqt+QSazBWgunjnlpTeakK1ClPy9grBVyeQ6LXzQXsi91dhC9hk2
         bUv0ln7vlzbMr4e7pjZuIvtdspxdMjnIQ1IopmCUVs/zPC8yIb9tqqfSRyHF20J+z3wR
         qnYfPYtV9KRi2g8DLpiPfQZaWEWtmRhx9/9dvrVSxHQsvK0OoVg6QLMwHiq00H2Dlg0F
         piRVD7ir6bhMiOwmKjul0SB5/rxTyA66+ZH7e4LfWUqlzue9qeAU1O92wtBE0beIwAmy
         Dzcw==
X-Gm-Message-State: AOAM530fSk1VhdGXe2+P5iWIqygkRf6I7H7PWe60u82G6i5JeBkaeiA2
        8aEGeD7YAr4QoLUylxPmS3ZNJVfceMIw0S40jc8=
X-Google-Smtp-Source: ABdhPJxp5jekdTwMBfEg6CBzgyuzrUwBX+xnhgMLf9B/+mzSuXsYs2HpJn5Sb7aUgq/+/NsPewtAYsWrnOsI8IsGMRg=
X-Received: by 2002:a50:ec10:: with SMTP id g16mr20734850edr.35.1629816318732;
 Tue, 24 Aug 2021 07:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210811025920.20751-1-zhouzhouyi@gmail.com> <YST4vtfcbJGKqoYD@hirez.programming.kicks-ass.net>
In-Reply-To: <YST4vtfcbJGKqoYD@hirez.programming.kicks-ass.net>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 24 Aug 2021 22:45:07 +0800
Message-ID: <CAABZP2zkTtOTknzvr0WkA+FprwzaYOP6QWk_FThMGaYTsoP_SA@mail.gmail.com>
Subject: Re: [PATCH V2][RFC] lockdep: improve comments in wait-type checks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        Boqun Feng <boqun.feng@gmail.com>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 24, 2021 at 9:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Aug 11, 2021 at 10:59:20AM +0800, Zhouyi Zhou wrote:
> > comments in wait-type checks be improved by mentioning the
> > PREEPT_RT kernel configure option.
> >
> > Many thanks
> > Zhouyi
> >
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> Acked goes after sobs, fixed that for you.
>
> Thanks!
Sincere thanks for your help and guidance

Zhouyi ;-)
