Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A0C678D4
	for <rcu@archiver.kernel.org>; Wed,  1 Mar 2023 19:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCATpX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Mar 2023 14:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCATpW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Mar 2023 14:45:22 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE2474F7
        for <rcu@vger.kernel.org>; Wed,  1 Mar 2023 11:45:18 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id ev13so10085188qvb.10
        for <rcu@vger.kernel.org>; Wed, 01 Mar 2023 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677699917;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/wnenQxxqSVWtcT09qecF55THwUhusv3ZYljnGarCE=;
        b=pKlQJ4kvdMBx1Dj10IwILdu9OjSAbqBUkUmeRr/625wmZMU1H8pTqbz0J/Uo09KXnB
         T2ZHdVMVtNyLpiEybcsHU8hEWWHOqzZusWeuvakaO/fLs51kmnZxv073vILm3ilhvfzR
         ZaX+rTXd6kRkpx7/+3AKnN+3yhNrspTRBs05o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677699917;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/wnenQxxqSVWtcT09qecF55THwUhusv3ZYljnGarCE=;
        b=fft4W+ItnyqqdOPJYZ3C3d54tWcp6PfIy/1RjmoRrOgsFd8l9CZfXhsENMY9b8ZPZp
         +jlViC5s5fKKHxa2PqEF/1dHXPtdCAPxFUqVnadK/J8qs3cOH6CYZxW/JiPXq58Davv0
         3Rs36Sr3BgxoYpdMy9Z5RzNE2NjozIDU1Ym4JkiwNLVhN1bMM7GwpE5NAjNISOppRA6H
         Th0NgxTMtXJOMPqktvJNnt+yu+qL7L4Q8tLaC6emhKBtZo5nnG+rtV4A5wfSTlc8hGeG
         5V5X33ErqVbITcfLJdM6nJvM/e+B8qaFbY2riWQZHDbvFExbuvA/30PZv3OWDUkFx1Nb
         yPOg==
X-Gm-Message-State: AO0yUKWpU6uA5VmYy4VNs4+jDuzkSVTuLpReylPeUu9XVrFWRywI93hs
        tnVfCDBRI/YInAq/Gkv9BIOYUg==
X-Google-Smtp-Source: AK7set/5daSEJ8Hvb78FgjUmCxvUwCjUQePFwiIgMZlpmnG9RE57v/PZoIhy1ILm7jaVrb2W1Blwmg==
X-Received: by 2002:a05:6214:2589:b0:56b:7cb:bdcd with SMTP id fq9-20020a056214258900b0056b07cbbdcdmr16581753qvb.39.1677699917080;
        Wed, 01 Mar 2023 11:45:17 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id 6-20020a05620a06c600b0071ddbe8fe23sm9400158qky.24.2023.03.01.11.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 11:45:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Date:   Wed, 1 Mar 2023 14:45:05 -0500
Message-Id: <E010E19D-94FD-4E23-BF46-A0F75734B8FB@joelfernandes.org>
References: <CAFULd4YPP_5koKN5ZbdgOueXcpUgap97UkaxxyzzGcQ=GEV__Q@mail.gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
In-Reply-To: <CAFULd4YPP_5koKN5ZbdgOueXcpUgap97UkaxxyzzGcQ=GEV__Q@mail.gmail.com>
To:     Uros Bizjak <ubizjak@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Mar 1, 2023, at 2:18 PM, Uros Bizjak <ubizjak@gmail.com> wrote:
>=20
> =EF=BB=BFOn Wed, Mar 1, 2023 at 7:52=E2=80=AFPM Steven Rostedt <rostedt@go=
odmis.org> wrote:
>>=20
>>> On Wed, 1 Mar 2023 19:43:34 +0100
>>> Uros Bizjak <ubizjak@gmail.com> wrote:
>>>=20
>>> On Wed, Mar 1, 2023 at 5:38=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
>>>>=20
>>>> On Wed, 1 Mar 2023 11:28:47 +0100
>>>> Uros Bizjak <ubizjak@gmail.com> wrote:
>>>>=20
>>>>> These benefits are the reason the change to try_cmpxchg was accepted
>>>>> also in the linear code elsewhere in the linux kernel, e.g. [2,3] to
>>>>> name a few commits, with a thumbs-up and a claim that the new code is
>>>>> actually *clearer* at the merge commit [4].
>>>>=20
>>>> I'll say it here too. I really like Joel's suggestion of having a
>>>> cmpxchg_success() that does not have the added side effect of modifying=
 the
>>>> old variable.
>>>>=20
>>>> I think that would allow for the arch optimizations that you are trying=
 to
>>>> achieve, as well as remove the side effect that might cause issues down=
 the
>>>> road.
>>>=20
>>> Attached patch implements this suggestion.
>>=20
>> I like it!

Me too :)

> Thanks!
>=20
>> Anyway to make this more generic?
>=20
> If we want to put the definition in generic headers, then we also need
> to define acquire/release/relaxed and 64bit variants. ATM, we have two
> sites that require this definition and I think that for now we could
> live with two instances of the same definition in two separate
> subsystems. But this would definitely be a good future addition. There
> is some code in the form of
>=20
> if (cmpxchg (ptr, 0, 1) =3D=3D 0)
>=20
> that can not be converted to try_cmpxchg, but can use cmpxchg_success.

I would prefer if we can put it in generic headers instead of duplicating
across ftrace and RCU.

thanks,

 - Joel

>=20
> Uros.
