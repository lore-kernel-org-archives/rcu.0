Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4420C77B70
	for <rcu@archiver.kernel.org>; Mon, 17 Apr 2023 10:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDQKNJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Apr 2023 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDQKNH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Apr 2023 06:13:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33683A91
        for <rcu@vger.kernel.org>; Mon, 17 Apr 2023 03:12:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2472a5dbbdcso254463a91.0
        for <rcu@vger.kernel.org>; Mon, 17 Apr 2023 03:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681726259; x=1684318259;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYOvn84VbpTxh6+JBi9iFxbj2KCHYEgXyKUjU/PX2jU=;
        b=pw2wFKi/EIeROqKvad7PBPG1Xu0a/9Wf9XOVkBP9cGdMNBr6CtLnQUO8RNXdqyz11B
         2RARoHKr1yAdJfrHDagEkNEURlbdrGAsEyFMCVM6IffCReSGQFI7mcGYOuJZAEMYyBGM
         y9yS+k9sy4mratTr98f5QVTrsE5SPjxL6/MKFjXXquT0JYe6bk0sw5WInmHFpyKS3kxH
         d2x9xP042lmpxn1d59ou54EoE63LZvAwvlF15S6+bRPduZfhuoL/gQ1w8z7ZGwZJhJqu
         mkTNNVNQhv8txn/RgjI1H1t9PpWnL+UzWQRgVLh7mOzVNuJpIQXz/1J3ZRno+vBNRggk
         6XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681726259; x=1684318259;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYOvn84VbpTxh6+JBi9iFxbj2KCHYEgXyKUjU/PX2jU=;
        b=lnoXBIVMOleviYs8LhhfB1jrWkX1JJEg43UJ6qQYweQOCpDCOrbJiApDvXWrPX2+K5
         8u7teT8hKhyb6cnAsHsKT9XWuLPXyI4AbnuwEmqA6LXwyZPT3q4yQ1+J07jx0N0Urlqp
         bIjFe1pQ1uK9h1rQ5Kw3HDIg0Rtp7UT5jz/G3cp6aaV3RXpEllxaVryEVu6BK+tUGVzE
         SlmDapt7yQlxq7G/k0mPxyCIsISgHOQ2sPgO4ZKtoh7u76VUG53u8bHw+qxb4SOxYweQ
         srSWR23Gcocqp+3nuvwaDbBogQSNoTh/gWJuLfPLeYpWEO/2POnxgY79kxff5OjEYgLB
         oKiw==
X-Gm-Message-State: AAQBX9eIEpoM5AkU20XuaKtRg7Aeif3qrMS5PY+qgSDye+0Dnw1Ppvex
        eKJP4uonSJqCu2GjUQfXb3pc1BJWzOetGXk0
X-Google-Smtp-Source: AKy350bAJhEuQXXDiITokplzm8xcwvrnSKeTz344dklR8CbKK28yKMMeSFBUTInZYc8QsXjPCjrXBw==
X-Received: by 2002:a05:6a00:138d:b0:63d:260d:f9dd with SMTP id t13-20020a056a00138d00b0063d260df9ddmr2309467pfg.33.1681726259351;
        Mon, 17 Apr 2023 03:10:59 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b00639fc7124c2sm7509440pfm.148.2023.04.17.03.10.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 03:10:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Question: Why the definition of ULONG_CMP_LE is different with
 time_before?
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <fd1c65f0-e4a1-4377-2767-c541395b1a8b@quicinc.com>
Date:   Mon, 17 Apr 2023 18:10:31 +0800
Cc:     rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <23CBBB68-EEC0-430C-92E5-B57B491EAF01@gmail.com>
References: <59BEC41C-E025-47EE-AA47-9B9795234415@gmail.com>
 <fd1c65f0-e4a1-4377-2767-c541395b1a8b@quicinc.com>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Neeraj,

Thank you for your explanation!

The lwn article is very helpful to me!

Thanks,
Alan



> 2023=E5=B9=B44=E6=9C=8817=E6=97=A5 =E4=B8=8B=E5=8D=881:28=EF=BC=8CNeeraj=
 Upadhyay <quic_neeraju@quicinc.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Alan,
>=20
> The reason for a different implementation looks to be due to the fact =
that the C standard does not specify the result of an operation that
> overflows a signed integer. This is described in lwn article: =
https://lwn.net/Articles/511259/ . On 32-bit systems, overflow would be =
common for counters used by RCU. So, RCU subsystem uses unsigned =
integers checks - ULONG_CMP_GE , ULONG_CMP_LT , to avoid any compiler =
optimization, which would cause results of these checks to have a =
different result, in the event of counter overflows.
>=20
>=20
> Thanks
> Neeraj
>=20
>=20
> On 4/16/2023 2:19 PM, Alan Huang wrote:
>> Hi,
>> I noticed that the definition of ULONG_CMP_LE in rcupdate.h is =
different with time_before.
>> I can=E2=80=99t figure it out that why their definition is different. =
Does the two definition are the same thing?
>> Thanks,
>> Alan

