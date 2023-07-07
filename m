Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F6EB64D9
	for <rcu@archiver.kernel.org>; Fri,  7 Jul 2023 19:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjGGT3n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Jul 2023 15:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjGGT1n (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Jul 2023 15:27:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3F426B0
        for <rcu@vger.kernel.org>; Fri,  7 Jul 2023 12:25:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76754b9eac0so208553385a.0
        for <rcu@vger.kernel.org>; Fri, 07 Jul 2023 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1688757910; x=1691349910;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+r3jktYVc7BJ0t7RIvh+DPkaX+O9am5ilz167T+8Rw=;
        b=VksFiZLUMkRUpHwPfLwxO749mxs+riqT1fz/v77lK8YECz2jLXyeBn36G1BTzde71m
         inTJDBVSJy+4wRdAg9ThlFwOCDK+wsUjCHVejqJ3AWaJ4XD6jA/KEb2XIgKfEoQIKcn3
         hFPQMjfsrUT00FQ7KEPSGGVRmabgmg1Xq6ypk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688757910; x=1691349910;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+r3jktYVc7BJ0t7RIvh+DPkaX+O9am5ilz167T+8Rw=;
        b=WIDVP9oF5gTVtVnmzxiOYkKpABcrW9lSRsO5LITjfRv3Gc8/Af2p+FewCNS+CzrOsN
         mF41kvqVGn+nFiLje4L3+wrtDvdbCFxHEn1WWEEyjsxw913JHbOR61wWk55qZ425OuRh
         BcWR5SgVGehUKCLaYxvK25WcMtH0wTpzRTDm3IcMHDZ78TQKkrfNJmg0anG6e2O1rlcL
         6hp1PrF87jX+j2lDXMgD8k0x8/cwlzONqB7666LbX+nj/6ZXKarrJeaE2WRCG8gPE6Q+
         YY/zwvpxTaLpUYZlqbKqqCRTXa77d2+BHaJBgSsmHxOCeVEiwFqC2JiWlaflieV5xDSP
         OrTg==
X-Gm-Message-State: ABy/qLbErf4tPJ4MorE+V1FIWG7DbZm5md9pddkbUOosd3v10KofFgzI
        PGPzVCnEVYz1gPYpt8YtokODbtF0sZ/ZUNTiZI8=
X-Google-Smtp-Source: APBJJlGdt9CR1Br+OTI2jKF07n0KLFWGh5RQtRs6GLBBfCJFzu9aHwdJgrx+H0iU0UDJuixZQMchUw==
X-Received: by 2002:a05:620a:28c4:b0:767:3b7d:687c with SMTP id l4-20020a05620a28c400b007673b7d687cmr7479809qkp.15.1688757909831;
        Fri, 07 Jul 2023 12:25:09 -0700 (PDT)
Received: from smtpclient.apple ([45.85.144.223])
        by smtp.gmail.com with ESMTPSA id ou30-20020a05620a621e00b00754b7ee6922sm2131293qkn.9.2023.07.07.12.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 12:25:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Date:   Fri, 7 Jul 2023 15:24:58 -0400
Message-Id: <140FCD95-052F-4DA9-AA5A-374D417490A9@joelfernandes.org>
References: <b3a22928-6537-ebca-d9c2-82d2f940208f@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b3a22928-6537-ebca-d9c2-82d2f940208f@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jul 7, 2023, at 10:56 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> =EF=BB=BFOn 7/7/23 10:07, Davidlohr Bueso wrote:
>>> On Thu, 06 Jul 2023, Waiman Long wrote:
>>>=20
>>> It was found that running the refscale test might sometimes crash the
>>> kernel with the following error:
>>>=20
>>> [ 8569.952896] BUG: unable to handle page fault for address: fffffffffff=
fffe8
>>> [ 8569.952900] #PF: supervisor read access in kernel mode
>>> [ 8569.952902] #PF: error_code(0x0000) - not-present page
>>> [ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
>>> [ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
>>> [ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.=
4 05/28/2021
>>> [ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
>>>  :
>>> [ 8569.952940] Call Trace:
>>> [ 8569.952941]  <TASK>
>>> [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
>>> [ 8569.952959]  kthread+0x10e/0x130
>>> [ 8569.952966]  ret_from_fork+0x1f/0x30
>>> [ 8569.952973]  </TASK>
>>>=20
>>> This is likely caused by the fact that init_waitqueue_head() is called
>>> after the ref_scale_reader kthread is created. So the kthread may try
>>> to use the waitqueue head before it is properly initialized. Fix this
>>> by initializing the waitqueue head first before kthread creation.
>>>=20
>>> Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read=
-side synchronization")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>=20
>> Strange this wasn't reported sooner.
>=20
> Red Hat does have a pretty large QE organization that run all sort of test=
s include this one pretty frequently. The race window is pretty small, but t=
hey did hit this once in a while.

Having worked on this test initially, I am happy to hear that Redhat runs th=
is test!

Thanks for fixing this issue.
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

-Joel

>=20
> Cheers,
> Longman
>=20
