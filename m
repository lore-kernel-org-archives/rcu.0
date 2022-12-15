Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AF7C4332F
	for <rcu@archiver.kernel.org>; Thu, 15 Dec 2022 00:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLOApd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOApc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Dec 2022 19:45:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB02511EF
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 16:45:30 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x28so13249828lfn.6
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 16:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uYBxsTIDfxCwdcVy0SlVo7L6KklaT8RI7tWL5R76GxA=;
        b=FNLgUFaF9svpbbtMTs3OU9It8D//Y6M14TiwnPoIEkWX7dTcvDln6mrg1q4xzKckYU
         uOEv/8cAWTAAdzNS413nOsRXkWqP008Am6MthTq/7a72YsakjbAuGyXAMJxwnDcvLMUN
         n2UXnHeP2wb+bg33ULDTODUVixLzO912rAdfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYBxsTIDfxCwdcVy0SlVo7L6KklaT8RI7tWL5R76GxA=;
        b=kEMYdy8k9wBLd85HlwYPp32lsnrWbl2vMxHZeZ9u/tbqnlBPWL4pcw9tuP2xinWL1V
         vFQB9671vmVXJkaan5tMpgOvvO3S/5TA7EOaT534FvwTOAgc61X2BqAoq0zvkSXb1m3P
         gmQk4s9n6FzvabLSigYGWnZ/8xx6eZMkbSWjUdP/cmXv20m1jF687gU6pK+PQN0AJTCd
         OlX+9XQDgZC1ySY+yNj7Uqiqccbi3Lac2zpUtP/M1tPdvXLzg6MNuvx8q4a5tjjlP/6D
         tNaX60B3Tq9/IcN/2E+nCRd6etRMWbgD/N0s9qmmn7yqMfP7dCQqIoKT+oMN0aKszGb7
         yV7w==
X-Gm-Message-State: ANoB5pnCb0ab6X0lo1snZY/cg8O0XAK8JtHIvu4FEPxXZnudHxntDLY/
        cgQP97GHnjy2gJqBz04AypWZML9LlVpeP0iQCnfuYA==
X-Google-Smtp-Source: AA0mqf4IrWNorDC3Tt/0G9y03c+7uT35Mc6/ZAXwiyOMdQM1IQZ/tj12Krg1jK6LMBSjXQCkCZeCPwck+/ln3oNKC2Y=
X-Received: by 2002:a05:6512:224c:b0:4b5:ad89:8174 with SMTP id
 i12-20020a056512224c00b004b5ad898174mr2000564lfu.84.1671065129157; Wed, 14
 Dec 2022 16:45:29 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR=DvPhk5JWUe7gYHeVsn5d4Wba83x2UB9uqP0EURgk1g@mail.gmail.com>
 <Y5nzjauYRdn7T6T+@kroah.com>
In-Reply-To: <Y5nzjauYRdn7T6T+@kroah.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Dec 2022 19:45:17 -0500
Message-ID: <CAEXW_YQbqY7Q9zQifQSsR+Fws5Wyu=n0OxMGvuwY4HpNXe0xDQ@mail.gmail.com>
Subject: Re: Please apply to v5.10 stable: 29368e093921 ("x86/smpboot: Move
 rcu_cpu_starting() earlier")
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 14, 2022 at 11:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 13, 2022 at 12:17:20PM -0500, Joel Fernandes wrote:
> > Hello,
> >
> > Please apply to the stable v5.10 kernel, the commit: 29368e093921
> > ("x86/smpboot:  Move rcu_cpu_starting() earlier").
> >
> > It made it into the mainline in 5.11.  I am able to reproduce the
> > following splat without it on v5.10 stable, which is identical to the
> > one that the commit fixed:
>
> Now queued up, thanks.

Thanks, Greg! I confirmed with overnight testing that the patch fixes the splat.

 - Joel
