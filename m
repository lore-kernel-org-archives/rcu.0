Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA08EC433FE
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 16:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJBQ7d (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJBQ7c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 12:59:32 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5460D252B3
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 09:59:31 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id cj27so5287879qtb.7
        for <rcu@vger.kernel.org>; Sun, 02 Oct 2022 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=7pumZxrRLlldLJSMDfrFxMUDYNJ0LvsZ7shndwUezwg=;
        b=lm3kHcyHVbCMINn+NU5+Ui3d3Ea8+W8JMxMGOOwejcXKS7VUxWfxGl3W+33D9eT/yZ
         PIh6gp2z+EIufn7K9+HyrRbC3kvjOZ31uIphrOO1nZbaICj6HI2xIOTEGuUpxd6dm9UB
         7pUOIrn5wHA10uYZthvCYzGZu/2JrlkliNXr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7pumZxrRLlldLJSMDfrFxMUDYNJ0LvsZ7shndwUezwg=;
        b=ESDqNNbcEGacPFRDpiv68YYD/fqtnzYGljemO9FkDh9lvSNsl9jAkTF7/lTlhdVbS4
         itCHXHyrNzoORN/vIDRK5tFc06WzIBN5YGIO4tylwbDqrvsQvHdjP+nImLvU1EtcWEjB
         njmdjY16lIQsXmPp9qdvMhfA8DOlXusb0sBeDSzKawco416VvzUitB1lgEtiwVqH5THH
         yxsssZBPojQhMxSIosNROXu6a4wtQzxBS0LWvZLYAzFSdQmqGUBGEKJyNXV/yZVb2Mw7
         4APtX8PrlY9Lvrem2SybT6I7I1c1K+CwVCZmCRb8bzRqOHxtxdnizxmh7pIqRDS/zjDx
         Cxnw==
X-Gm-Message-State: ACrzQf3oOeiAKwiRNX0mQXDBHID7Q+BilTpS+sDSpy8tlVBz59d2MR8U
        zgGKCjPcCVZg4e58MLCDytEcWw==
X-Google-Smtp-Source: AMsMyM7+fLygsHKKvN/CKnMJYf6m7/OubeKYFJ8Cey76x3Wez7yAhKxcAiY113Gs0DAjzkXqtXycRQ==
X-Received: by 2002:a05:622a:138c:b0:35c:e9d2:8d76 with SMTP id o12-20020a05622a138c00b0035ce9d28d76mr13598556qtk.463.1664729970433;
        Sun, 02 Oct 2022 09:59:30 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id t21-20020a05620a451500b006cbdc9f178esm8718529qkp.25.2022.10.02.09.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:59:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
Date:   Sun, 2 Oct 2022 12:59:29 -0400
Message-Id: <E0988E86-3DC5-4CB5-B073-503A9214ED57@joelfernandes.org>
References: <20221002165749.GU4196@paulmck-ThinkPad-P17-Gen-1>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <20221002165749.GU4196@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Oct 2, 2022, at 12:57 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Sun, Oct 02, 2022 at 12:30:52PM -0400, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Oct 2, 2022, at 12:24 PM, Paul E. McKenney <paulmck@kernel.org> wrot=
e:
>>>=20
>>> =EF=BB=BFOn Sun, Oct 02, 2022 at 12:11:07PM -0400, Joel Fernandes wrote:=

>>>>=20
>>>>=20
>>>>> On 10/2/2022 10:06 AM, Pingfan Liu wrote:
>>>>> On Fri, Sep 30, 2022 at 9:04 PM Joel Fernandes <joel@joelfernandes.org=
> wrote:
>>>>>>=20
>>>>>> On Thu, Sep 29, 2022 at 4:21 AM Pingfan Liu <kernelfans@gmail.com> wr=
ote:
>>>>>>>=20
>>>>>>> On Thu, Sep 29, 2022 at 4:19 PM Pingfan Liu <kernelfans@gmail.com> w=
rote:
>>>>>>>>=20
>>>>>>> [...]
>>>>>>>> "
>>>>>>>>=20
>>>>>>>> I have no idea whether this is related to the reverted commit.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> I have started another test against clean v6.0-rc7 to see whether th=
is
>>>>>>> is an issue with the mainline.
>>>>>>=20
>>>>>> I am not sure what exactly you are reverting (you could clarify that)=
,
>>>>>=20
>>>>> commit 96926686deab ("rcu: Make CPU-hotplug removal operations enable t=
ick").
>>>>> But due to conflict, "git revert" can not work directly. So I applied
>>>>> it by hand.
>>>>>=20
>>>>>> but if you are just removing the entire TICK_DEP_BIT_RCU, I do
>>>>>> remember (and mentioned on IRC to others recently) that without this
>>>>>> NOHZ_FULL has a hard time ending grace-periods because the forcing of=

>>>>>> tick is needed for this configuration if we are spinning in the kerne=
l
>>>>>> with the tick turned off. That seems to align with your TREE04
>>>>>> (NOHZ_FULL) configuration.
>>>>>>=20
>>>>>=20
>>>>> Yes, that is the scenario.
>>>>>=20
>>>>>> Also, the commit Frederic suggested to revert seems to be a cosmetic
>>>>>> optimization in the interrupt-entry path. That should not change
>>>>>> functionality I believe. So I did not fully follow why reverting that=

>>>>>> is relevant (maybe Frederic can clarify?).
>>>>>>=20
>>>>>=20
>>>>> Leave this question to Frederic.
>>>>=20
>>>> I take this comment back, Sorry. Indeed the commits Frederic mentioned w=
ill make
>>>> a functional change to CPU hotplug path.
>>>>=20
>>>> Sorry for the noise.
>>>>=20
>>>> Excited to see exact reason why TICK_DEP_BIT_RCU matters in the hotplug=
 paths. I
>>>> might jump into the investigation with you guys, but I have to make tim=
e for
>>>> Lazy-RCU v7 next :)
>>>=20
>>> One historical reason was that a nohz_full CPU could enter the kernel wi=
th
>>> the tick still disabled, and stay that way indefinitely.  Among other
>>> things, this can interfere with the grace-period wait in the offlining
>>> code path.
>>=20
>> Thanks for clarification/confirmation, that was my hunch as well. Does th=
e emergency forcing on of the tick not suffice for that? If I understand you=
 are sending an IPI to set the same tick dependency if grace periods are bei=
ng held too long. Another potential fix instead of setting tick dependency i=
n hotplug, then, could be to reduce the time before which emergency IPIs are=
 sent to free up nohz_full CPUs, I think.
>=20
> Why not try modifying it to work this way and seeing what (if anything)
> breaks?  If nothing breaks, then there is still the option of digging
> into the code.

Yes happy to try :)

>=20
> In both cases, after Lazy-RCU v7, of course.  ;-)

Sounds good and thanks for understanding ;)

Thanks,

 - Joel

>=20
>                                Thanx, Paul
