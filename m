Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0EAC10F04
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 14:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E201722AB0
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 14:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbhAEOEX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbhAEOEX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 09:04:23 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3748C061574;
        Tue,  5 Jan 2021 06:03:42 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id u12so28657589ilv.3;
        Tue, 05 Jan 2021 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTZiWCWqubQEjwaUq6ptG3Fb5yy9oh2sNY1nK0wUAUA=;
        b=kcVB8pZxVmpkYXj53GJTnmV6me+3gjeiJtsVpq1wCCKJigv6MBjLXnWNjTk6RNg8YT
         GLQAjU0IQwaASknnkjY3lgOAWsciArF2zrQxLhk/vgwKTek0xkSmNZukIZfA2OWEdkPq
         +4gSJCHeEjxodXtPYsWzT8siK8Kk7WPg9OIB2jI893M8aRZHHi1TsB312X0YAXQitR9n
         +yMwpoyikY4KgA1CmwVIs0ZD4tEOs3Hfhcav4V2qKZCLAi6GbN7vRTyGMRTlEAWrgJ/d
         aZD08pDb8CFhBR9y60LHIjpXbePJ0tyj+8gcvOpRaXpwPZJqVHRaAfjKkeVk2KdvluOy
         Zlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTZiWCWqubQEjwaUq6ptG3Fb5yy9oh2sNY1nK0wUAUA=;
        b=Gsl2/7PeKPVNMUEpJqmxit0OOeJtTWCEszRKJ9nOwLznTehrYOaQ3pYgU2UZiT+A5Q
         TRCJkGqh5144HEqL9g/1E3nl1LmJXMpdZnVrIRz4qWAIYBsrPbJTtKxR4fvfn3AXm7bx
         SLEYQ36WN1Ml3xwzdwSVm2IOyJTRbzi5IvnK+xuK4W03aViOQ/G3n312ytx4ABQTckG7
         wHufGtCGmhxPfb3HXN86fyTns2F7DCjiMT9WZeR/ia/H4lea5TzHVuqPxKwlyMn3FuQw
         FZUhbJDRDBZxTdcIfPRA7jIrrmutv5RL9sP//5Pt6P4+s/d0S7qfW/invsu8hMPQWTI3
         5F9w==
X-Gm-Message-State: AOAM5335nXpnDFhEVpxALgEFNN0pg/TAgU5xUNxP2QeNHgiTPR2gsefw
        fCw423UZiUTqw7mwZGUY5hK9/tYRUlXCUIMnnG2m61+XGqo=
X-Google-Smtp-Source: ABdhPJxQBBIsA0t9KivswYcwWBFwCDAY3dd237jV5xfJ1v44UbxKsrA5cgPHFY4EdVagbaACFfBOCeCIaYLStTcNbVs=
X-Received: by 2002:a92:b652:: with SMTP id s79mr77142302ili.251.1609855422119;
 Tue, 05 Jan 2021 06:03:42 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMygqbupE_6CK92=PwLw4DjnSuo9-+6iHs_DrZeZ55iRKg@mail.gmail.com>
 <20210105131441.GA2457@pc638.lan>
In-Reply-To: <20210105131441.GA2457@pc638.lan>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 5 Jan 2021 15:03:52 +0100
Message-ID: <CAKXUXMxFU0_FvOz7J83NPH96=wsWE4QBtB7_2U+SFwFkEwbHKQ@mail.gmail.com>
Subject: Re: kerneldoc warnings since commit 538fc2ee870a3 ("rcu: Introduce
 kfree_rcu() single-argument macro")
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 5, 2021 at 2:14 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Dear, Lukas.
>
> > Dear Uladzislau,
> >
> > in commit 538fc2ee870a3 ("rcu: Introduce kfree_rcu() single-argument
> > macro"), you have refactored the kfree_rcu macro.
> >
> > Since then, make htmldocs warns:
> >
> > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > 'ptr' description in 'kfree_rcu'
> > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > 'rhf' description in 'kfree_rcu'
> >
> > As you deleted the two arguments in the macro definition, kerneldoc
> > cannot resolve the argument names in the macro's kerneldoc
> > documentation anymore and warns about that.
> >
> > Probably, it is best to just turn the formal kerneldoc references to
> > the two arguments, which are not used in the macro definition anymore,
> > simply into two informal references in the documentation.
> >
> Thanks for your suggestion. I am not sure if htmldocs supports something
> like "__maybe_unused", but tend to say that it does not. See below the
> patch:
>

I was thinking of a similar solution as you found here. That will probably do.

Lukas

> <snip>
> From 65ecc7c58810c963c02e0596ce2e5758c54ef55d Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Tue, 5 Jan 2021 13:23:30 +0100
> Subject: [PATCH] rcu: fix kerneldoc warnings
>
> After refactoring of the kfree_rcu(), it becomes possible to use
> the macro with one or two arguments. From the other hand, in the
> description there are two arguments in the macro definition expected.
> That is why the "htmldocs" emits a warning about it:
>
> <snip>
> ./include/linux/rcupdate.h:882: warning: Excess function parameter
> 'ptr' description in 'kfree_rcu'
> ./include/linux/rcupdate.h:882: warning: Excess function parameter
> 'rhf' description in 'kfree_rcu'
> <snip>
>
> Fix it by converting two parameters into informal references in the
> macro description.
>
> Fixes: 3d3d9ff077a9 ("rcu: Introduce kfree_rcu() single-argument macro")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index ebd8dcca4997..e678ce7f5ca2 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -854,8 +854,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>
>  /**
>   * kfree_rcu() - kfree an object after a grace period.
> - * @ptr: pointer to kfree for both single- and double-argument invocations.
> - * @rhf: the name of the struct rcu_head within the type of @ptr,
> + * ptr: pointer to kfree for both single- and double-argument invocations.
> + * rhf: the name of the struct rcu_head within the type of ptr,
>   *       but only for double-argument invocations.
>   *
>   * Many rcu callbacks functions just call kfree() on the base structure.
> --
> 2.20.1
> <snip>
>
> Paul, does it work for you?
>
> Thanks!
>
> --
> Vlad Rezki
