Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A546C4332F
	for <rcu@archiver.kernel.org>; Sun, 27 Nov 2022 14:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiK0Oq7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 27 Nov 2022 09:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiK0Oq6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 27 Nov 2022 09:46:58 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D2C76F
        for <rcu@vger.kernel.org>; Sun, 27 Nov 2022 06:46:53 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id i9so5622003qkl.5
        for <rcu@vger.kernel.org>; Sun, 27 Nov 2022 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEezDp2/CAz1AaXs6aBbEArqHYSSyKjPu0NNTuAIJII=;
        b=Qh8CK/KwTIvjWpvUqQoVUXOh/PrDkYn+/GNRLiLaD+W8bE6LofakBFhWGZ0lhFQkPf
         A6iEPnlNIYDvBBaY9zVZ7M8NIimmswGJPZ2Vk2NsSDCCgW8ydUKz5psqHittGem1TYF5
         MMZ8lvR0EwhMq8kXhEtJEG2Uo9CJ2Hwc7/aMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEezDp2/CAz1AaXs6aBbEArqHYSSyKjPu0NNTuAIJII=;
        b=1MxDQIEpXx1JMprgPK4+jib5pXwWa+UAHYBIpft+qxfJWRKXkSCSeEycA1wUG+aSWs
         dC/+Tm1G7V5aFWOqMcLn0LhnNnWgP1EWckoy93UCOHDJHTOmRndAUzQ9js65qN7nqiaP
         4CST0PDWPf8jLdtKnHh0Auc3grFhSgzI1Uur/7rax4ao9WxmW6OT4v7NuYX1CGYJlOcQ
         gRMuUWR7UT1H0MxPHsx/f7c6zf00KqsSClqqdW9QZrIbDdpyDWzxd+sObXSux2ltpz2E
         xnDjLk6AsWSlxsTbqZZlY+2cacDjRXRQpNJzw5AyjWxx/F74ZrgrVN93PZ7QWcuGUu0s
         jyEQ==
X-Gm-Message-State: ANoB5pma4j/pwkt94CtCeDFD+i1CfMpLAgci5iSM4c4d6HOqXbIrPVyN
        5mprPI8AOQEojI8tnya4mB6eHRha6c3b3A==
X-Google-Smtp-Source: AA0mqf4qkVrRYyNuPY4UXFt0r/YtkxqEBsMGeiGU7RtsQUaxJS9Gjvqemy+US7MxtgXrqaKKUpnHnA==
X-Received: by 2002:a37:503:0:b0:6fb:c3b3:a937 with SMTP id 3-20020a370503000000b006fbc3b3a937mr32386275qkf.34.1669560412664;
        Sun, 27 Nov 2022 06:46:52 -0800 (PST)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bk11-20020a05620a1a0b00b006fbdb9d04b1sm6516333qkb.40.2022.11.27.06.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 06:46:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than snap in srcu_funnel_gp_start()
Date:   Sun, 27 Nov 2022 09:46:51 -0500
Message-Id: <C6E05D66-7426-4654-8551-296EE01646C2@joelfernandes.org>
References: <20221126180704.GA3269129@paulmck-ThinkPad-P17-Gen-1>
Cc:     Pingfan Liu <kernelfans@gmail.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221126180704.GA3269129@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Nov 26, 2022, at 1:07 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Sat, Nov 26, 2022 at 10:03:52AM -0800, Paul E. McKenney wrote:=

