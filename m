Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A8EEB64DD
	for <rcu@archiver.kernel.org>; Thu, 27 Jul 2023 04:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjG0EYR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Jul 2023 00:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG0EYP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Jul 2023 00:24:15 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693A02704
        for <rcu@vger.kernel.org>; Wed, 26 Jul 2023 21:24:14 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-765a7768f1dso51052185a.0
        for <rcu@vger.kernel.org>; Wed, 26 Jul 2023 21:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690431853; x=1691036653;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xC7j4/Ybsi2RpHHYT/JlFV6MzEyCzEDWGCxlDztTpBQ=;
        b=hu0B4U9NzBtrHwz21VKdrZCXFVrK91xv3HNuQhYyZ9MvxOvMlweLbzTdtyhmauFTqd
         M429DBdEVc5GSlBRPDkVSus7ltNs/sx6BcCh96cqDlwd13JaxXMGFvH77pYZTFQ/eqRI
         3qx7gvutywmUgGLKuPUTMoKNdTIXuCIIHwvm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690431853; x=1691036653;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xC7j4/Ybsi2RpHHYT/JlFV6MzEyCzEDWGCxlDztTpBQ=;
        b=aZd6Rw2RWMJ9HGTnIcGPeu/LCoV3zx6lMJDQJjOMY0xT33juW2i1TB1kX+Hy+MTqjg
         GwddobScZ0zKHAO9zwS/hWgver3Td5FYWKMQOCQCdW3Oky5CI0sht0QHx+ZIu7Woh8ZM
         QUUt/dpgVmOFIFYUtmjhBHYAQo2STR1fuYYoPt5F2av01HFPXoE1RwJmpuoI6BITX2Aa
         8zWgJ1bcrbYYqbxLOPbQNP1Qj0ICmDfKrbiJVjbM7Kty1pI0slCEANzaatqx+UFTKXl+
         LYm6CC2SlSBWgKfI+9atyG6/+LWjdm4pbUsdbN8aRKS9Ag+qq3tSvmAlXt7RtHSZjsOn
         FFRg==
X-Gm-Message-State: ABy/qLYB4EiA6KoAI+dpFzoz3txvDOJ4es7xVw/a8bd1pAVAiCxMib+F
        yC/AVZix16EOQxTRO4Tw6CPTeg==
X-Google-Smtp-Source: APBJJlG1aaXSxZK68BetchlHiLw/a2m/lftrHBhwyRYMkEZnvIHQOK5/DLILpg/zoJLyE55F082GSw==
X-Received: by 2002:a05:620a:2495:b0:767:e04c:8d6e with SMTP id i21-20020a05620a249500b00767e04c8d6emr4368433qkn.51.1690431853521;
        Wed, 26 Jul 2023 21:24:13 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.67])
        by smtp.gmail.com with ESMTPSA id j13-20020a37c24d000000b00763b94432ebsm155487qkm.18.2023.07.26.21.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 21:24:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/5] srcu: Fix error handling in init_srcu_struct_fields()
Date:   Thu, 27 Jul 2023 00:24:01 -0400
Message-Id: <6443E8C5-0271-48C3-B3D1-3CD20DB782FD@joelfernandes.org>
References: <3549e916-3829-40b8-b2ae-7a969826105c@paulmck-laptop>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "open list:SLEEPABLE READ-COPY UPDATE (SRCU)" <rcu@vger.kernel.org>
In-Reply-To: <3549e916-3829-40b8-b2ae-7a969826105c@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jul 27, 2023, at 12:02 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Wed, Jul 26, 2023 at 11:04:04PM -0400, Joel Fernandes wrote:
>>=20
>>=20
>> On 7/26/23 17:07, Paul E. McKenney wrote:
>>>> -                free_percpu(ssp->sda);
>>>> -                ssp->sda =3D NULL;
>>>> -                kfree(ssp->srcu_sup);
>>>> -                return -ENOMEM;
>>>> -            }
>>>> -        } else {
>>>> +        if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
>>>> +            goto err_free_sda;
>>>> +        else
>>>>            WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
>>> Given that the "then" clause is a goto, what is the "else" clause doing
>>> for us?
>>>=20
>>=20
>> Not much. Agreed we can get rid of "else" and reduce indent of the
>> WRITE_ONCE that follows.
>>=20
>> Would you mind making this fixup in the patch for your apply, or would
>> you like me to refresh the patch? Let me know either way, thank you!
>=20
> Please include it with your next series, which has at least one other
> change anyway.  ;-)

My pleasure ;-).

- Joel


>=20
>                            Thanx, Paul
