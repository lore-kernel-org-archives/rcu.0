Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D1CC433FE
	for <rcu@archiver.kernel.org>; Wed, 19 Oct 2022 12:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJSMeL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Oct 2022 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiJSMdn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Oct 2022 08:33:43 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBE21781F2
        for <rcu@vger.kernel.org>; Wed, 19 Oct 2022 05:13:06 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g16so6652906qtu.2
        for <rcu@vger.kernel.org>; Wed, 19 Oct 2022 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T23p+eH1hiX06EqMh9f1MnRALViDG4olAyABf/G8csw=;
        b=aHWtI4lWRBTzOPB5M2/ypIrj7o3/UVutXI5V5FefO8Ay19ezHR5uh7u+czDxibgQiK
         WmLY4NlJlk9VTmkUISlnHDLwXwJoAiV7wK6NeSgEHr5GOSvY0I+VdXwzCR3PBOfyHVWh
         T348mTiLWmQldWIkzgCgx4o1GA66oyfVGyOqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T23p+eH1hiX06EqMh9f1MnRALViDG4olAyABf/G8csw=;
        b=FtT1i+eCcQEchSaxXT3Dhcp4hBueNs2oeNncf4EVmIUaihs7DBkXxBYvc8j5upxL0H
         CaqGj5zMLYOnNjlCvhagUZdGQ6eq6jgnyzPFq9754t1Dp9q5griwwvHi5SVNf0Wl4SnM
         tfmXFjjzYKXNXA9eyJFEyMhO5LAnZYG5y2NPvFQop/QdalQfuBQTKwhduIRIvuZxAIzk
         styNvejvZO0PMzNX0+IATIgC3f9N9qU6dYQ2RyzDxdiORPJ64QUSizaYU8WwKeu+nk11
         KXS5vmihCTZKoCSqAcXfHEAk+XUkWACRRq/Qp75Z0J7yTc/ArfJ/EQVDJ6mmacR87J32
         tNXQ==
X-Gm-Message-State: ACrzQf2BHPt0NR3+Oi9gq2c8DvUPxRUAdyXJFAkIg6/CmBgvE8Qr07+d
        AeSdmjyuRZfpzqESOX4YS9BSuw==
X-Google-Smtp-Source: AMsMyM6fgHpPZ8OaJrRQE9JNAl9TApFGi/43M7kOO0JQUKTShVuE7DbFrvYlNxRinnayan1yuKfchg==
X-Received: by 2002:a05:622a:15d1:b0:39c:f1da:fe0e with SMTP id d17-20020a05622a15d100b0039cf1dafe0emr6024638qty.662.1666181449045;
        Wed, 19 Oct 2022 05:10:49 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id u24-20020a37ab18000000b006bb83c2be40sm4759557qke.59.2022.10.19.05.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:10:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Wed, 19 Oct 2022 08:10:48 -0400
Message-Id: <B3E5FB1F-3184-4C56-8B11-6F422DBF1B53@joelfernandes.org>
References: <20221019104045.160283-1-qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221019104045.160283-1-qiang1.zhang@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Oct 19, 2022, at 6:34 AM, Zqiang <qiang1.zhang@intel.com> wrote:
>=20
> =EF=BB=BFCurrently, regardless of whether the CONFIG_RCU_LAZY is enabled,
> invoke the call_rcu() is always lazy, it also means that when
> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
> lazy. therefore, this commit make call_rcu() lazy only when
> CONFIG_RCU_LAZY is enabled.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
> kernel/rcu/tree.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index abc615808b6e..97ef602da3d5 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2839,7 +2839,6 @@ void call_rcu_flush(struct rcu_head *head, rcu_callb=
ack_t func)
>    return __call_rcu_common(head, func, false);
> }
> EXPORT_SYMBOL_GPL(call_rcu_flush);
> -#endif
>=20
> /**
>  * call_rcu() - Queue an RCU callback for invocation after a grace period.=

> @@ -2890,6 +2889,13 @@ void call_rcu(struct rcu_head *head, rcu_callback_t=
 func)
>    return __call_rcu_common(head, func, true);
> }
> EXPORT_SYMBOL_GPL(call_rcu);
> +#else
> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +    return __call_rcu_common(head, func, false);

Thanks. Instead of adding new function, you can also pass IS_ENABLED(CONFIG=E2=
=80=A6) to the existing function of the same name.

Looks like though I made every one test the patch without having to enable t=
he config option ;-). Hey, I=E2=80=99m a half glass full kind of guy, why do=
 you ask?

Paul, I=E2=80=99ll take a closer look once I=E2=80=99m at the desk, but woul=
d you prefer to squash a diff into the existing patch, or want a new patch a=
ltogether?

Thanks.

- Joel


> +}
> +EXPORT_SYMBOL_GPL(call_rcu);
> +#endif
>=20
> /* Maximum number of jiffies to wait before draining a batch. */
> #define KFREE_DRAIN_JIFFIES (5 * HZ)
> --=20
> 2.25.1
>=20
