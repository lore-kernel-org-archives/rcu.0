Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC9AC4332F
	for <rcu@archiver.kernel.org>; Wed, 19 Oct 2022 12:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiJSMpY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Oct 2022 08:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiJSMpL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Oct 2022 08:45:11 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEBB1C97C6
        for <rcu@vger.kernel.org>; Wed, 19 Oct 2022 05:27:52 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o65so14282621iof.4
        for <rcu@vger.kernel.org>; Wed, 19 Oct 2022 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pY1YM4d0+1/Thcbjd6qmnOZ5kqWdSFQ3Kv1lnH4sWA=;
        b=Pga4wZNf04hMZrKKT9mcl+IhY6zlvMzumcfIAI+/P97rYjWbbLz1/iulZdE4nNOfwp
         3mk//sy6gmT1m4aLGyzzm+5hQK2Cqf90d2rtYQ7SwV+ZnK7spBTwpiE5NYlXWXfkKs4M
         kk9pehk8EXvHg6Dg9Ari3hhXFN7qWptrgomMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pY1YM4d0+1/Thcbjd6qmnOZ5kqWdSFQ3Kv1lnH4sWA=;
        b=yxbuH71R8t6Lpysc5OOF+P8kUfE1jAk8t+83+J4cEgZRrLMLnHZ1idLWPWiMZS8YyC
         7+E0oIDOQ67TFIQAepfXTi5adUAl47/PaANLbiw8isQJBZGgiI+7bx759dhsZY82HA+b
         TZo1Ua2DuT/irnpMA9z4LAUxqUFiTqYQuOGboQeG8ci4/pUDiBmh9OhhsQ7KO+7DOzkG
         xPDxsm/CujlOgV1HjrZRbr8Q2JFqC0KHyfaFbBUR1or1/Kp8lLHiu94c82XMlmjRBXp+
         XfN+SU6t8GCMmqGvNF9Bu4IWT0ZomnZHg9dC+MI9PIToIRi+QhLsRmlLgDJad4aSx8Pl
         fMyA==
X-Gm-Message-State: ACrzQf1gQ4ojHpdX/CZvfdVahrHG1NdRdFmQQA/DoUtDdhIbBVQLufoT
        YAUGroBByAXEQRydhFYrZPCGYplpKxRRng==
X-Google-Smtp-Source: AMsMyM4E3FQhClAFEYceh8cbgOaSLHYITXZdfbeN/35wsY1lSWQGRWVkMR7DQ9LSzDkQCe/5AEftJw==
X-Received: by 2002:a05:622a:392:b0:39c:e5a2:6d18 with SMTP id j18-20020a05622a039200b0039ce5a26d18mr6148925qtx.245.1666181551173;
        Wed, 19 Oct 2022 05:12:31 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id a10-20020ac85b8a000000b00397b1c60780sm4018435qta.61.2022.10.19.05.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:12:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Wed, 19 Oct 2022 08:12:30 -0400
Message-Id: <F24713AB-9AC8-494F-A677-D52C9CE591CF@joelfernandes.org>
References: <B3E5FB1F-3184-4C56-8B11-6F422DBF1B53@joelfernandes.org>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <B3E5FB1F-3184-4C56-8B11-6F422DBF1B53@joelfernandes.org>
To:     Zqiang <qiang1.zhang@intel.com>
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Oct 19, 2022, at 8:10 AM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>=20
> =EF=BB=BF
>=20
>> On Oct 19, 2022, at 6:34 AM, Zqiang <qiang1.zhang@intel.com> wrote:
>>=20
>> =EF=BB=BFCurrently, regardless of whether the CONFIG_RCU_LAZY is enabled,=

>> invoke the call_rcu() is always lazy, it also means that when
>> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
>> lazy. therefore, this commit make call_rcu() lazy only when
>> CONFIG_RCU_LAZY is enabled.
>>=20
>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>> ---
>> kernel/rcu/tree.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index abc615808b6e..97ef602da3d5 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -2839,7 +2839,6 @@ void call_rcu_flush(struct rcu_head *head, rcu_call=
back_t func)
>>   return __call_rcu_common(head, func, false);
>> }
>> EXPORT_SYMBOL_GPL(call_rcu_flush);
>> -#endif
>>=20
>> /**
>> * call_rcu() - Queue an RCU callback for invocation after a grace period.=

>> @@ -2890,6 +2889,13 @@ void call_rcu(struct rcu_head *head, rcu_callback_=
t func)
>>   return __call_rcu_common(head, func, true);
>> }
>> EXPORT_SYMBOL_GPL(call_rcu);
>> +#else
>> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
>> +{
>> +    return __call_rcu_common(head, func, false);
>=20
> Thanks. Instead of adding new function, you can also pass IS_ENABLED(CONFI=
G=E2=80=A6) to the existing function of the same name.
>=20
> Looks like though I made every one test the patch without having to enable=
 the config option ;-). Hey, I=E2=80=99m a half glass full kind of guy, why d=
o you ask?
>=20
> Paul, I=E2=80=99ll take a closer look once I=E2=80=99m at the desk, but wo=
uld you prefer to squash a diff into the existing patch, or want a new patch=
 altogether?

On the other hand, what I=E2=80=99d want is to nuke the config option altoge=
ther or make it default y, we want to catch issues sooner than later.

Thanks.

>=20
> Thanks.
>=20
> - Joel
>=20
>=20
>> +}
>> +EXPORT_SYMBOL_GPL(call_rcu);
>> +#endif
>>=20
>> /* Maximum number of jiffies to wait before draining a batch. */
>> #define KFREE_DRAIN_JIFFIES (5 * HZ)
>> --=20
>> 2.25.1
>>=20