>>> On Fri, Nov 25, 2022 at 08:37:03PM +0800, Pingfan Liu wrote:
>>> On Thu, Nov 24, 2022 at 08:19:26AM -0800, Paul E. McKenney wrote:
>>>> On Wed, Nov 23, 2022 at 09:24:17PM -0800, Paul E. McKenney wrote:
>>>>> On Thu, Nov 24, 2022 at 12:06:39PM +0800, Pingfan Liu wrote:
>>>>>> On Thu, Nov 24, 2022 at 11:33 AM Pingfan Liu <kernelfans@gmail.com> w=
rote:
>>>>>>> On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
>>>>>>>> On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
>>>>>>>>> Since the srcu read lock is still held during srcu_funnel_gp_start=
(),
>>>>>>>>> the seq snap should be the largest number for the slot
>>>>>>>>> srcu_have_cbs[idx].
>>>>>>>>>=20
>>>>>>>>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>>>>>>>>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>>>>>>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>>>>>>> Cc: Frederic Weisbecker <frederic@kernel.org>
>>>>>>>>> Cc: Josh Triplett <josh@joshtriplett.org>
>>>>>>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>>>>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>>>>>> To: rcu@vger.kernel.org
>>>>>>>>> ---
>>>>>>>>> include/linux/rcupdate.h |  1 +
>>>>>>>>> kernel/rcu/srcutree.c    | 11 ++++++-----
>>>>>>>>> 2 files changed, 7 insertions(+), 5 deletions(-)
>>>>>>>>>=20
>>>>>>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>>>>>>>> index 08605ce7379d..a09007236660 100644
>>>>>>>>> --- a/include/linux/rcupdate.h
>>>>>>>>> +++ b/include/linux/rcupdate.h
>>>>>>>>> @@ -32,6 +32,7 @@
>>>>>>>>> #include <linux/context_tracking_irq.h>
>>>>>>>>>=20
>>>>>>>>> #define ULONG_CMP_GE(a, b) (ULONG_MAX / 2 >=3D (a) - (b))
>>>>>>>>> +#define ULONG_CMP_GT(a, b) (ULONG_MAX / 2 > (a) - (b))
>>>>>>>>=20
>>>>>>>> Please see below...
>>>>>>>>=20
>>>>>>>>> #define ULONG_CMP_LT(a, b) (ULONG_MAX / 2 < (a) - (b))
>>>>>>>>> #define ulong2long(a)              (*(long *)(&(a)))
>>>>>>>>> #define USHORT_CMP_GE(a, b)        (USHRT_MAX / 2 >=3D (unsigned s=
hort)((a) - (b)))
>>>>>>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>>>>>>>> index 2fc0e775ade4..41902b823687 100644
>>>>>>>>> --- a/kernel/rcu/srcutree.c
>>>>>>>>> +++ b/kernel/rcu/srcutree.c
>>>>>>>>> @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu=
_struct *ssp, struct srcu_data *sdp,
>>>>>>>>>            for (snp =3D snp_leaf; snp !=3D NULL; snp =3D snp->srcu=
_parent) {
>>>>>>>>>                    spin_lock_irqsave_rcu_node(snp, flags);
>>>>>>>>>                    snp_seq =3D snp->srcu_have_cbs[idx];
>>>>>>>>> -                   if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_G=
E(snp_seq, s)) {
>>>>>>>>> +                   /*
>>>>>>>>> +                    * s should be the biggest in the current slot=
. Hence only LE is
>>>>>>>>> +                    * valid
>>>>>>>>> +                    */
>>>>>>>>> +                   BUG_ON(ULONG_CMP_GT(snp_seq, s));
>>>>>>>>=20
>>>>>>>> Why not this?  (Plus adjusting the comment above, of course.)
>>>>>>>>=20
>>>>>>>>                      WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
>>>>>>>>=20
>>>>>>>=20
>>>>>>> A neat solution!
>>>>>>>=20
>>>>>>> And what about the comment
>>>>>>>                        /* s should be the biggest in the current slo=
t. */
>>>>>>>=20
>>>>>>>> That way we don't need ULONG_CMP_GT().  Plus if we are confused abo=
ut
>>>>>>>> s being the biggest in the current slot, we get a splat and can deb=
ug
>>>>>>>> further.  We both might be quite sure that we are not confused, but=

>>>>>>>> that is exactly when we are most prone to making mistakes.  ;-)
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Same feeling :)
>>>>>>>=20
>>>>>>>> I also ask that you run with this check for some time.  After all, i=
f
>>>>>>=20
>>>>>> Forget to ask if  the test
>>>>>>  "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
>>>>>> 10h --configs 18*SRCU-P"
>>>>>> satisfies your requirement?
>>>>>=20
>>>>> I am thinking more in terms of adding the WARN_ON_ONCE(), letting it b=
e
>>>>> in -next and possibly mainline for a couple of years, and then if ther=
e
>>>>> are no splats, start feeling more confident in the asserted relationsh=
ip.
>>>>>=20
>>>>> If there was a significant performance, scalability, energy-efficiency=
, or
>>>>> simplification benefit, I would feel justified in being more aggressiv=
e.
>>>>>=20
>>>>> But I am not seeing a significant benefit.
>>>>=20
>>>> Ah, and before I forget -again-, have you thought through the counter-w=
rap
>>>> scenarios?  Please keep in mind that on a 32-bit system, those counters=

