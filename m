Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535F5EEB565
	for <rcu@archiver.kernel.org>; Sat,  9 Sep 2023 01:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjIIBJq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 21:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjIIBJp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 21:09:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9879268C
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 18:09:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so43165671fa.2
        for <rcu@vger.kernel.org>; Fri, 08 Sep 2023 18:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694221674; x=1694826474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3GCqPLGYjnqG/vcrz5uchTokgn3URl87uJVzY9m8YM=;
        b=LRydJC8Z9mwfkWwruWkvHOcy6e7UkrN0VUY9d1KVP9LJh8TNWeGkTmD1qwO56XkRtf
         6odfxO/UC7iHOkYgRlPW5iBa3MIkp2RUm4TGh32olgMFDYEj50k6xgJDyjVjAIezL6rp
         3wcyhv0yfopHtF+p44f+JffaFseF/LXApsucc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694221674; x=1694826474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3GCqPLGYjnqG/vcrz5uchTokgn3URl87uJVzY9m8YM=;
        b=Mpzp0O5Sxn0Z29zRmm799b4DS5wAqzFLFy0ofSExeiDCx+gDMuOUPjx1HVt/OhtPqJ
         OB6V5njHKZcXAMbhJObOu+cXOkNitUmJYyAVx8FPRW5r7SuBzMiW3iv0R7Qv8V8zbLzL
         VrruMN+dqX0JVQxU6IBzcm4YmKHWNXL62wKBPKc1LHXKeoFd5EMvWmasKPVFwcm+9i9u
         v/QIwgZoH821D4MkGlYT6MLRgD1V1uABwmNp1eemvZJ2AVTwjwkcD4jmoWV+rNVlXBgV
         tRJ2T1floBvF6j8HOeZkPe/auWq0K1C451r7NTk3Wv4pxYujnIaIOxoBxL6j2ppXqb/M
         gTQw==
X-Gm-Message-State: AOJu0YzA2pJa3WJ38MFoHQCLYt+9UgkhKg+eL0KW2Kt2ofTSDX8AkttB
        R8L8Oq2SX2PuyAnRM/YI6rC1nG8BW8ZCHxcNe5Gfqw==
X-Google-Smtp-Source: AGHT+IGRH+GyQD+1mO99RA490b0zFxrdbv0FSWc8VeRQRvJvuuzaigDTzHy7juJlnz54WCTCOQlcyxl0Piel2MXru5w=
X-Received: by 2002:a2e:9655:0:b0:2b6:de52:357 with SMTP id
 z21-20020a2e9655000000b002b6de520357mr2840888ljh.40.1694221673459; Fri, 08
 Sep 2023 18:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230908203603.5865-1-frederic@kernel.org> <20230908203603.5865-3-frederic@kernel.org>
In-Reply-To: <20230908203603.5865-3-frederic@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Sep 2023 21:07:42 -0400
Message-ID: <CAEXW_YQ1tz4G3EwPZBx=ADVzjDiQCVPA-4GtqMpFxfRsx3oc9A@mail.gmail.com>
Subject: Re: [PATCH 02/10] rcu: Rename jiffies_till_flush to jiffies_lazy_flush
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
> The variable name jiffies_till_flush is too generic and therefore:
>
> * It may shadow a global variable
> * It doesn't tell on what it operates
>
> Make the name more precise, along with the related APIs.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/rcu.h       |  8 ++++----
>  kernel/rcu/rcuscale.c  |  6 +++---
>  kernel/rcu/tree_nocb.h | 20 ++++++++++----------
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 56a8466a11a2..4ac4daae9917 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -541,11 +541,11 @@ enum rcutorture_type {
>  };
>
>  #if defined(CONFIG_RCU_LAZY)
> -unsigned long rcu_lazy_get_jiffies_till_flush(void);
> -void rcu_lazy_set_jiffies_till_flush(unsigned long j);
> +unsigned long rcu_get_jiffies_lazy_flush(void);
> +void rcu_set_jiffies_lazy_flush(unsigned long j);
>  #else
> -static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { retu=
rn 0; }
> -static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
> +static inline unsigned long rcu_get_jiffies_lazy_flush(void) { return 0;=
 }
