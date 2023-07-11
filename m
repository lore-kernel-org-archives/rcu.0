Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFEFEB64DD
	for <rcu@archiver.kernel.org>; Tue, 11 Jul 2023 14:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGKOwg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Jul 2023 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjGKOwf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Jul 2023 10:52:35 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB8D10E7;
        Tue, 11 Jul 2023 07:52:32 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-783698a37beso280055539f.0;
        Tue, 11 Jul 2023 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689087152; x=1691679152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLVFhHoBtig8GCr22bJk9AEngJBeUGKsMulOkrSe5Gc=;
        b=Iv39Rzmp53QvUwlG2Olxo34e7umnQOcmiBPBXA6NtmIj2ALDPYdmcgafUj1yKl0rel
         0fqgtmCblWn5XLvfoFY5o2x2sERs3Vz+I4w/LXIFXiWXV2Q+zqqR4pKqL4Q1VcRIjEA6
         bYPoUiOT/USKNzevXg/dToUT0FNfZmaaOl8cHJMZn+tM3gap3z2Pj7kzHS7w+7dWUWPn
         lOrya6VVONAHFbla8oZad1ogMI1MMqDkzqK6KGhvX/i7jZiXb8T0b2wiCbMBIHC7nIHN
         ntWrEtE+HHNfhopb3p++3+EsS7Hoxd0mBkQ2bZWOZ/vAI0m6sdhnfPpOoD44Upo81Tw+
         4GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689087152; x=1691679152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLVFhHoBtig8GCr22bJk9AEngJBeUGKsMulOkrSe5Gc=;
        b=KclTV8P2JfcoTacjEivD+5MqSr4ucB1ZlpTuvmLC/cLgKTl39gbulogsfA8jYKz4rR
         +oejsGdoo2J9sWjnrUr/zry+pqorZnlX7ivLI5Cg1h9Muy4UWQTOpZvfzsmPNvZw9oZu
         HrpOpJLYdMPyMeIWb8AVeT7dlGI6/p606Zu22IABtQUtvSKKNMwUMcJP35RvT+hGIHXW
         7mnweezswcGYmL4aTK5vxtRZnwGGibQPjoCFcg0GbsgOf308ZMoDVlEZ56zFDQpbxTdB
         IG/O2MlQPxLfJbSh10TtEvYJMGeMNI1HTyAa4w8L2MWaBc7R59Q7RmhmnWI01GWMnwoc
         ZifQ==
X-Gm-Message-State: ABy/qLZF1MgxLUc2fbx2CwKJkQLhhTUUj0zqZY/2pvzLg6t6GaaC3xjl
        y/CNlaRACAZbp8Qlr9JydFo=
X-Google-Smtp-Source: APBJJlF84v9Ld1nDEt2s2wVt5R0ypDFTOMav4D124dMZYRxSFHl4e9Ff496NThJgfi8+av1TxnLOEw==
X-Received: by 2002:a92:d385:0:b0:345:ed70:9a7e with SMTP id o5-20020a92d385000000b00345ed709a7emr16603477ilo.13.1689087151709;
        Tue, 11 Jul 2023 07:52:31 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001b9bebb7a9dsm2026724pld.90.2023.07.11.07.52.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:52:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 1/2] rcu: Use WRITE_ONCE() for assignments to ->next for
 rculist_nulls
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CAEXW_YShqCHHH9Q1icU=oGBbeHO+a1PTY-Q-+KbqVdTm8mR3cw@mail.gmail.com>
Date:   Tue, 11 Jul 2023 22:51:48 +0800
Cc:     paulmck@kernel.org, frederic@kernel.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        josh@joshtriplett.org, boqun.feng@gmail.com, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <184CFA4D-C925-40AD-8B80-A15E7D56940F@gmail.com>
References: <20230706102849.437687-1-mmpgouride@gmail.com>
 <20230706102849.437687-2-mmpgouride@gmail.com>
 <CAEXW_YShqCHHH9Q1icU=oGBbeHO+a1PTY-Q-+KbqVdTm8mR3cw@mail.gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8811=E6=97=A5 04:01=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 6, 2023 at 6:29=E2=80=AFAM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>=20
>> When the objects managed by rculist_nulls are allocated with
>> SLAB_TYPESAFE_BY_RCU, readers may still hold references to this
>> object that is being added, which means the modification of ->next
>> is visible to readers. So, this patch uses WRITE_ONCE() for =
assignments
>> to ->next.
>>=20
>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>> ---
>> include/linux/rculist_nulls.h | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/linux/rculist_nulls.h =
b/include/linux/rculist_nulls.h
>> index ba4c00dd8005..89186c499dd4 100644
>> --- a/include/linux/rculist_nulls.h
>> +++ b/include/linux/rculist_nulls.h
>> @@ -101,7 +101,7 @@ static inline void =
hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
>> {
>>        struct hlist_nulls_node *first =3D h->first;
>>=20
>> -       n->next =3D first;
>> +       WRITE_ONCE(n->next, first);
>>        WRITE_ONCE(n->pprev, &h->first);
>>        rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
>>        if (!is_a_nulls(first))
>> @@ -137,7 +137,7 @@ static inline void =
hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>>                last =3D i;
>>=20
>>        if (last) {
>> -               n->next =3D last->next;
>> +               WRITE_ONCE(n->next, last->next);
>>                n->pprev =3D &last->next;
>>                rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>>        } else {
>=20
> Don't you need READ_ONCE() for the read-side accesses as well?

Like Paul said, read-side uses rcu_dereference_raw()

>=20
> thanks,
>=20
> - Joel


