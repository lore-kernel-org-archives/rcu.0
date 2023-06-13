Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F86C88CB2
	for <rcu@archiver.kernel.org>; Tue, 13 Jun 2023 01:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbjFMBAQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jun 2023 21:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjFMBAP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jun 2023 21:00:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B099710DF;
        Mon, 12 Jun 2023 18:00:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-652a6bf4e6aso3983338b3a.2;
        Mon, 12 Jun 2023 18:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686618014; x=1689210014;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvmLqYkFxB2yGZhyqXLJmDbC/bCIHCXItlMaNFSz9kE=;
        b=TvQfxI/6VmpS4FcQkWUs4BkwDvfHHuZugkSq/Rxg+RUYOkMyVCj52H0DFj0Sc1op8r
         eTE91xnd9ypznhJxCgOXpm+LXkf2uuHvZasAAcGIMCbeTjJJo5qMQxd+CEI+HCxp5h4P
         Tcwuupr/oaEqEt/yfkKWsrwgcmkxbDk/jlJ5qlg5dMbyPumbbH4Ld+goEcN9GmiVypS3
         B+nJ5KNKcjHHsVK5v2fLdCmLvDgkzrHUK7tLWEulUBhFfQy0v63l4T0sLoqLktV7LMOq
         qWzO4mnL8j2Lauugh4No2+wT3YQZmbbE3rSW58RZPnWu7rxoR0tTac54iBynOTyNs5QZ
         ujHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686618014; x=1689210014;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvmLqYkFxB2yGZhyqXLJmDbC/bCIHCXItlMaNFSz9kE=;
        b=QnNJuJg5LwiQyiO5an4Pm5mMA/Gan61eAqOPIy+7qdXTmxTeLN+N0dBgfqoSOzOsDy
         o5EE655E7Ven2d26I3jYZwOGuvWkogIQab6hGn/BUmrwNzWy0ljEJAnX3yNAZJyO09PU
         Swgj3fG3LGdZ6zrYjAy8Xj88EhsrNo3f71y2e8E0eVZErDEfPISwJZroRMu1SoqQgGd4
         XI9nk9e2edPeYko6wbI/MNy8uu0xaLN10UOZn5ayYsQlVJd2Zn3l6h1/GwuCtFPNcvh4
         ILJaiPfdWYP4jubh+XZKCz+ClU4mPO8kOzYjaousppP2Yxg2M0A0M/+GIKatiUAQgsaQ
         OUMg==
X-Gm-Message-State: AC+VfDzjQlPCtkib9IUvtsx8KtvVG+aSS6dDgHLEaR1sphVX93MMdAGY
        3Ei/9MM7pMmIE7E7ls5H/ps=
X-Google-Smtp-Source: ACHHUZ6IorionXYZChlGwpqnR8J91yKl0HSYSIOQYx6KnXSvVy6MPNQzTHvvHiF2vlWw5P19ypHXAQ==
X-Received: by 2002:a05:6a21:9989:b0:111:6d42:a8ac with SMTP id ve9-20020a056a21998900b001116d42a8acmr11629911pzb.14.1686618014166;
        Mon, 12 Jun 2023 18:00:14 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001a67759f9f8sm7123634plh.106.2023.06.12.18.00.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2023 18:00:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH] docs/RCU: Add the missing rcu_read_unlock()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <1ca60542-5d9f-4e16-9b10-b4c79f495d03@paulmck-laptop>
Date:   Tue, 13 Jun 2023 08:59:57 +0800
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFD3C233-A84E-4951-9DBE-CE38A34ABA30@gmail.com>
References: <20230610040608.6355-1-mmpgouride@gmail.com>
 <1ca60542-5d9f-4e16-9b10-b4c79f495d03@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> 2023=E5=B9=B46=E6=9C=8813=E6=97=A5 05:26=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sat, Jun 10, 2023 at 04:06:08AM +0000, Alan Huang wrote:
>> We should exit the RCU read-side critical section before re-entering.
>>=20
>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>> ---
>> Documentation/RCU/rculist_nulls.rst | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/Documentation/RCU/rculist_nulls.rst =
b/Documentation/RCU/rculist_nulls.rst
>> index 9a734bf54..4370ac864 100644
>> --- a/Documentation/RCU/rculist_nulls.rst
>> +++ b/Documentation/RCU/rculist_nulls.rst
>> @@ -30,6 +30,7 @@ algorithms:
>>   obj =3D lockless_lookup(key);
>>   if (obj) {
>>     if (!try_get_ref(obj)) // might fail for free objects
>> +      rcu_read_unlock();
>=20
> Good eyes!  But don't we also need a pair of braces?

Yeah! We need that. I have sent the v2.

Thanks,
Alan

>=20
> Thanx, Paul
>=20
>>       goto begin;
>>     /*
>>     * Because a writer could delete object, and a writer could
>> --=20
>> 2.34.1


