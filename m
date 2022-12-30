Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95C4C3DA7A
	for <rcu@archiver.kernel.org>; Fri, 30 Dec 2022 01:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiL3BCk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Dec 2022 20:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiL3BCk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Dec 2022 20:02:40 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1759BC02
        for <rcu@vger.kernel.org>; Thu, 29 Dec 2022 17:02:38 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id p2so5309579ljn.7
        for <rcu@vger.kernel.org>; Thu, 29 Dec 2022 17:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iu66IXaYWbK0UFw1ZBZT29FpWCa6Vb+57KKmvLtbkM=;
        b=xCV9gXX503oKit//7hQNRIyYp/Ul+NBBup1ItzCa0hDX+cqQl+St2c6Q947j5h4XUE
         0toehrSNQwzYZo8ZZNDppqnEesPFt+WgUUgVnR1C93KVNaP/G2m8W+Mmwi+e4+4qt+vt
         Y+i25BXtYyab2qk6yubpOWo4MvSiOw6OCSiN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iu66IXaYWbK0UFw1ZBZT29FpWCa6Vb+57KKmvLtbkM=;
        b=nHgAmDt7E+hxeQiVOf3XHtkukR2DcRhueL5WHCt4Z06CX2xjYAGPpGsdi7rkkk+S8b
         OLMezNc92RhBK5hifBFFRQm5hDsumxAyFna03EKNVZaGOD6BU3eWpn5y+mHBwq7bIEsj
         yHOx0aQPbX8f3dQiDOW2M3S77mSXwFdzlSAs/fR4BN0CFbarN4WkG0CJlajWN3LL1ANX
         mRF0idhkZrMVeNIMu3bMph9INrl9SaRiYp4+8Ay3WOcm5yIjXdumMv6CYLhbgNFeCllu
         Tk3W1eMVnNU+KBxDZQbjM/iEhkxWnvZQw3mQpwEluHLsnFvWkt7U4/Wkwk6n4wNh5pyj
         CwOw==
X-Gm-Message-State: AFqh2kozZ/5ZqC9FRjUPxe9FFpYBWZ7sYXTcXPZxtzonIw4PHSl0LtlC
        uJjpMEx/JW4D85zvEc2+TL54qKw53wp+VhGY+pu4gA==
X-Google-Smtp-Source: AMrXdXtTDPKgOoxiS3bsYrIi0oAEix+DZcAlAqrz8JRNbyAr8y7p6EmymmNnGK8ofvFZAzj6RHsoEkw7na7I6PUr4fo=
X-Received: by 2002:a2e:3c15:0:b0:27f:dca1:8584 with SMTP id
 j21-20020a2e3c15000000b0027fdca18584mr205922lja.313.1672362156936; Thu, 29
 Dec 2022 17:02:36 -0800 (PST)
MIME-Version: 1.0
References: <Y6z9ygSGmPNz5hfd@google.com> <FA3EA215-5F84-4CFF-BC32-4B9CB7643948@joelfernandes.org>
In-Reply-To: <FA3EA215-5F84-4CFF-BC32-4B9CB7643948@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 30 Dec 2022 01:02:25 +0000
Message-ID: <CAEXW_YSBW-vfn6DzLY5vmCRRu6GJfVUFAT7vdj=ZPyDqz1U-3Q@mail.gmail.com>
Subject: Re: Please apply to v5.10 stable: 4d60b475f858 ("rcu: Prevent
 lockdep-RCU splats on lock acquisition/release")
To:     stable@vger.kernel.org
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 29, 2022 at 4:10 PM Joel Fernandes <joel@joelfernandes.org> wro=
te:
>
>
>
> > On Dec 28, 2022, at 9:39 PM, Joel Fernandes <joel@joelfernandes.org> wr=
ote:
> >
> > =EF=BB=BFHello,
> > Please apply to v5.10 stable: 4d60b475f858 ("rcu: Prevent lockdep-RCU s=
plats
> > on lock acquisition/release"). The patch made it in v5.11
> >
> > Without it, I get the follow splat on TREE05 rcutorture testing:
> >
> > [    1.253678] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.162-rc1+ =
#6
> > [    1.253678] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.15.0-1 04/01/2014
> > [    1.253678] Call Trace:
> > [    1.253678]
> > [    1.253678] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    1.253678] WARNING: suspicious RCU usage
> > [    1.253678] 5.10.162-rc1+ #6 Not tainted
> > [    1.253678] -----------------------------
> > [    1.253678] kernel/kprobes.c:300 RCU-list traversed in non-reader se=
ction!!
> >
> > I tested with the patch and the warning is gone.
>
> Please hold off on this particular one. After a 12 hour test, I am seeing=
 some new warnings. Will update the thread after some more debug.
>

Weirdly enough, the warning seems to be a false-positive from the
rcutorture scripts:

WARNING: Assertion failure in
/root/.jenkins/workspace/rcutorture_stable_linux-5.10.y@2/tools/testing/sel=
ftests/rcutorture/res/2022.12.29-02.23.56/TREE05/console.log
TREE05
WARNING: Summary:

But opening the console.log shows a normal flow followed by SUCCESS
message from the rcutorture kernel module.
Also "Summary:" is supposed to provide more information.

Here are some logs:
1. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.10.y=
/10/console
   (Scroll to the end)
2. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.10.y=
/10/artifact/tools/testing/selftests/rcutorture/res/2022.12.29-02.23.56/RUD=
E01/console.log

So this is probably something wrong with my setup, say something
interfered with the test. Or, there is something weird with the
scripts.

Anyway, re-running it with this patch overnight again!

 - Joel
