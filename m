Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E804AEE020C
	for <rcu@archiver.kernel.org>; Wed, 13 Sep 2023 20:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjIMUal (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Sep 2023 16:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIMUak (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Sep 2023 16:30:40 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01A170F
        for <rcu@vger.kernel.org>; Wed, 13 Sep 2023 13:30:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bf78950354so3606711fa.1
        for <rcu@vger.kernel.org>; Wed, 13 Sep 2023 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694637034; x=1695241834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm9W9+MOPpsrXLX2zq8bB4NC8aKbORqa0kjC5pLMzHU=;
        b=X5ws/RRaL+neEyZVMOSCp6CPnWm/mfdtdyVgIK55LGncGqaUWICfiInBFiAzInjhYd
         5YBlcuP5zMfmVM4WJI7UBoI9FpnUZ9rCwWytjpafp8Pe20QICubd1EiuZAPyYucMypAV
         S6hoSdHfHVLrvZD6VQX1V1xICHDX0Nnd6NBm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694637034; x=1695241834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm9W9+MOPpsrXLX2zq8bB4NC8aKbORqa0kjC5pLMzHU=;
        b=pT+O3qBXCX8NR8uugK6mdz+++IjnLvZx+uLJgERTpW8ueu6Fc+il4DO7HhwcKEyXCn
         ecuOAFAmfR4PvxKxKOeBbSjt+9i93zXgZCg1XWSHvfVZDPzriYYaxUoAVNkSriO13seV
         J0tA+OZ+9iPh1EjfEbAdan66eaT4q+sI4HUKJNbbYg9zcNVgjVjhRJ23ry7n2m36r3ew
         wFUtBWocvZ2Ewj+4xwsqu+E8gt1+MC0i1mCXwE3v6+HYxkEpp9QK1H5k/vgyXfmhitWf
         g7GDuF1JN9UuJXMtxMGv7G2WxRaMTsBmWTSZ3Ky9CAPuxXefH+Eg3X5WCtbVyMN96r71
         TXDQ==
X-Gm-Message-State: AOJu0YzAl85APWu7l2kZbaCgTWss4KgTzyRVGWbsXoqQUTi/904/u40f
        PVO1r8v/CkslWuBhpw3pC3hdLidopDcQi9hc8eMdKQ==
X-Google-Smtp-Source: AGHT+IGfpwVx3aDNVu5TXqQqy6KFi9TGSSVydc9fdXPB3vlgvyyUzGhiQl2qGP3tNqhp5bNlIO6alBgBd/AGTyz1sX8=
X-Received: by 2002:a2e:948a:0:b0:2b9:b4eb:c39c with SMTP id
 c10-20020a2e948a000000b002b9b4ebc39cmr2824889ljh.8.1694637031032; Wed, 13 Sep
 2023 13:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230910201445.GA1605059@google.com> <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com> <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
In-Reply-To: <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 13 Sep 2023 16:30:20 -0400
Message-ID: <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 11, 2023 at 4:16=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
[..]
> > I am digging deeper to see why the rcu_preempt thread cannot be pushed =
out
> > and then I'll also look at why is it being pushed out in the first plac=
e.
> >
> > At least I have a strong repro now running 5 instances of TREE03 in par=
allel
> > for several hours.
>
> Very good!  Then why not boot with rcutorture.onoff_interval=3D0 and see =
if
> the problem still occurs?  If yes, then there is definitely some reason
> other than CPU hotplug that makes this happen.

Hi Paul,
So looks so far like onoff_interval=3D0 makes the issue disappear. So
likely hotplug related. I am ok with doing the cpus_read_lock during
boost testing and seeing if that fixes it. If it does, I can move on
to the next thing in my backlog.

What do you think? Or should I spend more time root-causing it? It is
most like runaway RT threads combined with the CPU hotplug threads,
making scheduling of the rcu_preempt thread not happen. But I can't
say for sure without more/better tracing (Speaking of better tracing,
I am adding core-dump support to rcutorture, but it is not there yet).

thanks,

 - Joel
