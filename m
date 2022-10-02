Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA6EC433F5
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 16:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJBQa5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJBQa4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 12:30:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C12432D94
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 09:30:54 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id h10so4061181qvq.7
        for <rcu@vger.kernel.org>; Sun, 02 Oct 2022 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=I75huk9mSVXf8ngfO1HIO55b/F7ADBttuvkXfsGzZIk=;
        b=YHLnyIOzFW/svsPKQYYCJ7D2bzrnxfneXWJrvu2Xld12DTCShfhOrBNwlckMmxqMrN
         XewFqUPidT5OpVK04DofeRCf//I9crUWEM8sHfUwQMeedKLlWKu8Cmqmi2+1brH4wogQ
         hycBHnAfTjzlRCyfk3Jaz7BZw5N362h/KFAIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I75huk9mSVXf8ngfO1HIO55b/F7ADBttuvkXfsGzZIk=;
        b=k8w0oat6TyaDJxCdZAMB8sowv5H7zKXXvYyz07liUYjDhZTVkN5p9NH8UO+nCbtdzX
         XUkfuQMpHTYrc4RN6x5t+kOJUrM+NCjFowKaA8jdZUe6Zdt6eY4pVgmqQCHVbAfz+Hag
         mBXq/TtAf0gnIy5KLxKH3UZJmqbxNiDrmTKjqpiZx9QPUYTAQwopdunkhuK57clWnehD
         jLzXEYleaIZ5LI/Yyz2UwWNpXCQVkEeY0sV2b3CDxJPqx+ATMJyA84IjdrdpG1tha8dR
         1J1G12rpqkJrGtZgrbvGeE/WluxzvY5oRFMAdf6TnKitkHbc6RtsOv8MFDh/TAjX3WFb
         fjDw==
X-Gm-Message-State: ACrzQf0Z1tG4tGA5PBWTMIDR6LbRaPXUaT+M5kk/lYmfz4MigLs97KL9
        TjZBhoJWI0xCMND+ld9iaKAlMQ==
X-Google-Smtp-Source: AMsMyM7LJ2h5ytxnXMs6dAqOOkDDqqr3n7HNFdH8wG6N3HHgdckJ5tP6LJYpk6jBeoyFDolWVa2FyQ==
X-Received: by 2002:ad4:5b89:0:b0:4af:8f27:6aca with SMTP id 9-20020ad45b89000000b004af8f276acamr13639724qvp.58.1664728253660;
        Sun, 02 Oct 2022 09:30:53 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id b19-20020ac86793000000b0035bbb6268e2sm6974029qtp.67.2022.10.02.09.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:30:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
Date:   Sun, 2 Oct 2022 12:30:52 -0400
Message-Id: <23461472-D3B0-448F-8819-F3F23C285E3B@joelfernandes.org>
References: <20221002162442.GT4196@paulmck-ThinkPad-P17-Gen-1>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <20221002162442.GT4196@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Oct 2, 2022, at 12:24 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Sun, Oct 02, 2022 at 12:11:07PM -0400, Joel Fernandes wrote:
>>=20
>>=20
>>> On 10/2/2022 10:06 AM, Pingfan Liu wrote:
>>> On Fri, Sep 30, 2022 at 9:04 PM Joel Fernandes <joel@joelfernandes.org> w=
rote:
>>>>=20
>>>> On Thu, Sep 29, 2022 at 4:21 AM Pingfan Liu <kernelfans@gmail.com> wrot=
e:
>>>>>=20
>>>>> On Thu, Sep 29, 2022 at 4:19 PM Pingfan Liu <kernelfans@gmail.com> wro=
te:
>>>>>>=20
>>>>> [...]
>>>>>> "
>>>>>>=20
>>>>>> I have no idea whether this is related to the reverted commit.
>>>>>>=20
>>>>>=20
>>>>> I have started another test against clean v6.0-rc7 to see whether this=

>>>>> is an issue with the mainline.
>>>>=20
>>>> I am not sure what exactly you are reverting (you could clarify that),
>>>=20
>>> commit 96926686deab ("rcu: Make CPU-hotplug removal operations enable ti=
ck").
>>> But due to conflict, "git revert" can not work directly. So I applied
>>> it by hand.
>>>=20
>>>> but if you are just removing the entire TICK_DEP_BIT_RCU, I do
>>>> remember (and mentioned on IRC to others recently) that without this
>>>> NOHZ_FULL has a hard time ending grace-periods because the forcing of
>>>> tick is needed for this configuration if we are spinning in the kernel
>>>> with the tick turned off. That seems to align with your TREE04
>>>> (NOHZ_FULL) configuration.
>>>>=20
>>>=20
>>> Yes, that is the scenario.
>>>=20
>>>> Also, the commit Frederic suggested to revert seems to be a cosmetic
>>>> optimization in the interrupt-entry path. That should not change
>>>> functionality I believe. So I did not fully follow why reverting that
>>>> is relevant (maybe Frederic can clarify?).
>>>>=20
>>>=20
>>> Leave this question to Frederic.
>>=20
>> I take this comment back, Sorry. Indeed the commits Frederic mentioned wi=
ll make
>> a functional change to CPU hotplug path.
>>=20
>> Sorry for the noise.
>>=20
>> Excited to see exact reason why TICK_DEP_BIT_RCU matters in the hotplug p=
aths. I
>> might jump into the investigation with you guys, but I have to make time f=
or
>> Lazy-RCU v7 next :)
>=20
> One historical reason was that a nohz_full CPU could enter the kernel with=

> the tick still disabled, and stay that way indefinitely.  Among other
> things, this can interfere with the grace-period wait in the offlining
> code path.

Thanks for clarification/confirmation, that was my hunch as well. Does the e=
mergency forcing on of the tick not suffice for that? If I understand you ar=
e sending an IPI to set the same tick dependency if grace periods are being h=
eld too long. Another potential fix instead of setting tick dependency in ho=
tplug, then, could be to reduce the time before which emergency IPIs are sen=
t to free up nohz_full CPUs, I think.

Thanks!

- Joel=20

>=20
>                            Thanx, Paul
