Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D37C3DA78
	for <rcu@archiver.kernel.org>; Sun, 15 Jan 2023 21:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjAOV3x (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Jan 2023 16:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjAOV3v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Jan 2023 16:29:51 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4B216313
        for <rcu@vger.kernel.org>; Sun, 15 Jan 2023 13:29:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id q2so28199568ljp.6
        for <rcu@vger.kernel.org>; Sun, 15 Jan 2023 13:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=imIrwUXXSpGxJHX2IXIa4NzC1jMkxA/rgCDVCw5pEFE=;
        b=RWVPMLhj3nzukWBHC/0nsGVSXNfSsDSgW+QuchB/+fHdme4dQ77rAF0NrXjm/cnSO2
         +BxKMpMgJY85/EBZEaFUcTlSWeJ8CLONuZIKfYc0s00ztKHQhXEVDA8sMmdOyx/O21v8
         Kk6vJ1oidhdWGFl/HL5l5WvkmJvKlPhfletg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imIrwUXXSpGxJHX2IXIa4NzC1jMkxA/rgCDVCw5pEFE=;
        b=BO//l031L+kWy1f/EdaiC38WAYoZd0hHLnItgkdr8ZxKQfjEkHc8YJw5cOQ87PfMnv
         hteXHIYftSk7T+Gkw6dVnVp1ay3IEG1bf+N9k9hu0KnQqS0MLU0Bb5hc2TbShk+c7Ujt
         YbjfGk2YRoBZ/r5X/U0jNGcmUs6flzek7VWnop9gAEimIPipt1tsZTeUMocFQ34UohKv
         47LvnyktJT4zRgrxpBZHxCPhp6wNQZfB1uWvtv2pe9C51uUQTFKCoN+kqeu/ixczV/D2
         /aQJk6lPZWfOSDrHF0qH8oB2hUMp0ZzoSYYhMzVEgaZclL47w5/1g6s6XW7BW2+FoUUC
         1PhA==
X-Gm-Message-State: AFqh2kocWdIlM08mMiHD1FvSxlaUpuMAe+X5ou4HY3Ds8UVML1HU8Q64
        tJ6Iw8wRs7imKEVrxcfC+7lMyekAIl+S8tPTcxOUcg==
X-Google-Smtp-Source: AMrXdXvdy3taN11/dVs1uCoBkLM5Z3BbpAjjzT+Zg+zoauO3zWwSUCc2PjBReQ+vjgGadCr0ti/wUuBGWqao0CT5PVk=
X-Received: by 2002:a2e:964c:0:b0:284:6390:1f8 with SMTP id
 z12-20020a2e964c000000b00284639001f8mr2589023ljh.167.1673818188816; Sun, 15
 Jan 2023 13:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20230112005223.2329802-1-joel@joelfernandes.org>
 <20230112005223.2329802-2-joel@joelfernandes.org> <20230115155455.0fb66c12@rorschach.local.home>
In-Reply-To: <20230115155455.0fb66c12@rorschach.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 15 Jan 2023 16:29:38 -0500
Message-ID: <CAEXW_YRjV0CqoALU6F_9LZKD_e84gWQ3a8juucmXxLUuDQ7DHw@mail.gmail.com>
Subject: Re: [PATCH v2 rcu/dev 2/2] rcu: Disable laziness if lazy-tracking
 says so
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        fweisbec@gmail.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jan 15, 2023 at 3:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 12 Jan 2023 00:52:23 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>
> >
> >  static void
> > -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
> > +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> >  {
> >       static atomic_t doublefrees;
> >       unsigned long flags;
> >       struct rcu_data *rdp;
> > -     bool was_alldone;
> > +     bool was_alldone, lazy;
>
> I'm curious to why the the extra variable.
>
> >
> >       /* Misaligned rcu_head! */
> >       WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> > @@ -2622,6 +2622,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
> >       kasan_record_aux_stack_noalloc(head);
> >       local_irq_save(flags);
> >       rdp = this_cpu_ptr(&rcu_data);
> > +     lazy = lazy_in && !rcu_async_should_hurry();
>
> Wouldn't just having:
>
>         lazy = lazy && !rcu_async_should_hurry();
>
> be sufficient?

I prefer to not overwrite function arguments, it makes debugging harder IMHO.

 - Joel



>
> -- Steve
>
> >
> >       /* Add the callback to our list. */
> >       if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
> > --
