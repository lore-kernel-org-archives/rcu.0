Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DC6C83F16
	for <rcu@archiver.kernel.org>; Tue, 29 Aug 2023 10:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjH2KNV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Aug 2023 06:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjH2KMy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Aug 2023 06:12:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF09129
        for <rcu@vger.kernel.org>; Tue, 29 Aug 2023 03:12:48 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4103fdba0fbso23865751cf.3
        for <rcu@vger.kernel.org>; Tue, 29 Aug 2023 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693303967; x=1693908767;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3U7w7Dxv0aMNSqkqHyETmyZKkPYclhc4evSzr8ifFs=;
        b=jdlvcZWEok692A9iQ9+qmfAm3k7qCYat9eF1bXFp3fEQ+4j25X4UOa7oJP6BGevYIM
         it0nLAmGWroG/4wZUyOlR7ogL5WkoFEk4vuZNL4b3ngHPYHOK5U/Vfzb5adgNhGT2NHy
         5DVMaVD2QTIBsx0biBk05aVWebB9F9JrXsaMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693303967; x=1693908767;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3U7w7Dxv0aMNSqkqHyETmyZKkPYclhc4evSzr8ifFs=;
        b=HwivB/Bq+6kMD7slFClEOcYlEWb6fGn5K4U2N9Sh0D8nfQx2GPN/0PjZPXCyCO1fIR
         oWsHUBwcuwh+DJqss8hO1iy3Wk1JD7oFUJFO6298bgmxc//Dvdn5tkxIzai4RGgYcucb
         vM2m0hkCmoSyHzvnVIWwzsAxJZ/Iv1109UqldaMPCAAUy0Zw8De2zgtZKkbUp0lRnE5K
         HOuyUH7ntBNRlIhlUb7n99E8ULG/fbXWv3NX7T7XlHz+0EqtYeYpUIxk5/H47oBCujkG
         E/BNZjreYQf6pruwWJnha+hdGm6wD3eeqwGHp/NvCw+G3SQ+FEzLBzEPQqX1Ldbf0doB
         SrvQ==
X-Gm-Message-State: AOJu0Yxdw8S8Rfis0CknTAPDo+rLrg7C9KoPDlFO0d51Yof26g/iNLFn
        2OyNCyU2zFsUUrKy7zsa0MvYNT3KbvY9p1OII24=
X-Google-Smtp-Source: AGHT+IEVqgTNW06+UI1f1xfAQUCG/TUuimalKVqTc0ftOoXMoENg9h8R5usdIgj3KVXW0k9a4L1CRA==
X-Received: by 2002:a05:622a:1013:b0:403:f42a:95bc with SMTP id d19-20020a05622a101300b00403f42a95bcmr32558121qte.28.1693303967586;
        Tue, 29 Aug 2023 03:12:47 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.64])
        by smtp.gmail.com with ESMTPSA id kc5-20020a05622a44c500b00411f7da6e1bsm2888781qtb.60.2023.08.29.03.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 03:12:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()
Date:   Tue, 29 Aug 2023 06:12:35 -0400
Message-Id: <D98FE55B-C379-4C24-B4DD-4E02A1E2AB79@joelfernandes.org>
References: <ZO25SDat3cd6opQ7@lothringen>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Z qiang <qiang.zhang1211@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
In-Reply-To: <ZO25SDat3cd6opQ7@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Aug 29, 2023, at 5:24 AM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Mon, Aug 28, 2023 at 05:51:09PM -0400, Joel Fernandes wrote:
>> I think the issue is the loop later in the function does
>> not try to toggle cpus that came online too late.
>>=20
>> So it does not test offloading on all CPUs just because max got updated t=
oo
>> late.
>=20
> Right, and therefore for_each_possible_cpu() or for_each_present_cpu()
> should be fine to iterate since it's ok to try to toggle an offline CPU.

Ah I see what you mean, sounds good.

>=20
>>=20
>> One fix could be to periodically check in the loop if a new cpu at maxcpu=
 + 1
>> ever got onlined. If it did, update the maxcpu.
>=20
> Is it worth the complication though?

Probably not and so your suggestion sounds fine.

Thanks!

 - Joel


>=20
> Thanks.
>=20
>>=20
>> Thanks.
>>=20
>>=20
>>>=20
>>> Thanks.
