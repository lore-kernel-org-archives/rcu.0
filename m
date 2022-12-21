Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3512AC4332F
	for <rcu@archiver.kernel.org>; Wed, 21 Dec 2022 04:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiLUE02 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiLUE00 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Dec 2022 23:26:26 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA645E087
        for <rcu@vger.kernel.org>; Tue, 20 Dec 2022 20:26:24 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id pv25so9609702qvb.1
        for <rcu@vger.kernel.org>; Tue, 20 Dec 2022 20:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCgpNOZquvWN/9Ttvx6v+EBz7WzNJvsJWIJuT0Mli4o=;
        b=rsydt1487DQ+I36CTrPO9KN4tP5ytKwJD9mZbgEOkURy38DZoBqVFTo8J7Cr8nll8s
         huS0jz1y88YJVXoI06pAUoqTPxYiKPJlI1kDGDe6rV14henfbVsolzaxgq3ETm1Ia8tk
         XO4ugVh72EGwTa+BW87vcpOvfB0lDbb27iUkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCgpNOZquvWN/9Ttvx6v+EBz7WzNJvsJWIJuT0Mli4o=;
        b=QgDO5AH1jTyyYo3WYqhFL8QMqi22fO0hJEBXb4Qik/TZf/RAga/+/Ou6tK7zuCn4cq
         Vd/gqlmdgtHsPF7YKmvbW/4ZNu4XI3JpyMIX4C7nHUfjfhBk2p04VMGfuSoBCdm0iWtI
         aOQr1/w0dkNSO/n/oGWJoBx3A60DETDQqbmKeoy9pugYJUblJf9V4yE3xBAL7wyuapad
         kBLthyfSM9qgDEP+YXqCfo1bS9ONz8xEgmqozJ5OOxaQN6qe9w5IvU+1y8BJXNGyivgo
         45WEIdGPysEccXwSn01uvncTEmTLdTxKQIzoqq4W/BqfFLn5oD/sTLuUHjCf2+wkkp6K
         5ttQ==
X-Gm-Message-State: AFqh2krSqXsuAONvFQZBERy1Rw+GMOmXSEJjZGS2HiUKg7Iyf0BymFKa
        GcNpOJM3kLhAJVCqfBtxOMGtMA==
X-Google-Smtp-Source: AMrXdXuIgc10HzBZ3I3C3kZF2bbt5BV3lGXNCccWEyFVLPGrrgUNKt9Ho3ZiWcKwn7QLbLo2DCe47Q==
X-Received: by 2002:a0c:ed34:0:b0:4d8:42df:19d7 with SMTP id u20-20020a0ced34000000b004d842df19d7mr176862qvq.36.1671596783841;
        Tue, 20 Dec 2022 20:26:23 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id dm36-20020a05620a1d6400b006bbc3724affsm10030526qkb.45.2022.12.20.20.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 20:26:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Tue, 20 Dec 2022 23:26:12 -0500
Message-Id: <6BD506EA-77D2-4AC9-87A5-C8781594CF0F@joelfernandes.org>
References: <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 20, 2022, at 10:43 PM, Mathieu Desnoyers <mathieu.desnoyers@efficio=
s.com> wrote:
>=20
> =EF=BB=BFOn 2022-12-20 19:58, Frederic Weisbecker wrote:
>>> On Wed, Dec 21, 2022 at 01:49:57AM +0100, Frederic Weisbecker wrote:
>>> On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
>>>> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.or=
g> wrote:
>>>> Agreed about (1).
>>>>=20
>>>>> _ In (2), E pairs with the address-dependency between idx and lock_cou=
nt.
>>>>=20
>>>> But that is not the only reason. If that was the only reason for (2),
>>>> then there is an smp_mb() just before the next-scan post-flip before
>>>> the lock counts are read.
>>>=20
>>> The post-flip barrier makes sure the new idx is visible on the next READ=
ER's
>>> turn, but it doesn't protect against the fact that "READ idx then WRITE l=
ock[idx]"
>>> may appear unordered from the update side POV if there is no barrier bet=
ween the
>>> scan and the flip.
>>>=20
>>> If you remove the smp_mb() from the litmus test I sent, things explode.
>> Or rather, look at it the other way, if there is no barrier between the l=
ock
>> scan and the index flip (E), then the index flip can appear to be written=
 before the
>> lock is read. Which means you may start activating the index before you f=
inish
>> reading it (at least it appears that way from the readers pont of view).
>=20
> Considering that you can have pre-existing readers from arbitrary index ap=
pearing anywhere in the grace period (because a reader can fetch the
> index and be preempted for an arbitrary amount of time before incrementing=
 the lock count), the grace period algorithm needs to deal with the fact tha=
t a newcoming reader can appear in a given index either before or after the f=
lip.
>=20
> I don't see how flipping the index before or after loading the unlock/lock=
 values would break anything (except for unlikely counter overflow situation=
s as previously discussed).

If you say unlikely, that means it can happen some times which is bad enough=
 ;-). Maybe you mean impossible. I would not settle for anything less than k=
eeping the memory barrier around if it helps unlikely cases, but only D does=
 help for the theoretical wrapping/overflow issue. E is broken and does not e=
ven help the theoretical issue IMO. And both D and E do not affect correctne=
ss IMO.

Anyway in all likelihood, I will be trying to remove E completely and clarif=
y docs on D in the coming weeks. And also try to drop the size of the counte=
rs per our discussions

Thanks.



>=20
> Thanks,
>=20
> Mathieu
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>=20
