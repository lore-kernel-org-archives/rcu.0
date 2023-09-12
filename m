Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA4BCA0ECA
	for <rcu@archiver.kernel.org>; Tue, 12 Sep 2023 13:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjILNeD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjILNdw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Sep 2023 09:33:52 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D903A1FFF
        for <rcu@vger.kernel.org>; Tue, 12 Sep 2023 06:32:58 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76dc77fd024so355556185a.3
        for <rcu@vger.kernel.org>; Tue, 12 Sep 2023 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694525578; x=1695130378; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svmbrtqWlENrRfjFLkk8+XzIqzX9R6UBCXGlZ2j0y4U=;
        b=STqINg1Bp3Dt3huRvyxqS8cTEdTqba814q1oe78CwMuMwNgY6oyPPO5DIckuhTv1ju
         fqIT00I/oDghb8xFp5wCpxdkxkt/NjU1BbeLmDU90QIOUFEc1xmICUo7QW1P6LePtW/O
         o32axdlGZhric9VfMCSukFEFhIJ1HRANk4NN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525578; x=1695130378;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=svmbrtqWlENrRfjFLkk8+XzIqzX9R6UBCXGlZ2j0y4U=;
        b=l9/enImyNeucQElEq9X22r4Gki8P9dDHQ4sU1ZvIAvlwA+cIN5um2modf6PveYoaI/
         vbk7q+xAIOtm5PtlygDYJg/3V8AKjFKDU3t1hd2Ka8Pzw258C4+RsE0y/zlvdZZT56pM
         S9JlM4/xrRft5EbEHf5QbA+WYeHj3rKcuYtwn8KZsW+KaKFgWNpDc1N1ritods/c62yF
         2UaMI4Y9uXR/XPrmMh1xKhpanHr6TWHoaAzRIpB0C5WAwiHHpkF02rQsEf+IDRYK1cpB
         RI+fkTOuUkTMDMBmQ4w3lF5g3pelt9q850FnrnOtxKcmKmuklVJqDctleI7HkKzlgeDh
         P7Cw==
X-Gm-Message-State: AOJu0YxNySkJHb1daRWM2UqavkQYv1AADtHq4fQInpm2eZR0S7Y8xAte
        DklvIKDvTfgVvxtan+fdrhkIsA==
X-Google-Smtp-Source: AGHT+IEWmiZ0EGY1O/9xetI5jQSsVfvw8K2frb4QEsfc2ct2W79miQrJDwoAIrb/amscRDLXZA6ZgQ==
X-Received: by 2002:a05:620a:19a7:b0:76e:fd91:5f6f with SMTP id bm39-20020a05620a19a700b0076efd915f6fmr14641824qkb.37.1694525577897;
        Tue, 12 Sep 2023 06:32:57 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.69])
        by smtp.gmail.com with ESMTPSA id pj24-20020a05620a1d9800b0076e1e2d6496sm3203685qkn.104.2023.09.12.06.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:32:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: kmemleak handling of kfree_rcu
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <6bd9f6cc-84d0-4f6a-bfd7-912dcb8e476a@tessares.net>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Date:   Tue, 12 Sep 2023 09:32:46 -0400
Message-Id: <5FAC49DB-0849-4F83-9802-571E62819ACC@joelfernandes.org>
References: <6bd9f6cc-84d0-4f6a-bfd7-912dcb8e476a@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Sep 12, 2023, at 9:15 AM, Matthieu Baerts <matthieu.baerts@tessares.net=
> wrote:
> =EF=BB=BFHi Catalin,
>=20
> On 06/09/2023 19:15, Catalin Marinas wrote:
>=20
> (...)
>=20
>> I had a patch already but got distracted by a few (real) leaks reported
>> while testing it. Feel free to pick it up and change _ignore to
>> _not_leak if you find that more suitable. Well, it would be good for
>> Christoph to test it as I haven't managed to reproduce the false
>> positive.
>=20
> Thank you for the patch!
>=20
>> ----------------------8<--------------------------
>> =46rom b25350cb6f8a906a6164b625bfd57021190cb105 Mon Sep 17 00:00:00 2001
>> From: Catalin Marinas <catalin.marinas@arm.com>
>> Date: Wed, 6 Sep 2023 17:52:45 +0100
>> Subject: [PATCH] rcu: kmemleak: Ignore kmemleak false positives when
>> RCU-freeing objects
>>=20
>> Since the actual slab freeing is deferred when calling kvfree_rcu(), so
>> is the kmemleak_free() callback informing kmemleak of the object
>> deletion. =46rom the perspective of the kvfree_rcu() caller, the object i=
s
>> freed and it may remove any references to it. Since kmemleak does not
>> scan the tree RCU internal data storing the pointer, it will report such
>> objects as leaks during the grace period.
>>=20
>> Tell kmemleak to ignore such objects on the kvfree_call_rcu() path. Note
>> that the tiny RCU implementation does not have such issue since the
>> objects can be tracked from the rcu_ctrlblk structure.
>>=20
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reported-by: Christoph Paasch <cpaasch@apple.com>
>> ---
>> kernel/rcu/tree.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>=20
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index cb1caefa8bd0..2ac39b5705df 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -31,6 +31,7 @@
>> #include <linux/bitops.h>
>> #include <linux/export.h>
>> #include <linux/completion.h>
>> +#include <linux/kmemleak.h>
>> #include <linux/moduleparam.h>
>> #include <linux/panic.h>
>> #include <linux/panic_notifier.h>
>> @@ -3388,6 +3389,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *=
ptr)
>>        success =3D true;
>>    }
>>=20
>> +    /*
>> +     * The kvfree_rcu() caller considers the pointer freed at this point=

>> +     * and likely removes any references to it. Since the the actual sla=
b
>=20
> Just in case you didn't send this patch, checkpatch.pl noticed that the
> word "the" was repeated in the comment here above ("Since the the actual")=
.

Sounds like you detected a leak in the word the. :-)

(Sorry could not resist).

 - Joel


>=20
> Cheers,
> Matt
>=20
>> +     * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignor=
e
>> +     * this object (no scanning or false positives reporting).
>> +     */
>> +    kmemleak_ignore(ptr);
>> +
>>    // Set timer to drain after KFREE_DRAIN_JIFFIES.
>>    if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_RUNNING)
>>        schedule_delayed_monitor_work(krcp);
>=20
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
