Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8CFCD37AA
	for <rcu@archiver.kernel.org>; Fri, 15 Sep 2023 21:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbjIOVQX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Sep 2023 17:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbjIOVPr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Sep 2023 17:15:47 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6B30D1
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 14:14:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bfc1d8f2d2so31157071fa.0
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694812496; x=1695417296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVf1zJpiowrS0i0aGi///gDUBM+JJyWSf3eiJycmGDI=;
        b=CfacPhB22xrNfDTz3Ro3IKhFPBw7ZRtkKmwYc5741hEhz+D13JHASQCizyJOWOgL6e
         ceDG97mhXfMqFmf6CWQK6SlHrVsHfC3mQknPAR0L4o+E7lR0NKH+I7Lwrsm+/tSkMKqx
         bRNWENTUj+z3SXZ9sgkfJeqzPJw1DXge7CzmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812496; x=1695417296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVf1zJpiowrS0i0aGi///gDUBM+JJyWSf3eiJycmGDI=;
        b=q9OfN1dQO2UysTOEGRjVCQ9COgtFWP4/fayzPP1ep/IvIz9TExY9bqGyYJn7mF6WLy
         D0b7QdCFZ7pkesWWXfUssChZGZpCF0vnl65xI164Q7lIEkKoXlOJwjFJKgNs57EEokl+
         dzJSwYP8OAoS8sYZE4RV4Q8urWEKlTy/lOu3m/Tw8l1BbEXnL0KQlH+zF6I8ffvDO+vF
         1nVlIuueteFA+jp74IkBQanp5es1++dcKuk32zhVkhqKTQI3ktFZCPozwjUC3UpovGoE
         VTO12Zxk0qfGsLA7nK5hO7+GjEWybBtsRC+CLIbR5SHc1RCMmM/2Rl/jBnBr5lR5p1ma
         Xr9A==
X-Gm-Message-State: AOJu0YwWKSYi2FkVO/fC6kVP2Hef95lHJCD8uPfcT/g/OnBX/dKW908d
        I7LFTbgpHk5HJPrJQXk+nVbv4MTi6NFiyLzlvHmr5ZAHNQ7P1zqp
X-Google-Smtp-Source: AGHT+IGuK6f3MnF658WlVJA+efYU844/EWs9oktWYjciiRI0/0fDRzfF1TpmHmq6QNNaoBWtKAvC2v8ExQaPK+uhGS4=
X-Received: by 2002:a05:651c:1250:b0:2bc:d2a6:3083 with SMTP id
 h16-20020a05651c125000b002bcd2a63083mr2240386ljh.18.1694812495516; Fri, 15
 Sep 2023 14:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
 <fe78cd08-1b2c-4ab0-bbf7-8d324b4fa77f@paulmck-laptop> <20230914131351.GA2274683@google.com>
 <885bb95b-9068-45f9-ba46-3feb650a3c45@paulmck-laptop> <20230914185627.GA2520229@google.com>
 <20230914215324.GA1972295@google.com> <20230915001331.GA1235904@google.com>
 <20230915113313.GA2909128@google.com> <ddc6c9d3-f9c7-46ab-a11e-0841148baa3a@paulmck-laptop>
 <20230915163711.GA3116200@google.com> <d8f43d7a-3e42-4be7-a8c9-dcbff2ca87ef@paulmck-laptop>
In-Reply-To: <d8f43d7a-3e42-4be7-a8c9-dcbff2ca87ef@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 15 Sep 2023 17:14:44 -0400
Message-ID: <CAEXW_YRbFetLk1psOjjdXL2JiuKTcXs1T3J8V0YQDZ41ZewwDg@mail.gmail.com>
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 15, 2023 at 12:57=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
[...]
> > > > > On the other hand, I came up with a real fix [1] and I am current=
ly testing it.
> > > > > This is to fix a live lock between RT push and CPU hotplug's
> > > > > select_fallback_rq()-induced push. I am not sure if the fix works=
 but I have
> > > > > some faith based on what I'm seeing in traces. Fingers crossed. I=
 also feel
> > > > > the real fix is needed to prevent these issues even if we're able=
 to hide it
> > > > > by halving the total rcutorture boost threads.
> > > >
> > > > So that fixed it without any changes to RCU. Below is the updated p=
atch also
> > > > for the archives. Though I'm rewriting it slightly differently and =
testing
> > > > that more. The main thing I am doing in the new patch is I find tha=
t RT
> > > > should not select !cpu_active() CPUs since those have the scheduler=
 turned
> > > > off. Though checking for cpu_dying() also works. I could not find a=
ny
> > > > instance where cpu_dying() !=3D cpu_active() but there could be a t=
iny window
> > > > where that is true. Anyway, I'll make some noise with scheduler fol=
ks once I
> > > > have the new version of the patch tested.
> > > >
> > > > Also halving the number of RT boost threads makes it less likely to=
 occur but
> > > > does not work. Not too surprising since the issue actually may not =
be related
> > > > to too many RT threads but rather a lockup between hotplug and RT..
> > >
> > > Again, looks promising!  When I get the non-RCU -rcu stuff moved to
> > > v6.6-rc1 and appropriately branched and tested, I will give it a go o=
n
> > > the test setup here.
> >
> > Thanks a lot, and I have enclosed a simpler updated patch below which a=
lso
> > similarly shows very good results. This is the one I would like to test
> > more and send to scheduler folks. I'll send it out once I have it teste=
d more
> > and also possibly after seeing your results (I am on vacation next week=
 so
> > there's time).
>
> Much nicer!  This is just on current mainline, correct?

Yes, correct. I also applied it cleanly to all stable kernels for my
test rigs. Only 5.10 had a little merge conflict but it was trivially
fixed.

thanks,

 - Joel
