Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AEDC678D5
	for <rcu@archiver.kernel.org>; Wed,  8 Mar 2023 15:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCHPKL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 8 Mar 2023 10:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCHPJ5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 8 Mar 2023 10:09:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34C96923E
        for <rcu@vger.kernel.org>; Wed,  8 Mar 2023 07:09:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h8so17910552plf.10
        for <rcu@vger.kernel.org>; Wed, 08 Mar 2023 07:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678288195;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGgrbtL0osvGwqCEy5S6PgImlMHlY6fpkJDxu/3Zc74=;
        b=Cy+UsOiy8Kw+/Y5nUfo1zVaKbgnTQPV5QrFPFPlARLixMPr8kzSqNibag5C/pX8Lka
         wj94WV73tB+keA2r68yvUeg1nIE4qi47loC2k8XPxk43I3l1AjIJsu7Y3qiqq/VDHSVS
         F2Vn0biJWfJ2IrUwo0NsyfhSsBCRQG46yJJHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678288195;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGgrbtL0osvGwqCEy5S6PgImlMHlY6fpkJDxu/3Zc74=;
        b=ZTacBmWRiL9cJukHS7aapJZ2uPXcbZfS7gfnutuAbRk4BwOWhXiV3HQCcZ0T0rlMZq
         4DyNG/11zZ1iURLVOEqSyD/xavpispAWSUJIzcKeMmuW6pTEialCHSM2zLwIPx54iU6Z
         8zhRJ9OdJZPkRhPomO5miafEmB4X/lsYtJ+PqTIIOIxhMOrGzDfwjEBb7broLjiprio6
         vr4nQbP+n+BZaUqq3TQb8f2dHWy+33R/Qaz6BcGhfL0asKmI8l8rOyvZAncT7Xk+b43D
         /gKNUMcJJuxkVWPIHn091zGD+e9/h9S/9eX4eV+tzyMgk7GH4pz+4G4Pg1RbDfMwEXoY
         FK6Q==
X-Gm-Message-State: AO0yUKUm5RMlDjuZTZulEZgIQy22Y+FMEezBtHuN2N1ozNFivwUsGtpQ
        nRCbirE5hlAyERzHb580rgO5jQ==
X-Google-Smtp-Source: AK7set+TDA4sUlwdVLO52Tw5fNk3QFkY9MHeImXJKiiUBwXcbYr+lIVs8Vtq2XaesY2ALOkZ3MfFtA==
X-Received: by 2002:a17:902:d4c5:b0:199:30a6:376c with SMTP id o5-20020a170902d4c500b0019930a6376cmr20622902plg.68.1678288195139;
        Wed, 08 Mar 2023 07:09:55 -0800 (PST)
Received: from smtpclient.apple ([2600:1010:b049:5d6c:a98c:abbd:1cd:6532])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b0019a983f0119sm9941729plb.307.2023.03.08.07.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:09:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Date:   Wed, 8 Mar 2023 07:09:42 -0800
Message-Id: <4069DA96-5E01-4E70-8A04-52543A43B3BC@joelfernandes.org>
References: <ZAijOO0vEiiDn+Ex@lothringen>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, urezki@gmail.com
In-Reply-To: <ZAijOO0vEiiDn+Ex@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Mar 8, 2023, at 7:01 AM, Frederic Weisbecker <frederic@kernel.org> wrot=
e:
>=20
> =EF=BB=BFOn Wed, Mar 08, 2023 at 05:52:50AM -0800, Joel Fernandes wrote:
>> Just to add to previous reply:
>>=20
>> One thing to consider is that it is more of a performance improvement for=

>> booting in expedited mode to fallback to normal later, than a bug
>> fix. Repeated synchronize_rcu() can easily add 100s of milliseconds and t=
o
>> remedy that =E2=80=94 a conversion of the call from normal API to the exp=
edited API
>> will not help.
>=20
> 2 things to consider:
>=20
> 1) Is it this about specific calls to synchronize_rcu() that repeat a lot
>   and thus create such measurable impact? If so the specific callsites sho=
uld
>   be considered for a conversion.
>=20
> 2) Is it about lots of different calls to synchronize_rcu() that gather a b=
ig
>   noise? Then the solution is different.
>=20
> Again without proper analysis, what do we know?

Again, no one disputed that proper analysis is needed. That is obvious. I wa=
s just responding to your assumption that if boot is slow, user space will a=
lso be slow. That is not a good thing to conclude because there are many fac=
tors. Slowness at boot may be considered a bug, but slowness after boot may n=
ot be (say if the user care mores for power later).

On my side I am planning to dig deeper into our boot process, but it will ta=
ke time. I hope Qiuxu can do the boot analysis on his side.

Thanks.

>=20
> Thanks.
