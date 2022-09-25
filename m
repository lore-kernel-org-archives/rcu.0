Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A354EC32771
	for <rcu@archiver.kernel.org>; Sun, 25 Sep 2022 01:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIYBAn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 24 Sep 2022 21:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiIYBAm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 24 Sep 2022 21:00:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7582CDF0
        for <rcu@vger.kernel.org>; Sat, 24 Sep 2022 18:00:41 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y2so2233081qtv.5
        for <rcu@vger.kernel.org>; Sat, 24 Sep 2022 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=pBjKnhv48AReSenos1EzWblHzgx5WrkGKSxd+4i3v/8=;
        b=rpo+62678FtfrV3dy6G42gJaAPkuNqdO5WwHR7kp4UkI8d06N6pJ718KXUKsVpZmGb
         AHLvIL97mHg2WyizFkE2C7/UPbFIy/raFqGlaOLdI2rb+1+B58JPxQWLwm5xH+2InSSx
         8Udy1INyeog50lSzIJO9TLc2UP5opmwgsGRLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pBjKnhv48AReSenos1EzWblHzgx5WrkGKSxd+4i3v/8=;
        b=JC0Oygd2OodY81xS0ymUS5M16VLfoDVzxxNZZWr19pxSwedLeCXA9wjk6Xh924UD9+
         948OyOKxRyZPsfa61TbvvVqqlmxWXF+OSsKPIk6/sgaLIPnCAzSadco+ur1y65xroapK
         8uKDk/V52yXXc0U7HThjadZjIux1FggfXfiNtEfLeJgKHegz0sRNrFmmO7pr29WxXKsS
         YKJKRk4hbcTkace3NQijR+1+F3BcwNMIQJ697WRQZaxdaqQ6DsFRXwShsTGhO9hR2EyU
         NWluKVRQTX9itN8gIK5GRSTozj1qBMY3ADNLoBPofNsSTWGcqqXNGZ2v3wYJ2L05RizB
         lAbA==
X-Gm-Message-State: ACrzQf1kqYkSl3yNn6KQWUTPEf5p/uXx+YmirjReCRdA79ak/zyNECSL
        JOA2a21wykwUaoaHrs7QZrHyTAjl3x+lyr4Rw44=
X-Google-Smtp-Source: AMsMyM5fyBsvL64aefzYmSkRIjZgMlAJnW6XJVeRNB+NOdniJjy2K5qRG2kAn542g480npjuoxq3hA==
X-Received: by 2002:ac8:5f09:0:b0:35c:bf70:6a63 with SMTP id x9-20020ac85f09000000b0035cbf706a63mr13010085qta.500.1664067640543;
        Sat, 24 Sep 2022 18:00:40 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bm17-20020a05620a199100b006c73c3d288esm9052921qkb.131.2022.09.24.18.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 18:00:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Date:   Sat, 24 Sep 2022 21:00:39 -0400
