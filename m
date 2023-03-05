Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB2FC61DA4
	for <rcu@archiver.kernel.org>; Sun,  5 Mar 2023 10:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCEK3V (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 5 Mar 2023 05:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCEK3U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 5 Mar 2023 05:29:20 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF18CDFF
        for <rcu@vger.kernel.org>; Sun,  5 Mar 2023 02:29:18 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id by8so6730928ljb.7
        for <rcu@vger.kernel.org>; Sun, 05 Mar 2023 02:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678012157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzkzPKjLjmcIIk+MXeDNFz8SlV10tGBtTo3+SDfOWQ0=;
        b=Lt+13Q44DHx4wQTpK09D4hVuLpRv9ubsVbqbBVuHOItnLRqBRs+MPYPTdyBVau1Pxs
         jFBd/orrXfd0AYH5C5Fq6orWxbQIxtYbdO5hmM0t9Wsvt0RwQvOE0+w0XdXnaV+3BsWD
         E7Mwi1w8/ao5HWnsXoYqH94ThgzGYHhwkRkL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678012157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzkzPKjLjmcIIk+MXeDNFz8SlV10tGBtTo3+SDfOWQ0=;
        b=islLqI3WfRHXxmLY4KiZ8myg8wREyUVAGi8lOzmq/lnoEkjnA7DXoWO+4gb8op5d+l
         acfFC5vcpeoIchjdUOwBTVzw8Plu1FDsEXZmdLiDTBHTrGrFiLkunK6JxwN99XsjxI6G
         rAIbrno8IsYOX7MRwAKQJE/e6qBTs8iN9Kzr1QYzJvyqk8yiUQxFDN9U7astVMh+sKgG
         074dVAgTTNskEAtNVG8t0StXl+WB6ev8rCDT83fZqENM+iJwLLkcMlzk9ye9WZiUTVm8
         8ihck8ap9/mOWdN7S6N6pALYk6QELuU+ZOJ6fEU5Vld/Iuaw75Ar8FGwL+wNEfcJmtfK
         K8DA==
X-Gm-Message-State: AO0yUKVk7mK4H0cXoZYj/IdZRdDh6pfkCfj0okB1JWguA1q+Qu3dCkv0
        xUbuKFFs09CZM8nz/aiVn57/tFq+AngYLE/PsmUyYA==
X-Google-Smtp-Source: AK7set9YeJqnuTO6GPbeUeUubABtFPqDdNiBrtFeQv+RspFfojeCZKWsLOwNkmYeASAE4pZ5Cw/UFo4qE/Itjav+e2I=
X-Received: by 2002:a05:651c:b9b:b0:293:4e6d:f4f7 with SMTP id
 bg27-20020a05651c0b9b00b002934e6df4f7mr2157714ljb.3.1678012156960; Sun, 05
 Mar 2023 02:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20230201150954.409693-1-urezki@gmail.com> <20230201150954.409693-4-urezki@gmail.com>
In-Reply-To: <20230201150954.409693-4-urezki@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 5 Mar 2023 05:29:11 -0500
Message-ID: <CAEXW_YRhHaVuq+5f+VgCZM=SF+9xO+QXaxe0yE7oA9iCXK-XPg@mail.gmail.com>
Subject: Re: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single
 argument macro
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi, All,

On Wed, Feb 1, 2023 at 10:11=E2=80=AFAM Uladzislau Rezki (Sony)
<urezki@gmail.com> wrote:
>
> For a single argument invocations a new kfree_rcu_mightsleep()
> and kvfree_rcu_mightsleep() macroses are used. This is done in
> order to prevent users from calling a single argument from
> atomic contexts as "_mightsleep" prefix signals that it can
> schedule().
>

Since this commit in -dev branch [1] suggests more users still need
conversion, let us drop this single patch for 6.4 and move the rest of
the series forward? Let me know if you disagree.
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commi=
t/?h=3Ddev&id=3D9bf5e3a2626ed474d080f695007541b6ecd6e60b

All -- please supply Ack/Review tags for patches 1-12.

thanks,

 - Joel


> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate.h | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 094321c17e48..7571dbfecb18 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -957,9 +957,8 @@ static inline notrace void rcu_read_unlock_sched_notr=
ace(void)
>
>  /**
>   * kfree_rcu() - kfree an object after a grace period.
> - * @ptr: pointer to kfree for both single- and double-argument invocatio=
ns.
> - * @rhf: the name of the struct rcu_head within the type of @ptr,
> - *       but only for double-argument invocations.
> + * @ptr: pointer to kfree for double-argument invocations.
> + * @rhf: the name of the struct rcu_head within the type of @ptr.
>   *
>   * Many rcu callbacks functions just call kfree() on the base structure.
>   * These functions are trivial, but their size adds up, and furthermore
> @@ -982,26 +981,18 @@ static inline notrace void rcu_read_unlock_sched_no=
trace(void)
>   * The BUILD_BUG_ON check must not involve any function calls, hence the
>   * checks are done in macros here.
>   */
> -#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
> +#define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
> +#define kvfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>
>  /**
> - * kvfree_rcu() - kvfree an object after a grace period.
> - *
> - * This macro consists of one or two arguments and it is
> - * based on whether an object is head-less or not. If it
> - * has a head then a semantic stays the same as it used
> - * to be before:
> - *
> - *     kvfree_rcu(ptr, rhf);
> - *
> - * where @ptr is a pointer to kvfree(), @rhf is the name
> - * of the rcu_head structure within the type of @ptr.
> + * kfree_rcu_mightsleep() - kfree an object after a grace period.
> + * @ptr: pointer to kfree for single-argument invocations.
>   *
>   * When it comes to head-less variant, only one argument
>   * is passed and that is just a pointer which has to be
>   * freed after a grace period. Therefore the semantic is
>   *
> - *     kvfree_rcu(ptr);
> + *     kfree_rcu_mightsleep(ptr);
>   *
>   * where @ptr is the pointer to be freed by kvfree().
>   *
> @@ -1010,13 +1001,9 @@ static inline notrace void rcu_read_unlock_sched_n=
otrace(void)
>   * annotation. Otherwise, please switch and embed the
>   * rcu_head structure within the type of @ptr.
>   */
> -#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,          \
> -       kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
> -
> +#define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
>  #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
> -#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
>
> -#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
>  #define kvfree_rcu_arg_2(ptr, rhf)                                     \
>  do {                                                                   \
>         typeof (ptr) ___p =3D (ptr);                                     =
 \
> --
> 2.30.2
>
