Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33DC77B7E
	for <rcu@archiver.kernel.org>; Tue,  2 May 2023 15:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjEBPyL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 May 2023 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjEBPyI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 May 2023 11:54:08 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D76A3A94
        for <rcu@vger.kernel.org>; Tue,  2 May 2023 08:53:39 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75131c2997bso1742517185a.1
        for <rcu@vger.kernel.org>; Tue, 02 May 2023 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683042817; x=1685634817;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lc8SWnRjUYOTdNJRGlm9wk6s5S+263SRABuRLzDmZcU=;
        b=mwvfDreY/fSkTUQH7E64MSP1Fu+foLF3UdQLN1AWqeNq9pfgX+Lxsc/dvsUENsNceQ
         1LPXBxoBHpObY62bQ4VcvXt5mc0EQHSPdQB7zkf7aH4N1hPQ+0i0wrf2ruHtavP3pkKh
         mVTPu9FZxopn1+/3LvdcJjUOXLqVXTUsssTwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042817; x=1685634817;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc8SWnRjUYOTdNJRGlm9wk6s5S+263SRABuRLzDmZcU=;
        b=CFfuWoHyIF4/gSa7Bc5u4XN4ssShB7v0AV0E7Ii6fAseAwpkX56zW38sfc1MEfToxZ
         7LO3Hy8lAbmwMGnfjJA9dAf3DzmfEA4BUlT0js8dnTBdiNtvZy7vt6eoYgAdfQG5mnYw
         8dJtfHZGUX5rSsCt4FfRMYVWPVlZvZw5ROf7ZWs5niSAMnUT+XtN6Ya9sDWoAu/cMS9a
         9uYdHzOdFTkBnVv5EDGbSyUwKwRu552PJ8/gHNU4crMWtirqHoUFF/TsBZck7ymrQNf0
         ktboNlYMLogGjwpqKZNd2+ciZBeNNvLy/xSe4B/4BorA9SowtMkNhnW8P7F4OmAf2hF1
         ZqcA==
X-Gm-Message-State: AC+VfDzBLF4+ArP/Qi48deIxvtb89cwU/HlsLoq86dRrzata6K98+UJC
        e/EfgOdDFZ5Hfdm0o3W9954NHQVcRuXwz5dGSPc=
X-Google-Smtp-Source: ACHHUZ40yjp3WF/N+b184rc8lNzoQ8u54g6Kk8zlUgKjraZAuVA5Z02KAlOCvv/u+j8S+qIZAsIXRg==
X-Received: by 2002:a05:6214:4008:b0:5d8:eac2:3b54 with SMTP id kd8-20020a056214400800b005d8eac23b54mr5236016qvb.16.1683042817109;
        Tue, 02 May 2023 08:53:37 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b847:b63b:2082:8992:7700:a976])
        by smtp.gmail.com with ESMTPSA id h5-20020a0cab05000000b005f9a0018360sm9588801qvb.11.2023.05.02.08.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 08:53:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V2] rcu/torture replace wait_event with wait_event_idle
Date:   Tue, 2 May 2023 11:53:25 -0400
Message-Id: <439F943C-32E7-4FAA-8E35-15CA1CEC0A78@joelfernandes.org>
References: <CAABZP2wTpG1dCU8GNTuiyj+2zkHxWgOF3j3Mqjk5BUgS6KADZA@mail.gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
In-Reply-To: <CAABZP2wTpG1dCU8GNTuiyj+2zkHxWgOF3j3Mqjk5BUgS6KADZA@mail.gmail.com>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On May 2, 2023, at 9:50 AM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>=20
> =EF=BB=BFOn Tue, May 2, 2023 at 9:40=E2=80=AFPM Paul E. McKenney <paulmck@=
kernel.org> wrote:
>>=20
>>> On Tue, May 02, 2023 at 08:01:41AM +0800, zhouzhouyi@gmail.com wrote:
>>> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
>>>=20
>>> In kfree_rcu_test, kfree_scale_shutdown will be detected as hung task
>>> if kfree_loops is too big. Replace wait_event with wait_event_idle
>>> to avoid false positive.
>>>=20
>>> Tested in the PPC VM of Open Source Lab of Oregon State University.
>>>=20
>>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>>> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>>=20
>> Good catch, thank you!
>>=20
>> However, this commit beat you to it:
>>=20
>> ef1ef3d47677 ("rcuscale: Move shutdown from wait_event() to wait_event_id=
le()")
> You are very welcome ;-) Still, this is a very fruitful learning
> process for me ;-)

Speaking of learning, can you explain why it fixes the issue? ;-)

Your change log lacked the real reason but that is Ok since change logs can o=
nly tell you so much. I admit I myself did not know the reason till I read s=
ome code.

Quiz: why exactly does this all work out in the end even though the hung tas=
k detector saw it hung?

Thanks,

 - Joel=20


>=20
> Cheers
> Zhouyi
>>=20
>>                                                        Thanx, Paul
>>=20
>>> ---
>>> kernel/rcu/rcuscale.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>>> index 91fb5905a008..d99c586939d1 100644
>>> --- a/kernel/rcu/rcuscale.c
>>> +++ b/kernel/rcu/rcuscale.c
>>> @@ -771,7 +771,7 @@ kfree_scale_cleanup(void)
>>> static int
>>> kfree_scale_shutdown(void *arg)
>>> {
>>> -     wait_event(shutdown_wq,
>>> +     wait_event_idle(shutdown_wq,
>>>                 atomic_read(&n_kfree_scale_thread_ended) >=3D kfree_nrea=
lthreads);
>>>=20
>>>      smp_mb(); /* Wake before output. */
>>> --
>>> 2.34.1
>>>=20
