Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AD0EB64DA
	for <rcu@archiver.kernel.org>; Mon, 10 Jul 2023 20:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGJUBY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Jul 2023 16:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJUBY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Jul 2023 16:01:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5413E
        for <rcu@vger.kernel.org>; Mon, 10 Jul 2023 13:01:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso77694051fa.3
        for <rcu@vger.kernel.org>; Mon, 10 Jul 2023 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689019281; x=1691611281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVQddm2EFdyUg1lZY45lMs8lFNZyKaFAHPyUNGkCJXQ=;
        b=TwY4aYwTH/qA6+coIWC80o97pbXwocmsDE8k0T5R+tc/7g1YooiSw1WkqeOdHg1KFz
         GuUpRp5Ck2HuZANwYgDu58RbZF1Kp/oQCp32io6pstK1fO//JPi8dF9Ri/OUtcCPXQXW
         05FdLd1S8rR44arV+clas0mYHnnqrgz6eiqR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019281; x=1691611281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVQddm2EFdyUg1lZY45lMs8lFNZyKaFAHPyUNGkCJXQ=;
        b=Uwbtw45EaIjBcjevr+Yht+tGw4qPgj1TNA8GAW5rUJfgQYyu022NaO+Z0CbCpgq58a
         9lp36kGfNQc9gn3/TrE112PKpHHCFaJRUr501ELCTwUhGo+9jNj7Ruz40WZoolaf1cpY
         FtrdU3N7PFYwlAz37bC0jloFWfFJNyGYsEsiuGWze6mUSLIqmU7qqyrDyBKTqyCTV8V3
         7lr0XhznlNrhfQebWV7qQ31vaYEmuZzQuudnhv+gLdrbKXdCCEuMOxhHd+OI4B+D0pKS
         1KS7Buwuo4TF2lAiZ9rz/l+wzmVkZg8IkBVkwxY275vRkODld0on+STV09c23ndiY/7f
         fstg==
X-Gm-Message-State: ABy/qLYKG0Ffu/17dMg2cbqg87S2kmvLvkBrwW6AV4W/AUkri5onoiRx
        0A/UwxFuS8F2UMsZmBNHrmEsMztBvx/q//LwTBt0uA==
X-Google-Smtp-Source: APBJJlGgSLXp3yxbnFy0qDEYkmUE3GTfKvyf7aFFRBaVwMb9XLbkGdmsVhWedXpHmLgtZ5Ql2+eKt/zDdzDA5BtsEzI=
X-Received: by 2002:a2e:9189:0:b0:2b4:78f6:d335 with SMTP id
 f9-20020a2e9189000000b002b478f6d335mr10422076ljg.8.1689019280886; Mon, 10 Jul
 2023 13:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230706102849.437687-1-mmpgouride@gmail.com> <20230706102849.437687-2-mmpgouride@gmail.com>
In-Reply-To: <20230706102849.437687-2-mmpgouride@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 10 Jul 2023 16:01:07 -0400
Message-ID: <CAEXW_YShqCHHH9Q1icU=oGBbeHO+a1PTY-Q-+KbqVdTm8mR3cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, boqun.feng@gmail.com, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 6, 2023 at 6:29=E2=80=AFAM Alan Huang <mmpgouride@gmail.com> wr=
ote:
>
> When the objects managed by rculist_nulls are allocated with
> SLAB_TYPESAFE_BY_RCU, readers may still hold references to this
> object that is being added, which means the modification of ->next
> is visible to readers. So, this patch uses WRITE_ONCE() for assignments
> to ->next.
>
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> ---
>  include/linux/rculist_nulls.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index ba4c00dd8005..89186c499dd4 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -101,7 +101,7 @@ static inline void hlist_nulls_add_head_rcu(struct hl=
ist_nulls_node *n,
>  {
>         struct hlist_nulls_node *first =3D h->first;
>
> -       n->next =3D first;
> +       WRITE_ONCE(n->next, first);
>         WRITE_ONCE(n->pprev, &h->first);
>         rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
>         if (!is_a_nulls(first))
> @@ -137,7 +137,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hl=
ist_nulls_node *n,
>                 last =3D i;
>
>         if (last) {
> -               n->next =3D last->next;
> +               WRITE_ONCE(n->next, last->next);
>                 n->pprev =3D &last->next;
>                 rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>         } else {

Don't you need READ_ONCE() for the read-side accesses as well?

thanks,

 - Joel