> +static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
>  #endif
>
>  #if defined(CONFIG_TREE_RCU)
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index ffdb30495e3c..8db4fedaaa1e 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -764,9 +764,9 @@ kfree_scale_init(void)
>
>         if (kfree_by_call_rcu) {
>                 /* do a test to check the timeout. */
> -               orig_jif =3D rcu_lazy_get_jiffies_till_flush();
> +               orig_jif =3D rcu_get_jiffies_lazy_flush();
>
> -               rcu_lazy_set_jiffies_till_flush(2 * HZ);
> +               rcu_set_jiffies_lazy_flush(2 * HZ);
>                 rcu_barrier();
>
>                 jif_start =3D jiffies;
> @@ -775,7 +775,7 @@ kfree_scale_init(void)
>
>                 smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL =3D=
=3D 1);
>
> -               rcu_lazy_set_jiffies_till_flush(orig_jif);
> +               rcu_set_jiffies_lazy_flush(orig_jif);
>
>                 if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)=
) {
>                         pr_alert("ERROR: call_rcu() CBs are not being laz=
y as expected!\n");
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 5598212d1f27..b9eab359c597 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -264,21 +264,21 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool=
 force)
>   * left unsubmitted to RCU after those many jiffies.
>   */
>  #define LAZY_FLUSH_JIFFIES (10 * HZ)
> -static unsigned long jiffies_till_flush =3D LAZY_FLUSH_JIFFIES;
> +static unsigned long jiffies_lazy_flush =3D LAZY_FLUSH_JIFFIES;
>
>  #ifdef CONFIG_RCU_LAZY
>  // To be called only from test code.
> -void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
> +void rcu_set_jiffies_lazy_flush(unsigned long jif)
>  {
> -       jiffies_till_flush =3D jif;
> +       jiffies_lazy_flush =3D jif;
>  }
> -EXPORT_SYMBOL(rcu_lazy_set_jiffies_till_flush);
> +EXPORT_SYMBOL(rcu_set_jiffies_lazy_flush);
>
> -unsigned long rcu_lazy_get_jiffies_till_flush(void)
> +unsigned long rcu_get_jiffies_lazy_flush(void)
>  {
> -       return jiffies_till_flush;
> +       return jiffies_lazy_flush;
>  }
> -EXPORT_SYMBOL(rcu_lazy_get_jiffies_till_flush);
> +EXPORT_SYMBOL(rcu_get_jiffies_lazy_flush);
>  #endif
>
>  /*

While at it, could we replace jiffies_lazy_flush with
rcu_get_jiffies_lazy_flush() in the below? That way all users are
going through the API.

With that,
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> @@ -299,7 +299,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, =
int waketype,
>          */
>         if (waketype =3D=3D RCU_NOCB_WAKE_LAZY &&
>             rdp->nocb_defer_wakeup =3D=3D RCU_NOCB_WAKE_NOT) {
> -               mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flu=
sh);
> +               mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_lazy_flu=
sh);
>                 WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>         } else if (waketype =3D=3D RCU_NOCB_WAKE_BYPASS) {
>                 mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
> @@ -482,7 +482,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp,=
 struct rcu_head *rhp,
>         // flush ->nocb_bypass to ->cblist.
>         if ((ncbs && !bypass_is_lazy && j !=3D READ_ONCE(rdp->nocb_bypass=
_first)) ||
>             (ncbs &&  bypass_is_lazy &&
> -            (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_t=
ill_flush))) ||
> +            (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_l=
azy_flush))) ||
>             ncbs >=3D qhimark) {
>                 rcu_nocb_lock(rdp);
>                 *was_alldone =3D !rcu_segcblist_pend_cbs(&rdp->cblist);
> @@ -723,7 +723,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>                 lazy_ncbs =3D READ_ONCE(rdp->lazy_len);
>
>                 if (bypass_ncbs && (lazy_ncbs =3D=3D bypass_ncbs) &&
> -                   (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + ji=
ffies_till_flush) ||
> +                   (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + ji=
ffies_lazy_flush) ||
>                      bypass_ncbs > 2 * qhimark)) {
>                         flush_bypass =3D true;
>                 } else if (bypass_ncbs && (lazy_ncbs !=3D bypass_ncbs) &&
> --
> 2.41.0
>
