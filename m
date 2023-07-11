Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E3EB64DC
	for <rcu@archiver.kernel.org>; Tue, 11 Jul 2023 14:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGKO4b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Jul 2023 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGKO4b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Jul 2023 10:56:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594EA1BB;
        Tue, 11 Jul 2023 07:56:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8b4749013so42912445ad.2;
        Tue, 11 Jul 2023 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689087390; x=1691679390;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IM+8krr282TJ9jkeSkH/xfl6WQhKCsC0fTHhVCr1Hs=;
        b=fSMpw7cFdMRrTSl/izwwZ2BmnsMhWc8RdftnI+SL0qjDsiIBdx8hUzOap5Q5jjLnbm
         mMwda23OkgzKwV3cV/YZiVZuyT5sKm86d3sdsxZt5hN4U5KSUuTdG8ufH1VXTBZxunEA
         /1ha9a9ixKby4ODm26QEslil8ycilj6AABb+svPjNAZO1Kja02JBnTjOJUwhjU9jNTze
         xJqlSqwaQAqz0ZWBeBBSZePtAGpAJ8q4i3MCkwTn0a4WlhwLRDk6Mofs0PC8V9LoDRmt
         e2iKBAEkm08GW1fPXNp+eH5HzBaP+k/xST/qoTA77xNvDV7GDMQftQm1thPce2z6KJYF
         f52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689087390; x=1691679390;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IM+8krr282TJ9jkeSkH/xfl6WQhKCsC0fTHhVCr1Hs=;
        b=jOr/cJS5dmSK1zI4LVcf5O4qNdpLjfXNaAFWTikDtIaxV8OP1A/WXbCYO6+2R9ZDN5
         iWsA/HGzdfX+cAb7/Su82ApxToli7Ox8m4VCm3+Vmh0L/dmS+TyAV1UC5LnT1G2z/x7A
         9UKdWjFUtCdKnLSzePTsSfEkb3VlieDo+oapkMb3OOYFXT6wog8kfgRS61HY16ZBn+Is
         PhnHQlXDXPmrut/nmPLQ+kLZZ2WmPJzva4XB2jUv3sMm9YYMf2gJw9C/m1RzVPbkiRS2
         MjHsjBzm47Wi5fjc1PDrvs9ThamMcvGlrZVYv7g8/oWIh0Aa0ZkwpSsP+E61bSQHmoww
         Rd3g==
X-Gm-Message-State: ABy/qLYlyiWNPqfiK/YPoSmBDi7lAYt5UUA+2qMkm+z5fMQVxh1X0fOC
        I0L6lBR+z5GGpjZ8yjDa64E=
X-Google-Smtp-Source: APBJJlFWeHNpHfTFc6p1q5qt2nCi3ITvRRKleR1HYDb3smrvoJEkUb+v22l/r+Gk0vY+AJ2Ql+o/HQ==
X-Received: by 2002:a17:902:d395:b0:1b9:be2e:2b40 with SMTP id e21-20020a170902d39500b001b9be2e2b40mr14431834pld.50.1689087389729;
        Tue, 11 Jul 2023 07:56:29 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001b8062c1db3sm2026892pll.82.2023.07.11.07.56.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:56:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 1/2] rcu: Use WRITE_ONCE() for assignments to ->next for
 rculist_nulls
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <6563b226-0cbe-4600-be68-2748048cec78@paulmck-laptop>
Date:   Tue, 11 Jul 2023 22:56:02 +0800
Cc:     Joel Fernandes <joel@joelfernandes.org>, frederic@kernel.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        josh@joshtriplett.org, boqun.feng@gmail.com, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4179F0C7-D2A8-42A5-AF29-22949ADA15C0@gmail.com>
References: <20230706102849.437687-1-mmpgouride@gmail.com>
 <20230706102849.437687-2-mmpgouride@gmail.com>
 <CAEXW_YShqCHHH9Q1icU=oGBbeHO+a1PTY-Q-+KbqVdTm8mR3cw@mail.gmail.com>
 <6563b226-0cbe-4600-be68-2748048cec78@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8811=E6=97=A5 04:30=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Jul 10, 2023 at 04:01:07PM -0400, Joel Fernandes wrote:
>> On Thu, Jul 6, 2023 at 6:29=E2=80=AFAM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>>=20
>>> When the objects managed by rculist_nulls are allocated with
>>> SLAB_TYPESAFE_BY_RCU, readers may still hold references to this
>>> object that is being added, which means the modification of ->next
>>> is visible to readers. So, this patch uses WRITE_ONCE() for =
assignments
>>> to ->next.
>>>=20
>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>>> ---
>>> include/linux/rculist_nulls.h | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/include/linux/rculist_nulls.h =
b/include/linux/rculist_nulls.h
>>> index ba4c00dd8005..89186c499dd4 100644
>>> --- a/include/linux/rculist_nulls.h
>>> +++ b/include/linux/rculist_nulls.h
>>> @@ -101,7 +101,7 @@ static inline void =
hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
>>> {
>>>        struct hlist_nulls_node *first =3D h->first;
>>>=20
>>> -       n->next =3D first;
>>> +       WRITE_ONCE(n->next, first);
>>>        WRITE_ONCE(n->pprev, &h->first);
>>>        rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
>>>        if (!is_a_nulls(first))
>>> @@ -137,7 +137,7 @@ static inline void =
hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>>>                last =3D i;
>>>=20
>>>        if (last) {
>>> -               n->next =3D last->next;
>>> +               WRITE_ONCE(n->next, last->next);
>>>                n->pprev =3D &last->next;
>>>                rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>>>        } else {
>>=20
>> Don't you need READ_ONCE() for the read-side accesses as well?
>=20
> Both hlist_nulls_for_each_entry_rcu() and =
hlist_nulls_for_each_entry_safe()
> use rcu_dereference_raw().  To your point, both =
hlist_nulls_first_rcu()
> and hlist_nulls_next_rcu() look rather strange.  I would have expected
> them to also use rcu_dereference_raw().

hlist_nulls_first_rcu() and hlist_nulls_next_rcu() were added in commit:

	67bdbffd696f(=E2=80=9Crculist: avoid __rcu annotations=E2=80=9D)

According to the commit message, this avoids warnings from missing __rcu =
annotations.

>=20
> Thanx, Paul

