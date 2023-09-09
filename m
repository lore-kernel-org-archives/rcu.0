Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8907EEB57B
	for <rcu@archiver.kernel.org>; Sat,  9 Sep 2023 01:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjIIBtC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 21:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjIIBtC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 21:49:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C8E1716
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 18:48:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bbbda48904so44137591fa.2
        for <rcu@vger.kernel.org>; Fri, 08 Sep 2023 18:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694224135; x=1694828935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFC4wiL127MJ3x2dOUtgK+qn8vixUyxFWgVnpUusG5A=;
        b=x/eM8QKPOFxbTG1/15Pj8aFGlJLZjvu/BddiQntuqCf76EG/k1eHrTmkmTGMkj9A6G
         hqD6btICMb4WuMV8E/FAHR9Jl4NbaSli4HU06QlR8xU3kBl6D95a3YQapH16wfsocJ9t
         uiiBPniolNwauEFkan9/aS2nSYaknHA1jD7gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694224135; x=1694828935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFC4wiL127MJ3x2dOUtgK+qn8vixUyxFWgVnpUusG5A=;
        b=f+uh7VuC8BxaaoEkvFmKmv0tS2u7ru/tqBpTxntKmv30GWB1bLWWABV8ETeSlx10xc
         9Pmg6v5rNgA+wenm6arfDwk98woX6xkLSgKRvZp7zh7FowUKWEfGUTmxN4KBKY+j5Ooj
         x9uQNbx/JTW7sgcTBHufXL2sVzK/yR/mgzOx/QG7OdhAJfDr+L/F+W16VMwBlsRRe9Li
         3guj7jgn5DjB1o23a1SWp82tHt+2ZXMKMunN4Vg6QfpusUvg4hXQ+ZVTtgFWsbumhoXD
         RYUe+vSknfKgK4JUK+4IrFfmO5YgEBtlmcfpJjiZzLa33VT/HW3V93ugmxBHF9mA+cfz
         3Unw==
X-Gm-Message-State: AOJu0YxVBI9iX5K7am0V+O6qzDnRmdMRa8LYnyoM+Y9EUwwbJ8yPmxi4
        +SGsZHUtws0RJEGdfS3RoF/t3wSA1Tu02zo/a//YPg==
X-Google-Smtp-Source: AGHT+IEWaX1AGQYRyc6iCeThFz95+Si6y29Mcx8P3Ihl44LSN7k4AzUdmCdODRMHOLt4ERMhpTTEVuidKfCEVc3Q+LE=
X-Received: by 2002:a2e:330f:0:b0:2bd:2056:ceed with SMTP id
 d15-20020a2e330f000000b002bd2056ceedmr2791592ljc.25.1694224135577; Fri, 08
 Sep 2023 18:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230908203603.5865-1-frederic@kernel.org> <20230908203603.5865-4-frederic@kernel.org>
In-Reply-To: <20230908203603.5865-4-frederic@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Sep 2023 21:48:44 -0400
Message-ID: <CAEXW_YTxSft0cZkq6UOsdkDxLCjMZfqqK3fBVz6He0UebCqS+g@mail.gmail.com>
Subject: Re: [PATCH 03/10] rcu/nocb: Remove needless LOAD-ACQUIRE
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 8, 2023 at 4:36=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> The LOAD-ACQUIRE access performed on rdp->nocb_cb_sleep advertizes
> ordering callback execution against grace period completion. However
> this is contradicted by the following:
>
> * This LOAD-ACQUIRE doesn't pair with anything. The only counterpart
>   barrier that can be found is the smp_mb() placed after callbacks
>   advancing in nocb_gp_wait(). However the barrier is placed _after_
>   ->nocb_cb_sleep write.

Hmm, on one side you have:

WRITE_ONCE(rdp->nocb_cb_sleep, false);
smp_mb();
swake_up_one(&rdp->nocb_cb_wq);   /* wakeup -- consider this to be a STORE =
*/

And on another side you have:
swait_event_interruptible_exclusive(rdp->nocb_cb_wq, ..cond..) /*
consider this to be a LOAD */
smp_load_acquire(&rdp->nocb_cb_sleep)
/* exec CBs (LOAD operations) */

So there seems to be pairing AFAICS.

But maybe you are referring to pairing between advancing the callbacks
and storing to nocb_cb_sleep. In this case, the RELEASE of the nocb
unlock operation just after advancing should be providing the
ordering, but we still need the acquire this patch deletes.

> * Callbacks can be concurrently advanced between the LOAD-ACQUIRE on
>   ->nocb_cb_sleep and the call to rcu_segcblist_extract_done_cbs() in
>   rcu_do_batch(), making any ordering based on ->nocb_cb_sleep broken.

If you don't mind, could you elaborate more?

> * Both rcu_segcblist_extract_done_cbs() and rcu_advance_cbs() are called
>   under the nocb_lock, the latter hereby providing already the desired
>   ACQUIRE semantics.

The acquire orders loads to nocb_cb_sleep with all later loads/stores.
I am not sure how nocb_lock gives that same behavior since that's
doing ACQUIRE on the lock access itself and not on nocb_cb_sleep
access, I'd appreciate it if we can debate this out.

Every few months I need a memory-ordering workout so this can be that.
;-) You could be onto something.

thanks,

 - Joel



>
> Therefore it is safe to access ->nocb_cb_sleep with a simple compiler
> barrier.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree_nocb.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index b9eab359c597..6e63ba4788e1 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -933,8 +933,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>                 swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
>                                                     nocb_cb_wait_cond(rdp=
));
>
> -               // VVV Ensure CB invocation follows _sleep test.
> -               if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
> +               if (READ_ONCE(rdp->nocb_cb_sleep)) {
>                         WARN_ON(signal_pending(current));
>                         trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS=
("WokeEmpty"));
>                 }
> --
> 2.41.0
>
