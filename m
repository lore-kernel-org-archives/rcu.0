Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E1C5479D
	for <rcu@archiver.kernel.org>; Mon,  9 Jan 2023 23:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbjAIXVb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbjAIXVO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Jan 2023 18:21:14 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E2B495
        for <rcu@vger.kernel.org>; Mon,  9 Jan 2023 15:21:10 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id m12so5367396qvt.9
        for <rcu@vger.kernel.org>; Mon, 09 Jan 2023 15:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qcIo641VgQqypBE5BRTa9OYJg2aBsbbaZQkWbSADKY=;
        b=NjQCifZsiL4B5xrSUEOPPlD1mmXS4/AOXd7a+rENU5HIq1kA84dv9AKqHLBO9ZEtV0
         vIht+HSu6pi6L688tHyapy5yMzdkRthIbFiosSWCbvt4198Nc2gVJghlsg7CGDfrbH+3
         GyUfy/m+W4ekE6vOWUZTvBqZCvreB8IVILqxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qcIo641VgQqypBE5BRTa9OYJg2aBsbbaZQkWbSADKY=;
        b=17VL0npxaexbzff1CFC07KeSSeyETE9wpBCsfgU9QF/LoK2s/cx6ntycMdE2iZo3Jw
         SSTT/IuaZHZzZSCd2fjCWnU079BOFfJbn3yt5sJfWoWCw0MjCblETWnZIWtVrWNWQJ+G
         4VG/nhXeNHhYdQT9nNG0PjSLglmTNw00PoNhQZZi8+2vMsQWhepa746vOhsYgBjYBvIG
         TBX7+crlFlHmYtz1nLXt0G58pk0j5JTp8ACCthMYCDrc9+ndWNfXzsDNjR2E18dClyKF
         nGN/s1Xy3oZVR0HCRoUzPX4A3QkPbZ/ORE2lVSQYYsiicPZ3dMQKWpoHqaHSCcSVPJvY
         UUuA==
X-Gm-Message-State: AFqh2kofHy36EERdwF3DxMbIF2cdGrjtO1ehdC6UXo2bSTskzZsR8NPs
        qYvgZ/4FoeXshRRILbJhyfCxRg==
X-Google-Smtp-Source: AMrXdXtLbNwy5d2Ahknl9s2l2EHFybayrw8cV9Ng+MtksfdcAYis2xkNEfIL5frl36GSIvI6vWkiYQ==
X-Received: by 2002:ad4:51ce:0:b0:532:2112:69fc with SMTP id p14-20020ad451ce000000b00532211269fcmr14111388qvq.0.1673306469792;
        Mon, 09 Jan 2023 15:21:09 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b110:1f87:f047:ffed:9f93:3fb6])
        by smtp.gmail.com with ESMTPSA id bl41-20020a05620a1aa900b007059c5929b8sm6087242qkb.21.2023.01.09.15.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 15:21:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -rcu] rcu: Disable lazy if call_rcu() called when GPs expedited
Date:   Mon, 9 Jan 2023 18:20:55 -0500
Message-Id: <C461EF52-B060-4871-8C20-30824983E787@joelfernandes.org>
References: <20230109231416.GA4028633@paulmck-ThinkPad-P17-Gen-1>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        foo@bar.com
In-Reply-To: <20230109231416.GA4028633@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jan 9, 2023, at 6:14 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Jan 09, 2023 at 10:17:56PM +0000, Joel Fernandes (Google)=
 wrote:
>> During suspend, we see failures to suspend 1 in 300-500 suspends.
>> Looking closer, it appears that we are queuing lazy callbacks even
>> though rcu_gp_is_expedited(). These delays appear to not be very welcome
>> by the suspend/resume code as evidenced by these occasional suspend
>> failures.
>>=20
>> This commit therefore checks if rcu_gp_is_expedited() and ignores the
>> lazy hint if so.
>>=20
>> Ignoring the lazy hint if rcu_gp_is_expedited() makes the 3000
>> suspend/resume cycles pass reliably on a 12th gen 12-core Intel CPU.
>=20
> Yow!!!  ;-)

:-D

>> Fixes: 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power")
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>> Paul, could we take this for 6.2 -rc cycle? Thanks.
>>=20
>> kernel/rcu/tree.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 63545d79da51..93eb03f8ed99 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -2594,12 +2594,12 @@ static void check_cb_ovld(struct rcu_data *rdp)
>> }
>>=20
>> static void
>> -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)=

>> +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_=
in)
>> {
>>    static atomic_t doublefrees;
>>    unsigned long flags;
>>    struct rcu_data *rdp;
>> -    bool was_alldone;
>> +    bool was_alldone, lazy;
>=20
> Please put "lazy" in alpha order.  Except that...

Ah sure.

>=20
>>    /* Misaligned rcu_head! */
>>    WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
>> @@ -2622,6 +2622,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callba=
ck_t func, bool lazy)
>>    kasan_record_aux_stack_noalloc(head);
>>    local_irq_save(flags);
>>    rdp =3D this_cpu_ptr(&rcu_data);
>> +    lazy =3D lazy_in && !rcu_gp_is_expedited();
>=20
> Doesn't this completely disable laziness on Android?

Good point, I am not sure but it could be. Maybe it is safer that I add
a new suspend-indicator then, with corresponding
suspend entry/exit calls like we do for expedited.

That way anyone doing it this way will not disable
lazy fully.

Thoughts?

Thanks!

 - Joel=20



>=20
>                            Thanx, Paul
>=20
>>    /* Add the callback to our list. */
>>    if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
>> --=20
>> 2.39.0.314.g84b9a713c41-goog
