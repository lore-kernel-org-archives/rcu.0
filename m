Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE74FC001DE
	for <rcu@archiver.kernel.org>; Fri,  4 Aug 2023 16:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHDQP6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Aug 2023 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHDQP5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Aug 2023 12:15:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465A1BDD
        for <rcu@vger.kernel.org>; Fri,  4 Aug 2023 09:15:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso35806391fa.0
        for <rcu@vger.kernel.org>; Fri, 04 Aug 2023 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691165754; x=1691770554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTBUb3xh/xSekY6RSb7j+KpzPBpu+PCrs+mM2PREP98=;
        b=N4DmQlDgCgVlj+OgQMCL68oTHRJXSLJ6h5w8IJMvPcG7q+kTyomUERidAwgdwsfs2N
         GYRFJHiVfBHl3vYIIVmZVPtwH8aDTjIGOpAiuhKCoC8NyfW+FNXy4ggW7WY/HMsa0tnA
         F6nLx8VxtedW54h1lDvDn84Mug2PT5fT8GHhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165754; x=1691770554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTBUb3xh/xSekY6RSb7j+KpzPBpu+PCrs+mM2PREP98=;
        b=IyCgwlJRH//znlm0X+civf44l5XFLfZ5wjoPyawiQ2oAylpSrx9dUh+xYLyw4HChgb
         hGUDWxHgrAaw0wHnQr/eib5gWaDZH9NNFXTRuBbfBnbv5QEkTk0C/ZkB2B81ZT3V1aab
         1q+EnVXwuKjCUFZ2X49qzjFmCDJqY5AlLrW8t3RyMrwddR+Vj3K66SX5MLUtSzWKXq37
         XY7aeJ4gRvSHeECrT+ySD5GaWu00Pc6ScEGVpUHtS9yTYkDvdxqVE2IHzUK9rkCGvwMM
         h+5ENnXqz50XzTnyhew4j/WJTWAgA3g4MasoamDKyfPL2Yz6/uGyxlUuf4JiKS2b45eK
         /vLQ==
X-Gm-Message-State: AOJu0Yw5ZfQ10fv2cSc7g2evwDJ127amUNYy6Efwhe+mMjqlA4wd9W9U
        YqN3CBYzxGn6s0XGMsuV+BuzVLrezkKwnqv1umHHFw==
X-Google-Smtp-Source: AGHT+IHQCcgsXJrB40IvL18uKSefZUicbvmvqkVOw7aqPOFqbOthOu0+QpZEGWJSGc3XA5Av3QydXUr6or3RxSqiY+A=
X-Received: by 2002:a2e:95cf:0:b0:2b6:a763:5d13 with SMTP id
 y15-20020a2e95cf000000b002b6a7635d13mr1812635ljh.27.1691165753842; Fri, 04
 Aug 2023 09:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <D3D65E05-AC98-43EA-8B66-CA63E94C1C80@gmail.com>
 <6B0A9441-5DB5-476B-B94C-F0BDF1505095@joelfernandes.org> <E6EDDDE7-5D59-4284-931E-23E3636C8CF0@gmail.com>
In-Reply-To: <E6EDDDE7-5D59-4284-931E-23E3636C8CF0@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 4 Aug 2023 12:15:42 -0400
Message-ID: <CAEXW_YQez6yNzwLXg_mbKN9pZV1=EzO7-X5s5GLj_F34P6c+kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to requirements
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 4, 2023 at 11:47=E2=80=AFAM Alan Huang <mmpgouride@gmail.com> w=
rote:
>
> >
> >>>
> >>>>>> But the example here is different,
> >>>>>
> >>>>> That is intentional. Wills discussion partially triggered this. Tho=
ugh I am wondering
> >>>>> if we should document that as well.
> >>>>>
> >>>>>> the compiler can not use the value loaded from line 5
> >>>>>> unless the compiler can deduce that the tmp is equals to p in whic=
h case the address dependency
> >>>>>> doesn=E2=80=99t exist anymore.
> >>>>>>
> >>>>>> What am I missing here?
> >>>>>
> >>>>> Maybe you are trying to rationalize too much that the sequence ment=
ioned cannot result
> >>>>> in a counter intuitive outcome like I did?
> >>>>>
> >>>>> The point AFAIU is not just about line 10 but that the compiler can=
 replace any of the
> >>>>> lines after the plain access with the cached value.
> >>>>
> >>>> Well, IIUC, according to the C standard, the compiler can do anythin=
g if there is a data race (undefined behavior).
> >>>>
> >>>> However, what if a write is not protected with WRITE_ONCE and the re=
ad is marked with READ_ONCE?
> >>>> That=E2=80=99s also a data race, right? But the kernel considers it =
is Okay if the write is machine word aligned.
> >>>
> >>> Yes, but there is a compiler between the HLL code and what the
> >>> processor sees which can tear the write. How can not using
> >>> WRITE_ONCE() prevent store-tearing? See [1]. My understanding is that
> >>> it is OK only if the reader did a NULL check. In that case the torn
> >>
> >> Yes, a write-write data race where the value is the same is also fine.
> >>
> >> But they are still data race, if the compiler is within its right to d=
o anything it likes (due to data race),
> >> we still need WRITE_ONCE() in these cases, though it=E2=80=99s semanti=
cally safe.
> >>
> >> IIUC, even with _ONCE(), the compiler is within its right do anything =
according to the standard (at least before the upcoming C23), because the s=
tandard doesn=E2=80=99t consider a volatile access to be atomic.
> >>
> >> However, the kernel consider the volatile access to be atomic, right?
> >>
> >> BTW, line 5 in the example is likely to be optimized away. And yes, th=
e compiler can cache the value loaded from line 5 from the perspective of u=
ndefined behavior, even if I believe it would be a compiler bug from the pe=
rspective of kernel.
> >
> > I am actually a bit lost with what you are trying to say.  Are you sayi=
ng that mixing
> > plain accesses with marked accesses is an acceptable practice?
>
>
> I=E2=80=99m trying to say that sometimes data race is fine, that=E2=80=99=
s why we have the data_race().
>
> Even if the standard says data race results in UB.
>
> And IMHO, the possible data race at line 5 in this example is also fine, =
unless the compiler
> deduces that the value of gp is always the same.

IMHO, no one is saying it is not "fine". As in, such behavior is
neither a compiler nor strictly a kernel bug.  More a wtf that the
programmer should know off (does not hurt to know).

I will rest my case with AlanH pending any input from people who know
more than me. If there is a better way to represent such matters in
the docs, I am happy to make changes to this patch.

Cheers,

 - Joel
