Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB429C64EC7
	for <rcu@archiver.kernel.org>; Tue, 28 Feb 2023 20:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjB1U41 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjB1U4Y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Feb 2023 15:56:24 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDA134F73
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 12:56:22 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id m4so7850966qvq.3
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 12:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677617781;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1k1XmXsff3btuUGsie2pzFiOnlZVLd6pPcaArC3aVQs=;
        b=gmQXfguQviSRKLou+oUUzSbGaTJ9ngV0L/yjBbSllPFq5CjWR3J2W3ftRniJbEJZLG
         tz+tr7+GrkLgojwL4AmC8IlHQMcjefR6nZXWBI7jJNHOj5B1hpRKakgp63yY3St2O8iA
         iMs4QSzN4BLC4Lyzrp0TY2Q7WLwUzBLlW2TME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677617781;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k1XmXsff3btuUGsie2pzFiOnlZVLd6pPcaArC3aVQs=;
        b=kOhA6epbBoOOFEOFZwngbtRmzdCfG/dhnnkhJHQNtiEFzzw2e/09qDh+U/KRopBsgv
         1RLTQAZuUSZe781Y7HR+d0rExe1UliG25heD9+zkc4DYIxwSdJsp5OmWH+t3jpQYkMGR
         pTbQpngRDlLsDWVjvAuH/tSXpIasMfTYm5Y+P+k1+m4xFyGCPGBFEWHPzvLwNRt5hVSj
         n4/LjpRtJUz/ANlQf+C0rzAQpJ2T1XhhykNjRE66pr7KEI2C0gNPVvKTi7A6cUhsKGvy
         yG/h1FYLsae0hq/J9GWnBfWvPMd9gw2jVeiqESCbDqH6diAEpG8kARUbXjbkAd42bISC
         4Wzw==
X-Gm-Message-State: AO0yUKUPDLaoRLctA4YipCGOmLvgyosig4FbxKhpqZe3xTeoWbpx6W3L
        PhYmHmbM7NThBLw9BLXa5wqH5Hq1wM/hoxDp
X-Google-Smtp-Source: AK7set/wVX5+WV6VxKZvkpTsFI6BZFSZalcly9larjlq30KVCinUIpyb9ZcD4JgMAHH47oMcF3+7cQ==
X-Received: by 2002:a05:6214:e8f:b0:571:f87:a66e with SMTP id hf15-20020a0562140e8f00b005710f87a66emr7923388qvb.34.1677617781566;
        Tue, 28 Feb 2023 12:56:21 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id bm26-20020a05620a199a00b007424376ca4bsm7545832qkb.18.2023.02.28.12.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 12:56:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Date:   Tue, 28 Feb 2023 15:56:09 -0500
Message-Id: <944C2939-BE6B-431D-B751-F052A7684844@joelfernandes.org>
References: <Y/5mguXPPqdP3MZF@google.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
In-Reply-To: <Y/5mguXPPqdP3MZF@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Feb 28, 2023, at 3:39 PM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>=20
> =EF=BB=BFOn Tue, Feb 28, 2023 at 04:51:21PM +0100, Uros Bizjak wrote:
>> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) =3D=3D old in
>> check_cpu_stall.  x86 CMPXCHG instruction returns success in ZF flag, so
>> this change saves a compare after cmpxchg (and related move instruction i=
n
>> front of cmpxchg).
>=20
> In my codegen, I am not seeing mov instruction before the cmp removed, how=

> can that be? The rax has to be populated with a mov before cmpxchg right?
>=20
> So try_cmpxchg gives: mov, cmpxchg, cmp, jne
> Where as cmpxchg gives: mov, cmpxchg, mov, jne
>=20
> So yeah you got rid of compare, but I am not seeing reduction in moves.
> Either way, I think it is an improvement due to dropping cmp so:
>=20
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Ah there probably is a lesser mov to hold the value to compare against,
but maybe not always?=20

Would be nice to clarify that in the changelog anyway.

Thanks,

 - Joel

>=20
> thanks,
>=20
> - Joel
>=20
>=20
>>=20
>> No functional change intended.
>>=20
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>> ---
>> kernel/rcu/tree_stall.h | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index b10b8349bb2a..d81c88e66b42 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -760,7 +760,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>>    jn =3D jiffies + ULONG_MAX / 2;
>>    if (rcu_gp_in_progress() &&
>>        (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
>> -        cmpxchg(&rcu_state.jiffies_stall, js, jn) =3D=3D js) {
>> +        try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>>=20
>>        /*
>>         * If a virtual machine is stopped by the host it can look to
>> @@ -778,7 +778,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>>=20
>>    } else if (rcu_gp_in_progress() &&
>>           ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
>> -           cmpxchg(&rcu_state.jiffies_stall, js, jn) =3D=3D js) {
>> +           try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>>=20
>>        /*
>>         * If a virtual machine is stopped by the host it can look to
>> --=20
>> 2.39.2
>>=20