>>>> can wrap quite quickly compared to typical uptimes.
>>>=20
>>> I think 32-bit has not significant different since the statement
>>>  WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
>>>=20
>>> where 's < snp_seq' is not associated with bits. Am I missing anything?
>>=20
>> Your point is that long before there was any danger of wrap, this
>> WARN_ON_ONCE() would trigger?
>>=20
>> If so, the point is to avoid that WARN_ON_ONCE() from triggering.
>>=20
>> Or am I missing your point?
>=20
> For example, are you instead saying that the WARN_ON_ONCE() proposed in
> your patch will detect the problem either way?  If so, what I am asking
> is whether your earlier analysis considered wrap without the addition
> of that WARN_ON_ONCE().

Do we want to make some rules on when to delete WARNs and fold in the change=
, such as a future date after scanning the list for reports? Such date can b=
e embedded in a comment on top of the warning.

Thanks,

    - Joel

>                            Thanx, Paul
>=20
>>> Thanks,
>>>=20
>>>    Pingfan
>>>=20
>>>>                            Thanx, Paul
>>>>=20
>>>>>> Thanks
>>>>>>=20
>>>>>>    Pingfan
>>>>>>> Sure. I will try it immediately.
>>>>>>>=20
>>>>>>>> the assumption is incorrect, the resulting SRCU hangs off in variou=
s
>>>>>>>> systems around the world will not be so much fun to debug.
>>>>>>>>=20
>>>>>>>> Given that this is slowpath code, it is much better to take an extr=
a
>>>>>>>> compare and branch than to introduce even an extremely small risk o=
f
>>>>>>>> hanging SRCU.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Agree.
>>>>>>>=20
>>>>>>>=20
>>>>>>> Thanks,
>>>>>>>=20
>>>>>>>        Pingfan
>>>>>>>=20
>>>>>>>>                                                      Thanx, Paul
>>>>>>>>=20
>>>>>>>>> +                   if (!srcu_invl_snp_seq(snp_seq) && (snp_seq =3D=
=3D s)) {
>>>>>>>>>                            if (snp =3D=3D snp_leaf && snp_seq =3D=3D=
 s)
>>>>>>>>>                                    snp->srcu_data_have_cbs[idx] |=3D=
 sdp->grpmask;
>>>>>>>>>                            spin_unlock_irqrestore_rcu_node(snp, fl=
ags);
>>>>>>>>> -                           if (snp =3D=3D snp_leaf && snp_seq !=3D=
 s) {
>>>>>>>>> -                                   srcu_schedule_cbs_sdp(sdp, do_=
norm ? SRCU_INTERVAL : 0);
>>>>>>>>> -                                   return;
>>>>>>>>> -                           }
>>>>>>>>>                            if (!do_norm)
>>>>>>>>>                                    srcu_funnel_exp_start(ssp, snp,=
 s);
>>>>>>>>>                            return;
>>>>>>>>> --
>>>>>>>>> 2.31.1
>>>>>>>>>=20
