Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDC1C4332F
	for <rcu@archiver.kernel.org>; Thu, 29 Dec 2022 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiL2QKc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Dec 2022 11:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiL2QKb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Dec 2022 11:10:31 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9957311A37
        for <rcu@vger.kernel.org>; Thu, 29 Dec 2022 08:10:30 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 186so21022818ybe.8
        for <rcu@vger.kernel.org>; Thu, 29 Dec 2022 08:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SlNJLfS96B1Ap7tev1XkTq1jXyL6cDjILqwD2QbOmc=;
        b=hk2Oghj+PA6RJQ262xlgf9G9dCHc5PZO+KeGiNMN1m1VWTXYypgncHv9arriXyENnk
         8EVXcWxXi00oRvr6x6R/YLIe/xzLee6ProhYHWHV9/E939HHu84hO1qrb6AS6b2yNj7f
         oe8gYCCkSN3f55KDq2Notv+9y6cQexVKFrTLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SlNJLfS96B1Ap7tev1XkTq1jXyL6cDjILqwD2QbOmc=;
        b=uFYGF4nydq7pTZ+AJUr+osimnLHD8Xad5ZbD9+BbIv6xZ2kqFLDRoL+tmc+JWjlHFw
         3vtPKjwZPqLWFCLousc2+1UVb/kxmdoZ6+xTZn67kgs6PdFKwuS+Coi64HKk6BrafFbn
         /mEPcy/K80kjoFAnzPjx/4Q2OoaqRcM3mCb8GCFzkYHsh2DIpe9UqmZAzcT11teK1W5b
         aXkuoQYfeogvf4mxr8UTorzrsrNg4cGGRJ32ZkFbtz+JYBRAL/ufPe2/SU0Gi9jXxXJP
         losTDmR3LAAC3VAlxfa9E4yHRFVFYwo+0RUDzZyexXILFtwBPHEOyW2LYR/I1mk5yZj9
         Z5VQ==
X-Gm-Message-State: AFqh2korHK53bRamhm5Z7yfw/7PUvOrnz8Astl1eVqeO91hEXasFdup/
        LODG0TNd81T+JWc64FARjY6cwwjgoHI2zNO6
X-Google-Smtp-Source: AMrXdXsDkBpvI443hkmgNVkCjHLvFqZhpRaPn6HGiPqeQIRPAiZ95SqSldA5Fnwp4aZoO4RR0o8XUg==
X-Received: by 2002:a05:6902:4e9:b0:77f:e6fd:eefd with SMTP id w9-20020a05690204e900b0077fe6fdeefdmr13226012ybs.50.1672330229258;
        Thu, 29 Dec 2022 08:10:29 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id s4-20020a05620a254400b006feb158e5e7sm13486607qko.70.2022.12.29.08.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 08:10:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Please apply to v5.10 stable: 4d60b475f858 ("rcu: Prevent lockdep-RCU splats on lock acquisition/release")
Date:   Thu, 29 Dec 2022 11:10:17 -0500
Message-Id: <FA3EA215-5F84-4CFF-BC32-4B9CB7643948@joelfernandes.org>
References: <Y6z9ygSGmPNz5hfd@google.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
In-Reply-To: <Y6z9ygSGmPNz5hfd@google.com>
To:     stable@vger.kernel.org
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 28, 2022, at 9:39 PM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>=20
> =EF=BB=BFHello,
> Please apply to v5.10 stable: 4d60b475f858 ("rcu: Prevent lockdep-RCU spla=
ts
> on lock acquisition/release"). The patch made it in v5.11
>=20
> Without it, I get the follow splat on TREE05 rcutorture testing:
>=20
> [    1.253678] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.162-rc1+ #6
> [    1.253678] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.=
15.0-1 04/01/2014
> [    1.253678] Call Trace:
> [    1.253678]
> [    1.253678] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    1.253678] WARNING: suspicious RCU usage
> [    1.253678] 5.10.162-rc1+ #6 Not tainted
> [    1.253678] -----------------------------
> [    1.253678] kernel/kprobes.c:300 RCU-list traversed in non-reader secti=
on!!
>=20
> I tested with the patch and the warning is gone.

Please hold off on this particular one. After a 12 hour test, I am seeing so=
me new warnings. Will update the thread after some more debug.

Sorry for the noise,

 - Joel


>=20
> thanks,
>=20
> - Joel
>=20