Message-Id: <22F29015-5962-433D-8815-E4154B4897DD@joelfernandes.org>
References: <19217A4C-7183-4D78-A714-FBFE7BB20742@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org
In-Reply-To: <19217A4C-7183-4D78-A714-FBFE7BB20742@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Sep 24, 2022, at 7:28 PM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>=20
> =EF=BB=BFHi Frederic, thanks for the response, replies
> below courtesy fruit company=E2=80=99s device:
>=20
>>> On Sep 24, 2022, at 6:46 PM, Frederic Weisbecker <frederic@kernel.org> w=
rote:
>>>=20
>>> =EF=BB=BFOn Thu, Sep 22, 2022 at 10:01:01PM +0000, Joel Fernandes (Googl=
e) wrote:
>>> @@ -3902,7 +3939,11 @@ static void rcu_barrier_entrain(struct rcu_data *=
rdp)
>>>   rdp->barrier_head.func =3D rcu_barrier_callback;
>>>   debug_rcu_head_queue(&rdp->barrier_head);
>>>   rcu_nocb_lock(rdp);
>>> -    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>>> +    /*
>>> +     * Flush the bypass list, but also wake up the GP thread as otherwi=
se
>>> +     * bypass/lazy CBs maynot be noticed, and can cause real long delay=
s!
>>> +     */
>>> +    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_WA=
KE));
>>=20
>> This fixes an issue that goes beyond lazy implementation. It should be do=
ne
>> in a separate patch, handling rcu_segcblist_entrain() as well, with "Fixe=
s: " tag.
>=20
> I wanted to do that, however on discussion with
> Paul I thought of making this optimization only for
> all lazy bypass CBs. That makes it directly related
> this patch since the laziness notion is first
> introduced here. On the other hand I could make
> this change in a later patch since we are not
> super bisectable anyway courtesy of the last
> patch (which is not really an issue if the CONFIG
> is kept off during someone=E2=80=99s bisection.

Or are we saying it=E2=80=99s worth doing the wake up for rcu barrier even f=
or regular bypass CB? That=E2=80=99d save 2 jiffies on rcu barrier. If we ag=
ree it=E2=80=99s needed, then yes splitting the patch makes sense.

Please let me know your opinions, thanks,

 - Joel




>=20
>> And then FLUSH_BP_WAKE is probably not needed anymore.=20
>=20
> It is needed as the API is in tree_nocb.h and we
> have to have that handle the details of laziness
> there rather than tree.c. We could add new apis
> to get rid of flag but it=E2=80=99s cleaner (and Paul seemed
> to be ok with it).
>=20
>>>   if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>>>       atomic_inc(&rcu_state.barrier_cpu_count);
>>>   } else {
>>> @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rd=
p, int waketype,
>>>   raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>>>=20
>>>   /*
>>> -     * Bypass wakeup overrides previous deferments. In case
>>> -     * of callback storm, no need to wake up too early.
>>> +     * Bypass wakeup overrides previous deferments. In case of
>>> +     * callback storm, no need to wake up too early.
>>>    */
>>> -    if (waketype =3D=3D RCU_NOCB_WAKE_BYPASS) {
>>> +    if (waketype =3D=3D RCU_NOCB_WAKE_LAZY
>>> +        && READ_ONCE(rdp->nocb_defer_wakeup) =3D=3D RCU_NOCB_WAKE_NOT) {=

>>=20
>> This can be a plain READ since ->nocb_defer_wakeup is only written under -=
>nocb_gp_lock.
>=20
> Yes makes sense, will do.
>=20
>>> +        mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
>>> +        WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>>> +    } else if (waketype =3D=3D RCU_NOCB_WAKE_BYPASS) {
>>>       mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>>>       WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>>>   } else {
>>> @@ -512,9 +598,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *r=
dp, bool was_alldone,
>>>   }
>>>   // Need to actually to a wakeup.
>>>   len =3D rcu_segcblist_n_cbs(&rdp->cblist);
>>> +    bypass_len =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>> +    lazy_len =3D READ_ONCE(rdp->lazy_len);
>>>   if (was_alldone) {
>>>       rdp->qlen_last_fqs_check =3D len;
>>> -        if (!irqs_disabled_flags(flags)) {
>>> +        // Only lazy CBs in bypass list
>>> +        if (lazy_len && bypass_len =3D=3D lazy_len) {
>>> +            rcu_nocb_unlock_irqrestore(rdp, flags);
>>> +            wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
>>> +                       TPS("WakeLazy"));
>>=20
>> I'm trying to think of a case where rcu_nocb_try_bypass() returns false
>> (queue to regular list) but then call_rcu() -> __call_rcu_nocb_wake() end=
s up
>> seeing a lazy bypass queue even though we are queueing a non-lazy callbac=
k
>> (should have flushed in this case).
>>=20
>> Looks like it shouldn't happen, even with concurrent (de-offloading) but j=
ust
>> in case, can we add:
>=20
> Yes I also feel this couldn=E2=80=99t happen because irq is
> off and nocb lock is held throughout the calls to
> the above 2 functions. Unless I missed the race
> you=E2=80=99re describing?
>=20
>>=20
>>     WARN_ON_ONCE(lazy_len !=3D len)
>=20
> But this condition can be true even in normal
> circumstances? len also contains DONE CBs
> which are ready to be invoked. Or did I miss
> something?
>=20
> Thanks,
>=20
>  - Joel
>=20
>>=20
>>> +        } else if (!irqs_disabled_flags(flags)) {
>>>           /* ... if queue was empty ... */
>>>           rcu_nocb_unlock_irqrestore(rdp, flags);
>>>           wake_nocb_gp(rdp, false);
>>=20
>> Thanks.
