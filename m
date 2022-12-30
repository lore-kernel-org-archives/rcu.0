Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77663C4332F
	for <rcu@archiver.kernel.org>; Fri, 30 Dec 2022 04:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiL3EoK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Dec 2022 23:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiL3EoF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Dec 2022 23:44:05 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C61658A
        for <rcu@vger.kernel.org>; Thu, 29 Dec 2022 20:44:04 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f20so21202000lja.4
        for <rcu@vger.kernel.org>; Thu, 29 Dec 2022 20:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7QSHQY92PKl6Csv4DinNtxhvZYHxHaJepsou+rj5ec=;
        b=pe9uzRfBWiCos9FkvzlQ/NwDE0KjJlKerVVnHGmTd5X8e3Y6cfm2Hdl2C2Xobpt42/
         RK6s+qVisi7SYxmUNOD3rTYiSFdJ84n8mxjD0NGgDwtPvtiEYiDSn3PEPYGiO3ToePIC
         sCjUPHXypUoA1PNrGYXw7M3rP6aMCsOFpdzAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7QSHQY92PKl6Csv4DinNtxhvZYHxHaJepsou+rj5ec=;
        b=HPqtG40r3fk93jVJz8A0wpXix++3d8SrN0tv0VQtaC+b1mnWwxw8IdDpYZPqj2QSqy
         oKHgrlyDWwb+VKi0boSQN6TML8Y1jKbjRUrUXG8x9pJXwdGkoRWeKapTL/CxJhTcNODr
         BSiSLQVDeCJUHsT2b2Qp5sKjK6Ug1lNY8ziUJu39bibWJZ++fiTFUNFekMUnim+L+fyZ
         LetwSVmPIM11rNThIDFCSnOfVjCwVVT2rM2OhitinVwp4Ey9DMEzuCEgFEYuYlCoeAew
         2/UQROZrcQG+FkHQQ49LlcPTUGHt22rayRSFqZ/yUq24rBZWmEmk3wTbEQ+5FApxIh04
         6rbA==
X-Gm-Message-State: AFqh2kqBKwN6eeGFVmkGeGNrsnlwHw192xM0lopD02u4+llJyxUWjvip
        Ss4LerSLIDvJA9eER5uaR72X5vzg1Y9J0SNdv2Zgwg==
X-Google-Smtp-Source: AMrXdXtChccg0kx8a8ChzWda57Y8At9qQMbMUtOm7Xvrx+KxJdSkccVNlL5sX2QwDSKYp7OQv44eAzPLydw7bJDxSdE=
X-Received: by 2002:a2e:9c8d:0:b0:27f:c11a:b6c8 with SMTP id
 x13-20020a2e9c8d000000b0027fc11ab6c8mr1245699lji.167.1672375442347; Thu, 29
 Dec 2022 20:44:02 -0800 (PST)
MIME-Version: 1.0
References: <Y6z9ygSGmPNz5hfd@google.com> <FA3EA215-5F84-4CFF-BC32-4B9CB7643948@joelfernandes.org>
 <CAEXW_YSBW-vfn6DzLY5vmCRRu6GJfVUFAT7vdj=ZPyDqz1U-3Q@mail.gmail.com>
In-Reply-To: <CAEXW_YSBW-vfn6DzLY5vmCRRu6GJfVUFAT7vdj=ZPyDqz1U-3Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 30 Dec 2022 04:43:50 +0000
Message-ID: <CAEXW_YSOPgpHYWmN3qQA5PHv6L7ssN1ouWr600GKG2bPEiMbyA@mail.gmail.com>
Subject: Re: Please apply to v5.10 stable: 4d60b475f858 ("rcu: Prevent
 lockdep-RCU splats on lock acquisition/release")
To:     stable@vger.kernel.org
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 30, 2022 at 1:02 AM Joel Fernandes <joel@joelfernandes.org> wro=
te:
>
> On Thu, Dec 29, 2022 at 4:10 PM Joel Fernandes <joel@joelfernandes.org> w=
rote:
> >
> >
> >
> > > On Dec 28, 2022, at 9:39 PM, Joel Fernandes <joel@joelfernandes.org> =
wrote:
> > >
> > > =EF=BB=BFHello,
> > > Please apply to v5.10 stable: 4d60b475f858 ("rcu: Prevent lockdep-RCU=
 splats
> > > on lock acquisition/release"). The patch made it in v5.11
> > >
> > > Without it, I get the follow splat on TREE05 rcutorture testing:
> > >
> > > [    1.253678] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.162-rc1=
+ #6
> > > [    1.253678] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS 1.15.0-1 04/01/2014
> > > [    1.253678] Call Trace:
> > > [    1.253678]
> > > [    1.253678] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [    1.253678] WARNING: suspicious RCU usage
> > > [    1.253678] 5.10.162-rc1+ #6 Not tainted
> > > [    1.253678] -----------------------------
> > > [    1.253678] kernel/kprobes.c:300 RCU-list traversed in non-reader =
section!!
> > >
> > > I tested with the patch and the warning is gone.
> >
> > Please hold off on this particular one. After a 12 hour test, I am seei=
ng some new warnings. Will update the thread after some more debug.
> >
>
> Weirdly enough, the warning seems to be a false-positive from the
> rcutorture scripts:
>
> WARNING: Assertion failure in
> /root/.jenkins/workspace/rcutorture_stable_linux-5.10.y@2/tools/testing/s=
elftests/rcutorture/res/2022.12.29-02.23.56/TREE05/console.log
> TREE05
> WARNING: Summary:
>
> But opening the console.log shows a normal flow followed by SUCCESS
> message from the rcutorture kernel module.
> Also "Summary:" is supposed to provide more information.
>
> Here are some logs:
> 1. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.10=
.y/10/console
>    (Scroll to the end)
> 2. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.10=
.y/10/artifact/tools/testing/selftests/rcutorture/res/2022.12.29-02.23.56/R=
UDE01/console.log
>
> So this is probably something wrong with my setup, say something
> interfered with the test. Or, there is something weird with the
> scripts.
>
> Anyway, re-running it with this patch overnight again!

I think I found it, v5.10 is also missing this patch which made it in
v5.11: 8d68e68a781d ("torture: Exclude "NOHZ tick-stop error" from
fatal errors")

That is needed along with the $SUBJECT patch.

I will re-run my 5.10 tests again with both these to see if everything
is now green.


 - Joel
