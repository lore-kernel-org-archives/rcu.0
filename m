Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8896EC678DB
	for <rcu@archiver.kernel.org>; Sun,  5 Mar 2023 12:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCEM4t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 5 Mar 2023 07:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjCEM4s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 5 Mar 2023 07:56:48 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2445410AB8
        for <rcu@vger.kernel.org>; Sun,  5 Mar 2023 04:56:47 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r16so6200836qtx.9
        for <rcu@vger.kernel.org>; Sun, 05 Mar 2023 04:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678021006;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2XDFrZbN2R3QrerdWbI2vAM5IjvoYd3LrvKIPWNBMM=;
        b=DwcsnVM/0wvDSVFvwkJg7MMwygBOl3ma1cPtNzXr1XVib4DICM6ylSyldpxox7oQe3
         QKajr5oX3v27f7YG4mlZYCSon9P7tfFcgclzhhjbenClPZ3daN7aV68XhGtu1hWazAeA
         wwSaWoosO4HCblQpg+mfiZ6c21tAiZtOr+jr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678021006;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2XDFrZbN2R3QrerdWbI2vAM5IjvoYd3LrvKIPWNBMM=;
        b=IKAcLN8yUYYadRBSiTf8k+/fGfzp+Eawmz63vwyAQWx1Ln2AU9fCi8d+slQgssOBms
         l5p8VcH24ZELqfr2l2UFXiXH+2gcnNymWZJgrJorUSTa4n72jDPGYVa8sRWLvFFI5/cU
         soRW1Aylpoz6jBiu702z6Nel6o/6uyfUFUe21aaa+vK4P0+uSCovCL8R7xi0BuFlRJJQ
         MPRQEvASR5/inBIKMiBLy/PHoMiHuuU7NczdJjLZPD1m1UBIet2pQM990xXEPy9GfGqr
         Loajsay3X52v4PlOK1c1ay9qcENJJ5Op4m9+pYaSGJxoAv+hPL1ExDaiYWeFkTzNz/jy
         iLnw==
X-Gm-Message-State: AO0yUKW2w0QRtkx0tIvgSTD1uOvpAI+K+IM/WkGimJFkRfD5FkbQbC8W
        tlwahKoSbNDg3tq5lOrEDQxYdw==
X-Google-Smtp-Source: AK7set96BMq3T6wQESxMr1hZ3PhBGzTnQewXdFI8luRoOSNMaoCJgqBzLjJv6DBKWxzKI70C3m24sw==
X-Received: by 2002:ac8:7f87:0:b0:3bf:daae:7ee6 with SMTP id z7-20020ac87f87000000b003bfdaae7ee6mr12426886qtj.18.1678021006206;
        Sun, 05 Mar 2023 04:56:46 -0800 (PST)
Received: from smtpclient.apple ([2600:1005:b003:394d:acb0:58:f50c:218b])
        by smtp.gmail.com with ESMTPSA id q25-20020a37f719000000b007343fceee5fsm5486765qkj.8.2023.03.05.04.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 04:56:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
Date:   Sun, 5 Mar 2023 07:56:33 -0500
Message-Id: <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
References: <ZAR//FKO4syzapk6@pc636>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
In-Reply-To: <ZAR//FKO4syzapk6@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Mar 5, 2023, at 6:41 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BF
>>=20
>>>> On Mar 5, 2023, at 5:29 AM, Joel Fernandes <joel@joelfernandes.org> wro=
te:
>>>=20
>>> =EF=BB=BFHi, All,
>>>=20
>>>> On Wed, Feb 1, 2023 at 10:11=E2=80=AFAM Uladzislau Rezki (Sony)
>>>> <urezki@gmail.com> wrote:
>>>>=20
>>>> For a single argument invocations a new kfree_rcu_mightsleep()
>>>> and kvfree_rcu_mightsleep() macroses are used. This is done in
>>>> order to prevent users from calling a single argument from
>>>> atomic contexts as "_mightsleep" prefix signals that it can
>>>> schedule().
>>>>=20
>>>=20
>>> Since this commit in -dev branch [1] suggests more users still need
>>> conversion, let us drop this single patch for 6.4 and move the rest of
>>> the series forward? Let me know if you disagree.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/co=
mmit/?h=3Ddev&id=3D9bf5e3a2626ed474d080f695007541b6ecd6e60b
>>>=20
>>> All -- please supply Ack/Review tags for patches 1-12.
>>=20
>> Or put another way, what is the transition plan for these remaining users=
?
>>=20
>> I am getting on a plane right now but I can research which users are rema=
ining later.
>>=20
> I am not sure. I think we can cover it on the meeting.

Cool, thanks.

> My feeling is
> that, we introduced "_mightsleep" macros first and after that try to
> convert users.

One stopgap could be to add a checkpatch error if anyone tries to use old AP=
I,
and then in the meanwhile convert all users.
Though, that requires people listening to checkpatch complaints.

Thanks,

 - Joel


>=20
> @Paul what is your view?
>=20
> Thanks!
>=20
> --
> Uladzislau Rezki
